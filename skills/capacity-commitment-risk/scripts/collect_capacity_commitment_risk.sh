#!/bin/sh
set -eu

HOST=""
AS_OF=""
HISTORY_START=""
HORIZON_DAYS="90"
OUTPUT_DIR=""
COMMITMENT_FILE=""
CLUSTERS=""
WORKSPACES=""

usage() {
  cat <<'EOF'
Usage:
  collect_capacity_commitment_risk.sh \
    --hostname <dce-host> \
    --as-of <YYYY-MM-DD> \
    --history-start <YYYY-MM-DD> \
    [--horizon-days 90] \
    [--cluster <cluster>]... \
    [--workspace <workspace-id>]... \
    [--commitment-file <commitments.json>] \
    [--output-dir <dir>]

Collects live DCE JSON evidence only. It does not parse JSON and does not need
extra interpreters, JSON parsers, package installs, or third-party libraries.
EOF
}

need_value() {
  [ "$#" -ge 2 ] || { echo "$1 requires an argument" >&2; exit 2; }
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --hostname) need_value "$@"; HOST="$2"; shift 2 ;;
    --as-of) need_value "$@"; AS_OF="$2"; shift 2 ;;
    --history-start) need_value "$@"; HISTORY_START="$2"; shift 2 ;;
    --horizon-days) need_value "$@"; HORIZON_DAYS="$2"; shift 2 ;;
    --cluster) need_value "$@"; CLUSTERS="${CLUSTERS}
$2"; shift 2 ;;
    --workspace) need_value "$@"; WORKSPACES="${WORKSPACES}
$2"; shift 2 ;;
    --commitment-file) need_value "$@"; COMMITMENT_FILE="$2"; shift 2 ;;
    --output-dir) need_value "$@"; OUTPUT_DIR="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "unknown arg: $1" >&2; usage >&2; exit 2 ;;
  esac
done

[ -n "$AS_OF" ] || { echo "--as-of required" >&2; exit 2; }
[ -n "$HISTORY_START" ] || { echo "--history-start required" >&2; exit 2; }

if [ -z "$OUTPUT_DIR" ]; then
  OUTPUT_DIR="$(mktemp -d "${TMPDIR:-/tmp}/capacity-commitment-evidence-XXXXXX")"
fi
mkdir -p "$OUTPUT_DIR"
TRACE="$OUTPUT_DIR/trace.tsv"
: > "$TRACE"

if [ -n "$HOST" ]; then
  export DCE_HOST="$HOST"
fi

run_dce() {
  name="$1"
  shift
  out="$OUTPUT_DIR/$name.json"
  err="$OUTPUT_DIR/$name.err"
  cmd="dce $*"
  if dce "$@" >"$out" 2>"$err"; then
    printf '%s\t%s\t%s\n' "$name" "ok" "$cmd" >> "$TRACE"
  else
    printf '%s\t%s\t%s\n' "$name" "failed" "$cmd" >> "$TRACE"
  fi
}

safe_name() {
  printf '%s' "$1" | tr -c 'A-Za-z0-9_-' '_'
}

run_dce auth_status auth status
run_dce workspaces global-management workspace list-workspaces --page 1 --page-size 200 -o json
run_dce clusters container-management cluster list-clusters --page 1 --page-size 200 -o json
run_dce workspace_quotas llm-studio workspacequotaservice list-workspace-quotas --page.page-size -1 -o json
run_dce model_serving llm-studio modelservingmanagement list-model-serving --page.page-size -1 -o json
run_dce workspace_report operations-management report list-workspaces --start "$HISTORY_START" --end "$AS_OF" --page 1 --page-size 200 -o json
run_dce usage llm-studio apikeymanagement get-api-key-usage-statistics2 --start-time "${HISTORY_START}T00:00:00+08:00" --end-time "${AS_OF}T23:59:59+08:00" --period TIME_PERIOD_DAY -o json

printf '%s\n' "$CLUSTERS" | while IFS= read -r cluster; do
  [ -n "$cluster" ] || continue
  safe="$(safe_name "$cluster")"
  run_dce "gpu_devices_$safe" container-management devices list-gpu-devices --cluster "$cluster" -o json
done

printf '%s\n' "$WORKSPACES" | while IFS= read -r ws; do
  [ -n "$ws" ] || continue
  safe="$(safe_name "$ws")"
  run_dce "llm_queues_ws_$safe" llm-studio queuemanagement list-queues2 --workspace "$ws" --page.page-size -1 -o json
  run_dce "ai_lab_queues_ws_$safe" ai-lab queuemanagement list-queues2 --workspace "$ws" --page.page-size -1 -o json
  run_dce "billing_ws_$safe" billing-center bill get-account-bill-aggregation --workspace-id "$ws" -o json
done

if [ -n "$COMMITMENT_FILE" ]; then
  cp "$COMMITMENT_FILE" "$OUTPUT_DIR/commitments.json"
fi

cat > "$OUTPUT_DIR/README.md" <<EOF
# Capacity Commitment Evidence

- Host: ${HOST:-default}
- As of: $AS_OF
- History start: $HISTORY_START
- Horizon days: $HORIZON_DAYS
- Trace: $TRACE

Read the JSON files in this directory, then compare:

1. Contract/commitment JSON, if provided.
2. DCE quota and queue JSON as quota proxy, not as signed contract proof.
3. Cluster and GPU device JSON for actual capacity.
4. Model serving, workspace report, usage, and billing JSON for demand signals.

If no --cluster was provided, inspect clusters.json and run this script again
with --cluster for every GPU cluster that needs device-level capacity evidence.
If no --workspace was provided, inspect workspaces.json and run again with
workspace ids that need queue/billing evidence.
EOF

printf 'Evidence directory: %s\n' "$OUTPUT_DIR"
printf 'Trace: %s\n' "$TRACE"
