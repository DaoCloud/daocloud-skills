#!/usr/bin/env bash
set -euo pipefail

: "${DCE_HOST:?DCE_HOST is required}"
: "${DCE_TOKEN:?DCE_TOKEN is required}"
: "${K8S_AI_BENCH_TASK_OUTPUT_DIR:?K8S_AI_BENCH_TASK_OUTPUT_DIR is required}"

# Target environment. Override with K8S_AI_BENCH_GPU_CLUSTER /
# K8S_AI_BENCH_GPU_NAMESPACE when running against a different DCE.
cluster="${K8S_AI_BENCH_GPU_CLUSTER:-jinye-gpu-cluster-1}"
namespace="${K8S_AI_BENCH_GPU_NAMESPACE:-default}"
deployment="k8s-ai-bench-gpu-saturate"

log_path="${K8S_AI_BENCH_TASK_OUTPUT_DIR}/log.txt"
if [[ ! -f "${log_path}" ]]; then
  echo "task log not found: ${log_path}" >&2
  exit 1
fi
if ! grep -Fq 'GPU_BOTTLENECK_OK' "${log_path}"; then
  echo "agent did not emit GPU_BOTTLENECK_OK" >&2
  exit 1
fi

census="$(grep -Eo "Census: ${cluster} mode=VGPU total=[0-9]+ allocated=[0-9]+" "${log_path}" | head -n 1 || true)"
if [[ -z "${census}" ]]; then
  echo "agent did not report a VGPU census line for ${cluster}" >&2
  exit 1
fi
[[ "${census}" =~ total=([0-9]+)\ allocated=([0-9]+) ]] || { echo "malformed census line: ${census}" >&2; exit 1; }
reported_total="${BASH_REMATCH[1]}"
reported_allocated="${BASH_REMATCH[2]}"

bottleneck="$(grep -Eo "Bottleneck: ${cluster} \((GPU|VGPU), (compute|scheduling|vram)\)" "${log_path}" | head -n 1 || true)"
if [[ -z "${bottleneck}" ]]; then
  echo "agent did not identify ${cluster} as the first bottleneck" >&2
  exit 1
fi
[[ "${bottleneck}" =~ \((GPU|VGPU),\ (compute|scheduling|vram)\) ]] || { echo "malformed bottleneck line: ${bottleneck}" >&2; exit 1; }
bottleneck_mode="${BASH_REMATCH[1]}"
bottleneck_constraint="${BASH_REMATCH[2]}"
if [[ "${bottleneck_constraint}" == "compute" ]]; then
  echo "agent reported a compute constraint, but GPU core utilization is idle; expected scheduling (or vram for the GPU mode)" >&2
  exit 1
fi
if [[ "${bottleneck_mode}" == "VGPU" && "${bottleneck_constraint}" != "scheduling" ]]; then
  echo "agent reported constraint ${bottleneck_constraint} for VGPU mode, but only scheduling is saturated there" >&2
  exit 1
fi

dce_token="${DCE_TOKEN#Bearer }"

printf '%s' "${dce_token}" | dce --insecure --hostname "${DCE_HOST}" auth login \
  --auth-type bearer --with-token --skip-validate >/dev/null

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

live_total="$(vgpu_metric "sum(kpanda_gpu_count) by (mode)")"
live_allocated="$(vgpu_metric "sum(kpanda_gpu_allocated) by (mode)")"

if (( reported_total != live_total )); then
  echo "reported VGPU total ${reported_total} does not match live value ${live_total}" >&2
  exit 1
fi
if (( reported_allocated != live_allocated )); then
  echo "reported VGPU allocated ${reported_allocated} does not match live value ${live_allocated}" >&2
  exit 1
fi
if (( live_allocated != live_total )); then
  echo "fixture no longer saturates the VGPU pool (allocated ${live_allocated} / total ${live_total})" >&2
  exit 1
fi

response_dir="$(mktemp -d)"
trap 'rm -rf "${response_dir}"' EXIT

dce --insecure --hostname "${DCE_HOST}" container-management apps get-deployment \
  --cluster "${cluster}" --namespace "${namespace}" --name "${deployment}" -o json >"${response_dir}/deployment.json"

python3 - "${response_dir}/deployment.json" "${namespace}" "${deployment}" <<'PY'
import json
import sys

path, namespace, deployment = sys.argv[1:4]
with open(path, encoding="utf-8") as handle:
    resource = json.load(handle)
metadata = resource.get("metadata", {})
if metadata.get("name") != deployment or metadata.get("namespace") != namespace:
    raise SystemExit(f"unexpected fixture identity: {metadata.get('namespace')}/{metadata.get('name')!r}")

print(f"DCE API verified fixture intact: {deployment} is present in {namespace}.")
PY

echo "Verified: agent identified ${cluster} (${bottleneck_mode}, ${bottleneck_constraint}) as the first bottleneck with numbers matching the live metrics API (VGPU total=${live_total}, allocated=${live_allocated})."
