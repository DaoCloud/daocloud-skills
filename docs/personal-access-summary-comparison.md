# 个人权限汇总:workflow 版与非 workflow 版对比

`global-management:personal-access-summary` 和
`global-management:personal-access-summary-workflow` 解决同一个问题——汇总当前登录
账号的可见工作空间、用户组、角色绑定和有效全局权限——但走两条不同的路径:前者由调用方
依次发五条 CLI 命令,后者调用一次 `personal-access-summary-page` workflow。

两个 skill 同时保留,是为了让 workflow 编排的收益和代价都有一个可对照的基准。本文记录
两者在 API、流程、开销和实测耗时上的差异。

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

这一步值多少,取决于调用方:

- **能写 shell 的调用方**——不值钱。`ID=$(... | jq -r .uid)` 一行解决,同一次 Bash
  调用内就完成,模型不介入。
- **一次只能发一条命令的调用方**——值一整轮往返,因为读 `uid` 这步需要模型参与。
- **契约约束**——依赖固化在 cli.yaml 里,调用方不可能取错字段。这一条与调用方能力无关。

---

## 调用开销

| | 非 workflow | workflow |
|---|---:|---:|
| skill 步骤数 | 4 | 3 |
| CLI 进程数 | 5 | 1 |
| HTTP 请求数 | 5 | 5 |
| 返回形态 | 5 份独立 JSON | 1 份聚合 JSON **字符串**,需 `jq 'fromjson'` |

两版都按单次观测呈现,不声称经过二次验证。

---

## 实测耗时

时间戳取自 Claude Code 的会话 JSONL 日志,毫秒精度。命令执行时长由脚本内 `date` 打点。

同一账号、同一主机、连续两轮:

| 区段 | 非 workflow | workflow |
|---|---:|---:|
| 触发 → 写完命令 | 10.080s | 8.754s |
| 命令执行 + 落库 | 2.302s | 1.116s |
| 结果 → 产出报告 | 18.921s | 16.739s |
| **净耗时(不含确认等待)** | **31.30s** | **26.61s** |

另一组仅命令执行段的亚秒级测量:非 workflow **1.310s**,workflow **1.003s**,均为
5 次 HTTP 请求。

三点结论:

1. **模型生成是净耗时的大头。** "写命令 + 写报告"合计约 27s(非 workflow)和 25s
   (workflow),占净耗时八成以上;HTTP 只占 1–2 秒。
2. **命令执行差 0.3–1.2 秒。** 请求数相同,差异量级接近单次网络抖动,单次测量不足以
   判定谁更快。workflow 稳定略快,但幅度小。
3. **确认等待与 skill 无关,却主导墙钟时间。** 同一会话内实测跨度从 1.1 秒到
   1891.7 秒(31.5 分钟),占某一轮墙钟的 96.9%。比较两版性能时必须排除这一项。

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

这也是 workflow 命令取名 `personal-access-summary-page` 的原因:它表示"一页的聚合",
不适合当作翻页工具反复调用。workflow DSL 没有循环原语,翻页只能由调用方在外层完成。

以上为按 workflow 定义推算,未经实测——测试账号三个集合都只有一页,触发不了多页路径。

---

## 选型建议

| 场景 | 用哪个 |
|---|---|
| 调用方能在一次 shell 调用里串联命令 | 任选,差异不显著 |
| 调用方一次只能发一条命令 | workflow 版,省一轮往返 |
| 需要把依赖关系固化、防止取错字段 | workflow 版 |
| 某个集合可能超过 100 条 | 非 workflow 版,分页代价低得多 |
| 需要单独重取某一项 | 非 workflow 版,workflow 无法只跑一步 |
