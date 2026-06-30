---
name: ai-ops-daily-summary
description: Generate a concise leadership-facing AI operations daily summary and business-value analysis from DaoCloud Enterprise DCE / LLM Studio / Hydra data. Use when the user asks for today's AI operations summary, AI usage report, LLM Studio operating metrics, boss/leadership AI daily report, token/API key/model service overview, business value, operating value, risk identification, or wants available DCE CLI data turned into the most important conclusions, especially in table form.
---

# AI Ops Daily Summary

## Overview

Create a boss-ready daily AI operations summary from DCE / LLM Studio / Hydra data. Favor the most important conclusions, shown as compact tables with direct metrics and a one-line executive takeaway. Do not depend on bundled scripts; run the DCE CLI commands directly so the workflow stays transparent and easy to adjust.

## Data Integrity Rules

- Use only data that was actually retrieved in the current run. Never guess, backfill, extrapolate, or invent values.
- If a metric is not returned by DCE CLI commands, including DCE LLM Studio / Hydra-backed command groups, do not include that metric in tables, conclusions, risk reads, or recommendations.
- Do not write placeholder values such as `N/A`, `unknown`, `not available`, `-`, or `0` unless the retrieved data explicitly says the value is zero.
- If a whole data source is unavailable, omit metrics that depend on it. Mention the gap only when it materially limits confidence.
- Distinguish measured values from calculated values. Only calculate from retrieved inputs, and state the formula briefly when the calculation drives a conclusion.
- Do not expose raw API keys, tokens, credentials, or secrets. Count and summarize only.

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

If a DCE CLI command returns 404 or fails, keep the partial data and mention any material gap only if it affects confidence. Do not include metrics from failed commands.

## Business Value Data

When the user asks for business value, operating value, or risk identification and business recommendations, collect data only through `dce` CLI commands. Do not call page-specific HTTP endpoints such as `/api/v1alpha1/business-value/...`, even if the user provides a dashboard URL. Use the dashboard only to understand which business concepts matter; use DCE CLI output as the sole data source.

CLI sources that can support business-value analysis:

| Business area | Preferred source | Use only when retrieved |
|---|---|---|
| Token throughput and output | `dce insight metric query-metric`, `dce insight metric query-range-metric`, LLM Studio dashboard/token usage commands | Throughput, cumulative tokens, usage trend |
| Capacity and utilization | `dce insight metric`, `dce insight resource list-nodes`, `dce insight resource get-node`, GPU dashboard/resource commands | Rated capacity if returned, GPU/node utilization, bottleneck read |
| Tenant/API Key consumption | `dce llm-studio apikeymanagement get-api-key-usage-statistics`, `list-api-key`, WS API Key usage commands | Active tenants, API Key count, token ranking |
| Workspace quota and budget | `dce llm-studio workspacequotaservice list-workspace-quotas` | Budget usage, quota exhaustion risk |
| Model supply and serving | `dce llm-studio modelmanagement list-models`, `modelservingmanagement list-model-serving`, `adminmodelmanagement list-models` | Model availability, serving posture |
| Revenue, cost, gross profit, ROI | Token usage plus prices returned by LLM Studio model APIs, retrieved cost config, workspace quota/billing fields if returned | Financial value; omit if price or cost inputs are missing |
| Risk suggestions | `dce insight alert`, quota commands, usage commands, API Key commands, security/log commands if available | Only recommendations backed by retrieved data |

Hydra is usually exposed through `dce llm-studio ...` commands. If a separate `hydra` CLI is not installed, do not claim it was used; say the Hydra data was accessed through DCE LLM Studio commands only if those commands succeeded.

## Summary Workflow

1. Query visible workspaces first, then run all per-workspace commands for each workspace.
2. Aggregate across all visible workspaces.
3. Prioritize conclusions in this order:
   - Actual consumption: request count, total/input/output tokens, active users.
   - Adoption: active users vs total users, workspace coverage.
   - Supply readiness: public/MAAS models enabled and gateway health.
   - Deployment posture: workspace model-serving count.
   - Governance and waste: API Key count, zero-quota keys, never-used keys, stale keys, disabled/expired keys.
4. For business-value requests, add retrieved operating-value signals in this order:
   - Capacity utilization and cumulative Token output.
   - Revenue, cost, gross profit, margin, and ROI only when measured or calculable from retrieved inputs.
   - Tenant/API Key concentration and quota risk.
   - Model supply and model-serving readiness.
   - Retrieved risk suggestions and alerts.
