#!/usr/bin/env bash
set -euo pipefail

: "${DCE_HOST:?DCE_HOST is required}"
: "${DCE_TOKEN:?DCE_TOKEN is required}"
: "${K8S_AI_BENCH_TASK_OUTPUT_DIR:?K8S_AI_BENCH_TASK_OUTPUT_DIR is required}"

cluster="kpanda-global-cluster"
namespace="default"
pending_pod="k8s-ai-bench-diag-pending-pod"
cfg_pod="k8s-ai-bench-diag-cfg-pod"

dce_token="${DCE_TOKEN#Bearer }"

log_path="${K8S_AI_BENCH_TASK_OUTPUT_DIR}/log.txt"
if [[ ! -f "${log_path}" ]]; then
  echo "task log not found: ${log_path}" >&2
  exit 1
fi
if ! grep -Fq 'CLUSTER_DIAGNOSIS_OK' "${log_path}"; then
  echo "agent did not emit CLUSTER_DIAGNOSIS_OK" >&2
  exit 1
fi
if ! grep -Fq "Pod: ${namespace}/${pending_pod}" "${log_path}"; then
  echo "agent did not report ${pending_pod} as an abnormal Pod" >&2
  exit 1
fi
if ! grep -Fq "Pod: ${namespace}/${cfg_pod}" "${log_path}"; then
  echo "agent did not report ${cfg_pod} as an abnormal Pod" >&2
  exit 1
fi

printf '%s' "${dce_token}" | dce --insecure --hostname "${DCE_HOST}" auth login \
  --auth-type bearer --with-token --skip-validate >/dev/null
response_dir="$(mktemp -d)"
trap 'rm -rf "${response_dir}"' EXIT

dce --insecure --hostname "${DCE_HOST}" container-management core get-pod \
  --cluster "${cluster}" --namespace "${namespace}" --name "${pending_pod}" -o json >"${response_dir}/pending.json"
dce --insecure --hostname "${DCE_HOST}" container-management core get-pod \
  --cluster "${cluster}" --namespace "${namespace}" --name "${cfg_pod}" -o json >"${response_dir}/cfg.json"

python3 - "${response_dir}/pending.json" "${response_dir}/cfg.json" "${namespace}" "${pending_pod}" "${cfg_pod}" <<'PY'
import json
import sys

pending_path, cfg_path, namespace, pending_pod, cfg_pod = sys.argv[1:6]

with open(pending_path, encoding="utf-8") as handle:
    pending = json.load(handle)
metadata = pending.get("metadata", {})
if metadata.get("name") != pending_pod or metadata.get("namespace") != namespace:
    raise SystemExit(f"unexpected pending fixture identity: {metadata.get('namespace')}/{metadata.get('name')!r}")
if pending.get("status", {}).get("phase") != "Pending":
    raise SystemExit(f"pending fixture is not Pending: {pending.get('status', {}).get('phase')!r}")

with open(cfg_path, encoding="utf-8") as handle:
    cfg = json.load(handle)
metadata = cfg.get("metadata", {})
if metadata.get("name") != cfg_pod or metadata.get("namespace") != namespace:
    raise SystemExit(f"unexpected cfg fixture identity: {metadata.get('namespace')}/{metadata.get('name')!r}")
reasons = []
for state in cfg.get("status", {}).get("containerStatuses") or []:
    waiting = (state.get("state") or {}).get("waiting") or {}
    if waiting.get("reason"):
        reasons.append(waiting["reason"])
if "CreateContainerConfigError" not in reasons:
    raise SystemExit(f"cfg fixture is not in CreateContainerConfigError: {reasons!r}")

print(f"DCE API verified both fixtures intact: {pending_pod} Pending, {cfg_pod} CreateContainerConfigError.")
PY
