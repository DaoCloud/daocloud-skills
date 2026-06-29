---
name: ai-ops-daily-summary
description: Generate a concise leadership-facing AI operations daily summary from DaoCloud Enterprise DCE data. Use when the user asks for today's AI operations summary, AI usage report, LLM Studio operating metrics, boss/leadership AI daily report, token/API key/model service overview, or wants the DCE CLI data turned into the most important 5 conclusions, especially in table form.
---

# AI Ops Daily Summary

## Overview

Create a boss-ready daily AI operations summary from DCE / LLM Studio data. Favor the most important 5 conclusions, shown as a compact table with direct metrics and a one-line executive takeaway. Do not depend on bundled scripts; run the DCE CLI commands directly so the workflow stays transparent and easy to adjust.

## Data Collection

Use the DCE CLI directly. Prefer `dce` on `PATH`. If a local repository checkout is available, `bin/dce` may also be used. Always request JSON with `-o json` when collecting data.

For "today", build the time window in the user's timezone. Example for Beijing time:

```text
start-time: YYYY-MM-DDT00:00:00+08:00
end-time:   YYYY-MM-DDT23:59:59+08:00
timezone:   Asia/Shanghai
```

Run these commands:

```bash
# 1. Visible workspaces
dce container-management workspace list-workspaces -o json

# 2. Per-workspace dashboard summary
dce llm-studio wsdashboardmanagement get-ws-dashboard-summary \
  --workspace <workspace-id> \
  --start-time '<start-time>' \
  --end-time '<end-time>' \
  --timezone '<timezone>' \
  -o json

# 3. Per-workspace token usage details
dce llm-studio wsdashboardmanagement list-ws-instance-token-usage \
  --workspace <workspace-id> \
  --start-time '<start-time>' \
  --end-time '<end-time>' \
  --page.page-size -1 \
  -o json

dce llm-studio wsdashboardmanagement list-ws-user-token-usage \
  --workspace <workspace-id> \
  --start-time '<start-time>' \
  --end-time '<end-time>' \
  --page.page-size -1 \
  -o json

# 4. Per-workspace model serving inventory
dce llm-studio wsmodelservingmanagement list-ws-model-serving \
  --workspace <workspace-id> \
  --page.page-size -1 \
  -o json

# 5. Per-workspace API Key inventory and usage
dce llm-studio wsapikeymanagement list-wsapi-key \
  --workspace <workspace-id> \
  --page.page-size -1 \
  -o json

dce llm-studio wsapikeymanagement get-api-key-usage-statistics2 \
  --workspace <workspace-id> \
  --start-time '<start-time>' \
  --end-time '<end-time>' \
  --period TIME_PERIOD_HOUR \
  -o json

# 6. Platform model supply
dce llm-studio maasservice list-maas-models \
  --page.page-size -1 \
  -o json

dce llm-studio adminmodelmanagement list-models \
  --page.page-size -1 \
  --show-deploy-template \
  --selector ALL \
  -o json
```

If a DCE endpoint returns 404 or fails, keep the partial data and mention any material gap only if it affects confidence.

## Summary Workflow

1. Query visible workspaces first, then run all per-workspace commands for each workspace.
2. Aggregate across all visible workspaces.
3. Prioritize conclusions in this order:
   - Actual consumption: request count, total/input/output tokens, active users.
   - Adoption: active users vs total users, workspace coverage.
   - Supply readiness: public/MAAS models enabled and gateway health.
   - Deployment posture: workspace model-serving count.
   - Governance and waste: API Key count, zero-quota keys, never-used keys, stale keys, disabled/expired keys.
4. Keep exactly 5 conclusions unless the user asks for more.
5. Present the output as a Markdown table when the user wants a direct/visual view.

## Output Format

Use this table shape by default:

| # | Conclusion | Key Data | Read |
|---:|---|---:|---|
| 1 | No AI consumption today | Requests `0`; tokens `0` | AI capability produced no business usage today |

When the user asks in Chinese, localize the table:

| # | 结论 | 关键数据 | 直观判断 |
|---:|---|---:|---|
| 1 | 今日实际使用为 0 | 请求 `0`；Token `0` | AI 能力今日未产生业务消耗 |

Then add one short executive sentence. Example:

```text
一句话给老板：今天 AI 平台“供给正常、消费为零”，重点不是扩容，而是把已有模型和 API Key 接到真实业务场景里。
```

Adjust the wording based on the data. Do not expose raw API keys or secrets; only count keys and summarize status.

## Interpretation Rules

- Treat `requestCount=0` and `todayTokens=0` as the strongest signal: consumption is zero.
- If dashboard totals are zero and token usage detail lists are empty, state the zero-usage conclusion confidently.
- If public models are enabled and gateway status is healthy, describe supply as ready or available.
- If workspace model-serving count is zero, describe the posture as public-model driven rather than self-deployed/private-serving driven.
- For API Keys, count total, disabled, expired, zero-quota, never-used (`lastUsedTime` missing), and stale keys. Do not print the key values.
- Use concrete workspace names and IDs only when they clarify the conclusion; otherwise aggregate for leadership readability.
