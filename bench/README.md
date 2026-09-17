# DCE skill benchmark

This directory contains a complete end-to-end benchmark for testing an agent
with the `dce` skill. The task creates one Pod through the DCE CLI, queries it,
verifies the result independently, and removes it during cleanup.

Choose the directory for the operating system where the benchmark is running:

- [Unix guide](unix/README.md) — macOS and Linux, using Bash
- [Windows guide](windows/README.md) — Windows PowerShell, using `.ps1` scripts

The two directories are self-contained. Each has its own setup script, task
renderer, matrix file, task template, verifier, and cleanup script. The only
shared input is the repository's `skills/` directory, referenced by
`skillsDir: ./skills` in each matrix.

## Task flow

```text
setup -> render task -> agent receives prompt -> DCE Pod is created and queried
     -> verifier checks the DCE API -> cleanup deletes the Pod
```

The sample task is deliberately narrow. It permits only the following Pod:

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

The rendered prompt receives `DCE_HOST` and `DCE_TOKEN` from the environment;
credentials are not stored in the template. Use a current `k8s-ai-bench`
release such as `v0.1.1-rc.1` or later for PowerShell task-script support.

## Agent configuration

Each matrix selects exactly one agent with `runs.agent`. The agent may be a
local CLI or a gateway bridge. For Codex, the platform-specific matrix uses
the unified `k8s-ai-agent-bridge` and starts the CLI in non-interactive mode.
Set `CODEX_BIN` when `codex` is not already on `PATH`.

The `models` section is benchmark metadata. It does not install or select the
agent's underlying model; the configured bridge and its environment determine
how the agent is started.
