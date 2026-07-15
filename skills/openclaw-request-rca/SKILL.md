---
name: openclaw-request-rca
description: >
  Diagnose OpenClaw request failures or slow requests with DCE Insight tracing,
  alerts, logs, and pod status. Use when the user asks for OpenClaw request
  root-cause analysis, R.E.D analysis, error-chain details, or mitigation advice.
---

# OpenClaw Request RCA

## Overview

Use this skill to produce a request-focused OpenClaw root-cause analysis from DCE Insight data. The output should answer:

1. Is the OpenClaw request failing, slow, or healthy-but-degraded?
2. Which request stage is responsible: ingress, OpenClaw request wrapper, agent runtime, downstream tool/model/IO, or platform dependency?
3. What evidence supports the root cause?
4. What short-term mitigation and longer-term fix should be applied?

Always include R.E.D dimensions:

- Rate: request throughput.
- Errors: failed/error spans and platform alerts.
- Duration: service latency, operation latency, and slow spans.

OpenClaw spans can be isolated with this span tag:

```text
otel.scope.name=openclaw-otel-plugin
```

Prefer direct DCE CLI queries and JSON output. Do not infer root cause from a single signal; correlate OpenClaw spans with platform-side pods, alerts, and gateway logs.

## Request RCA Workflow

Follow this order. Do not jump directly from an alert to a root cause without checking the OpenClaw request span.

### Fast Path: One Terminal Call

For a normal "recent OpenClaw analysis" request, use the bundled collector first. It performs the necessary DCE API calls concurrently and returns compact NDJSON containing cluster inventory, strictly filtered OpenClaw spans, errors, R.E.D metrics, pods, and alerts:

```bash
python3 scripts/collect_rca.py 24 1s
```

Resolve `scripts/collect_rca.py` relative to this `SKILL.md`. The arguments are:

1. lookback hours, default `24`;
2. slow threshold, default `1s`;
3. optional cluster name.

Efficiency rules:

- Prefer this single collector invocation over sequential terminal calls.
- Do not call `get-tag-values` or list every Kubernetes namespace on the normal path. The collector queries only the top trace-service namespaces and applies the required OpenClaw tag directly to span queries.
- Do not rerun commands merely to reformat JSON; the collector aggregates with the Python 3 standard library.
- If no OpenClaw spans are found among the candidate namespaces, answer with low confidence from workload, metric, and alert evidence. Do not automatically broaden the window or scan every namespace.
- The default path fetches filtered spans plus error and slow-span summaries, but skips Jaeger trace details.
- Fetch trace details or logs only when the user explicitly asks for a deeper RCA or supplies a trace ID. Do not delay the first answer for enrichment.

The collector overlaps independent work:

1. Run trace-service discovery concurrently with Pod, alert, and metric collection.
2. Query at most the top 12 trace-service namespaces per cluster with the strict OpenClaw span filter.
3. Query error and slow spans concurrently for every discovered OpenClaw namespace.
4. Join the first-pass results and emit compact aggregates instead of full raw alert/span payloads.

The collector requires `python3` and `dce` only. It does not require `jq`, pip, or any third-party Python package.

The entire first-pass collection has an 8-second budget and each DCE command has a 5-second timeout. Keep successful partial evidence and answer when any source times out. The namespace cap can be changed with `OPENCLAW_RCA_MAX_NAMESPACES`, but do not increase it on the normal path.

For an explicit deep RCA, enable up to three priority Jaeger trace details per matched namespace:

```bash
OPENCLAW_RCA_DETAIL=1 python3 scripts/collect_rca.py 24 1s '<cluster-name>'
```

When the user supplies a cluster, pass it as the third argument so the collector skips cluster discovery.

Target latency for the first-pass analysis is under 10 seconds in a normally responsive DCE environment.

1. Identify the OpenClaw trace namespace and service by locating `otel.scope.name=openclaw-otel-plugin`.
2. Query OpenClaw error spans in the incident window.
3. Query slow OpenClaw spans in the same window.
4. Compare operations in the same trace:
   - `channel_ingress`
   - `openclaw_request`
   - `agent_run`
   - any child spans for model, tool, network, storage, or callback work
5. Classify the request symptom.
6. Correlate platform-side evidence only after classifying the OpenClaw request.
7. Output the root cause with confidence and mitigation actions.

## Request Stage Model

Use these stages when explaining a request:

