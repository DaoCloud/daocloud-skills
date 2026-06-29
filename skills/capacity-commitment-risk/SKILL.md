---
name: capacity-commitment-risk
description: Assess whether current supply commitments match actual DCE capacity and identify the main risks over the next 90 days using live data. Use when asked "当前供给承诺与实际产能是否匹配", "未来 90 天产能风险在哪里", "GPU/LLM 平台承诺量是否超卖", "capacity commitments vs actual capacity", "90-day supply risk", quota, queue, GPU capacity, tenant demand, or contract-backed supply planning. Requires real DCE queries and/or a real commitment file; do not answer with a generic framework.
---

# Capacity Commitment Risk

Evaluate whether promised supply can actually be delivered by comparing:

- **Commitments:** contracted/reserved GPU, token, queue, quota, or workspace
  commitments from DCE quotas and/or a real commitment file.
- **Actual capacity:** live DCE GPU inventory, queue capacity, model-serving
  replicas, utilization, workspace activity, and billing/usage trend.
- **90-day risk:** gaps, ramp dates, high utilization, tenant concentration,
  missing join keys, and commitments without observable capacity.

Do not fabricate commitment volume or future demand. Every number must come from
live DCE output, a real user-provided commitment file, or an explicit
assumption/gap.

Runtime dependency rule: use only POSIX `sh` plus the `dce` CLI. Commitment
files and evidence artifacts are JSON. Do not add extra interpreters, JSON
parsers, package installs, or third-party libraries for this skill.

## Quick Start

Run the bundled evidence collector from this skill directory:

```bash
sh scripts/collect_capacity_commitment_risk.sh \
  --hostname https://<dce-host> \
  --as-of 2026-06-29 \
  --history-start 2026-05-30 \
  --horizon-days 90 \
  --commitment-file /path/to/commitments.json \
  --cluster <gpu-cluster> \
  --workspace <workspace-id>
```

If no commitment file exists, still run the script without it. It will query DCE
for workspace quotas, model services, usage, and capacity inventory. If no
`--cluster` / `--workspace` is supplied, inspect the collected `clusters.json`
and `workspaces.json`, then rerun with the relevant ids to collect GPU devices,
queues, and billing. Label the result as **DCE quota proxy only** rather than
contractual commitment when no real commitment file exists.

## Required Workflow

Use the `dce` skill rules for command inspection, auth checks, and module
availability. Then run the shell collector or perform equivalent live read-only
queries. The shell collector intentionally does not parse JSON; after it writes
the evidence directory, read the JSON files and compute the tables/risk ranking
from those real results.

Minimum live query set:

```bash
dce auth status --hostname <host>
dce global-management workspace list-workspaces --page 1 --page-size 200 -o json
dce container-management cluster list-clusters --page 1 --page-size 200 -o json
dce container-management devices list-gpu-devices --cluster <cluster> -o json
dce llm-studio workspacequotaservice list-workspace-quotas --page.page-size -1 -o json
dce llm-studio modelservingmanagement list-model-serving --page.page-size -1 -o json
dce operations-management report list-workspaces --start <history-start> --end <as-of> -o json
```

Optional, but recommended:

```bash
dce llm-studio queuemanagement list-queues2 --workspace <id> --page.page-size -1 -o json
dce ai-lab queuemanagement list-queues2 --workspace <id> --page.page-size -1 -o json
dce billing-center bill get-account-bill-aggregation --workspace-id <id> --start-time <unix> --end-time <unix> -o json
dce llm-studio apikeymanagement get-api-key-usage-statistics2 --start-time <rfc3339> --end-time <rfc3339> --period TIME_PERIOD_DAY -o json
```

## Commitment Sources

Read `references/input-contracts.md` when using a commitment file. A commitment
file is required for contract-backed conclusions such as "signed GPU promise",
"reserved GPU", "SLA minimum capacity", or "delivery date". DCE workspace quotas
and queues are real data, but they are **not automatically contracts**.

When only DCE quota data exists:

- Say "commitment source: DCE quota/queue proxy".
- Do not claim contractual overcommitment.
- Rank risks as data-closure / quota-vs-capacity / utilization / concentration.

## Matching Logic

For each resource class:

- GPU commitments: compare `committed_gpu` by model/cluster/window with live GPU
  inventory and utilization-adjusted headroom.
- Token commitments: compare token quota/contract with recent token usage trend
  and serving capacity signals.
- Queue commitments: compare queue nominal quota/flavors with live cluster GPU
  inventory and active workloads.
- Workspace/customer commitments: join by `workspace_id`, alias, username, or
  explicitly supplied customer name; mark missing joins.

Use a conservative 90-day stance:

```text
available_headroom = physical_capacity - current_reserved_or_committed
utilization_adjusted_headroom = physical_capacity * (1 - max(avg_gpu_util, 0.7 if unknown))
coverage = available_or_total_capacity / committed_capacity
```

If utilization is missing, report both physical coverage and reduced confidence.

## Output Requirements

Answer in Chinese when the user asks in Chinese. Include:

1. Data scope and source: host, as-of date, 90-day horizon, history window,
   commitment source.
2. Query trace: commands/endpoints, row counts, failed queries.
3. Supply vs commitment table: resource, committed, actual, headroom, coverage,
   confidence.
4. 90-day risk ranking: risk, severity, when it can materialize, evidence,
   exact next action.
5. Data gaps that prevent a stronger conclusion.

Use this conclusion style:

```text
结论：当前供给承诺 <匹配/偏紧/不匹配/无法闭合>。
未来 90 天主要风险：
1. <risk>（高/中/低）— evidence...
2. <risk>（高/中/低）— evidence...
```

Never write "风险一定会发生". Use "证据指向 / 主要风险 / 需要确认".
