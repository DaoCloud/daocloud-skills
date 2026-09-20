#!/usr/bin/env bash
set -euo pipefail

: "${DCE_HOST:?DCE_HOST is required}"
: "${DCE_TOKEN:?DCE_TOKEN is required}"
: "${K8S_AI_BENCH_TASK_OUTPUT_DIR:?K8S_AI_BENCH_TASK_OUTPUT_DIR is required}"

cluster="kpanda-global-cluster"
namespace="default"
pending_pod="k8s-ai-bench-diag-pending-pod"
pvc_pod="k8s-ai-bench-diag-pvc-pod"

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
if ! grep -Fq "Pod: ${namespace}/${pvc_pod}" "${log_path}"; then
  echo "agent did not report ${pvc_pod} as an abnormal Pod" >&2
  exit 1
fi

printf '%s' "${dce_token}" | dce --insecure --hostname "${DCE_HOST}" auth login \
  --auth-type bearer --with-token --skip-validate >/dev/null
response_dir="$(mktemp -d)"
trap 'rm -rf "${response_dir}"' EXIT

dce --insecure --hostname "${DCE_HOST}" container-management core get-pod \
  --cluster "${cluster}" --namespace "${namespace}" --name "${pending_pod}" -o json >"${response_dir}/pending.json"
dce --insecure --hostname "${DCE_HOST}" container-management core get-pod \
  --cluster "${cluster}" --namespace "${namespace}" --name "${pvc_pod}" -o json >"${response_dir}/pvc.json"

python3 - "${response_dir}/pending.json" "${response_dir}/pvc.json" "${namespace}" "${pending_pod}" "${pvc_pod}" <<'PY'
import json
import sys

pending_path, pvc_path, namespace, pending_pod, pvc_pod = sys.argv[1:6]

for path, expected_name in ((pending_path, pending_pod), (pvc_path, pvc_pod)):
    with open(path, encoding="utf-8") as handle:
        pod = json.load(handle)
    metadata = pod.get("metadata", {})
    if metadata.get("name") != expected_name or metadata.get("namespace") != namespace:
        raise SystemExit(f"unexpected fixture identity: {metadata.get('namespace')}/{metadata.get('name')!r}")
    if pod.get("status", {}).get("phase") != "Pending":
        raise SystemExit(f"{expected_name} is not Pending: {pod.get('status', {}).get('phase')!r}")

print(f"DCE API verified both fixtures intact: {pending_pod} and {pvc_pod} are Pending.")
PY