| Stage | Typical Span | Meaning | Bottleneck Signal |
|---|---|---|---|
| Ingress | `channel_ingress` | Request accepted by OpenClaw channel/plugin | High duration or error here means entry/transport issue |
| Request wrapper | `openclaw_request` | End-to-end OpenClaw request handling | High duration here bounds the total user-visible OpenClaw time |
| Agent runtime | `agent_run` | Agent execution inside OpenClaw | If this matches `openclaw_request`, latency is inside agent execution |
| Downstream call | model/tool/HTTP/DB child spans | Work invoked by the agent | Slow/error child span identifies the concrete dependency |
| Platform dependency | gateway/storage/controller/log alerts | DCE/OpenClaw hosting dependencies | Treat as correlated unless the trace points to it directly |

## Symptom Classification

Classify before writing root cause:

| Symptom | Evidence | Root-Cause Direction |
|---|---|---|
| Direct OpenClaw failure | `onlyErrorSpans=true` returns OpenClaw spans, or span status is error | Inspect failed operation, status code, status message, and trace detail |
| Slow OpenClaw request | No error spans, but `openclaw_request` exceeds threshold | Compare `agent_run`, child spans, and ingress duration |
| Agent bottleneck | `agent_run` duration ~= `openclaw_request` duration | Investigate model/tool/IO/callback work or add finer child spans |
| Ingress bottleneck | `channel_ingress` is large or failed | Investigate channel plugin, gateway, auth, transport, or queueing |
| Platform-correlated degradation | OpenClaw spans are healthy, but gateway/storage/node alerts fire | Report as external risk/correlation, not proven direct OpenClaw cause |
| No OpenClaw traffic | No `openclaw-otel-plugin` spans in the window | Broaden time window, verify namespace/service, then inspect collection pipeline |

## Root Cause Confidence

State confidence explicitly:

| Confidence | Criteria |
|---|---|
| High | Error/slow OpenClaw span directly identifies the failed or slow operation, and trace detail supports it |
| Medium | OpenClaw spans show degradation, but the concrete child dependency is missing or inferred |
| Low | OpenClaw spans are healthy or absent; only platform logs/alerts suggest a related risk |

If confidence is Low or Medium, say exactly what data would raise confidence, such as child spans inside `agent_run`, specific trace IDs from the user, or pod events.

## Data Collection

Use `dce` on `PATH` when available. If working from this repository, `bin/dce` may be used. Always request JSON with `-o json`.

### 1. Find Clusters

```bash
dce container-management cluster list-clusters -o json --page-size 100
```

Record the cluster that contains OpenClaw spans or the reported workload. Common examples:

```text
kpanda-global-cluster
```

### 2. Discover the OpenClaw Namespace

Use `scripts/collect_rca.py`; it already performs namespace discovery. Do not run separate terminal commands for this section on the normal path.

The collector:

1. fetches trace services, Pods, alerts, and metrics concurrently;
2. selects up to the top 12 namespaces represented by trace services;
3. queries those candidate namespaces concurrently with the required span filter;
4. emits only namespaces whose filtered result contains OpenClaw spans.

Namespace discovery only identifies candidates. A namespace can contain unrelated traces, so every OpenClaw query and interpretation must retain:

```text
otel.scope.name=openclaw-otel-plugin
```

If the collector returns multiple OpenClaw namespaces, analyze each independently and select by the reported incident window, service, operation, or trace ID. If it returns none, report that the fast candidate scan found no OpenClaw spans; perform exhaustive namespace discovery only after the user requests a deeper search.

### 3. Query OpenClaw Spans

Use a concrete RFC3339 time window. For "recent" incidents, start with the last 24 hours; for user-provided timestamps, preserve the user's timezone in the explanation and convert to RFC3339 for queries.

All queries in this section must include the tag filter below. DCE tracing query results can include non-OpenClaw chain data when the filter is missing, malformed, ignored by a command variant, or when follow-up queries are run only by namespace/service/time. Treat any unfiltered or partially filtered result as mixed trace data, not OpenClaw evidence.

Required OpenClaw filter:

```json
{"key": "otel.scope.name", "operation": "EQUAL", "value": "openclaw-otel-plugin"}
```

After each query, validate that every span used as OpenClaw evidence has `otel.scope.name=openclaw-otel-plugin` in its tags/process tags/scope metadata. If the returned rows do not expose this tag, state that the result is not sufficiently proven as OpenClaw-only and rerun with a narrower query such as trace ID + operation name + the required tag filter.

All OpenClaw spans:

