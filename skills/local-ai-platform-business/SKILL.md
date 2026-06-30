---
name: ai-platform:business-loop
description: 判断地方 GPU/LLM 平台是否形成经营闭环，必须先查询真实 DCE 数据，再基于 GPU、工作空间/客户、LLM Studio Token 用量、Billing Center 账单和成本证据设计初装费、运维费、Token 分成。Use when asked about GPU 平台商业化、客户资源变现、经营闭环、LLM Studio Token 用量分析、初装费、运维费、分成比例、地方平台 AI 算力运营模型、收入成本测算或商业建议。
---

# AI Platform Business Loop

## Overview

Use this skill to turn DCE platform facts into a business judgement: whether a local GPU/LLM platform has a closed operating loop, what evidence supports the judgement, and how to price initial setup, monthly operations, and Token revenue sharing.

Treat DCE as the source of truth. Do not invent customers, Token volume, revenue, GPU utilization, or costs when data is missing.
Do not judge closure from assumptions, user claims, or a generic business framework alone. First run live read-only queries against the target DCE environment. If data cannot be queried, state that the loop cannot be judged yet and list the exact missing queries.

## Evidence-First Rule

Before giving a closure level, collect or explicitly fail to collect all four evidence groups:

- GPU/resource supply and utilization.
- Workspace/customer carrier and resource binding.
- LLM Studio Token/request activity.
- Billing Center revenue, voucher/discount, and billable product evidence.

Use the user's statement that "GPU and customer resources exist" only as scope guidance. It is not proof of a business loop.
When a query fails because the local generated `dce` binary lacks a command but the target host has the module installed, use the `dce` module-availability workflow and, only for read-only endpoints whose path is known from generated references, query the endpoint directly with the saved DCE credential. Do not print credentials.

## Workflow

1. Establish the analysis window.
   - Default to the last 30 days when the user does not specify dates.
   - Use RFC3339/date-time strings for LLM Studio commands.
   - Use Unix seconds for billing commands.
2. Check access.
   - Confirm `dce` exists.
   - If a hostname is provided or required, run `dce auth status --hostname <host>`.
   - If not logged in, stop and ask the user to authenticate.
3. Confirm unfamiliar commands before execution.
   - Run `dce commands show <path...> --json`.
   - Use the returned flags, auth, HTTP path, and output hints as the source of truth.
4. Collect evidence from DCE.
   - GPU supply and utilization from Container Management.
   - Customer/workspace carrier data from Global Management.
   - Token usage and request activity from LLM Studio.
   - Revenue evidence from Billing Center.
5. Verify the evidence chain.
   - Join GPU/resource records to clusters, namespaces, workspaces, model services, and customers when data allows.
   - Join Token/request activity to workspace/customer and model service.
   - Join Billing Center `amountDue`, `productName`, and `voucherPayment` back to the same workspace/customer.
   - If a join key is missing, mark the affected dimension as a gap instead of assuming the join.
6. Produce the operating-loop report.
   - Give the closure level first.
   - Show the queried commands/endpoints and evidence table.
   - Explain pricing and sharing recommendations.
   - List gaps and next actions.

## Data Collection

Use JSON output whenever possible.

Minimum query set for a real judgement:

```bash
dce auth status --hostname <host>
dce global-management about list-g-product-versions -o json
dce global-management workspace list-workspaces --page 1 --page-size 200 -o json
dce container-management devices list-gpu-devices --cluster <cluster> -o json
dce llm-studio wsdashboardmanagement list-ws-user-token-usage --workspace <id> --start-time <date-time> --end-time <date-time> --page.page-size -1 -o json
dce llm-studio wsdashboardmanagement list-ws-instance-token-usage --workspace <id> --start-time <date-time> --end-time <date-time> --page.page-size -1 -o json
dce billing-center bill get-account-bill-aggregation --workspace-id <id> --start-time <unix-seconds> --end-time <unix-seconds> -o json
```

For many workspaces, scan all candidate workspace IDs and summarize only workspaces with non-zero GPU/resource use, Token activity, or billable revenue.

### GPU

Inspect and then run:

```bash
dce commands show container-management devices list-gpu-devices --json
dce container-management devices list-gpu-devices --cluster <cluster> -o json
```

Use fields such as `modelName`, `cluster`, `coreUtilization`, `frameBufferMemoryUtilization`, `deviceUUID`, and `nodeName` when present.
If GPU devices are empty, say that GPU supply is not proven in DCE for the queried clusters; do not infer GPU availability from product names or platform claims.

### Workspaces And Customer Carrier

Inspect and then run:

```bash
dce commands show global-management workspace list-workspaces --json
dce global-management workspace list-workspaces -o json
```

For per-workspace resources, inspect and run:

```bash
dce commands show global-management workspace list-shared-resources-by-workspace --json
dce global-management workspace list-shared-resources-by-workspace --workspace-id <id> -o json
```

Treat workspaces as customer carriers only when DCE data or the user confirms the mapping. Otherwise call them workspaces, not customers.
Collect workspace IDs because Billing Center and LLM Studio commands usually require numeric workspace IDs.

### LLM Studio Token Usage

Inspect and then run the relevant LLM Studio commands:

```bash
dce commands show llm-studio wsdashboardmanagement get-ws-dashboard-summary --json
dce llm-studio wsdashboardmanagement get-ws-dashboard-summary \
  --workspace <id> \
  --start-time <date-time> \
  --end-time <date-time> \
  -o json
```

