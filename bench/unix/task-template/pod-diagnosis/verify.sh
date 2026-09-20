#!/usr/bin/env bash
set -euo pipefail

: "${DCE_HOST:?DCE_HOST is required}"
: "${DCE_TOKEN:?DCE_TOKEN is required}"
: "${K8S_AI_BENCH_TASK_OUTPUT_DIR:?K8S_AI_BENCH_TASK_OUTPUT_DIR is required}"

cluster="kpanda-global-cluster"
namespace="default"
pod_name="k8s-ai-bench-diag-pod"
fixture_image="nginx:stable-nonexistent"

dce_token="${DCE_TOKEN#Bearer }"

log_path="${K8S_AI_BENCH_TASK_OUTPUT_DIR}/log.txt"
if [[ ! -f "${log_path}" ]]; then
  echo "task log not found: ${log_path}" >&2
  exit 1
fi
if ! grep -Fq 'POD_DIAGNOSIS_OK' "${log_path}"; then
  echo "agent did not emit POD_DIAGNOSIS_OK" >&2
  exit 1
fi
if ! grep -Fqi 'ImagePullBackOff' "${log_path}"; then
  echo "agent did not identify ImagePullBackOff as the root cause" >&2
  exit 1
fi

printf '%s' "${dce_token}" | dce --insecure --hostname "${DCE_HOST}" auth login \
  --auth-type bearer --with-token --skip-validate >/dev/null
response_path="$(mktemp)"
trap 'rm -f "${response_path}"' EXIT

dce --insecure --hostname "${DCE_HOST}" container-management core get-pod \
  --cluster "${cluster}" --namespace "${namespace}" --name "${pod_name}" -o json >"${response_path}"

python3 - "${response_path}" "${pod_name}" "${namespace}" "${fixture_image}" <<'PY'
import json
import sys

response_path, pod_name, namespace, fixture_image = sys.argv[1:5]
with open(response_path, encoding="utf-8") as handle:
    pod = json.load(handle)
metadata = pod.get("metadata", {})
containers = pod.get("spec", {}).get("containers", [])
if metadata.get("name") != pod_name:
    raise SystemExit(f"unexpected pod name: {metadata.get('name')!r}")
if metadata.get("namespace") != namespace:
    raise SystemExit(f"unexpected pod namespace: {metadata.get('namespace')!r}")
if not containers or containers[0].get("image") != fixture_image:
    image = containers[0].get("image") if containers else None
    raise SystemExit(f"unexpected first container image: {image!r}")
reasons = []
for state in pod.get("status", {}).get("containerStatuses") or []:
    waiting = (state.get("state") or {}).get("waiting") or {}
    if waiting.get("reason"):
        reasons.append(waiting["reason"])
if "ImagePullBackOff" not in reasons:
    raise SystemExit(f"fixture pod is not in ImagePullBackOff: {reasons!r}")
print(f"DCE API verified {pod_name} is still in ImagePullBackOff with image {fixture_image}.")
PY
