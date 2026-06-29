---
name: container-management:pod-diagnosis
description: >
  Use when a user asks to diagnose, inspect, troubleshoot, or find the root
  cause of a specific Pod failure, non-running Pod, or pod-level issue in a
  Kubernetes cluster managed by the DCE/kpanda module. Also use for Chinese
  requests like 排查 Pod 故障原因、某个 pod 异常、pod 启动失败、pod 无法运行、
  pod 一直重启、CrashLoopBackOff、OOMKilled、ImagePullBackOff、Pending、Evicted、
  or Terminating.
---

# Kpanda Pod Diagnosis

Diagnose unhealthy or failing pods through a standardized inspection workflow.

**REQUIRED SUB-SKILL:** Use `dce` for all command execution, auth checks, and catalog discovery.

## Workflow

### Step 1 — Identify Target Pods
Run `dce container-management core list-cluster-pods --cluster <cluster> -o json` to list all pods.
Filter for non-Running/Completed phases:
- `Pending` — scheduling or resource issues
- `Failed` — terminal crash
- `Unknown` — control plane communication failure
- `Evicted` — preemption or node pressure
- CrashLoopBackOff / OOMKilled — visible in container states

### Step 2 — Collect Pod Events
For each problematic pod:
- `dce container-management core list-events --cluster <cluster> --namespace <namespace> --kind Pod --name <pod> -o json`
- `dce container-management core list-cluster-events --cluster <cluster> --kind Pod --name <pod> -o json`
- `dce container-management core get-pod --cluster <cluster> --namespace <namespace> --name <pod> -o json`

### Step 3 — Retrieve Container Logs
- `dce container-management insight get-pod-container-log --cluster <cluster> --namespace <namespace> --name <pod> --container <container> -o json`
- Check for stack traces, OOM signals, exit codes, or missing dependencies.

### Step 4 — Inspect Related Workloads
If the pod is owned by a controller:
- `dce container-management core list-pods --cluster <cluster> --namespace <namespace> --kind <owner-kind> --name <owner-name> -o json`
- Check replica counts, restart counts, and selector mismatches.

### Step 5 — Node Affinity and Resource Analysis
- `dce container-management core list-pods-by-node --cluster <cluster> --node <node> -o json`
- `dce container-management core get-pod --cluster <cluster> --namespace <namespace> --name <pod> -o json`
- Check tolerations, node selectors, affinity rules, and resource limits.

## User omitted cluster name
Run `dce container-management cluster list-clusters -o json`, present list, ask user to pick one.

## User omitted pod name
Run `dce container-management core list-cluster-pods --cluster <cluster> -o json`, present list filtered by non-Running phases, ask user to pick one.

## Auth not established
Stop and instruct user to run `dce auth login --hostname <host>`.

## Output Format

Present a concise report in this order:

1. **Pod Overview** — name, namespace, phase, node, restarts, age
2. **Container States** — exit codes, OOM, CrashLoopBackOff indicators
3. **Events** — warning events, scheduling failures, image pull errors
4. **Logs** — last termination log or error excerpt
5. **Root-Cause Hypothesis** — inferred from events + container state
6. **Recommended Action** — one or two concrete next steps

## Rules

- Prefer `-o json` for machine-readable output.
- Do not guess flags or body shape. Confirm with `dce commands show` before executing unfamiliar commands.
- Report empty API responses as "no resources found" rather than silently skipping.
- Do not perform remediation (restart, delete, scale). This skill is read-only.
- If multiple pods are affected, prioritize by restart count and age — most started/recent failures first.
