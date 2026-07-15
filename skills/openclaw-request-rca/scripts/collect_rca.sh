#!/usr/bin/env bash
set -euo pipefail

# Collect the complete first-pass OpenClaw RCA data set in one terminal call.
# The DCE API calls are executed concurrently; output is compact NDJSON so the
# caller can reason over it without reading large raw payloads.

HOURS="${1:-24}"
SLOW_THRESHOLD="${2:-1s}"
CLUSTER_FILTER="${3:-}"
PARALLELISM="${OPENCLAW_RCA_PARALLELISM:-12}"
SPAN_PAGE_SIZE="${OPENCLAW_RCA_SPAN_PAGE_SIZE:-100}"

command -v dce >/dev/null
command -v jq >/dev/null

WORK_DIR="$(mktemp -d "${TMPDIR:-/tmp}/openclaw-rca.XXXXXX")"
trap 'rm -rf "$WORK_DIR"' EXIT

END_EPOCH="$(date -u +%s)"
START_EPOCH="$((END_EPOCH - HOURS * 3600))"
END_RFC3339="$(date -u -r "$END_EPOCH" '+%Y-%m-%dT%H:%M:%SZ')"
START_RFC3339="$(date -u -r "$START_EPOCH" '+%Y-%m-%dT%H:%M:%SZ')"
END_MILLIS="$((END_EPOCH * 1000))"
LOOKBACK_MILLIS="$((HOURS * 3600000))"

if [[ -n "$CLUSTER_FILTER" ]]; then
  printf '%s\n' "$CLUSTER_FILTER" >"$WORK_DIR/cluster_names.txt"
else
  dce container-management cluster list-clusters --page-size 100 -o json >"$WORK_DIR/clusters.json"
  jq -r '.items[].metadata.name' "$WORK_DIR/clusters.json" >"$WORK_DIR/cluster_names.txt"
fi

if [[ ! -s "$WORK_DIR/cluster_names.txt" ]]; then
  jq -nc --arg error "No matching DCE cluster" --arg cluster "$CLUSTER_FILTER" \
    '{type:"error",error:$error,cluster:$cluster}'
  exit 2
fi

collect_cluster_inventory() {
  local cluster="$1"
  local safe_cluster="${cluster//[^A-Za-z0-9_.-]/_}"

  dce container-management core list-cluster-namespaces \
    --cluster "$cluster" --page-size 500 -o json >"$WORK_DIR/namespaces.$safe_cluster.json" &
  DISCOVERY_PIDS+=("$!")
  dce insight tracing get-services \
    --cluster-name "$cluster" --lookback "$LOOKBACK_MILLIS" --end-time "$END_MILLIS" \
    --sort 'reqRate,desc' --page 1 --page-size 500 -o json >"$WORK_DIR/services.$safe_cluster.json" &
  DISCOVERY_PIDS+=("$!")
  dce insight resource list-pods \
    --cluster "$cluster" --page-size 500 -o json >"$WORK_DIR/pods.$safe_cluster.json" &
  PLATFORM_PIDS+=("$!")
  dce insight alert list-alerts \
    --cluster-name "$cluster" --page-size 100 --sorts startsAt,desc -o json >"$WORK_DIR/alerts.$safe_cluster.json" &
  PLATFORM_PIDS+=("$!")
  dce insight metric query-metric \
    --cluster-name "$cluster" --time "$END_EPOCH" \
    --query 'sum(increase(openclaw_requests_total['"$HOURS"'h])) by (openclaw_outcome,openclaw_final_state,channel,job)' \
    -o json >"$WORK_DIR/metrics.$safe_cluster.json" &
  PLATFORM_PIDS+=("$!")
}

DISCOVERY_PIDS=()
PLATFORM_PIDS=()
while IFS= read -r cluster; do
  collect_cluster_inventory "$cluster"
done <"$WORK_DIR/cluster_names.txt"

