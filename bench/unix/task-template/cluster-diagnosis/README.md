# cluster-diagnosis

Bench task for the `container-management-cluster-diagnosis` skill: run a full
health inspection of one cluster and report every abnormal Pod.

## Test scenario

`setup.sh` (Unix) / `setup.ps1` (Windows) creates two Pods in the target
cluster and namespace, each held Pending for a *different* scheduling
reason. The target is selected by `K8S_AI_BENCH_DIAG_CLUSTER` (default
`kpanda-global-cluster`, the built-in management cluster of every DCE) and
`K8S_AI_BENCH_DIAG_NAMESPACE` (default `default`):

- `k8s-ai-bench-diag-pending-pod` requests `cpu: 100` and `memory: 200Gi` —
  an impossible request that keeps it Pending forever with a
  `FailedScheduling` condition.
- `k8s-ai-bench-diag-pvc-pod` references the missing PersistentVolumeClaim
  `k8s-ai-bench-nonexistent-pvc`, so the scheduler holds it Pending with an
  unbound-volume failure.

Neither Pod is ever scheduled, so the fixture never attempts an image pull
and is independent of node capacity. The two distinct failure modes are the
point of the task: a passing agent must find both Pods and tell the two
scheduling reasons apart.

## Agent contract

Following the cluster-diagnosis skill workflow, the agent confirms `dce`
authentication, inspects the cluster overview, node health, and Pod inventory
before drawing any conclusion. For every abnormal Pod it must emit one line
of exactly this form:

    Pod: <namespace>/<name> (<reason>)

and finish with the marker `CLUSTER_DIAGNOSIS_OK`. The task is strictly
read-only.

## Verification

`verify.sh` / `verify.ps1` fails the run unless:

1. The task log contains `CLUSTER_DIAGNOSIS_OK`.
2. Both fixture Pods are reported as abnormal — the log must contain
   `Pod: default/k8s-ai-bench-diag-pending-pod` and
   `Pod: default/k8s-ai-bench-diag-pvc-pod`.
3. The live DCE API still shows both Pods Pending with the expected identity,
   proving the agent inspected without modifying anything.

## Expected result

A passing run reports both fixture Pods as abnormal, each with its own
scheduling reason, and leaves them Pending. `cleanup.sh` / `cleanup.ps1`
deletes both Pods afterwards.

## Running the task

`DCE_HOST`/`DCE_TOKEN` must point at a DCE instance that manages the target
cluster. See `bench/unix/README.md` (or `bench/windows/README.md` on Windows)
for the full runbook; in short: set the environment variables, render the
task, and run a matrix whose `runs.taskPattern` selects this task, e.g.
`taskPattern: "cluster-diagnosis"`.
