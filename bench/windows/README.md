# DCE skill benchmark on Windows

This guide runs the sample DCE task natively in Windows PowerShell. WSL and
Git Bash are not required. Run PowerShell from the `daocloud-skills`
repository root.

## 1. Set the DCE environment

```powershell
$env:DCE_HOST = 'https://dce.example.invalid'
$env:DCE_TOKEN = 'Bearer <current-token>'
$env:K8S_AI_BENCH_VERSION = 'v0.1.1-rc.1'
$env:K8S_AI_BENCH_REPOSITORY = 'DaoCloud/ai-skills-bench'
$env:DCE_CLI_VERSION = 'v0.2.0-rc.12'
```

`DCE_TOKEN` may include the `Bearer ` prefix. The scripts remove that prefix
when calling `dce auth login`.

## 2. Download the tools

```powershell
.\bench\windows\setup.ps1
$env:Path = "$(Resolve-Path .\bench\windows\.build\bin);$env:Path"
```

The setup script detects amd64 or arm64, downloads the matching Windows
benchmark ZIP, and extracts the `.exe` files. If `dce.exe` is not already on
`PATH`, it downloads the Windows DCE CLI into the same directory. Override the
DCE release with `DCE_CLI_VERSION` and `DCE_CLI_REPOSITORY`.

The setup script does not install the agent. For Codex, install and log in to
Codex on this same Windows machine.

## 3. Render the task(s)

```powershell
.\bench\windows\render-task.ps1                    # render every template under task-template\
.\bench\windows\render-task.ps1 pod-diagnosis      # render a single task
```

This substitutes `DCE_HOST` and `DCE_TOKEN` into each prompt and creates the
runtime tasks under `bench\windows\.runtime\tasks\<task-name>`. With no
arguments every template is rendered; pass a task name to render only that
one. Which rendered tasks a matrix run executes is selected by its
`runs.taskPattern` regex, so narrow the pattern instead of re-rendering when
you only want a subset.

## 4. Run with Codex

```powershell
.\bench\windows\.build\bin\k8s-ai-bench.exe run `
  --matrix-file .\bench\windows\eval-matrix-codex.yaml
```

The matrix runs `k8s-ai-agent-bridge.exe --agent codex`. The bridge invokes
`codex.exe exec --ephemeral` and passes the rendered prompt through stdin. If
Codex is not on `PATH`, set its full path before running:

```powershell
$env:CODEX_BIN = 'C:\Users\<user>\AppData\Roaming\npm\codex.exe'
```

The committed matrices use `taskPattern: ".*"`, so one run executes every
rendered task. To focus a run on a subset, narrow the regex, e.g.
`taskPattern: "pod-diagnosis"` — no re-rendering needed.

To use another agent, copy the matrix and change `agents`, `models`, and
`runs.agent`. A generic stdin wrapper must read the prompt from stdin and
write its answer to stdout.

## DCE task workflow

The prompt asks the agent to discover and inspect the DCE commands, authenticate
to `DCE_HOST`, create the single Pod, query it, and print
`DCE_POD_CREATED_OK`. The verifier independently checks the marker and the DCE
API response. Cleanup deletes only `k8s-ai-bench-dce-pod`.

The Windows template is in
`bench\windows\task-template\dce-create-pod\`:

```text
prompt.template  task.yaml  verify.ps1  cleanup.ps1
```

### Pod diagnosis task

`pod-diagnosis` evaluates the `container-management-pod-diagnosis` skill. It is
a read-only diagnosis task, so it adds a `setup.ps1` lifecycle script:

```text
setup.ps1 creates a fixture Pod with a known root cause
  -> the agent diagnoses the Pod and prints POD_DIAGNOSIS_OK
  -> verify.ps1 checks the marker, the expected root cause in the agent answer,
     and that the fixture Pod is still untouched via the DCE API
  -> cleanup.ps1 deletes the fixture Pod
```

The fixture Pod is `k8s-ai-bench-diag-pod` in the `default` namespace of
`kpanda-global-cluster`. `setup.ps1` is idempotent: it removes a leftover
fixture before recreating it and waits until the expected failure state is
observable before the agent starts.

All templates are rendered by default, so running only this task is just a
matter of narrowing a matrix's `runs.taskPattern` to `pod-diagnosis` (or
rendering it alone with `.\bench\windows\render-task.ps1 pod-diagnosis`).
