#!/usr/bin/env bash
set -euo pipefail

: "${DCE_HOST:?DCE_HOST is required}"
: "${DCE_TOKEN:?DCE_TOKEN is required}"

# Target environment. Override with K8S_AI_BENCH_GPU_CLUSTER /
# K8S_AI_BENCH_GPU_NAMESPACE when running against a different DCE.
cluster="${K8S_AI_BENCH_GPU_CLUSTER:-jinye-gpu-cluster-1}"
namespace="${K8S_AI_BENCH_GPU_NAMESPACE:-default}"
deployment="k8s-ai-bench-gpu-saturate"

dce_token="${DCE_TOKEN#Bearer }"

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
trap 'rm -f "${script_dir}/prompt.txt"' EXIT

printf '%s' "${dce_token}" | dce --insecure --hostname "${DCE_HOST}" auth login \
  --auth-type bearer --with-token --skip-validate >/dev/null

set +e
delete_output="$(dce --insecure --hostname "${DCE_HOST}" container-management apps delete-deployment \
  --cluster "${cluster}" --namespace "${namespace}" --name "${deployment}" -o json 2>&1)"
delete_status=$?
set -e

if [[ "${delete_status}" -eq 0 ]]; then
  echo "Deleted DCE Deployment ${deployment}."
elif printf '%s' "${delete_output}" | grep -Eiq '404|not found|does not exist'; then
  echo "DCE Deployment ${deployment} was already absent."
else
  printf '%s\n' "${delete_output}" >&2
  exit 1
fi
