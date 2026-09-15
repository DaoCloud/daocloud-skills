#!/usr/bin/env bash
set -euo pipefail

: "${DCE_HOST:?DCE_HOST is required}"
: "${DCE_TOKEN:?DCE_TOKEN is required}"

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
trap 'rm -f "${script_dir}/prompt.txt"' EXIT

printf '%s' "${DCE_TOKEN}" | dce --insecure --hostname "${DCE_HOST}" auth login \
  --auth-type bearer --with-token --skip-validate >/dev/null
set +e
delete_output="$(dce --insecure --hostname "${DCE_HOST}" container-management core delete-pod \
  --cluster kpanda-global-cluster --namespace default \
  --name k8s-ai-bench-dce-pod -o json 2>&1)"
delete_status=$?
set -e

if [[ "${delete_status}" -eq 0 ]]; then
  echo "Deleted DCE Pod k8s-ai-bench-dce-pod."
  exit 0
fi
if printf '%s' "${delete_output}" | grep -Eiq '404|not found|does not exist'; then
  echo "DCE Pod k8s-ai-bench-dce-pod was already absent."
  exit 0
fi
printf '%s\n' "${delete_output}" >&2
exit "${delete_status}"