```bash
cat <<'JSON' | dce insight tracing query-spans --file - -o json
{
  "clusterName": "<cluster-name>",
  "namespace": "<openclaw-namespace>",
  "start": "<start-rfc3339>",
  "end": "<end-rfc3339>",
  "sort": "duration,desc",
  "page": 1,
  "pageSize": 200,
  "tags": [
    {"key": "otel.scope.name", "operation": "EQUAL", "value": "openclaw-otel-plugin"}
  ]
}
JSON
```

Error spans:

```bash
cat <<'JSON' | dce insight tracing query-spans --file - -o json
{
  "clusterName": "<cluster-name>",
  "namespace": "<openclaw-namespace>",
  "start": "<start-rfc3339>",
  "end": "<end-rfc3339>",
  "onlyErrorSpans": true,
  "sort": "startTime,desc",
  "page": 1,
  "pageSize": 100,
  "tags": [
    {"key": "otel.scope.name", "operation": "EQUAL", "value": "openclaw-otel-plugin"}
  ]
}
JSON
```

Slow spans:

```bash
cat <<'JSON' | dce insight tracing query-spans --file - -o json
{
  "clusterName": "<cluster-name>",
  "namespace": "<openclaw-namespace>",
  "start": "<start-rfc3339>",
  "end": "<end-rfc3339>",
  "durationMin": "1s",
  "sort": "duration,desc",
  "page": 1,
  "pageSize": 100,
  "tags": [
    {"key": "otel.scope.name", "operation": "EQUAL", "value": "openclaw-otel-plugin"}
  ]
}
JSON
```

Recommended duration thresholds:

| Threshold | Meaning |
|---:|---|
| `> 1s` | Investigate for interactive request latency |
| `> 3s` | Treat as user-visible slow request |
| `> 10s` | Treat as severe latency or timeout risk |

When the user reports a timeout, also query with `durationMin` close to the timeout threshold, for example `10s`, `30s`, or `60s`.

When narrowing by `serviceName`, `operationName`, `traceID`, status, duration, or errors, keep the same `otel.scope.name=openclaw-otel-plugin` tag filter. Never replace this filter with service, namespace, or operation filters; those are additional constraints only.

### 4. Collect R.E.D Metrics

Service-level R.E.D:

```bash
dce insight tracing get-services \
  --cluster-name <cluster-name> \
  --namespace <openclaw-namespace> \
  --lookback 86400000 \
  --end-time "$END" \
  --span-kinds SPAN_KIND_SERVER \
  --sort 'repLatency,desc' \
  --page 1 \
  --page-size 50 \
  -o json
```

Available operations:

```bash
dce insight tracing query-operations \
  --cluster-name <cluster-name> \
  --namespace <openclaw-namespace> \
  --service-name <service-name> \
  --start <start-rfc3339> \
  --end <end-rfc3339> \
  -o json
```

Operation detail may be available for some services:

```bash
dce insight tracing get-operation-detail \
  --cluster-name <cluster-name> \
  --namespace <openclaw-namespace> \
  --service-name <service-name> \
  --lookback 86400000 \
  --end-time "$END" \
  --step 3600000 \
  --rate-per 60000 \
  --span-kinds SPAN_KIND_SERVER \
  --page 1 \
  --page-size 50 \
  --sort 'p99,desc' \\
  -o json
```

If operation detail is empty, use `query-spans` grouped manually by `operationName`.

### 5. Inspect Trace Details

For the slowest or failed trace:

```bash
dce insight tracing find-jaeger-trace \
  --trace-id <trace-id> \
  --cluster-name <cluster-name> \
  --namespace <openclaw-namespace> \
  -o json
```

Use the trace detail to identify process tags such as:

- `agent_runtime`
- `agent_version`
- `k8s.namespace.name`
- `service.namespace`
- `process.command`
- `process.runtime.version`

If trace detail contains a long parent or aggregate operation such as `session_processing`, do not use it alone as the request latency. Prefer individual span rows from `query-spans` for `openclaw_request`, `agent_run`, and child spans.

### 6. Correlate Platform-Side Signals

OpenClaw error spans may be absent even when users see degraded behavior. Always correlate with pod health, alerts, and gateway logs.

Pod health:

```bash
dce insight resource list-pods \
  --cluster <cluster-name> \
  --namespace <namespace> \
  --page-size 200 \
  -o json
```

Pod detail:

```bash
dce insight resource get-pod \
  --cluster <cluster-name> \
  --namespace <namespace> \
  --name <pod-name> \
  -o json
```

