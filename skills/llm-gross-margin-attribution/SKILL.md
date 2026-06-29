---
name: llm-gross-margin-attribution
description: Attribute why LLM gross margin got worse using live DCE data. Use when the user asks whether today's/this week's LLM gross margin decline is caused by model cost, tenant/customer mix, cache hit-rate changes, token usage, billing, or asks for ranked impact attribution such as "今天毛利变差是模型成本、租户结构还是缓存命中率变化导致的？按影响大小排序". Requires real DCE queries; do not answer with a generic framework.
---

# LLM Gross Margin Attribution

Diagnose an LLM gross-margin decline by querying DCE, comparing a current period
against a baseline period, and ranking the margin impact of:

1. Model cost / unit-cost change.
2. Tenant or workspace mix change.
3. Cache hit-rate change.

Do not fabricate numbers. Every metric must come from a live DCE command, a
user-provided real unit-cost file, or an explicitly reported missing-data gap.

Runtime dependency rule: use only POSIX `sh` plus the `dce` CLI. Cost/map inputs
and evidence artifacts are JSON. Do not add extra interpreters, JSON parsers,
package installs, or third-party libraries for this skill.

## Required Stance

- Query real data first. Do not answer with only a decomposition framework.
- Use read-only commands only.
- Show the data-collection trace before the conclusion.
- Rank by margin-point impact on gross margin deterioration, not by narrative
  plausibility.
- If Billing Center revenue or LLM Studio token/cache data is missing, stop or
  mark the attribution incomplete. Do not infer them from deployment inventory.
- If model-cost data is unavailable in DCE, ask for a real cost source
  (`--model-cost-file`) or use Gmagpie pod cost with a model-serving map. Do not
  invent model prices.

## Quick Start

Run the bundled evidence collector from this skill directory:

```bash
sh scripts/collect_margin_attribution.sh \
  --hostname https://<dce-host> \
  --current-start 2026-06-29T00:00:00+08:00 \
  --current-end 2026-06-29T23:59:59+08:00 \
  --baseline-start 2026-06-28T00:00:00+08:00 \
  --baseline-end 2026-06-28T23:59:59+08:00 \
  --cost-search <serving-or-pod-search>
```

For upstream/provider model costs that are not represented by GPU pod fees, use
a real unit-cost file from finance/provider contracts:

```bash
sh scripts/collect_margin_attribution.sh \
  --hostname https://<dce-host> \
  --current-start <rfc3339> --current-end <rfc3339> \
  --baseline-start <rfc3339> --baseline-end <rfc3339>
```

The shell collector runs live `dce` queries and writes raw JSON evidence plus a
trace file. It intentionally does not parse JSON; after it writes the evidence
directory, read those JSON files and compute the ranked attribution from real
results. If model cost requires a finance/provider cost file, read the real JSON
cost file separately and cite it in the output.

## Data Sources

Use the `dce` skill rules for command discovery, auth checks, and module
availability.

Minimum live query set:

```bash
dce auth status --hostname <host>
dce global-management workspace list-workspaces --page 1 --page-size 200 -o json
dce llm-studio apikeymanagement get-api-key-usage-statistics2 --start-time <start> --end-time <end> --period TIME_PERIOD_DAY -o json
dce llm-studio modelservingmanagement list-model-serving --page.page-size -1 -o json
dce billing-center bill list-bills --billing-time-start <date> --billing-time-end <date> --page 1 --page-size 200 -o json
```

If tenant/workspace-level attribution cannot be joined from API-key usage,
discover the available LLM Studio workspace dashboard commands with `dce` and
run the matching workspace token-usage endpoint for each relevant workspace as
an optional follow-up. Treat those workspace dashboard rows as enrichment, not
as a dependency that blocks the base collector.

Cost source, choose one:

- `gmagpie`: query `dce operations-management fee list-pods-fee` using a
  user-provided model-serving map with cluster/namespace/pod search strings.
- `unit-cost-file`: use a real model-cost file; see
  `references/input-contracts.md`.

For cache metrics, prefer LLM Studio cached-token fields from API-key usage
statistics. If the deployment also exposes lower-level Prometheus counters
through Insight, use them only as a cross-check unless the LLM Studio field is
missing.

## Attribution Method

Compare current period against baseline:

```text
gross_margin = (revenue - model_cost) / revenue
margin_delta = current_gross_margin - baseline_gross_margin
```

Compute three ranked impacts:

- `model_cost`: change in model cost per billable token, holding current
  traffic/revenue mix fixed.
- `tenant_mix`: shift of revenue/token share across workspaces or tenants with
  different baseline margins.
- `cache_hit_rate`: change in cached-token share, converted to saved or added
  model cost using the real model cost basis.

Use Shapley-like averaging when all fields are present; otherwise use the
script's conservative stepwise estimate and label confidence `medium` or `low`.
Any unallocated difference is reported as residual, not hidden.

## Output Requirements

Answer in Chinese when the user asks in Chinese. Include:

1. Data scope: current period, baseline period, timezone, data source, coverage.
2. Query trace: commands/endpoints, row counts, failed queries.
3. KPI table: revenue, model cost, gross margin, tokens, cached tokens, cache
   hit rate, active workspaces.
4. Ranked impact table: factor, margin-point impact, direction, evidence,
   confidence.
5. Data gaps and exact next query needed if attribution is incomplete.

Use this conclusion style:

```text
按毛利恶化影响排序：
1. 模型成本上升：-x.x pct point
2. 租户结构变化：-y.y pct point
3. 缓存命中率下降：-z.z pct point
```

Never write "根因一定是 X" unless only one factor has data and the others are
proven flat. Prefer "证据指向 / 主要拖累 / 次要拖累".
