---
name: container-management:gpu-bottleneck-analysis
description: >
  Use when a user asks to analyze GPU pool or GPU cluster capacity, predict
  bottlenecks under traffic, QPS, or inference load growth, or choose between
  scaling, throttling, and routing changes. Also use for Chinese requests about
  GPU 池/集群容量、流量上涨、QPS 增长、推理负载增长、哪个 GPU 池先成为瓶颈、是否扩容/限流/改路由.
  Example prompts include "如果今晚流量上涨 30%，哪个 GPU 池会先成为瓶颈？",
  "建议扩容、限流还是改路由？", "which GPU pool will bottleneck first",
  and "what if traffic increases by X%".
---

# GPU Pool Bottleneck Analysis

Analyze GPU cluster capacity across multiple clusters, predict bottlenecks under
increased inference QPS, and recommend concrete actions (scale, throttle, or
reroute).

**REQUIRED SUB-SKILL:** Use `dce` for all command execution, auth checks, and
catalog discovery.

**SCOPE:** Read-only analysis. This skill does NOT create, modify, or delete
any resources.

## When to Use

- "If traffic increases by 30%, which GPU pool will bottleneck first?"
- "Should we scale, throttle, or change routing for GPU workloads?"
- "GPU capacity planning across clusters"
- "Which cluster has the most GPU headroom?"
- "Predict GPU saturation under load increase"

## Prerequisites

- `dce` auth is established. If not, stop and instruct the user to run
  `dce auth login --hostname <host>`.
- User provides the inference QPS metric name if it is not a standard kpanda
  metric (see Step 4).

## Workflow

### Step 1 — Discover GPU Clusters

Run `dce container-management cluster list-clusters -o json` to get all clusters.

Then identify which clusters have GPU capacity. Use one of:
- `dce container-management cluster list-all-cluster-gpu` (returns global GPU inventory)
- Filter clusters by checking node labels/GPU allocatable resources in Step 2

If the user specified target clusters, use those instead.

**Output:** List of clusters to analyze, each marked with GPU presence.

**After execution, summarize:** "Found X clusters with GPU. Names: ..."

### Step 2 — GPU Resource Census (per cluster)

For each GPU cluster, collect capacity and utilization data. Use **kpanda aggregated
recording rules** (preferred) as the primary data source; fall back to dce node
APIs only when metrics are unavailable.

#### 2a — Query Aggregated GPU Metrics (preferred)

Use `dce insight metric batch-query-metric` with the following PromQL queries.
These recording rules are maintained by kpanda and cover all three GPU modes:
**GPU**, **MIG**, and **VGPU**.

| Metric | PromQL | What it tells you |
|--------|--------|-------------------|
| GPU count per node | `sum(kpanda_gpu_count) by (node, mode)` | Physical GPU / MIG instance / vGPU count |
| GPU allocated per node | `sum(kpanda_gpu_allocated) by (node, mode)` | GPUs already reserved by Running/Pending pods |
| GPU core utilization | `avg(kpanda_gpu_device_core_utilization) by (node, mode)` | Actual GPU compute utilization (%) |
| GPU memory allocated | `sum(kpanda_gpu_mem_allocated) by (node, mode)` | VRAM reserved by pods (MiB) |
| GPU memory total | `sum(kpanda_gpu_device_memory_total) by (node, mode)` | Total VRAM per node (MiB) |
| GPU memory used | `sum(kpanda_gpu_device_memory_used) by (node, mode)` | Actual VRAM consumed (MiB) |
| GPU mode per node | `kpanda_gpu_mode` | Whether node uses GPU / MIG / VGPU |

**Cluster-level aggregation (sum across nodes):**
```promql
# Total GPU capacity by mode
sum(kpanda_gpu_count) by (mode)

# Total allocated GPUs by mode
sum(kpanda_gpu_allocated) by (mode)

# Average core utilization (weighted by GPU count)
avg(kpanda_gpu_device_core_utilization) by (mode)

# Total memory capacity / allocated / used by mode
sum(kpanda_gpu_device_memory_total) by (mode)
sum(kpanda_gpu_mem_allocated) by (mode)
sum(kpanda_gpu_device_memory_used) by (mode)
```

