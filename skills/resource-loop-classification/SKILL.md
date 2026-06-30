---
name: resource-loop-classification
description: Classify DCE/GPU/LLM platform resources by operating-loop maturity, especially questions like "哪些资源已经形成经营闭环，哪些还只是有资源、没模式？". Use when asked to identify which resources, workspaces, tenants, GPU clusters, namespaces, model services, queues, apps, or products have customer usage, billing/revenue, repeat operation, utilization, and a viable business model versus idle or unmonetized resources.
---

# Resource Loop Classification

## Overview

Use this skill to turn DCE resource facts into a business maturity map: which resources have formed an operating loop, which are weak or partial loops, and which are only deployed assets without a clear usage or monetization model.

Use existing `dce` CLI commands and the `dce` skill for command discovery, authentication, module availability checks, and safe execution. Do not invent customers, revenue, utilization, resource ownership, or business models.

## Classification Model

Classify each resource into one of four levels:

- `已形成闭环`: Resource has a clear tenant/customer carrier, sustained usage, measurable cost or utilization, billing/revenue or chargeback evidence, and an owner/action rhythm for renewal, expansion, or optimization.
- `弱闭环`: Resource has tenant/customer and usage evidence, but revenue is low, utilization is unstable, usage is concentrated, or operating ownership is incomplete.
- `有资源、没模式`: Resource exists and may consume capacity/cost, but there is no proven user demand, billing path, pricing rule, customer mapping, or repeatable operating motion.
- `证据不足`: DCE data cannot connect resource, user/tenant, usage, and money well enough to classify.

Do not treat "resource exists" as a loop. A loop requires evidence that resource -> user/customer -> usage -> fee/revenue/chargeback -> continued operation can be connected.

## Workflow

1. Define scope.
   - If the user does not specify scope, cover AI-related resources first: GPU devices/nodes, LLM/model services, queues, workspaces, namespaces, billing records, and related report data.
   - Default analysis window: last 30 days. For "今天/最近", compare against the previous equal-length period when useful.
   - Use Unix seconds for Billing Center commands.
2. Check DCE access.
   - Confirm `dce` is available.
   - If a hostname is provided or required, run `dce auth status --hostname <host>`.
   - If auth is missing, stop and ask the user to authenticate.
3. Discover read-only commands.
   - Use `dce search "<intent>" --json` for candidates.
   - Use `dce commands show <path...> --json` before executing unfamiliar commands.
   - If a module route is missing, follow the `dce` skill module-availability workflow.
4. Build the resource inventory.
   - Resource dimensions: cluster, node/GPU, namespace, workspace, model service/instance, queue, app/workload, product/module.
   - Ownership dimensions: workspace, tenant/customer, namespace owner, operator, business owner when available.
5. Attach loop evidence.
   - Usage: requests, tokens, active users, GPU utilization, pod/runtime activity, model invocations, queue activity.
   - Monetization: bill aggregation from Billing Center, amount due, voucher/discount, chargeback, revenue allocation, pricing rule.
   - Repeatability: recurring usage, renewal/expansion signals, multiple tenants, stable operating process.
   - Cost/risk: GPU cost, pod/node cost, idle capacity, concentration, support burden.
6. Classify and rank.
   - Assign a maturity level to every material resource.
   - Rank `有资源、没模式` resources by cost/risk or opportunity size.
   - Rank `已形成闭环` resources by gross contribution, usage growth, or strategic value when data allows.
7. Report the result first, then evidence and next actions.

## DCE Data Discovery

Prefer current catalog discovery over hardcoded assumptions. Useful searches include:

```bash
dce search "gpu devices" --json
dce search "workspace resources" --json
dce search "report workspaces" --json
dce search "bill aggregation" --json
dce search "billing" --json
dce search "namespace report" --json
dce search "llm studio token usage" --json
dce search "model service" --json
dce search "queue" --json
```

Common read-only command families may include:

```bash
dce commands show operations-management report list-workspaces --json
dce commands show operations-management report list-namespaces --json
dce commands show operations-management report list-pods --json
dce commands show billing-center bill get-account-bill-aggregation --json
dce billing-center bill get-account-bill-aggregation \
  --workspace-id <id> \
  --start-time <unix-seconds> \
  --end-time <unix-seconds> \
  -o json
```

Use only commands that exist in the current catalog and only after inspecting their flags and auth requirements.
Use Operations Management report commands for resource and usage reports, but use Billing Center for fee, bill, revenue, and voucher evidence.

## Evidence Rules

Use the strongest available evidence:

- `资源存在`: inventory records, cluster/node/GPU/workspace/namespace/model service lists.
- `有人使用`: requests, tokens, active users, pods, runtime, GPU utilization, logs, last-used time.
- `有承载对象`: workspace, namespace, tenant, customer, department, app, model service owner.
- `有收费/收入`: Billing Center bill aggregation, `amountDue`, `productName`, chargeback, quota-to-price mapping, confirmed contract.
- `券/抵扣`: `voucherPayment` or credits from Billing Center; report these separately from cash revenue.
- `可持续经营`: repeated usage across periods, multiple users/tenants, utilization trend, renewal/expansion, operational owner.

Classify as `证据不足` when a resource has usage but cannot be mapped to owner or money, or when money exists but cannot be mapped back to the resource.

## Output Format

Use Chinese when the user asks in Chinese.

```markdown
## 结论
已形成闭环：<数量/名称摘要>
弱闭环：<数量/名称摘要>
有资源、没模式：<数量/名称摘要>
最大机会/风险：...

## 资源分层
| 资源 | 类型 | 闭环等级 | 使用证据 | 收费/收入证据 | 主要问题 | 下一步 |
|---|---|---|---|---|---|---|
| ... | GPU/工作空间/模型服务/... | 已形成闭环 | ... | ... | ... | ... |

## 有资源、没模式 Top 风险
| 排名 | 资源 | 成本/占用 | 缺口 | 建议动作 |
|---:|---|---:|---|---|
| 1 | ... | ... | ... | ... |

## 已闭环资源 Top 机会
| 排名 | 资源 | 当前证据 | 放大路径 |
|---:|---|---|---|
| 1 | ... | ... | ... |

## 缺口
- ...
```

## Recommended Actions By Level

- `已形成闭环`: optimize margin, expand quota, standardize pricing, improve renewal and reporting cadence.
- `弱闭环`: reduce concentration, convert trial/voucher to paid usage, fix utilization or owner gaps.
- `有资源、没模式`: choose one path: retire, package into a paid offer, bind to a tenant/customer, or run a time-boxed pilot with success metrics.
- `证据不足`: collect the missing join key: resource-to-workspace, workspace-to-customer, usage-to-bill, or cost-to-resource.

## Guardrails

- Do not execute write, update, delete, recalculate, quota-change, status-change, or other mutating commands.
- Do not equate workspace with customer unless DCE data or the user confirms the mapping.
- Do not count one-off trial usage as a closed loop without payment, renewal, or operating evidence.
- Do not use GPU utilization alone as business success; connect it to tenant/customer usage and money.
- Do not report precise revenue, cost, or margin when only directional evidence exists.
