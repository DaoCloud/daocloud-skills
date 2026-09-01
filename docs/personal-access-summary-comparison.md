# 个人权限汇总:workflow 版与非 workflow 版对比

`global-management:personal-access-summary` 和
`global-management:personal-access-summary-workflow` 解决同一个问题——汇总当前登录
账号的可见工作空间、用户组、角色绑定和有效全局权限——但走两条不同的路径:前者由调用方
依次发五条 CLI 命令,后者调用一次 `personal-access-summary-page` workflow。

两个都保留下来,是为了看清 workflow 到底省了什么、又贵在哪里。本文记录两者在 API、
流程、开销和实测耗时上的差异。

---

## 调用的 API 完全相同

两版调用的是同一批只读操作,不多不少:

| # | Operation | HTTP | 非 workflow 命令 | workflow 步骤 |
|---|---|---|---|---|
| 1 | `Account_GetUser` | `GET /apis/ghippo.io/v1alpha1/current-user` | `account get-user` | `user` |
| 2 | `Users_ListUserGroups` | `GET /apis/ghippo.io/v1alpha1/users/{id}/groups` | `users list-user-groups` | `groups` |
| 3 | `Users_ListUserSubjects` | `GET /apis/ghippo.io/v1alpha1/users/{id}/subjects` | `users list-user-subjects` | `role_bindings` |
| 4 | `Account_GetGlobalPermissions` | `GET /apis/ghippo.io/v1alpha1/current-user/global-permissions` | `account get-global-permissions` | `global_permissions` |
| 5 | `Workspace_ListWorkspaces` | `GET /apis/ghippo.io/v1alpha1/workspaces` | `workspace list-workspaces` | `workspaces` |

在测试账号上反复执行,两版输出的五个字段(account、workspaces、userGroups、
roleBindings、globalPermissions)逐字段一致。

---

## 流程差异只有一处:`uid` 由谁传递

`Users_ListUserGroups` 和 `Users_ListUserSubjects` 都需要 `{id}`,而这个 id 只能从
`Account_GetUser` 的响应里取。两版的分歧全在这里。

**非 workflow(4 步)**

```
Step 1  account get-user            → 调用方读出 .uid
Step 2  list-user-groups   --id <uid>
        list-user-subjects --id <uid>
        list-workspaces
Step 3  account get-global-permissions
Step 4  汇总呈现
```

**workflow(3 步)**

```
Step 1  personal-access-summary-page --page 1 --page-size 100
          runtime 内部:user → ${steps.user.uid} → groups / role_bindings
Step 2  按 pagination.total 决定是否需要后续页
Step 3  汇总呈现
```

差的那一步就是"读 `uid` 再喂给下一步"。workflow 把这个依赖写进了 cli.yaml 的
`${steps.user.uid}`,由运行时解析。

---

## 调用开销

| | 非 workflow | workflow |
|---|---:|---:|
| skill 步骤数 | 4 | 3 |
| CLI 进程数 | 5 | 1 |
| HTTP 请求数 | 5 | 5 |
| 返回形态 | 5 份独立 JSON | 1 份聚合 JSON **字符串**,需 `jq 'fromjson'` |

两版均为单次采集,不重复读取校验总数。

---

## 实测耗时

让 agent 各跑一轮,同一账号、同一主机,前后脚进行。一轮完整问答的耗时分三段:agent 生成
命令、命令执行、agent 读取结果并产出报告。

| 阶段 | 非 workflow | workflow |
|---|---:|---:|
| agent 生成命令 | 10.08s | 8.75s |
| 命令执行 | 2.30s | 1.12s |
| agent 产出报告 | 18.92s | 16.74s |
| **合计** | **31.30s** | **26.61s** |

另有一轮单独测量命令执行:非 workflow **1.310s**,workflow **1.003s**,两者均为 5 次
HTTP 请求。上表中间一行由会话日志时间戳推算,含日志写入开销,故略高。

两点结论:

1. **耗时主要在模型生成,不在接口。** 生成命令与产出报告合计约占九成,HTTP 只有 1-2
   秒。两版差距主要来自命令长度——非 workflow 版要多写一段取 `uid` 并传给后续命令的
   脚本。
2. **命令执行两版差 0.3-1.2 秒。** 请求次数相同,该差距与单次网络抖动同量级,单次测量
   不足以判定优劣。

上表不含等待人工授权确认的时间,它取决于操作者何时响应提示,与两个 skill 无关。

---

## 数据量大时 workflow 更亏

workflow 只有一个 `--page` 输入,它同时驱动全部五个步骤。为某个集合多翻一页,就得把
另外四步一起重跑,包括两个根本不分页的步骤。

假设 workspaces 有 500 条、pageSize 为 100:

| | 非 workflow | workflow |
|---|---:|---:|
| `get-user` | 1 | 5 |
| `list-user-groups` | 1 | 5 |
| `list-user-subjects` | 1 | 5 |
| `list-workspaces` | 5 | 5 |
| `get-global-permissions` | 1 | 5 |
| **合计** | **9** | **25** |

这也是命令名带 `-page` 的原因:它返回的是单页聚合,不适合当作翻页工具反复调用。
workflow DSL 没有循环结构,翻页必须由调用方在外层驱动。

上表按 workflow 定义推算,未经实测:测试账号三个集合均只有一页,触发不到第二页。

---

## 选型建议

| 场景 | 用哪个 |
|---|---|
| 调用方能自行编排,多条命令一次执行 | 任选,差异不显著 |
| 调用方一次只能发一条命令 | workflow 版,省一轮往返 |
| 需要固化依赖关系,避免取错字段 | workflow 版 |
| 某个集合可能超过 100 条 | 非 workflow 版,翻页开销低得多 |
| 只需重取其中一项 | 非 workflow 版,workflow 无法只跑一步 |
