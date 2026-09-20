#!/usr/bin/env bash
set -euo pipefail

: "${DCE_HOST:?DCE_HOST is required}"
: "${DCE_TOKEN:?DCE_TOKEN is required}"

cluster="kpanda-global-cluster"
namespace="default"
pod_name="k8s-ai-bench-diag-pod"
fixture_image="nginx:stable-nonexistent"

dce_token="${DCE_TOKEN#Bearer }"

printf '%s' "${dce_token}" | dce --insecure --hostname "${DCE_HOST}" auth login \
  --auth-type bearer --with-token --skip-validate >/dev/null

# Idempotency: remove any leftover fixture from a previous aborted run.
dce --insecure --hostname "${DCE_HOST}" container-management core delete-pod \
  --cluster "${cluster}" --namespace "${namespace}" --name "${pod_name}" -o json >/dev/null 2>&1 || true

work_dir="$(mktemp -d "${TMPDIR:-/tmp}/pod-diagnosis-setup.XXXXXX")"
trap 'rm -rf "${work_dir}"' EXIT

cat > "${work_dir}/pod.json" <<EOF
{
  "apiVersion": "v1",
  "kind": "Pod",
  "metadata": {
    "name": "${pod_name}",
    "namespace": "${namespace}"
  },
  "spec": {
    "containers": [
      {
        "name": "main",
        "image": "${fixture_image}"
      }
    ]
  }
}
EOF

python3 - "${work_dir}/pod.json" "${work_dir}/body.json" <<'PY'
import json
import sys

with open(sys.argv[1], encoding="utf-8") as handle:
    pod = handle.read()
with open(sys.argv[2], "w", encoding="utf-8") as handle:
    json.dump({"data": pod}, handle)
PY

dce --insecure --hostname "${DCE_HOST}" container-management apps create-workload-by-json \
  --cluster "${cluster}" --namespace "${namespace}" --kind pods \
  --file "${work_dir}/body.json" >/dev/null

deadline=$((SECONDS + 180))
while :; do
  response="$(dce --insecure --hostname "${DCE_HOST}" container-management core get-pod \
    --cluster "${cluster}" --namespace "${namespace}" --name "${pod_name}" -o json 2>/dev/null)" || true
  reason="$(printf '%s' "${response}" | python3 -c '
import json, sys

try:
    pod = json.load(sys.stdin)
except Exception:
    sys.exit(0)
for state in pod.get("status", {}).get("containerStatuses") or []:
    waiting = (state.get("state") or {}).get("waiting") or {}
    if waiting.get("reason"):
        print(waiting["reason"])
        break
' || true)"
  case "${reason}" in
    ImagePullBackOff|ErrImagePull)
      echo "Fixture pod ${pod_name} is failing image pulls (${reason})."
      exit 0
      ;;
  esac
  if (( SECONDS >= deadline )); then
    echo "fixture pod did not reach an image-pull failure state within 180s (last reason: ${reason:-none})" >&2
    exit 1
  fi
  sleep 5
done
