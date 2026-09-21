# pod-diagnosis

Bench task for the `container-management-pod-diagnosis` skill: diagnose a
single Pod that cannot start and report the root cause.

## Test scenario

`setup.sh` (Unix) / `setup.ps1` (Windows) creates one Pod in the target DCE:

- Cluster: `kpanda-global-cluster`, namespace `default`
- Name: `k8s-ai-bench-diag-pod`
- Image: `nginx:stable-nonexistent` — a tag that can never be pulled

The Pod schedules normally, but its container never starts: the kubelet keeps
retrying the image pull and leaves the container in `ErrImagePull` /
`ImagePullBackOff`. This yields a single, unambiguous root cause that does
not depend on node capacity or registry reachability — the image simply does
not exist.

## Agent contract

Following the pod-diagnosis skill workflow, the agent confirms `dce`
authentication, inspects the Pod's status, events, and container state, and
presents a structured diagnosis. The prompt requires two machine-readable
outputs:

- exactly one line of the form `Root Cause: <short reason>`
- the completion marker `POD_DIAGNOSIS_OK`

The task is strictly read-only: the prompt forbids creating, deleting,
updating, or restarting any resource.

## Verification

`verify.sh` / `verify.ps1` fails the run unless:

1. The task log contains `POD_DIAGNOSIS_OK`.
2. The log names an image-pull failure (`ErrImagePull` or `ImagePullBackOff`)
   as the root cause.
3. The fixture is still intact according to the live DCE API — same name,
   namespace, and image, with the container still in an image-pull failure
   state. This proves the agent performed a read-only diagnosis and did not
   "fix" or delete the Pod.

## Expected result

A passing run identifies the image-pull failure as the root cause, emits the
`Root Cause:` line followed by `POD_DIAGNOSIS_OK`, and leaves the fixture
untouched. `cleanup.sh` / `cleanup.ps1` deletes the Pod afterwards.

## Running the task

`DCE_HOST`/`DCE_TOKEN` must point at a DCE instance that manages
`kpanda-global-cluster`. See `bench/unix/README.md` (or
`bench/windows/README.md` on Windows) for the full runbook; in short: set the
two environment variables, render the task, and run a matrix whose
`runs.taskPattern` selects this task, e.g. `taskPattern: "pod-diagnosis"`.