#### 2b — Fallback: dce Node APIs

If the insight metrics API returns empty or errors:

```
dce container-management core list-nodes --cluster <cluster> -o json
dce container-management core get-node --cluster <cluster> --name <node> -o json
dce container-management core get-node-gpu-stats --cluster <cluster> --node <node>
dce container-management core list-node-gpu --cluster <cluster> --node <node>
dce container-management clustersetting list-gpu-setting --cluster <cluster> --available-enable=true
```

**After execution, summarize per cluster:**
"Cluster `<name>`: X GPUs (mode: Y), Z% utilized, W MiB VRAM used / total."

**Per-cluster summary (by GPU mode):**

| Field | Source | Why it matters |
|-------|--------|----------------|
| Total GPUs | `kpanda_gpu_count` | Physical capacity ceiling |
| Allocated GPUs | `kpanda_gpu_allocated` | Reserved by pods (may be > utilized) |
| Utilized GPUs (effective) | `core_utilization * total` | Actual compute usage |
| Remaining GPUs (by alloc) | `total - allocated` | How many more can be scheduled |
| Remaining GPUs (by util) | `total * (1 - utilization%)` | How much compute headroom exists |
| Total VRAM | `kpanda_gpu_device_memory_total` | Memory capacity ceiling |
| Allocated VRAM | `kpanda_gpu_mem_allocated` | VRAM reserved by pods |
| Used VRAM | `kpanda_gpu_device_memory_used` | Actual VRAM consumed |

> **Important distinction:** `allocated` reflects Kubernetes resource **requests**
> (what pods have reserved), while `utilized` / `used` reflects **actual consumption**.
> Bottleneck can occur at either layer — pods may fail to schedule (allocation
> exhausted) or GPU may be fully utilized (compute/memory exhausted).

### Step 3 — Workload & HPA Analysis (per cluster)

For each GPU cluster:

1. **GPU workloads:**
   ```
   dce container-management apps list-all-deployments --cluster <cluster> --gpu-type "*" -o json
   ```
   - Record: workload name, namespace, replicas, GPU request per pod

2. **HPA configuration:**
   ```
   dce container-management autoscaling list-horizontal-pod-autoscalers --cluster <cluster> --namespace <ns> -o json
   ```
   - Record: HPA target, min/max replicas, current replicas, target metric

3. **Resource quotas (optional but recommended):**
   ```
   dce container-management core compute-resource-quota --cluster <cluster> --namespace <ns>
   ```
   - Record: GPU quota limits per namespace

**After execution, summarize:**
"Cluster `\u003cname\u003e`: X GPU workloads running, Y total replicas. HPA configured: yes/no."

**Purpose:** Understand how workloads will respond to load increase.
Workloads with HPA may auto-scale, consuming more GPU; workloads without HPA
will queue or fail.

### Step 4 — Metric Collection (per cluster)

Collect current QPS and GPU metrics using **kpanda aggregated recording rules**
where available.

#### 4a — GPU Metrics (via dce insight metric)

Query the kpanda GPU recording rules for each cluster using the insight metric API:

**Batch query (preferred for multiple metrics):**
```
dce insight metric batch-query-metric --file - -o json
```

**Body for GPU capacity/utilization snapshot:**
```json
{
  "matchLabel": {
    "clusterName": "<cluster>"
  },
  "param": {
    "time": 1747850400
  },
  "queryList": [
    "sum(kpanda_gpu_count) by (mode)",
    "sum(kpanda_gpu_allocated) by (mode)",
    "avg(kpanda_gpu_device_core_utilization) by (mode)",
    "sum(kpanda_gpu_device_memory_total) by (mode)",
    "sum(kpanda_gpu_mem_allocated) by (mode)",
    "sum(kpanda_gpu_device_memory_used) by (mode)"
  ]
}
```

