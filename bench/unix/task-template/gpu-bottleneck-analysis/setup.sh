#!/usr/bin/env bash
set -euo pipefail

: "${DCE_HOST:?DCE_HOST is required}"
: "${DCE_TOKEN:?DCE_TOKEN is required}"
: "${K8S_AI_BENCH_GPU_CLUSTER:?K8S_AI_BENCH_GPU_CLUSTER is required (name of the GPU cluster to saturate, e.g. jinye-gpu-cluster-1)}"
: "${K8S_AI_BENCH_GPU_NAMESPACE:?K8S_AI_BENCH_GPU_NAMESPACE is required (namespace for the fixture Deployment, e.g. default)}"

cluster="${K8S_AI_BENCH_GPU_CLUSTER}"
namespace="${K8S_AI_BENCH_GPU_NAMESPACE}"
deployment="k8s-ai-bench-gpu-saturate"

# Consumed by the inline python helpers below through os.environ.
export DEPLOYMENT_NAME="${deployment}"

dce_token="${DCE_TOKEN#Bearer }"

printf '%s' "${dce_token}" | dce --insecure --hostname "${DCE_HOST}" auth login \
  --auth-type bearer --with-token --skip-validate >/dev/null

# Prints the integer value of <promql> for mode=VGPU on the target cluster.
# Prints 0 when the vector has no VGPU series or the query fails.
vgpu_metric() {
  dce --insecure --hostname "${DCE_HOST}" insight metric query-metric \
    --cluster-name "${cluster}" --query "$1" -o json 2>/dev/null \
    | python3 -c 'import json,sys
try:
    data = json.load(sys.stdin)
except Exception:
    print(0)
    raise SystemExit
for vector in data.get("vector", []):
    if vector["metric"].get("mode") == "VGPU":
        print(int(float(vector["values"]["value"])))
        break
else:
    print(0)
'
}

# Prints "<bound> <total>" pod counts for the fixture deployment.
fixture_pod_counts() {
  dce --insecure --hostname "${DCE_HOST}" \
    container-management core list-pods --cluster "${cluster}" --namespace "${namespace}" -o json 2>/dev/null \
    | python3 -c 'import json,os,sys
try:
    data = json.load(sys.stdin)
except Exception:
    print(0, 0)
    raise SystemExit
deployment = os.environ["DEPLOYMENT_NAME"]
bound = total = 0
for pod in data.get("items", []):
    if deployment in pod["metadata"]["name"]:
        total += 1
        if pod["spec"].get("nodeName"):
            bound += 1
print(bound, total)
'
}

# Deletes fixture pods that are still unschedulable. Fresh replacement pods
# enter the scheduling queue without the exponential backoff history, which is
# what makes HAMi vGPU binding converge in seconds instead of minutes.
reset_unbound_pods() {
  dce --insecure --hostname "${DCE_HOST}" \
    container-management core list-pods --cluster "${cluster}" --namespace "${namespace}" -o json 2>/dev/null \
    | python3 -c 'import json,os,sys
try:
    data = json.load(sys.stdin)
except Exception:
    raise SystemExit
deployment = os.environ["DEPLOYMENT_NAME"]
for pod in data.get("items", []):
    name = pod["metadata"]["name"]
    if deployment in name and not pod["spec"].get("nodeName"):
        print(name)
' | while read -r pod_name; do
    [[ -n "${pod_name}" ]] || continue
    dce --insecure --hostname "${DCE_HOST}" container-management core delete-pod \
      --cluster "${cluster}" --namespace "${namespace}" --name "${pod_name}" -o json >/dev/null 2>&1 || true
  done
}

# Idempotency: remove any leftover fixture from a previous aborted run.
dce --insecure --hostname "${DCE_HOST}" container-management apps delete-deployment \
  --cluster "${cluster}" --namespace "${namespace}" --name "${deployment}" -o json >/dev/null 2>&1 || true

