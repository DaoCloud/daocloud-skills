# 个人权限汇总:workflow 版与非 workflow 版对比

`global-management:personal-access-summary` 和
`global-management:personal-access-summary-workflow` 解决同一个问题——汇总当前登录
账号的可见工作空间、用户组、角色绑定和有效全局权限——但走两条不同的路径:前者由调用方
依次发五条 CLI 命令,后者调用一次 `personal-access-summary-page` workflow。

两个都保留下来,是为了看清 workflow 到底省了什么、又贵在哪里。本文记录两者在 API、
流程、开销和实测耗时上的差异。

---

## 调用的 API 完全相同

两版打到的是同一批只读操作,一个不多一个不少:

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

这一步省下来值多少,要看谁在调用:

- **能自己写脚本的**——省不下什么。`ID=$(... | jq -r .uid)` 一行就取到了,和后面几条
  命令写在同一段脚本里一次跑完。
- **一次只能发一条命令的(比如 AI 助手)**——省下一整轮来回。它得先看到第一条命令的
  结果,才知道下一条该带什么 id。
- **不管谁调用,都少一类出错可能。** 依赖关系写死在 cli.yaml 里,调用方不会把字段名
  取错。

---

## 调用开销

| | 非 workflow | workflow |
|---|---:|---:|
| skill 步骤数 | 4 | 3 |
| CLI 进程数 | 5 | 1 |
| HTTP 请求数 | 5 | 5 |
| 返回形态 | 5 份独立 JSON | 1 份聚合 JSON **字符串**,需 `jq 'fromjson'` |

两版都只查一遍,查完不会为了确认数字没变再查一次。

---

## 实测耗时

让 AI 助手各跑一轮,同一账号、同一主机,前后脚进行。一轮完整问答的时间分三段:助手想好
要敲什么命令、命令实际执行、助手读完结果写出报告。

| 阶段 | 非 workflow | workflow |
|---|---:|---:|
| 助手写出命令 | 10.08s | 8.75s |
| 命令执行 | 2.30s | 1.12s |
| 助手写出报告 | 18.92s | 16.74s |
| **合计** | **31.30s** | **26.61s** |

另一轮单独掐表测命令执行:非 workflow **1.310s**,workflow **1.003s**,两者都是 5 次
HTTP 请求。上表中间那行是从会话日志的时间戳倒推的,含少量日志写入开销,所以比这个数略大。

两点结论:

1. **时间几乎都花在 AI 写字上。** 写命令加写报告占了九成,真正调接口只有 1 到 2 秒。
   两版的差距主要来自命令本身长短不同——非 workflow 版要多写一段取 `uid` 再传给后续
   命令的脚本。
2. **命令执行两版只差 0.3 到 1.2 秒。** 请求次数一样,这点差距和一次网络波动同量级,
   单次测量说明不了谁更快。

上表不包含等人点击授权确认的时间。那取决于旁边有没有人、什么时候看到提示,和这两个
skill 无关。

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

这也是命令名里带 `-page` 的原因:它拿的就是"一页",不适合当翻页工具反复调。workflow
自己不会循环,要翻页只能由调用方一页一页地调。

这张表是按 workflow 的定义算出来的,没有实测过——测试账号三个集合都只有一页,翻不到
第二页。

---

## 选型建议

| 场景 | 用哪个 |
|---|---|
| 调用方能自己写脚本,几条命令一起跑 | 任选,差别不大 |
| 调用方一次只能发一条命令 | workflow 版,省一轮来回 |
| 想把依赖关系固定下来,避免取错字段 | workflow 版 |
| 某个集合可能超过 100 条 | 非 workflow 版,翻页便宜得多 |
| 只想重新取其中一项 | 非 workflow 版,workflow 没法只跑一步 |