# Namespace/service discovery is the only prerequisite for span queries.
# Keep pod, alert, and metric calls running while the trace path proceeds.
for pid in "${DISCOVERY_PIDS[@]}"; do
  wait "$pid"
done

# Build cluster/namespace pairs from both Kubernetes inventory and tracing
# services. This avoids slow tag-value discovery and still covers namespaces
# that no longer have a running Pod but have traces inside the requested window.
: >"$WORK_DIR/pairs.tsv"
while IFS= read -r cluster; do
  safe_cluster="${cluster//[^A-Za-z0-9_.-]/_}"
  {
    jq -r '.items[]?.metadata.name // empty' "$WORK_DIR/namespaces.$safe_cluster.json"
    jq -r '.items[]?.namespace // empty' "$WORK_DIR/services.$safe_cluster.json"
  } | sort -u | awk -v cluster="$cluster" 'NF {print cluster "\t" $0}' >>"$WORK_DIR/pairs.tsv"
done <"$WORK_DIR/cluster_names.txt"

export WORK_DIR START_RFC3339 END_RFC3339 SLOW_THRESHOLD SPAN_PAGE_SIZE
xargs -P "$PARALLELISM" -n 2 bash -c '
  cluster="$1"
  namespace="$2"
  safe_cluster="${cluster//[^A-Za-z0-9_.-]/_}"
  safe_namespace="${namespace//[^A-Za-z0-9_.-]/_}"
  jq -nc \
    --arg cluster "$cluster" --arg namespace "$namespace" \
    --arg start "$START_RFC3339" --arg end "$END_RFC3339" \
    --argjson pageSize "$SPAN_PAGE_SIZE" \
    "{clusterName:\$cluster,namespace:\$namespace,start:\$start,end:\$end,sort:\"duration,desc\",page:1,pageSize:\$pageSize,tags:[{key:\"otel.scope.name\",operation:\"EQUAL\",value:\"openclaw-otel-plugin\"}]}" \
    | dce insight tracing query-spans --file - -o json \
      >"$WORK_DIR/spans.$safe_cluster.$safe_namespace.json"
' _ <"$WORK_DIR/pairs.tsv"

# Query errors only for namespaces that actually contain OpenClaw spans.
: >"$WORK_DIR/openclaw_pairs.tsv"
while IFS=$'\t' read -r cluster namespace; do
  safe_cluster="${cluster//[^A-Za-z0-9_.-]/_}"
  safe_namespace="${namespace//[^A-Za-z0-9_.-]/_}"
  span_file="$WORK_DIR/spans.$safe_cluster.$safe_namespace.json"
  if [[ "$(jq '.pagination.total // (.items | length) // 0' "$span_file")" -gt 0 ]]; then
    printf '%s\t%s\n' "$cluster" "$namespace" >>"$WORK_DIR/openclaw_pairs.tsv"
  fi
done <"$WORK_DIR/pairs.tsv"