5. Keep up to 5 conclusions. Fewer is better than adding unsupported conclusions.
6. Present the output as Markdown tables when the user wants a direct/visual view.

## Output Format

When the user asks for an AI operations daily summary, business-value analysis, risk identification, remediation advice, or leadership-facing report, answer in structured Markdown with the sections below. Do not output a step-by-step investigation log. Unless the user explicitly asks, do not show skill loading, command retries, raw JSON processing, or other internal process details.

Rules:

- Put the conclusion first.
- Use Markdown tables for key metrics whenever possible.
- Keep intermediate investigation detail out of the final answer.
- Recommendations must be specific and executable.
- Use only values retrieved through DCE CLI commands in the current run.
- Omit any metric, finding, cause, or recommendation that is not backed by retrieved DCE CLI data.
- If data is incomplete, explicitly say `Based on the currently available DCE CLI data`.
- Match the user's language in the final answer, but keep these skill instructions in English.
- Do not expose raw API keys or secrets; only count keys and summarize status.

Required response template:

```markdown
# Conclusion

Based on the currently available DCE CLI data, <1-2 sentences with the current judgment, risk level, and most important issue>. Current risk level: Normal / Watch / Risk / Critical.

## Key Metrics

| Metric | Current Value | Status |
|---|---:|---|
| Token consumption | `<retrieved request/token count>` | Normal / Watch / Risk / Critical |
| Active users or tenants | `<retrieved active count>` | Normal / Watch / Risk / Critical |
| API Keys | `<retrieved key count/status summary>` | Normal / Watch / Risk / Critical |
| Model supply or serving | `<retrieved model/serving count/status>` | Normal / Watch / Risk / Critical |
| Capacity, quota, or cost signal | `<retrieved value, if available>` | Normal / Watch / Risk / Critical |

## Main Findings

1. <most important finding backed by retrieved DCE CLI data>
   <business or operating impact>.

2. <second important finding backed by retrieved DCE CLI data>
   <business or operating impact>.

3. <third important finding, optional and only if backed by retrieved data>
   <business or operating impact>.

## Cause Analysis

Cause 1: <cause>

Evidence: <retrieved metric / command result>.  
Impact: <impact on usage, cost, capacity, governance, or risk>.

Cause 2: <cause, optional and only if backed by retrieved data>

Evidence: <retrieved metric / command result>.  
Impact: <impact>.

Cause 3: <cause, optional and only if backed by retrieved data>

Evidence: <retrieved metric / command result>.  
Impact: <impact>.

## Recommended Actions

Immediate Actions

1. <specific action tied to retrieved risk or metric>
2. <specific action tied to retrieved risk or metric>

Continuous Monitoring

1. <specific retrieved metric to watch>
2. <specific threshold or condition that would change the conclusion>

Follow-Up Improvements

1. <durable improvement tied to retrieved data>
2. <instrumentation, quota, alerting, cost, or governance improvement>

## Follow-Up Questions

- Help me inspect the detailed cause for `<workspace / tenant / API Key group / model serving>`
- Help me generate an action plan for today's AI operations risk
- Help me export a leadership- or delivery-facing AI operations report
```

Optional detail tables may be added under the required sections only when they materially improve the answer and every row is backed by retrieved DCE CLI data. Keep them concise.

## Interpretation Rules

- Treat `requestCount=0` and `todayTokens=0` as the strongest signal: consumption is zero.
- If dashboard totals are zero and token usage detail lists are empty, state the zero-usage conclusion confidently.
- If public models are enabled and gateway status is healthy, describe supply as ready or available.
- If workspace model-serving count is zero, describe the posture as public-model driven rather than self-deployed/private-serving driven.
- For API Keys, count total, disabled, expired, zero-quota, never-used (`lastUsedTime` missing), and stale keys. Do not print the key values.
- Use concrete workspace names and IDs only when they clarify the conclusion; otherwise aggregate for leadership readability.
- Do not infer business risk from missing data. A missing quota response is not a budget risk; a missing cost response is not zero cost; a missing department endpoint is not zero department usage.
- If department token usage is unsupported in the current runtime mode, omit department rankings and base the summary on tenant/API Key/workspace data that was retrieved.
- Capacity risk must be grounded in retrieved throughput, rated capacity, GPU utilization, node metrics, or explicit bottleneck forecast data.
- Financial conclusions require retrieved revenue/cost/profit data or retrieved token usage plus retrieved price/cost configuration. Otherwise omit financial metrics.
- Risk recommendations must map to retrieved evidence: quota exhaustion, low utilization, traffic drop, concentration, alert/security event, or explicit risk-suggestion API output.
