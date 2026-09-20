#!/usr/bin/env bash
set -euo pipefail

: "${DCE_HOST:?DCE_HOST is required}"
: "${DCE_TOKEN:?DCE_TOKEN is required}"

cluster="kpanda-global-cluster"
namespace="default"
pending_pod="k8s-ai-bench-diag-pending-pod"
pvc_pod="k8s-ai-bench-diag-pvc-pod"

dce_token="${DCE_TOKEN#Bearer }"

printf '%s' "${dce_token}" | dce --insecure --hostname "${DCE_HOST}" auth login \
  --auth-type bearer --with-token --skip-validate >/dev/null

# Idempotency: remove any leftover fixtures from a previous aborted run.
for pod_name in "${pending_pod}" "${pvc_pod}"; do
  dce --insecure --hostname "${DCE_HOST}" container-management core delete-pod \
    --cluster "${cluster}" --namespace "${namespace}" --name "${pod_name}" -o json >/dev/null 2>&1 || true
done

work_dir="$(mktemp -d "${TMPDIR:-/tmp}/cluster-diagnosis-setup.XXXXXX")"
trap 'rm -rf "${work_dir}"' EXIT

# Fixture 1: unschedulable Pod — an impossible resource request keeps it
# Pending forever, without depending on image pulls or node capacity.
cat > "${work_dir}/pending.json" <<EOF
{
  "apiVersion": "v1",
  "kind": "Pod",
  "metadata": {
    "name": "${pending_pod}",
    "namespace": "${namespace}"
  },
  "spec": {
    "containers": [
      {
        "name": "main",
        "image": "nginx:stable",
        "resources": {
          "requests": {
            "cpu": "100",
            "memory": "200Gi"
          }
        }
      }
    ]
  }
}
EOF

# Fixture 2: a Pod referencing a missing PersistentVolumeClaim is held
# Pending by the scheduler with an unbound-volume failure. Like fixture 1 it
# is never scheduled, so no image pull is ever attempted.
cat > "${work_dir}/pvc.json" <<EOF
{
  "apiVersion": "v1",
  "kind": "Pod",
  "metadata": {
    "name": "${pvc_pod}",
    "namespace": "${namespace}"
  },
  "spec": {
    "containers": [
      {
        "name": "main",
        "image": "nginx:stable"
      }
    ],
    "volumes": [
      {
        "name": "data",
        "persistentVolumeClaim": {
          "claimName": "k8s-ai-bench-nonexistent-pvc"
        }
      }
    ]
  }
}
EOF

for fixture in pending pvc; do
  python3 - "${work_dir}/${fixture}.json" "${work_dir}/${fixture}-body.json" <<'PY'
import json
import sys

with open(sys.argv[1], encoding="utf-8") as handle:
    pod = handle.read()
with open(sys.argv[2], "w", encoding="utf-8") as handle:
    json.dump({"data": pod}, handle)
PY
  dce --insecure --hostname "${DCE_HOST}" container-management apps create-workload-by-json \
    --cluster "${cluster}" --namespace "${namespace}" --kind pods \
    --file "${work_dir}/${fixture}-body.json" >/dev/null
done

deadline=$((SECONDS + 180))
while :; do
  pending_phase="$(dce --insecure --hostname "${DCE_HOST}" container-management core get-pod \
    --cluster "${cluster}" --namespace "${namespace}" --name "${pending_pod}" -o json 2>/dev/null \
    | python3 -c 'import json,sys
try:
    print(json.load(sys.stdin).get("status", {}).get("phase", ""))
except Exception:
    pass' || true)"
  pvc_phase="$(dce --insecure --hostname "${DCE_HOST}" container-management core get-pod \
    --cluster "${cluster}" --namespace "${namespace}" --name "${pvc_pod}" -o json 2>/dev/null \
    | python3 -c 'import json,sys
try:
    print(json.load(sys.stdin).get("status", {}).get("phase", ""))
except Exception:
    pass' || true)"

  if [[ "${pending_phase}" == "Pending" && "${pvc_phase}" == "Pending" ]]; then
    echo "Fixture pods ready: ${pending_pod} and ${pvc_pod} are Pending for different scheduling reasons."
    exit 0
  fi
  if (( SECONDS >= deadline )); then
    echo "fixtures not ready within 180s (pending phase: ${pending_phase:-none}, pvc phase: ${pvc_phase:-none})" >&2
    exit 1
  fi
  sleep 5
done