# Wait for lingering allocations from a previous run to clear so the census
# baseline starts at zero. Terminating HAMi pods can take several minutes to
# release their vGPU slices; a release mid-run would invalidate the census
# cross-check in verify.sh.
baseline_deadline=$((SECONDS + 600))
while :; do
  baseline_allocated="$(vgpu_metric "sum(kpanda_gpu_allocated) by (mode)")"
  if (( baseline_allocated == 0 )); then
    break
  fi
  if (( SECONDS >= baseline_deadline )); then
    echo "warning: VGPU allocated=${baseline_allocated} before fixture creation; continuing anyway" >&2
    break
  fi
  sleep 30
done

# Size the fixture to the live vGPU capacity reported by kpanda.
vgpu_total="$(vgpu_metric "sum(kpanda_gpu_count) by (mode)")"
if (( vgpu_total < 1 )); then
  echo "no VGPU capacity reported for ${cluster} (kpanda_gpu_count mode=VGPU is empty)" >&2
  exit 1
fi

work_dir="$(mktemp -d "${TMPDIR:-/tmp}/gpu-bottleneck-setup.XXXXXX")"
trap 'rm -rf "${work_dir}"' EXIT

# Fixture: a Deployment whose replicas request one vGPU slice each. No node
# pinning is needed: the HAMi scheduler only admits vGPU requests onto nodes
# that expose vGPU devices. The intentionally nonexistent image keeps every
# pod Pending after binding, so the pods reserve vGPU allocation
# (kpanda_gpu_allocated counts bound pods) without consuming any real GPU
# compute or memory.
cat > "${work_dir}/deployment.json" <<EOF
{
  "apiVersion": "apps/v1",
  "kind": "Deployment",
  "metadata": {
    "name": "${deployment}",
    "namespace": "${namespace}"
  },
  "spec": {
    "replicas": ${vgpu_total},
    "selector": {"matchLabels": {"app": "${deployment}"}},
    "template": {
      "metadata": {"labels": {"app": "${deployment}"}},
      "spec": {
        "containers": [
          {
            "name": "main",
            "image": "nginx:stable-nonexistent",
            "resources": {
              "requests": {"cpu": "100m", "memory": "128Mi", "nvidia.com/vgpu": "1", "nvidia.com/gpucores": "20", "nvidia.com/gpumem": "1024"},
              "limits": {"cpu": "250m", "memory": "256Mi", "nvidia.com/vgpu": "1", "nvidia.com/gpucores": "20", "nvidia.com/gpumem": "1024"}
            }
          }
        ]
      }
    }
  }
}
EOF

python3 - "${work_dir}/deployment.json" "${work_dir}/body.json" <<'PY'
import json
import sys

with open(sys.argv[1], encoding="utf-8") as handle:
    resource = handle.read()
with open(sys.argv[2], "w", encoding="utf-8") as handle:
    json.dump({"data": resource}, handle)
PY

dce --insecure --hostname "${DCE_HOST}" container-management apps create-workload-by-json \
  --cluster "${cluster}" --namespace "${namespace}" --kind deployments \
  --file "${work_dir}/body.json" >/dev/null

# Wait until the vGPU pool is fully allocated. Binding is retried by deleting
# unschedulable pods; the allocated metric lags binding by a scrape interval.
deadline=$((SECONDS + 600))
last_reset=${SECONDS}
while :; do
  read -r bound total <<< "$(fixture_pod_counts)"
  allocated="$(vgpu_metric "sum(kpanda_gpu_allocated) by (mode)")"

  if (( allocated >= vgpu_total )); then
    echo "Fixture ready: VGPU pool on ${cluster} saturated (${allocated}/${vgpu_total} allocated, ${bound} fixture pods bound)."
    exit 0
  fi

  if (( bound < vgpu_total && SECONDS - last_reset >= 45 )); then
    reset_unbound_pods
    last_reset=${SECONDS}
  fi

  if (( SECONDS >= deadline )); then
    echo "VGPU pool not saturated within 600s (bound ${bound}/${total}, allocated ${allocated}/${vgpu_total})" >&2
    exit 1
  fi
  sleep 15
done
