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

Present the final answer as structured Markdown. Do not include a step-by-step
tool execution log, skill loading details, API retry details, JSON parsing
details, or other internal process unless the user explicitly asks for them.
If data is incomplete, explicitly say that the judgment is based on currently
available data in the conclusion.

Use these top-level sections in this order. Treat the template as the report
spine, not as a limit on evidence: preserve domain-specific tables and details
inside the matching sections when they are needed to support the conclusion.

# Conclusion

Use 1-2 sentences to state the current judgment, risk level
(`normal` / `watch` / `risk` / `critical`), and the most important issue.
For user-facing answers, localize the section title and risk labels to the
user's language.

## Key Metrics

Start with a Markdown summary table with 3-6 key indicators. Prefer these
fields when available: Pod phase, restart count, node, container state, last
exit code, warning event count, and latest error reason.

| Metric | Current Value | Status |
|--------|---------------|--------|
| Pod phase | `<value>` | `<normal/watch/risk/critical>` |

If the Pod has meaningful container, event, or log evidence, include supporting
detail tables under this section, such as:

- Pod overview: `Namespace | Pod | Phase | Node | Restarts | Age`
- Container states: `Container | Ready | Restart Count | State | Last State | Exit Code`
- Events: `Type | Reason | Message | Last Seen`
- Log evidence: short excerpts only, grouped by container, without dumping full logs

## Main Findings

Use a numbered list with 2-3 findings. Each finding must explain the impact.
Do not omit the decisive evidence: include the event reason, container state,
exit code, or log signal that supports each finding.

## Cause Analysis

Analyze 2-3 causes around the main findings. For each cause, include:

Cause N: `<cause>`

Evidence: `<specific event, container state, exit code, or log excerpt>`.

Impact: `<user-visible or operational impact>`.

## Recommended Actions

Group concrete actions by:

### Immediate

### Monitor

### Optimize Later

## Follow-up Questions

Provide 2-3 copyable follow-up questions in the user's language. They should
guide the user toward detailed events/logs, remediation planning, or an
exportable stakeholder report.

## Rules

- Prefer `-o json` for machine-readable output.
- Do not guess flags or body shape. Confirm with `dce commands show` before executing unfamiliar commands.
- Report empty API responses as "no resources found" rather than silently skipping.
- Do not perform remediation (restart, delete, scale). This skill is read-only.
- If multiple pods are affected, prioritize by restart count and age — most started/recent failures first.
- Put the conclusion first. Do not write the final answer as a troubleshooting
  transcript.
- Use tables for indicators whenever possible.
- Recommended actions must be specific and executable.
