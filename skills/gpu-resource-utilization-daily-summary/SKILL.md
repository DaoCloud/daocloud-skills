---
name: gpu-resource-utilization-daily-summary
description: >-
  Generate a Chinese daily GPU operations snapshot for system resource utilization,
  idle headroom, and the trade-off between higher utilization and elastic buffer.
  Use for requests containing 今日系统运维摘要, 系统资源利用率, 空闲余量, GPU利用率,
  资源利用效率, or 弹性缓冲. Query only the Crane API endpoint
  /apis/crane.io/v1alpha1/singlepage/gpu-resource-status through its DCE command.
---

# GPU Resource Utilization Daily Summary

## Scope

Read-only snapshot. Use only the Crane endpoint below; do not call another endpoint,
metric source, DCE module, or helper script.

## Workflow

Run this command exactly once:

```bash
dce business-cockpit singlepageservice get-gpu-resource-status -o json
```

Treat the JSON response as the sole source of truth. Record the local collection
date and time. This endpoint is a snapshot, so do not claim a full-day trend.

## Calculations

Use only fields present in the response:

- `gpuTotal`: total GPU cards.
- `busyCount`, `idleCount`, `errorCount`: state counts.
- `utilizationPct`, `memUsagePct`, `hbmUsagePct`, `kvCacheHitPct`,
  `networkThroughputGbps`: observed system indicators.
- State ratio = state count / `gpuTotal` × 100.
- Observed idle headroom = `idleCount` / `gpuTotal` × 100.
- Utilization headroom = 100 - `utilizationPct`.
- Unclassified cards = `gpuTotal` - (`busyCount` + `idleCount` + `errorCount`).

Do not equate idle cards with guaranteed schedulable capacity. Report both state
headroom and utilization headroom, and flag a non-zero unclassified count.

## Decision logic

Give a short evidence-based recommendation:

- Favor efficiency actions when utilization is below 60%, idle headroom is at
  least 30%, and memory/HBM indicators are not high: consolidate fragmented
  workloads, improve placement, or route more work to idle capacity.
- Favor a balanced posture when utilization is 60–80% or idle headroom is
  20–30%: improve utilization gradually while protecting the observed idle pool.
- Favor elastic buffer or capacity action when utilization is above 80%, idle
  headroom is below 20%, any memory/HBM indicator is above 85%, or error cards
  are present. Do not recommend consuming the remaining buffer aggressively.
- If signals conflict, prioritize error and memory/HBM risk over GPU compute
  utilization and say why.

These thresholds are operating heuristics, not measurements from the API.

## Response

Write the final answer in Chinese, using compact Markdown tables. Omit
missing metrics; never invent zeros or placeholders. Keep it concise and include:

1. A one-sentence conclusion with collection time and the snapshot limitation.
2. A status-distribution table with count and percentage for busy, idle, error, and
   unclassified cards when applicable.
3. A utilization-metrics table for GPU, memory, HBM, and KV Cache; show network
   throughput as a numeric value.
4. A headroom-and-trade-off table comparing observed idle headroom, utilization headroom,
   risk signal, and the recommended posture.
5. At most three findings and two concrete actions, each tied to retrieved data.

Do not expose raw response data beyond the fields needed for the summary. If the
query fails, report that the summary could not be generated and show the command
that failed; do not substitute another data source.