if [[ -s "$WORK_DIR/openclaw_pairs.tsv" ]]; then
  xargs -P "$PARALLELISM" -n 2 bash -c '
    cluster="$1"
    namespace="$2"
    safe_cluster="${cluster//[^A-Za-z0-9_.-]/_}"
    safe_namespace="${namespace//[^A-Za-z0-9_.-]/_}"
    jq -nc \
      --arg cluster "$cluster" --arg namespace "$namespace" \
      --arg start "$START_RFC3339" --arg end "$END_RFC3339" --argjson pageSize "$SPAN_PAGE_SIZE" \
      "{clusterName:\$cluster,namespace:\$namespace,start:\$start,end:\$end,onlyErrorSpans:true,sort:\"startTime,desc\",page:1,pageSize:\$pageSize,tags:[{key:\"otel.scope.name\",operation:\"EQUAL\",value:\"openclaw-otel-plugin\"}]}" \
      | dce insight tracing query-spans --file - -o json \
        >"$WORK_DIR/errors.$safe_cluster.$safe_namespace.json" &
    jq -nc \
      --arg cluster "$cluster" --arg namespace "$namespace" \
      --arg start "$START_RFC3339" --arg end "$END_RFC3339" --arg durationMin "$SLOW_THRESHOLD" --argjson pageSize "$SPAN_PAGE_SIZE" \
      "{clusterName:\$cluster,namespace:\$namespace,start:\$start,end:\$end,durationMin:\$durationMin,sort:\"duration,desc\",page:1,pageSize:\$pageSize,tags:[{key:\"otel.scope.name\",operation:\"EQUAL\",value:\"openclaw-otel-plugin\"}]}" \
      | dce insight tracing query-spans --file - -o json \
        >"$WORK_DIR/slow.$safe_cluster.$safe_namespace.json" &
    wait
  ' _ <"$WORK_DIR/openclaw_pairs.tsv"

  # Fetch aggregate Jaeger trace metadata for the most important traces in the
  # same invocation: errors first, then the slowest traces, at most 3 per
  # OpenClaw namespace.
  : >"$WORK_DIR/trace_pairs.tsv"
  while IFS=$'\t' read -r cluster namespace; do
    safe_cluster="${cluster//[^A-Za-z0-9_.-]/_}"
    safe_namespace="${namespace//[^A-Za-z0-9_.-]/_}"
    {
      jq -r '.items[]?.traceId // empty' "$WORK_DIR/errors.$safe_cluster.$safe_namespace.json"
      jq -r '.items[]?.traceId // empty' "$WORK_DIR/slow.$safe_cluster.$safe_namespace.json"
    } | awk '!seen[$0]++ && count++ < 3' | awk -v cluster="$cluster" -v namespace="$namespace" '{print cluster "\t" namespace "\t" $0}' \
      >>"$WORK_DIR/trace_pairs.tsv"
  done <"$WORK_DIR/openclaw_pairs.tsv"

  if [[ -s "$WORK_DIR/trace_pairs.tsv" ]]; then
    xargs -P "$PARALLELISM" -n 3 bash -c '
      cluster="$1"
      namespace="$2"
      trace_id="$3"
      safe_cluster="${cluster//[^A-Za-z0-9_.-]/_}"
      safe_namespace="${namespace//[^A-Za-z0-9_.-]/_}"
      dce insight tracing find-jaeger-trace \
        --trace-id "$trace_id" --cluster-name "$cluster" --namespace "$namespace" -o json \
        >"$WORK_DIR/trace.$safe_cluster.$safe_namespace.$trace_id.json"
    ' _ <"$WORK_DIR/trace_pairs.tsv"
  fi
fi

# Platform correlation is independent of trace drill-down. Join it only before
# composing the final records.
for pid in "${PLATFORM_PIDS[@]}"; do
  wait "$pid"
done

jq -nc \
  --arg start "$START_RFC3339" --arg end "$END_RFC3339" \
  --argjson hours "$HOURS" --arg slowThreshold "$SLOW_THRESHOLD" \
  '{type:"meta",start:$start,end:$end,hours:$hours,slowThreshold:$slowThreshold,spanFilter:"otel.scope.name=openclaw-otel-plugin"}'

