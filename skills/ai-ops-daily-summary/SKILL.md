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

### Current Environment Fast Path

This environment is currently verified as **CSP mode**. For the normal daily summary, use the CSP fast path first. Do not start by listing workspaces, probing WS endpoints, reading command help, or inspecting raw response schemas.

The fast path must finish data collection in **one orchestration/tool round trip**:

1. Build `start-time`, `end-time`, timezone, and local collection time in memory.
2. Launch all independent command groups below concurrently (for example, with `Promise.all` when the orchestration tool supports it). Do not wait for one API before starting the next.
3. Apply `jq` inside each command pipeline so only compact, secret-free summaries return to the model. Never return raw API Key objects.
4. Compose the report directly from those compact results. Do not run schema-discovery or confirmation calls when the expected fields are present.

Run these command groups concurrently:

| Group | Commands | Return only |
|---|---|---|
| Usage + price | `get-api-key-usage-statistics2` and `modelmanagement list-models --show-public-model-price` | total input/output/Token, per-model usage, per-model calculated charge, price coverage, peak hour, latest timestamp |
| API Key governance | `apikeymanagement list-api-key` | total, disabled, expired, zero-quota, unlimited, never-used, stale/latest-use counts; never return `key` |
| Model serving | `modelservingmanagement list-model-serving` | total and status counts |
| Model supply | `maasservice list-maas-models` | total, enabled count, gateway-status counts |
| Active alerts | `insight alert list-alerts --all` | total, severity/status counts, compact CRITICAL/WARNING rule summaries |
| Clock | local `date` | collection cutoff in the user's timezone |

Usage and model prices are the only dependent pair. Fetch both within the same concurrent group and join them locally with `jq -s`; do not make a second API round after usage returns. Other groups must run in parallel with that pair.

The fast path is successful when the usage call returns `totalUsage`, even if another optional group fails. Keep successful partial data and produce the summary. Enter runtime-mode detection only when a primary CSP endpoint returns `SYSTEM-REQUEST_MODE_ERROR`, a mode-specific `404`, or an incompatible response shape.

Do not confuse one orchestration round trip with one server API. The current DCE runtime exposes separate read APIs; the speedup comes from launching them together and returning compact aggregates once.

### Runtime Mode Detection (Fallback Only)

Use this section only when the current-environment CSP fast path fails because the runtime mode appears to have changed. Do not run it on every daily summary.

1. List visible workspaces for context:

   ```bash
   dce container-management workspace list-workspaces -o json
   ```

2. Probe one read-only workspace endpoint with the first visible workspace ID:

   ```bash
   dce llm-studio wsdashboardmanagement get-ws-dashboard-summary \
     --workspace <workspace-id> \
     --start-time '<start-time>' \
     --end-time '<end-time>' \
     --timezone '<timezone>' \
     -o json
   ```

3. Probe one read-only CSP endpoint:

   ```bash
   dce llm-studio apikeymanagement list-api-key \
     --page.page-size -1 \
     -o json
   ```

Classify the runtime from actual responses:

- **WS mode:** the workspace dashboard probe succeeds. Use the WS collection path below.
- **CSP mode:** the CSP probe succeeds while WS endpoints return `SYSTEM-REQUEST_MODE_ERROR` or mode-specific `404`. Use the CSP collection path below and do not retry every WS endpoint.
- **Mixed mode:** both probes succeed. Collect both paths, deduplicate overlapping metrics, and label the source scope.
- **Undetermined:** neither probe succeeds. Keep only other successful `Any` or Insight data and state the material coverage gap.

Messages such as `Current API mode: CSP` or `Current API mode: WS` in command help describe the command's required mode; they are not proof of the server's active mode. A successful read-only probe is the deciding evidence.

For "today", build the time window in the user's timezone. Example for Beijing time:

```text
start-time: YYYY-MM-DDT00:00:00+08:00
end-time:   YYYY-MM-DDT23:59:59+08:00
timezone:   Asia/Shanghai
```

### WS Mode Collection

Run these commands only when the WS probe succeeds:

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

### CSP Mode Collection

In CSP mode, use global LLM Studio resources instead of workspace-prefixed resources:

```bash
# 1. Global API Key inventory and token usage
dce llm-studio apikeymanagement list-api-key \
  --page.page-size -1 \
  -o json

dce llm-studio apikeymanagement get-api-key-usage-statistics2 \
  --start-time '<start-time>' \
  --end-time '<end-time>' \
  --period TIME_PERIOD_HOUR \
  -o json

# 2. Global model inventory, published prices, and serving state
dce llm-studio modelmanagement list-models \
  --page.page-size -1 \
  --show-public-model-price \
  -o json

dce llm-studio modelservingmanagement list-model-serving \
  --page.page-size -1 \
  -o json

# 3. Platform model supply
dce llm-studio maasservice list-maas-models \
  --page.page-size -1 \
  -o json

dce llm-studio adminmodelmanagement list-models \
  --page.page-size -1 \
  --show-deploy-template \
  --selector ALL \
  -o json

# 4. Current platform alerts
dce insight alert list-alerts \
  --all \
  -o json
```

