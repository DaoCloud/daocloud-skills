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
- `dce container-management core list-events --cluster <cluster> --namespace <namespace> --kind Pod --kind-name <pod> -o json`
- `dce container-management core list-cluster-events --cluster <cluster> --kind Pod --name <pod> -o json`
- `dce container-management core get-pod --cluster <cluster> --namespace <namespace> --name <pod> -o json`

The two event commands name the pod through different flags, and the difference
is not cosmetic:

- `list-events` — `--kind-name` is the involvedObject. Its `--name` is a fuzzy
  match on the event's own name, so passing the pod there silently filters for
  the wrong thing. **`--kind` without `--kind-name` answers HTTP 500.**
- `list-cluster-events` — `--name` is the involvedObject, and there is no
  `--kind-name` flag.

### Step 3 — Retrieve Container Logs
- `dce container-management insight get-pod-container-log --cluster <cluster> --namespace <namespace> --name <pod> --container <container> -o json`
- Check for stack traces, OOM signals, exit codes, or missing dependencies.

Skip this step only when the container has genuinely never run: `restartCount`
is 0 **and** `lastState` is empty, or `status.containerStatuses` is an empty
array. Nothing else qualifies.

**`waiting` is not a reason to skip.** A CrashLoopBackOff container reports
state `waiting` between restarts, but it has started and died once per restart
and its logs are intact. Those logs are usually the only evidence that names the
failure; everything else the API returns is the symptom. Skipping them here
leaves you inferring a cause from the pod spec, which is how a diagnosis ends up
confidently wrong.

Treat an empty-looking `env` value the same way — this API flattens
`valueFrom` to null and renders the value as `""`, so a variable injected from a
Secret or the downward API is indistinguishable from one that was never set.
Never conclude "the credential is missing" from that field alone; confirm
against the logs or the referenced Secret.

If the endpoint answers 5xx, the cluster's log pipeline is down, not this pod.
**Stop after the first failure; do not repeat the call for the remaining
containers.** The client retries 5xx three times with 1s/2s/4s backoff, so every
dead call burns 7-23 seconds and returns nothing. Record the failure once, say
in the report that logs were unavailable, and finish from events and pod spec.
A missing log section never justifies withholding the diagnosis.

### Step 4 — Inspect Related Workloads
If the pod is owned by a controller:
- `dce container-management core list-pods --cluster <cluster> --namespace <namespace> --kind <owner-kind> --kind-name <owner-name> -o json`
- Check replica counts, restart counts, and selector mismatches.

`list-pods` follows the same rule as `list-events` in Step 2: `--kind-name` is
the owner, `--name` is a fuzzy match on the pod's own name, and `--kind` without
`--kind-name` answers **HTTP 500**. `<owner-kind>` must match the `kind` in
`metadata.ownerReferences[0]` — one of `Deployment`, `StatefulSet`, `DaemonSet`,
`Service`, `Job`, `CronJob`, `ReplicaSet`, `NetworkPolicy`.

### Step 5 — Node Affinity and Resource Analysis
- `dce container-management core list-pods-by-node --cluster <cluster> --node <node> -o json`
- `dce container-management core get-pod --cluster <cluster> --namespace <namespace> --name <pod> -o json`
- Check tolerations, node selectors, affinity rules, and resource limits.

## User omitted cluster name
Run `dce container-management cluster list-clusters -o json`, present list, ask user to pick one.

## User omitted pod name
Run `dce container-management core list-cluster-pods --cluster <cluster> -o json`, present list filtered by non-Running phases, ask user to pick one.

## Auth not established

**HTTP 401 from any step means the token expired.** It is not a permission
problem — that would be 403 — and it says nothing about the pod being
diagnosed. Stop there instead of working through the remaining steps; every
later call fails identically and only adds latency.

Report it and have the user run the login themselves, naming the host actually
in use:

```bash
dce auth login --hostname <host>
```

Never supply credentials on the user's behalf.

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