Alerts:

```bash
dce insight alert list-alerts \
  --cluster-name <cluster-name> \
  --namespace <namespace> \
  --page-size 100 \
  --sorts startsAt,desc \
  -o json
```

Container logs:

```bash
dce container-management insight get-pod-container-log \
  --cluster <cluster-name> \
  --namespace <namespace> \
  --name <pod-name> \
  --container <container-name> \
  --page-size 100 \
  -o json
```

Useful log searches for gateway issues:

```bash
dce container-management insight get-pod-container-log \
  --cluster <cluster-name> \
  --namespace hydra-system \
  --name <higress-gateway-pod> \
  --container higress-gateway \
  --log-search error \
  --page-size 100 \
  -o json
```

Watch for messages such as:

- `Envoy is not fully initialized`
- `cannot fetch Wasm module`
- `wasm module download failed`
- `gRPC update ... failed`
- `context deadline exceeded`

Node and cluster pressure:

```bash
dce insight alert list-alerts \\n  --cluster-name <cluster-name> \\n  --target <node-name> \\n  --target-type NODE \\n  --page-size 50 \\n  -o json
```

Look for memory, disk IO, filesystem, network, and kubelet-related alerts. Node pressure can amplify timeouts but should be described as a contributing factor unless directly visible in the request trace.

## Analysis Rules

- Only spans verified with `otel.scope.name=openclaw-otel-plugin` may be counted as OpenClaw spans. Namespace, service, operation name, trace ID, or timing overlap alone is not enough, because query results may contain non-OpenClaw chain data.
- Treat `onlyErrorSpans=true` returning zero OpenClaw spans as "no direct OpenClaw error span found", not as "no incident".
- If `openclaw_request` and `agent_run` have matching durations, attribute the observed latency to the agent execution phase unless deeper child spans contradict it.
- If `channel_ingress` is near zero or a few milliseconds, do not classify ingress as the OpenClaw bottleneck.
- Platform-side `higress-gateway` NotReady, failed Wasm downloads, `storageserver` Pending, or node memory/IO alerts are dependency or platform risks. State whether they are directly visible in OpenClaw spans or only correlated.
- Convert nanosecond durations from span output to human-friendly units (`2999000000` -> `2.999s`).
- Convert UTC timestamps to the user's timezone in final tables when useful.
- Do not call platform-side gateway/storage failure the OpenClaw request root cause unless the OpenClaw trace shows the request depends on it or the timing and path clearly line up.
- If OpenClaw spans are `HEALTHY` but slow, phrase the result as "latency root cause" rather than "error root cause".
- If no child spans exist under `agent_run`, recommend adding instrumentation before claiming a specific model/tool/IO dependency.

## Root-Cause Decision Table

Use this mapping to move from evidence to conclusion and mitigation.

| Evidence Pattern | Likely Root Cause | Immediate Mitigation | Durable Fix |
|---|---|---|---|
| `onlyErrorSpans=true` returns `openclaw_request` errors | OpenClaw request handling failure | Use trace detail to identify failing operation; retry or route traffic away from affected service | Fix failing code path and add error-specific alert |
| `agent_run` ~= `openclaw_request`, both slow, no error | Agent execution latency | Reduce request complexity, temporarily disable expensive tools, or increase timeout only if safe | Add child spans for model/tool/IO; optimize slow step |
| Child model/tool span dominates `agent_run` | Downstream dependency latency | Fail open/fallback/cache if available; isolate bad dependency | Add timeout, retry budget, circuit breaker, and dependency SLO |
| `channel_ingress` slow or failed | Ingress/channel bottleneck | Restart or scale channel/gateway component; check auth/transport | Add ingress queue/latency metrics and capacity guardrails |
| No OpenClaw error span, platform gateway NotReady | Platform-correlated risk | Restore gateway/plugin endpoint or disable failed plugin | Make plugin download cached/fail-open and add readiness guard |
| No OpenClaw error span, storage/controller Pending | Platform dependency risk | Repair Pending pods and failed rollout/job | Fix install/upgrade workflow, PVC/scheduling/resource constraints |
| Node memory/IO pressure alert overlaps incident | Resource pressure contributing factor | Move workload, free memory/disk IO, restart only if necessary | Add capacity, requests/limits, and noisy-neighbor isolation |
| No `openclaw-otel-plugin` spans | Observability gap or no traffic | Broaden window; verify namespace/service and collector health | Add telemetry health checks and missing-span alerts |

