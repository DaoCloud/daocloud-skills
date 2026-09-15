#!/usr/bin/env bash
set -euo pipefail

: "${DCE_HOST:?DCE_HOST is required}"
: "${DCE_TOKEN:?DCE_TOKEN is required}"
: "${K8S_AI_BENCH_TASK_OUTPUT_DIR:?K8S_AI_BENCH_TASK_OUTPUT_DIR is required}"

log_path="${K8S_AI_BENCH_TASK_OUTPUT_DIR}/log.txt"
if [[ ! -f "${log_path}" ]]; then
  echo "task log not found: ${log_path}" >&2
  exit 1
fi
if ! grep -Fq 'DCE_POD_CREATED_OK' "${log_path}"; then
  echo "agent did not emit DCE_POD_CREATED_OK" >&2
  exit 1
fi

printf '%s' "${DCE_TOKEN}" | dce --insecure --hostname "${DCE_HOST}" auth login \
  --auth-type bearer --with-token --skip-validate >/dev/null
response_path="$(mktemp)"
trap 'rm -f "${response_path}"' EXIT

dce --insecure --hostname "${DCE_HOST}" container-management core get-pod \
  --cluster kpanda-global-cluster --namespace default \
  --name k8s-ai-bench-dce-pod -o json >"${response_path}"

python3 - "${response_path}" <<'PY'
import json
import sys

with open(sys.argv[1], encoding="utf-8") as handle:
    pod = json.load(handle)
metadata = pod.get("metadata", {})
containers = pod.get("spec", {}).get("containers", [])
if metadata.get("name") != "k8s-ai-bench-dce-pod":
    raise SystemExit(f"unexpected pod name: {metadata.get('name')!r}")
if metadata.get("namespace") != "default":
    raise SystemExit(f"unexpected pod namespace: {metadata.get('namespace')!r}")
if not containers or containers[0].get("image") != "nginx:stable":
    image = containers[0].get("image") if containers else None
    raise SystemExit(f"unexpected first container image: {image!r}")
print("DCE API verified k8s-ai-bench-dce-pod in default with image nginx:stable.")
PY