**Body for per-node breakdown:**
```json
{
  "matchLabel": {
    "clusterName": "<cluster>"
  },
  "param": {
    "time": 1747850400
  },
  "queryList": [
    "sum(kpanda_gpu_count) by (node, mode)",
    "sum(kpanda_gpu_allocated) by (node, mode)",
    "avg(kpanda_gpu_device_core_utilization) by (node, mode)"
  ]
}
```

**Single query (for quick checks):**
```
dce insight metric query-metric --cluster-name <cluster> --query '<promql>' -o json
```

**Range query (for trend analysis):**
```
dce insight metric query-range-metric --cluster-name <cluster> --query '<promql>' --start <unix_sec> --end <unix_sec> --step 60 -o json
```

**Batch range query (for multiple time-series):**
```
dce insight metric batch-query-range-metric --file - -o json
```

**Body:**
```json
{
  "matchLabel": {
    "clusterName": "<cluster>"
  },
  "param": {
    "start": 1747846800,
    "end": 1747850400,
    "step": 60
  },
  "queryList": [
    "avg(kpanda_gpu_device_core_utilization) by (mode)"
  ]
}
```

#### 4b — QPS Metrics (workload-specific)

QPS is not covered by kpanda GPU recording rules. Try workload-specific queries:

```promql
# Common inference QPS patterns — try in order:
rate(inference_requests_total[5m])
rate(http_requests_total{service=~".*infer.*"}[5m])
sum(rate(request_count{destination_workload=~".*gpu.*"}[5m]))
sum(rate(istio_requests_total{destination_service=~".*infer.*"}[5m]))
```

If the inference workload exposes custom metrics, the user may need to provide
the exact metric name.

**After execution, summarize:**
"Cluster `\u003cname\u003e`: GPU utilization X%, VRAM usage Y/Z MiB. QPS: [value or 'not found']."

#### 4c — Fallback APIs

If `dce insight metric` is unavailable, use:

```
dce container-management autoscaling list-metric-values --cluster <cluster> --namespace <ns> --kind <kind> --kind-name <name> --name <metric_name>
dce container-management autoscaling list-custom-metric-summary --cluster <cluster> --kind <kind>
```

#### 4d — User fallback

**If automatic metric collection fails** (empty results or errors), ask the user
to provide:
- Current total QPS across all GPU clusters (or per cluster)
- Current average GPU core utilization per cluster (%)
- Current VRAM utilization per cluster (%)
- GPU resource request per inference request (if known)

### Data Integrity Checkpoint (Before Step 5)

**Before proceeding to bottleneck analysis, verify you have actual data:**

| Required Data | Source | Status |
|---------------|--------|--------|
| Cluster name(s) | Step 1 command output | □ Verified |
| GPU capacity (total/allocated) | Step 2 metrics or API output | □ Verified |
| GPU utilization (%) | Step 2 or Step 4 metrics | □ Verified |
| GPU workload count | Step 3 command output | □ Verified |
| QPS data | Step 4 metrics or user fallback | □ Verified / □ Missing |

**If any REQUIRED data (first 4 rows) is missing:**
- Stop analysis.
- Report: "Missing data for `<field>`. Cannot proceed with bottleneck analysis."
- Ask user to provide the missing information or verify cluster access.

**If QPS data is missing but other data is present:**
- Proceed with utilization-based projection only (Case B in Step 5.2).
- Clearly state: "QPS data unavailable. Using GPU utilization-based projection only."

### Step 5 — Bottleneck Analysis & Recommendations

#### 5.1 Calculate Headroom (by GPU mode)

For each cluster, calculate headroom **per GPU mode** (GPU / MIG / VGPU),
then aggregate.

**Compute headroom:**
```
Total GPU               = sum(kpanda_gpu_count) by (mode)
Allocated GPU           = sum(kpanda_gpu_allocated) by (mode)
Core Utilization        = avg(kpanda_gpu_device_core_utilization) by (mode)

Remaining (by alloc)    = Total - Allocated          # Scheduling headroom
Remaining (by util)     = Total * (1 - Utilization%)  # Compute headroom
```