In CSP mode:

- Use `totalUsage.input`, `totalUsage.output`, and `totalUsage.total` from the global API Key usage statistics as the consumption totals.
- Aggregate `dataPoints` by `model` and `timestamp` for model shares, hourly trends, and the latest completed data point.
- Use global API Key inventory only for governance counts. Do not infer active-user or active-key counts from aggregate token data.
- Do not call `workspacequotaservice` or other WS-only resources after the runtime has been identified as CSP unless a mixed-mode probe proves they work.
- Do not describe global CSP metrics as workspace totals or tenant rankings.

### Cost Calculation

Calculate cost only when both model-level token usage and matching model prices are returned in the current run:

```text
model cost = input_tokens / 1000 * inputPerKTokens
           + output_tokens / 1000 * outputPerKTokens
total cost = sum(model cost)
```

- Join usage model names such as `public/<model-id>` to the corresponding model price.
- If any used model lacks a price, report only the priced subset and its coverage; do not present it as the total cost.
- If the API does not return a currency, label the result as `pricing units` (or the user's language equivalent), never as CNY, USD, or another currency.
- Treat the result as calculated/estimated cost and state the formula briefly.

### Collection Cutoff

For an in-progress day, record the local collection time and the maximum returned usage timestamp. Describe figures as `as of <time>`, not as a completed full-day total. If the requested end time is later than the collection time, do not imply that future hours are covered.

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

1. Build the requested local-day time window and record the collection time.
2. Run the current-environment CSP fast path in one concurrent orchestration round and aggregate before returning data to the model.
3. If the primary CSP usage endpoint succeeds, skip mode probes, workspace discovery, command help, and response-shape inspection. Continue directly to conclusions.
4. Only if the CSP fast path indicates a mode change, detect WS, CSP, mixed, or undetermined mode with the fallback read-only probes.
5. On fallback, collect only the command path supported by the detected mode:
   - WS: query visible workspaces and aggregate successful per-workspace results.
   - CSP: query global API Key usage, global models, model serving, MAAS supply, and active alerts.
   - Mixed: collect both and explicitly deduplicate overlapping usage totals.
6. Report the source scope (`workspace aggregate`, `global CSP`, or `mixed`) and the latest usage timestamp when the day is still in progress.
7. Prioritize conclusions in this order:
   - Actual consumption: request count, total/input/output tokens, active users.
   - Adoption: active users vs total users, workspace coverage.
   - Supply readiness: public/MAAS models enabled and gateway health.
   - Deployment posture: model-serving count and status in the detected scope.
   - Governance and waste: API Key count, zero-quota keys, never-used keys, stale keys, disabled/expired keys.
8. For business-value requests, add retrieved operating-value signals in this order:
   - Capacity utilization and cumulative Token output.
   - Revenue, cost, gross profit, margin, and ROI only when measured or calculable from retrieved inputs.
   - Tenant/API Key concentration and quota risk.
   - Model supply and model-serving readiness.
   - Retrieved risk suggestions and alerts.
9. Keep up to 5 conclusions. Fewer is better than adding unsupported conclusions.
10. Present the output as Markdown tables when the user wants a direct/visual view.

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
- State the detected runtime mode and metric scope when they affect interpretation.
- For an in-progress day, include the local collection cutoff or latest returned usage timestamp.
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
- In CSP mode, a global usage total does not prove which API Keys were active. Report aggregate consumption and inventory metadata separately unless per-key usage was retrieved.
- If global usage is nonzero while every listed API Key reports zero quota, zero used quota, or stale `lastUsedTime`, describe this as a metering/attribution consistency risk that needs reconciliation. Do not claim quota bypass or identify a responsible Key without per-key evidence.
- Count active alerts by severity and firing status. A retrieved firing `CRITICAL` alert may set the overall risk to Critical even when all model-serving records are RUNNING; distinguish platform reliability risk from model-serving availability.
- Use concrete workspace names and IDs only when they clarify the conclusion; otherwise aggregate for leadership readability.
- Do not infer business risk from missing data. A missing quota response is not a budget risk; a missing cost response is not zero cost; a missing department endpoint is not zero department usage.
- In CSP mode, omit request counts, active-user counts, workspace allocation, and workspace quotas unless a successful command explicitly returned them.
- If department token usage is unsupported in the current runtime mode, omit department rankings and base the summary on tenant/API Key/workspace data that was retrieved.
- Capacity risk must be grounded in retrieved throughput, rated capacity, GPU utilization, node metrics, or explicit bottleneck forecast data.
- Financial conclusions require retrieved revenue/cost/profit data or retrieved token usage plus retrieved price/cost configuration. Otherwise omit financial metrics.
- A calculated token charge is not infrastructure cost, gross profit, or ROI. Use the returned price units and currency metadata exactly; if currency is absent, say `pricing units`.
- Risk recommendations must map to retrieved evidence: quota exhaustion, low utilization, traffic drop, concentration, alert/security event, or explicit risk-suggestion API output.
