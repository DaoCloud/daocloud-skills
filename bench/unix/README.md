# DCE skill benchmark on Unix

This guide runs the sample DCE task on macOS or Linux. Run every command from
the `daocloud-skills` repository root.

## 1. Set the DCE environment

```bash
export DCE_HOST='https://dce.example.invalid'
export DCE_TOKEN='Bearer <current-token>'
export K8S_AI_BENCH_VERSION='v0.1.1-rc.1'
```

`DCE_TOKEN` may include the `Bearer ` prefix. The scripts remove that prefix
when calling `dce auth login`.

## 2. Download the tools

```bash
./bench/unix/setup.sh
export PATH="$PWD/bench/unix/.build/bin:$PATH"
```

The setup script downloads the released benchmark binaries. If `dce` is not
already on `PATH`, it also downloads the Unix DCE CLI. It can install missing
`curl` and `tar` through Homebrew, apt, or dnf. It does not install the agent.

Override the repositories or versions when testing another release:

```bash
export K8S_AI_BENCH_REPOSITORY='DaoCloud/ai-skills-bench'
export DCE_CLI_REPOSITORY='DaoCloud/daocloud-skills'
export DCE_CLI_VERSION='v0.2.0-rc.12'
```

## 3. Render the task(s)

```bash
./bench/unix/render-task.sh                    # render every template under task-template/
./bench/unix/render-task.sh pod-diagnosis      # render a single task
```

This substitutes `DCE_HOST` and `DCE_TOKEN` into each prompt and creates the
runtime tasks under `bench/unix/.runtime/tasks/<task-name>`. With no arguments
every template is rendered; pass a task name to render only that one. Which
rendered tasks a matrix run executes is selected by its `runs.taskPattern`
regex, so narrow the pattern instead of re-rendering when you only want a
subset.

## 4. Run with Codex

```bash
./bench/unix/.build/bin/k8s-ai-bench run \
  --matrix-file ./bench/unix/eval-matrix-codex.yaml
```

The matrix selects `k8s-ai-agent-bridge` with `args: [--agent, codex]`. The
bridge runs `codex exec --ephemeral` and passes the rendered prompt through
stdin. Codex must be installed and logged in on the same machine.

The committed matrices use `taskPattern: ".*"`, so one run executes every
rendered task. To focus a run on a subset, narrow the regex, e.g.
`taskPattern: "pod-diagnosis"` — no re-rendering needed.

To use a different agent, copy the matrix and change `agents`, `models`, and
`runs.agent`. A generic stdin wrapper must read the prompt from stdin and
write its answer to stdout.

## DCE task workflow

The prompt asks the agent to discover and inspect the DCE commands, authenticate
to `DCE_HOST`, create the single Pod, query it, and print
`DCE_POD_CREATED_OK`. The verifier independently checks the marker and the DCE
API response. Cleanup deletes only `k8s-ai-bench-dce-pod`.

The Unix template is in
`bench/unix/task-template/dce-create-pod/`:

```text
prompt.template  task.yaml  verify.sh  cleanup.sh
```