while IFS= read -r cluster; do
  safe_cluster="${cluster//[^A-Za-z0-9_.-]/_}"
  jq -nc \
    --arg cluster "$cluster" \
    --slurpfile services "$WORK_DIR/services.$safe_cluster.json" \
    --slurpfile pods "$WORK_DIR/pods.$safe_cluster.json" \
    --slurpfile alerts "$WORK_DIR/alerts.$safe_cluster.json" \
    --slurpfile metrics "$WORK_DIR/metrics.$safe_cluster.json" \
    '{type:"cluster",cluster:$cluster,
      traceServiceCount:($services[0].pagination.total // ($services[0].items|length) // 0),
      openclawMetrics:($metrics[0].vector // []),
      podSummary:{total:($pods[0].pagination.total // ($pods[0].items|length) // 0),notReady:[ $pods[0].items[]? | select((.phase == "POD_PHASE_PENDING" or .phase == "POD_PHASE_UNKNOWN" or .phase == "POD_PHASE_FAILED") or (.phase == "POD_PHASE_RUNNING" and .containerNumSummary.readyNum != .containerNumSummary.totalNum)) | {namespace,name,phase,ready:.containerNumSummary,restarts:.restartCount}]},
      alertSummary:{
        total:($alerts[0].pagination.total // ($alerts[0].items|length) // 0),
        bySeverity:([$alerts[0].items[]? | .severity] | group_by(.) | map({severity:.[0],count:length})),
        byRule:([$alerts[0].items[]? | {ruleName,severity,status,namespace,startAt,description}]
          | group_by([.ruleName,.severity,.namespace,.status])
          | map({ruleName:.[0].ruleName,severity:.[0].severity,status:.[0].status,namespace:.[0].namespace,count:length,
            latestStartAt:(map(.startAt|tonumber)|max|tostring),descriptions:(map(.description)|map(select(length>0))|unique|.[0:3])}))}
      }
    '
done <"$WORK_DIR/cluster_names.txt"

if [[ ! -s "$WORK_DIR/openclaw_pairs.tsv" ]]; then
  jq -nc '{type:"openclaw",found:false,spanCount:0,errorSpanCount:null,classification:"no_traffic_or_telemetry_gap"}'
  exit 0
fi

while IFS=$'\t' read -r cluster namespace; do
  safe_cluster="${cluster//[^A-Za-z0-9_.-]/_}"
  safe_namespace="${namespace//[^A-Za-z0-9_.-]/_}"
  jq -nc \
    --arg cluster "$cluster" --arg namespace "$namespace" \
    --slurpfile spans "$WORK_DIR/spans.$safe_cluster.$safe_namespace.json" \
    --slurpfile errors "$WORK_DIR/errors.$safe_cluster.$safe_namespace.json" \
    --slurpfile slow "$WORK_DIR/slow.$safe_cluster.$safe_namespace.json" \
    '{type:"openclaw",found:true,cluster:$cluster,namespace:$namespace,
      spanCount:($spans[0].pagination.total // ($spans[0].items|length) // 0),
      errorSpanCount:($errors[0].pagination.total // ($errors[0].items|length) // 0),
      slowSpanCount:($slow[0].pagination.total // ($slow[0].items|length) // 0),
      slowest:[$slow[0].items[:10][]? | {traceId,spanId,serviceName,operationName,duration,startTime,status,method,protocol}],
      errors:[$errors[0].items[:10][]? | {traceId,spanId,serviceName,operationName,duration,startTime,status,method,protocol}]}'
done <"$WORK_DIR/openclaw_pairs.tsv"

if [[ -s "$WORK_DIR/trace_pairs.tsv" ]]; then
  while IFS=$'\t' read -r cluster namespace trace_id; do
    safe_cluster="${cluster//[^A-Za-z0-9_.-]/_}"
    safe_namespace="${namespace//[^A-Za-z0-9_.-]/_}"
    jq -nc \
      --arg cluster "$cluster" --arg namespace "$namespace" --arg traceId "$trace_id" \
      --slurpfile detail "$WORK_DIR/trace.$safe_cluster.$safe_namespace.$trace_id.json" \
      '{type:"traceDetail",cluster:$cluster,namespace:$namespace,traceId:$traceId,
        traces:[$detail[0].traces[]? | {traceId,operationName,duration,startTime,status,statusCode,spanCount,warnings,
          processes:[.processMap[]?.process | {serviceName,tags:[.tags[]? | select(.key == "agent_runtime" or .key == "agent_version" or .key == "k8s.namespace.name" or .key == "service.namespace" or .key == "process.runtime.version" or .key == "runtime_environment") | {key,value:(.vStr // .vInt64 // .vFloat64 // .vBool)}]}]}]}'
  done <"$WORK_DIR/trace_pairs.tsv"
fi