## Output Format

When the user asks for a root-cause summary, R.E.D analysis, remediation advice, or leadership-facing report, answer in structured Markdown with the sections below. Do not output a step-by-step investigation log. Unless the user explicitly asks, do not show skill loading, command retries, raw JSON processing, or other internal process details.

Rules:

- Put the conclusion first.
- Use Markdown tables for key metrics whenever possible.
- Keep intermediate investigation detail out of the final answer.
- Recommendations must be specific and executable.
- If data is incomplete, explicitly say `Based on the currently available data`.
- Use local time if the user is using a local timezone context.
- Optimize for the first answer: use at most 3 findings and 2 actions. Do not wait for trace detail, logs, exhaustive namespace scans, or additional correlation unless the user explicitly asks.

Required response template:

```markdown
# Conclusion

Based on the currently available data, <1-2 sentences with the current judgment, risk level, and most important issue>. Current risk level: Normal / Watch / Risk / Critical.

## Key Metrics

| Metric | Current Value | Status |
|---|---:|---|
| OpenClaw span filter | `otel.scope.name=openclaw-otel-plugin` | Normal / Watch / Risk / Critical |
| Rate | `<reqRate or request count>` | Normal / Watch / Risk / Critical |
| Errors | `<error span count or error rate>` | Normal / Watch / Risk / Critical |
| Duration | `<p95/p99/max or slowest operation>` | Normal / Watch / Risk / Critical |
| Main slow operation | `<operationName + duration>` | Normal / Watch / Risk / Critical |

## Main Findings

1. <most important finding and impact>
2. <second finding and impact, if material>
3. <third finding, only if material>

## Cause Analysis

<One concise cause statement with confidence. If direct trace evidence is absent, say the cause is unconfirmed and identify the strongest correlated signal.>

## Recommended Actions

1. <highest-priority mitigation tied to evidence>
2. <second action, only if necessary>
```

Stop after this concise answer. Add trace details, logs, exhaustive correlation, or additional tables only in response to a user follow-up.

## Common Interpretation

If the data shows:

- `openclaw-otel-plugin` exists under an application namespace such as `jinye-ns`.
- `onlyErrorSpans=true` returns no spans.
- Slow spans are `openclaw_request` and `agent_run`.
- `channel_ingress` is approximately `1ms`.

Then summarize:

```text
OpenClaw has no direct error span in the selected window. The degradation is latency-oriented, concentrated in agent execution. Platform-side gateway or dependency failures may still affect the user path, but they are correlated external risks unless the trace shows direct child-span failures.
```

If platform-side evidence shows `higress-gateway` cannot fetch `ai-statistics/plugin.wasm`, or `storageserver` is Pending, recommend:

- Restore the Wasm module endpoint or temporarily disable the failing plugin.
- Repair Pending platform pods by checking image pulls, PVCs, scheduling, Secret/ConfigMap, and node resources.
- Add OpenClaw latency alerts for `openclaw_request > 1s` and `> 3s`.
- Add finer spans inside `agent_run` for model calls, tool calls, IO, and callbacks.

## Mitigation Guidance

Choose mitigations based on the classified root cause:

| Root Cause Type | P0 Mitigation | P1 Follow-Up | P2 Prevention |
|---|---|---|---|
| OpenClaw direct errors | Roll back recent change or route traffic away from failing service | Fix failing operation and add regression test | Add error-rate SLO and alert by operation |
| Agent execution slow | Disable expensive tools, simplify prompt/workflow, or cap tool iterations | Add child spans and optimize slow model/tool/IO step | Add latency budget and circuit breaker per agent step |
| Downstream dependency slow | Use fallback/cache, reduce timeout, or isolate bad dependency | Tune retries and concurrency | Add dependency dashboard and per-call SLO |
| Gateway/plugin failure | Restore plugin endpoint or temporarily disable failed Wasm plugin | Make plugin download fail-open or cached | Add plugin availability probe before rollout |
| Platform pod Pending | Repair image/PVC/scheduling/resource issue; restart rollout only after cause is known | Clean failed Helm jobs and rerun upgrade/rollback | Add preflight checks for install/upgrade |
| Node pressure | Move workloads or free memory/disk IO | Resize nodes or tune requests/limits | Add capacity planning and noisy-neighbor isolation |
| Telemetry gap | Verify collector and namespace/service selection | Add missing-span alert | Standardize OpenClaw telemetry tags |