**Memory headroom:**
```
Total VRAM              = sum(kpanda_gpu_device_memory_total) by (mode)
Allocated VRAM          = sum(kpanda_gpu_mem_allocated) by (mode)
Used VRAM               = sum(kpanda_gpu_device_memory_used) by (mode)

VRAM Remaining (alloc)  = Total - Allocated
VRAM Remaining (used)   = Total - Used
```

Use the **more conservative** of allocation-based and utilization-based headroom.

**Why two perspectives matter:**
- **Allocation bottleneck** (`Allocated >= Total`): New pods cannot be scheduled,
  even if GPUs are idle. Occurs when resource requests are over-provisioned.
- **Utilization bottleneck** (`Utilization >= 100%`): GPUs are fully busy.
  Occurs when actual load exceeds compute capacity.

#### 5.2 Model +30% Load

**Scenario:** Inference QPS increases by 30%.

**Case A — QPS data is available:**
```
Current QPS per cluster = <measured or provided>
Projected QPS           = Current QPS * 1.3
Additional QPS          = Current QPS * 0.3

If QPS-to-GPU ratio is known:
  Additional GPU need   = Additional QPS / (QPS per GPU)
Else:
  Assume linear scaling: Additional GPU need = Allocated * 0.3

Projected Allocated     = Current Allocated + Additional GPU need
Projected Utilization   = Current Utilization * 1.3
```

**Case B — QPS data is NOT available:**
```
Assume utilization scales linearly with QPS:
Projected Utilization   = Current Utilization * 1.3
Projected Allocated     = Current Allocated * 1.3  (conservative)
```

**Bottleneck detection:**
```
Compute bottleneck  if Projected Utilization > 90% (threshold for latency degradation)
                      or Projected Utilization > 100% (hard saturation)

Scheduling bottleneck if Projected Allocated > Total

VRAM bottleneck     if Projected VRAM usage > Total VRAM
                      (estimate: Used VRAM * 1.3, or Allocated VRAM * 1.3)
```

**HPA Consideration:**
If a cluster has HPA-enabled GPU workloads, factor in auto-scaling:
```
HPA max additional GPU = sum(HPA max_replicas * gpu_request) - sum(current replicas * gpu_request)
Effective capacity     = Remaining GPU + HPA max additional GPU
```

#### 5.3 Identify First Bottleneck

For each cluster, compute a **bottleneck score** considering all constraint types:

| Constraint | Score Formula | Weight |
|------------|--------------|--------|
| Compute saturation | `Projected Utilization / 100` | 1.0 |
| Scheduling saturation | `Projected Allocated / Total` | 1.0 |
| VRAM saturation | `Projected VRAM / Total VRAM` | 0.8 |

**Total score** = weighted sum. Cluster with highest score is the first bottleneck.

**Per-mode breakdown:** Report which GPU mode (GPU / MIG / VGPU) within the
cluster becomes constrained first, as different modes may have different headroom.

**Tie-breaking:**
1. Higher current core utilization
2. Smaller remaining GPU count (less scaling flexibility)
3. No HPA configured (cannot auto-scale)
4. Higher VRAM utilization

#### 5.4 Generate Recommendations

For the bottleneck cluster (and any cluster with score > 1.0), recommend in
priority order:

| Condition | Recommendation | Rationale |
|-----------|---------------|-----------|
| Other clusters have >30% headroom | **Change routing** | Shift traffic to healthier clusters; fastest to implement |
| Bottleneck is allocation (not utilization) | **Scale out** | Add GPU nodes; scheduling pressure means queueing |
| Bottleneck is utilization, growth is temporary | **Throttle** | Reduce QPS at ingress; protects latency SLA |
| All clusters near saturation | **Scale + Throttle** | Scale all clusters AND throttle to buy time |
| No scaling capacity and no routing target | **Throttle** | Only option to prevent cascading failure |
| MIG mode saturated but GPU mode has headroom | **Change mode / reconfigure** | Consolidate MIG workloads or migrate to GPU mode |

