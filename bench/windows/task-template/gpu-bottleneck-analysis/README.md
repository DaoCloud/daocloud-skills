# gpu-bottleneck-analysis

Bench task for the `container-management-gpu-bottleneck-analysis` skill:
analyze GPU pool capacity across clusters and predict which GPU pool becomes
the bottleneck first if inference traffic grows by 30%.

## Test scenario

The task targets the cluster named by `K8S_AI_BENCH_GPU_CLUSTER` (default
`jinye-gpu-cluster-1`) in namespace `K8S_AI_BENCH_GPU_NAMESPACE` (default
`default`). The target cluster is expected to expose two GPU pools:

- a physical GPU pool (mode `GPU`), typically already fully allocated by
  pre-existing workloads, and
- a HAMi vGPU pool (mode `VGPU`).

`setup.sh` (Unix) / `setup.ps1` (Windows) saturates the vGPU pool
deterministically:

1. It removes any leftover fixture from an aborted previous run and waits for
   lingering vGPU allocations to decay to zero (HAMi pods can take several
   minutes to release their slices after deletion; a mid-run release would
   invalidate the census cross-check below).
2. It reads the live pool size from `sum(kpanda_gpu_count) by (mode)` and
   creates the Deployment `k8s-ai-bench-gpu-saturate` with one replica per
   vGPU slice. Each Pod requests `nvidia.com/vgpu: 1` plus small
   `nvidia.com/gpucores`/`nvidia.com/gpumem` slices and uses the nonexistent
   image `nginx:stable-nonexistent`. No node pinning is needed: the HAMi
   scheduler only admits vGPU requests onto nodes that expose vGPU devices.
3. Because the image cannot be pulled, every Pod is *bound* by the HAMi
   scheduler — reserving a vGPU slice in `kpanda_gpu_allocated` — but never
   starts a container, so no real GPU compute or memory is consumed.
4. Unschedulable Pods are deleted periodically: fresh replacement Pods enter
   the scheduling queue without the exponential backoff history, which makes
   HAMi binding converge in seconds instead of minutes.
5. Setup finishes only once `sum(kpanda_gpu_allocated) by (mode)` reports the
   pool as fully allocated.

Together with any healthy contrast cluster (large headroom in both modes),
this gives the +30% projection a single deterministic answer: the target
cluster exhausts its scheduling capacity first, while GPU core utilization
stays near zero.

## Agent contract

Following the gpu-bottleneck-analysis skill workflow, the agent discovers the
GPU clusters, collects the kpanda GPU recording-rule metrics per cluster and
per GPU mode, inspects GPU workloads, and runs the +30% projection (using the
skill's QPS fallback when inference QPS metrics are unavailable). The prompt
requires these machine-readable outputs:

- one line per analyzed cluster and mode, of exactly the form
  `Census: <cluster> mode=<mode> total=<N> allocated=<M>`
- one line for the first bottleneck pool, of exactly the form
  `Bottleneck: <cluster> (<mode>, <constraint>)` with the constraint being
  `compute`, `scheduling`, or `vram`
- the completion marker `GPU_BOTTLENECK_OK`

The task is strictly read-only.

## Verification

`verify.sh` / `verify.ps1` fails the run unless:

1. The task log contains `GPU_BOTTLENECK_OK`.
2. The reported VGPU census numbers match the live metrics API at verify
   time — both the pool total and the allocated count are re-queried and
   compared for equality, so fabricated numbers fail.
3. The bottleneck line names the target cluster with a valid constraint:
   `compute` is always rejected (core utilization is idle by design), the
   VGPU mode must be `scheduling` (its VRAM stays below capacity), and the
   GPU mode accepts `scheduling` or `vram` because pre-existing workloads
   may hold all of its VRAM as well.
4. The fixture Deployment is still present and the pool is still saturated
   according to the live API, proving the agent analyzed without modifying
   anything.

## Expected result

A passing run identifies the target cluster as the first bottleneck with a
scheduling constraint (or `vram` when naming the fully-allocated GPU mode).
When both pools are saturated, both modes are legitimate answers — observed
runs have produced either. `cleanup.sh` / `cleanup.ps1` deletes the fixture
Deployment afterwards; the reserved slices release within a few minutes,
which the next run's baseline wait absorbs.

## Environment requirements

- The DCE at `DCE_HOST` must manage the target cluster with HAMi installed
  and `insight-agent` reporting the `kpanda_gpu_*` recording rules.
- The vGPU pool must be free of foreign allocations at setup time; the
  baseline wait tolerates slow release from previous runs.
- Override `K8S_AI_BENCH_GPU_CLUSTER` (default `jinye-gpu-cluster-1`) and
  `K8S_AI_BENCH_GPU_NAMESPACE` (default `default`) to run against a
  different cluster or namespace.

## Running the task

See `bench/unix/README.md` (or `bench/windows/README.md` on Windows) for the
full runbook; in short: set `DCE_HOST`/`DCE_TOKEN`, render the task, and run
a matrix whose `runs.taskPattern` selects this task, e.g.
`taskPattern: "gpu-bottleneck-analysis"`.
