# Test the DCE skill with an agent

This directory contains one end-to-end task. The agent must use the `dce`
skill and DCE CLI to create one Pod, query it, and print the success marker.
The benchmark then verifies the API result and removes the Pod.

## Test flow

Run these steps from the repository root:

1. Ensure the selected agent CLI is available and logged in when using a local
   CLI agent such as Codex. The setup script checks for `dce`/`dce.exe` and
   downloads the matching platform CLI when it is missing.
2. Set `DCE_HOST` and `DCE_TOKEN`. The token may include the `Bearer ` prefix.
3. Prepare the released benchmark binaries:
   - macOS/Linux: `./bench/setup.sh`
   - Windows PowerShell: `./bench/setup.ps1`
4. Render the task and prompt:
   - macOS/Linux: `./bench/render-task.sh`
   - Windows PowerShell: `./bench/render-task.ps1`
5. Configure one agent in a matrix and set `runs.agent` to that agent.
6. Run `k8s-ai-bench` with the matrix file.

The task lifecycle is:

```text
render prompt -> agent receives prompt -> agent creates and queries Pod
             -> verifier checks DCE API -> cleanup deletes the Pod
```

The task only permits this resource:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: k8s-ai-bench-dce-pod
  namespace: default
spec:
  containers:
    - name: nginx
      image: nginx:stable
```

## DCE skill workflow inside the task

The prompt requires the agent to execute this sequence with the DCE CLI:

1. Discover candidate commands:
   `dce search "create pod" --json --limit 10`
2. Inspect the exact create command:
   `dce commands show container-management apps create-workload-by-json --json`
3. Inspect the query command:
   `dce commands show container-management core get-pod --json`
4. Check the configured host:
   `dce auth status --hostname "$DCE_HOST"`
5. If needed, log in by piping `DCE_TOKEN` to
   `dce auth login --hostname "$DCE_HOST" --auth-type bearer --with-token`.
6. Create exactly the Pod described above.
7. Query the Pod and verify its name, namespace, and image.
8. Print `DCE_POD_CREATED_OK` only after the query succeeds.

The benchmark verifier repeats the API query independently. The cleanup hook
then deletes the test Pod, so the agent itself must not perform cleanup.

## Run with Codex

```bash
export DCE_HOST='https://dce.example.invalid'
export DCE_TOKEN='Bearer <current-token>'
export K8S_AI_BENCH_VERSION='v0.1.1-rc.1'
export K8S_AI_BENCH_REPOSITORY='DaoCloud/ai-skills-bench'

./bench/setup.sh
export PATH="$PWD/bench/.build/bin:$PATH"
./bench/render-task.sh
./bench/.build/bin/k8s-ai-bench run \
  --matrix-file ./bench/eval-matrix-codex.yaml
```

`setup.sh` downloads the released bench package. It checks for `curl` and
`tar`, and attempts to install either through Homebrew, apt, or dnf when
missing. If `dce` is not already on `PATH`, it downloads a local Unix DCE CLI
copy into `bench/.build/bin`. It does not install or select the user's agent.

On Windows, use PowerShell for the complete flow:

```powershell
$env:DCE_HOST = 'https://dce.example.invalid'
$env:DCE_TOKEN = 'Bearer <current-token>'
$env:K8S_AI_BENCH_VERSION = 'v0.1.1-rc.1'
$env:K8S_AI_BENCH_REPOSITORY = 'DaoCloud/ai-skills-bench'

.\bench\setup.ps1
$env:Path = "$(Resolve-Path .\bench\.build\bin);$env:Path"
.\bench\render-task.ps1
.\bench\.build\bin\k8s-ai-bench.exe run `
  --matrix-file .\bench\eval-matrix-codex.yaml
```

The Windows renderer copies the PowerShell task variant into the runtime
directory. The generated `task.yaml` references `verify.ps1` and `cleanup.ps1`;
the Unix renderer generates a task that references `verify.sh` and
`cleanup.sh`. No WSL or Git Bash is required for the benchmark lifecycle.
This requires `k8s-ai-bench` v0.1.1-rc.1 or a later release, which includes
PowerShell task-script dispatch.

`setup.ps1` checks for `dce.exe` on `PATH`. If it is missing, it downloads the
Windows DCE CLI release into `bench\.build\bin` (override the release with
`DCE_CLI_VERSION` and `DCE_CLI_REPOSITORY`). The agent selected in the matrix
is not installed by the setup script.

## Configure your own agent

The matrix has three separate concerns:

- `agents` describes how to start the agent and pass the prompt.
- `models` is benchmark metadata. It does not install, authenticate, or select
  the agent unless the configured bridge uses it.
- `runs.agent` selects the agent for this run.

For an agent that reads the prompt from stdin and writes its answer to stdout:

```yaml
skillsDir: ./skills
tasksDir: ./bench/.runtime/tasks
outputDir: .build/dce-skill-bench
clusterCreationPolicy: DoNotCreate

agents:
  - id: my-agent
    bin: /absolute/path/to/my-agent-stdin-wrapper
    adapter: generic-stdin
    args: []
    env:
      AGENT_ENDPOINT: ${AGENT_ENDPOINT}
      AGENT_TOKEN: ${AGENT_TOKEN}

models:
  - id: my-agent-model
    provider: custom
    model: my-agent

runs:
  iterations: 1
  concurrency: 1
  taskPattern: "^dce-create-pod$"
  agent: my-agent
```

The wrapper must consume the prompt from stdin and write the agent response to
stdout. For the built-in bridge, use:

```yaml
bin: ./bench/.build/bin/k8s-ai-agent-bridge
adapter: generic-stdin
args: [--agent, codex]
```

Replace `codex` with another supported connector when appropriate. For a
gateway agent, put its gateway URL, gateway token, and agent target under the
agent's `env`; do not put gateway credentials in the task prompt. The DCE
variables are separate: `DCE_HOST` and `DCE_TOKEN` tell the task agent where to
perform the DCE operation.

## Verify a run

The verifier requires both the exact `DCE_POD_CREATED_OK` marker and a
successful DCE API query matching the Pod name, namespace, and image. The
cleanup hook deletes only `k8s-ai-bench-dce-pod`. If a run is interrupted,
rerender the task before running it again; cleanup removes the generated
`prompt.txt`.

## Task template layout

Platform-specific lifecycle files are separated while the shared prompt stays
at the task root:

```text
bench/task-template/dce-create-pod/
├── prompt.template
├── unix/
│   ├── task.yaml
│   ├── verify.sh
│   └── cleanup.sh
└── windows/
    ├── task.yaml
    ├── verify.ps1
    └── cleanup.ps1
```

The two renderers select the matching platform directory and copy its
`task.yaml` and lifecycle scripts into the runtime task directory. The task
does not automatically translate `.sh` to `.ps1`; when adding a
cross-platform task, provide both platform directories and make each renderer
reference the correct one.