**Output format:** Present the recommendation with:
- Action type (Scale / Throttle / Route / Reconfigure)
- Target cluster(s) and GPU mode(s)
- Constraint type (Compute / Scheduling / VRAM)
- Estimated impact (how much additional load can be absorbed)
- Confidence level (High/Medium/Low) based on data quality

## Output Format

Present a structured report in this order:

1. **GPU Cluster Overview**
   - Per cluster, per GPU mode (GPU / MIG / VGPU):
   - Table: Cluster | Mode | Total | Allocated | Core Util% | VRAM Total | VRAM Alloc | VRAM Used%

2. **Current Load Distribution**
   - Table: Cluster | Current QPS | GPU Workloads | Total Replicas | HPA Enabled?

3. **+30% Traffic Projection**
   - Per cluster, per mode:
   - Table: Cluster | Mode | Proj Core Util% | Proj Allocated | Sched Headroom | Compute Headroom | VRAM Headroom | Status
   - Status: **OK** (all headroom > 30%) / **At Risk** (some headroom 10-30%) / **Critical** (any headroom < 10% or negative)

4. **Bottleneck Determination**
   - First bottleneck cluster: `<name>`
   - Bottleneck mode: `<GPU|MIG|VGPU>`
   - Constraint type: `<Compute|Scheduling|VRAM>`
   - Reason: `<specific metric and value>`
   - Time to saturation (if trend data available): `<estimate>`

5. **Recommended Actions** (prioritized)
   - Action 1: `<type>` on `<target>` (mode: `<mode>`) — `<rationale>`
   - Action 2: `<type>` on `<target>` (mode: `<mode>`) — `<rationale>`
   - Fallback: `<type>` — `<when to use>`

6. **Data Quality & Assumptions**
   - List any assumptions made (e.g., "linear QPS-to-GPU scaling assumed")
   - Flag any missing data that would improve accuracy

## Rules

### Hard Constraints

1. **Execute Before Analyze — 先执行，后分析**
   - **NEVER** present analysis, tables, or conclusions before executing the
     corresponding `dce` command.
   - **NEVER** hallucinate command output. If a command has not been executed,
     you do not have data.
   - If a step requires data from a previous command, **wait for the command
     output** before proceeding.

2. **No Fabricated Data — 禁止编造数据**
   - Every number, cluster name, node name, GPU count, utilization percentage,
     or QPS value **must** come from actual `dce` command output.
   - If a command returns empty, report "no resources found" or "no data".
   - Do not fill in "typical" or "example" values.
   - Do not assume GPU model, node count, or capacity from cluster name alone.

3. **Summarize Command Output — 命令输出摘要**
   - After each `dce` command execution, **summarize the result in 2-4 sentences**
     before moving to the next step.
   - Extract only the key facts (e.g., "Found 3 clusters with GPU: A, B, C")
   - Do not dump full JSON or table output into the conversation.
   - If the output is large, use a subagent or redirect to file, then report
     the summary.

4. **Data Integrity Checkpoint — 数据完整性检查点**
   - Before Step 5 (Bottleneck Analysis), confirm that you have:
     - At least one cluster name with verified GPU presence
     - GPU capacity numbers (total / allocated) from actual metrics or APIs
     - Current utilization data OR explicit user-provided fallback values
   - If any required data is missing, **stop** and ask the user for the missing
     information. Do not proceed with incomplete data.

### General Rules

- **Read-only:** Do not create, modify, or delete any resources.
- **Prefer `-o json`:** Use JSON output for machine-readable parsing.
- **Do not guess commands:** Confirm with `dce commands show` before executing
  unfamiliar commands.
- **Report empty responses:** Say "no resources found" rather than silently
  skipping.
- **Transparent assumptions:** Clearly state any assumptions used in calculations.
- **Progressive data collection:** Try automatic metrics first; fall back to
  user-provided values.
- **Conservative estimates:** When in doubt, use the more pessimistic capacity
  estimate.

## User omitted cluster name

Run `dce container-management cluster list-clusters -o json`, present the GPU-enabled
clusters, and ask the user to pick one or more for analysis.

