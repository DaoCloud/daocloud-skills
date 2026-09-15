# DCE skill agent benchmark

This example uses [k8s-ai-bench](https://github.com/DaoCloud/k8s-ai-bench) to
evaluate whether a headless agent can use the repository's `dce` skill to
create one Pod in a DCE environment. The task is kept as a template so the
DCE address and bearer token are supplied at runtime instead of committed to
the repository.

## How it works

1. `render-task.sh` reads `DCE_HOST` and `DCE_TOKEN` from the environment.
2. It copies `bench/task-template/dce-create-pod` to the ignored
   `bench/.runtime/tasks/dce-create-pod` directory and renders `prompt.txt`.
3. `k8s-ai-bench` starts the configured agent bridge and sends the rendered
   prompt through its standard input adapter.
4. The agent reads `skills/dce/SKILL.md`, uses the DCE CLI to create the Pod,
   and prints `DCE_POD_CREATED_OK` only after checking the result.
5. The verifier queries the Pod with the DCE CLI. The cleanup hook deletes it
   after the iteration.

The generated directory is intentionally ignored. Do not commit `DCE_TOKEN`
or paste it into a matrix file.

## Prerequisites

- A checkout of this repository.
- A working `dce` CLI available to the agent runtime and on `PATH` for the
  verifier and cleanup scripts.
- A current DCE bearer token with permission to create, get, and delete Pods.
- A logged-in Codex CLI, or another supported local agent connector.
- Go and a checkout of `k8s-ai-bench` with `k8s-ai-agent-bridge` support.

Set the DCE connection values in the shell where both the agent and benchmark
will run:

```bash
export DCE_HOST='https://dce.example.invalid'
export DCE_TOKEN='Bearer <current-token>'
```

The value of `DCE_TOKEN` is passed to `dce auth login` through standard input;
it is not put in a command-line argument. Keep the terminal session private.

## Build and run with Codex

Run these commands from the root of this repository:

```bash
export SKILLS_ROOT="$PWD"
export K8S_AI_BENCH_ROOT='/path/to/k8s-ai-bench'

mkdir -p "$SKILLS_ROOT/bench/.build/bin"
(cd "$K8S_AI_BENCH_ROOT" && \
  go build -o "$SKILLS_ROOT/bench/.build/bin/k8s-ai-bench" . && \
  go build -o "$SKILLS_ROOT/bench/.build/bin/k8s-ai-agent-bridge" ./cmd/k8s-ai-agent-bridge)

"$SKILLS_ROOT/bench/render-task.sh"
"$SKILLS_ROOT/bench/.build/bin/k8s-ai-bench" run \
  --matrix-file "$SKILLS_ROOT/bench/eval-matrix-codex.yaml"
```

The matrix runs only `dce-create-pod`. It uses the `codex` connector selected
by `args: [--agent, codex]`; the model entry supplies the connector's model
metadata and does not replace the Codex CLI login.

Before a live run, the DCE skill's normal authentication check can be used:

```bash
dce auth status --hostname "$DCE_HOST"
```

If a run is interrupted, wait until no benchmark process is using the
generated task and then remove only the generated directory:

```bash
rm -rf bench/.runtime
```

## Task contract

The agent must create this Pod in `default` on `kpanda-global-cluster`:

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

The verifier checks the success marker, Pod name, namespace, and container
image. It does not accept a successful answer without querying DCE.

## Using another supported agent

The same rendered task can be used with the bridge's other connectors by
copying the matrix and changing the agent entry and `runs.agent`, for example
`claude`, `openclaw`, or `hermes`. Gateway connectors additionally need their
own `*_BASE_URL`, `*_GATEWAY_TOKEN`, and `*_AGENT_TARGET` environment variables;
those values are connector settings, not DCE credentials.