```bash
dce commands show llm-studio wsdashboardmanagement list-ws-user-token-usage --json
dce llm-studio wsdashboardmanagement list-ws-user-token-usage \
  --workspace <id> \
  --start-time <date-time> \
  --end-time <date-time> \
  --page.page-size -1 \
  -o json
```

```bash
dce commands show llm-studio wsdashboardmanagement list-ws-instance-token-usage --json
dce llm-studio wsdashboardmanagement list-ws-instance-token-usage \
  --workspace <id> \
  --start-time <date-time> \
  --end-time <date-time> \
  --page.page-size -1 \
  -o json
```

Use `inputTokens`, `outputTokens`, `cachedTokens`, `totalTokens`, `requestCount`, `lastUsedTime`, `modelName`, `instanceName`, and `instanceId` when present. Prefer user-level data for active customer/user analysis and instance-level data for product/model-service analysis.
If token commands fail, include the command, error class, and missing request context in the gap section. Do not treat model deployment or API key existence as Token usage.

### Billing

Inspect and then run:

```bash
dce commands show billing-center bill get-account-bill-aggregation --json
dce billing-center bill get-account-bill-aggregation \
  --workspace-id <id> \
  --start-time <unix-seconds> \
  --end-time <unix-seconds> \
  -o json
```

Use `amountDue`, `productName`, and `voucherPayment` when present. Treat voucher payments and credits separately from cash revenue.
Billing evidence must come from Billing Center, not Operations Management fee reports. If `billing-center` is installed on the host but absent from the local generated CLI, use the generated module reference to call the read-only leopard endpoint directly and report that fallback.

## Closure Levels

Classify the platform using the strongest supported evidence:

- `未闭环`: GPU exists, but no proven customer/workspace carrier, Token usage, or billable revenue.
- `弱闭环`: Customer/workspace and Token activity exist, but revenue is low, GPU utilization is poor, or usage is concentrated in one customer/model.
- `基本闭环`: GPU, workspace/customer, Token usage, and billing evidence can be connected for the analysis window, and revenue covers part of fixed delivery or operations costs.
- `健康闭环`: Token usage is sustained or growing, revenue is stable, GPU utilization is reasonable, customers are not overly concentrated, and there is evidence of renewal, expansion, or repeat usage.

When evidence is incomplete, state the highest defensible level and mark the missing proof.
Do not classify as `基本闭环` or `健康闭环` unless Token/request activity and Billing Center revenue are both present and can be connected to the same workspace/customer.

## Pricing Model

Use ranges unless the user provides exact labor cost, GPU cost, and target margin.
Base fee and sharing recommendations on the queried evidence. If the evidence is incomplete, provide conditional ranges tied to the missing data instead of a definitive price.

### Initial Setup Fee

Base the initial setup fee on:

- Environment assessment and deployment.
- GPU cluster/namespace/workspace/resource binding.
- LLM Studio model service, queue, API key, and quota setup.
- Customer onboarding, acceptance testing, and first-run enablement.
- Delivery risk buffer.

Recommend three tiers:

- `轻量接入`: one workspace or pilot customer, limited model services.
- `标准交付`: multiple workspaces/customers, production model services, basic acceptance.
- `深度集成`: custom networking, security, billing, monitoring, or multi-tenant operations.

### Monthly Operations Fee

Base monthly operations on:

- Number and class of GPUs under operation.
- Number of model services and queues.
- SLA and incident response window.
- Monitoring, report frequency, quota management, and customer support.
- Required optimization for utilization, cost, or latency.

Separate fixed operations fees from usage-based Token revenue.

### Token Revenue Sharing

Recommend three scenarios:

- `保守`: platform keeps a higher share when it contributes GPU, customers, account ownership, and local operations.
- `均衡`: platform and service/operator share revenue when both contribute materially.
- `增长`: service/operator takes a higher share when it provides models, productization, customer success, and ongoing optimization that materially drives Token growth.

Always distinguish gross Token revenue, voucher/discount impact, infrastructure cost, model/provider cost, and net distributable revenue when data allows.

## Report Format

Use this structure:

```markdown
## 结论
闭环等级：<未闭环|弱闭环|基本闭环|健康闭环>
一句话判断：...

## 证据
| 维度 | 指标 | 观察 | 结论 |
|---|---:|---|---|
| GPU | ... | ... | ... |
| 客户/工作空间 | ... | ... | ... |
| Token | ... | ... | ... |
| 账单 | ... | ... | ... |

## 查询记录
| 数据源 | 命令/端点 | 结果 |
|---|---|---|
| ... | ... | 成功/失败 + 关键错误 |

## 收费建议
初装费：...
月运维费：...
Token 分成：...

## 风险与缺口
- ...

## 下一步动作
- ...
```

## Guardrails

- Do not execute write, update, delete, quota-change, or status-change commands for this analysis.
- Do not answer with only a generic framework when live DCE access is available; query real data first.
- Do not treat generated command docs as proof that a module is installed on the target host; if a module route is missing, verify installed product versions using the DCE skill module-availability workflow.
- Do not equate workspace count to customer count unless confirmed.
- Do not use Token volume alone as revenue. Use billing data for revenue and Token data for usage intensity.
- Do not invent pricing precision. Use assumptions and ranges when cost inputs are unavailable.
