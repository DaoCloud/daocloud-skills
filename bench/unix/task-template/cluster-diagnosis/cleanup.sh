#!/usr/bin/env bash
set -euo pipefail

: "${DCE_HOST:?DCE_HOST is required}"
: "${DCE_TOKEN:?DCE_TOKEN is required}"

cluster="kpanda-global-cluster"
namespace="default"
pending_pod="k8s-ai-bench-diag-pending-pod"
cfg_pod="k8s-ai-bench-diag-cfg-pod"

dce_token="${DCE_TOKEN#Bearer }"

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
trap 'rm -f "${script_dir}/prompt.txt"' EXIT

printf '%s' "${dce_token}" | dce --insecure --hostname "${DCE_HOST}" auth login \
  --auth-type bearer --with-token --skip-validate >/dev/null
status=0
for pod_name in "${pending_pod}" "${cfg_pod}"; do
  set +e
  delete_output="$(dce --insecure --hostname "${DCE_HOST}" container-management core delete-pod \
    --cluster "${cluster}" --namespace "${namespace}" --name "${pod_name}" -o json 2>&1)"
  delete_status=$?
  set -e
  if [[ "${delete_status}" -eq 0 ]]; then
    echo "Deleted DCE Pod ${pod_name}."
  elif printf '%s' "${delete_output}" | grep -Eiq '404|not found|does not exist'; then
    echo "DCE Pod ${pod_name} was already absent."
  else
    printf '%s\n' "${delete_output}" >&2
    status=1
  fi
done
exit "${status}"