## Auth not established

Stop and instruct the user to run `dce auth login --hostname <host>`.

---

## Appendix: Complete Command & PromQL Reference

All commands and queries used by this skill. This section is inlined so the AI
has full context without reading external files.

### dce container-management Commands

**Cluster Discovery:**
```bash
dce container-management cluster list-clusters -o json
dce container-management cluster list-all-cluster-gpu
dce container-management cluster get-cluster --name <cluster> -o json
```

**Node & GPU Resources:**
```bash
dce container-management core list-nodes --cluster <cluster> -o json
dce container-management core get-node --cluster <cluster> --name <node> -o json
dce container-management core get-node-gpu-stats --cluster <cluster> --node <node>
dce container-management core list-node-gpu --cluster <cluster> --node <node>
dce container-management clustersetting list-gpu-setting --cluster <cluster> --available-enable=true
```

**Workloads:**
```bash
dce container-management apps list-all-deployments --cluster <cluster> --gpu-type "*" -o json
dce container-management apps list-all-stateful-sets --cluster <cluster> --gpu-type "*" -o json
```

**HPA & Autoscaling:**
```bash
dce container-management autoscaling list-horizontal-pod-autoscalers --cluster <cluster> --namespace <ns> -o json
dce container-management autoscaling list-metric-values --cluster <cluster> --namespace <ns> --kind <Pod|Service> --kind-name <name> --name <metric_name>
dce container-management autoscaling list-custom-metric-summary --cluster <cluster> --kind <Pod|Service>
```

**Resource Quotas:**
```bash
dce container-management core compute-resource-quota --cluster <cluster> --namespace <ns>
```

### dce insight metric Commands

```bash
# Batch instant query (preferred)
dce insight metric batch-query-metric --file - -o json
# Body: { "matchLabel": {"clusterName": "..."}, "param": {"time": <unix_sec>}, "queryList": [...] }

# Single instant query
dce insight metric query-metric --cluster-name <cluster> --query '<promql>' --time <unix_sec> -o json

# Range query
dce insight metric query-range-metric --cluster-name <cluster> --query '<promql>' \
  --start <unix_sec> --end <unix_sec> --step 60 -o json

# Batch range query
dce insight metric batch-query-range-metric --file - -o json
# Body: { "matchLabel": {"clusterName": "..."}, "param": {"start": ..., "end": ..., "step": 60}, "queryList": [...] }
```

### Kpanda GPU Recording Rules (PromQL)

**GPU Mode & Count:**
```promql
kpanda_gpu_mode
sum(kpanda_gpu_count) by (node, mode)
sum(kpanda_gpu_count) by (mode)
```

**GPU Allocation:**
```promql
sum(kpanda_gpu_allocated) by (node, mode)
sum(kpanda_gpu_allocated) by (mode)
sum(kpanda_gpu_allocated) by (mode) / sum(kpanda_gpu_count) by (mode)
```

**GPU Core Utilization:**
```promql
kpanda_gpu_device_core_utilization
avg(kpanda_gpu_device_core_utilization) by (node, mode)
avg(kpanda_gpu_device_core_utilization) by (mode)
```

**GPU Memory:**
```promql
kpanda_gpu_device_memory_total
kpanda_gpu_device_memory_used
sum(kpanda_gpu_mem_allocated) by (node, mode)
sum(kpanda_gpu_device_memory_used) by (mode) / sum(kpanda_gpu_device_memory_total) by (mode)
```

**Pod-Level GPU Metrics:**
```promql
kpanda_gpu_pod_utilization
kpanda_gpu_mem_pod_usage
kpanda_gpu_mem_pod_utilization
```

**QPS / Request Rate (workload-specific, try in order):**
```promql
rate(inference_requests_total[5m])
rate(http_requests_total{service=~".*infer.*"}[5m])
sum(rate(request_count{destination_workload=~".*gpu.*"}[5m]))
sum(rate(istio_requests_total{destination_service=~".*infer.*"}[5m]))
```
