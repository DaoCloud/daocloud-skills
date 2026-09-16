# Test the DCE skill with an agent

This directory contains one end-to-end task. The agent must use the `dce`
skill and DCE CLI to create one Pod, query it, and print the success marker.
The benchmark then verifies the API result and removes the Pod.

## Test flow

Run these steps from the repository root:

1. Make sure the DCE CLI is available as `dce`. The verifier and cleanup
   scripts use this command. A logged-in agent CLI is also required for local
   CLI agents such as Codex.
2. Set `DCE_HOST` and `DCE_TOKEN`. The token may include the `Bearer ` prefix.
3. Prepare the released benchmark binaries:
   - macOS/Linux: `./bench/setup.sh`
   - Windows PowerShell: `./bench/setup.ps1`
4. Render the task prompt:
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

On Windows, use PowerShell to download the bench ZIP with `setup.ps1`, then use
WSL or Git Bash for the complete task run. The current benchmark executes task
`setup.sh`, `verify.sh`, and `cleanup.sh` files directly, and the current DCE
CLI release does not publish a native Windows binary.

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
