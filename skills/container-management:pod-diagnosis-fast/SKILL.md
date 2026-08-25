---
name: container-management:pod-diagnosis-fast
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
If the user already named a pod, skip this step.

Never list a cluster's pods with `-o json`. That returns whole pod objects —
about 550 KB per 20-pod page — and clusters here hold hundreds to tens of
thousands of pods. Use `-o table`, which carries the same shortlist at roughly
100 bytes per pod.

**Sweep both filter dimensions. Neither one alone is enough.**

`--status` is the composite container state and is what finds crash loops.
`--phase` is the pod-level phase. They overlap far less than they appear to: a
pod in CrashLoopBackOff or ImagePullBackOff still reports phase `Running`, and a
`Failed` pod does *not* report status `ERROR`. On one real cluster
`--status ERROR` matched 1 pod while `--phase Failed` matched 12364.

```
--status FILTER_POD_STATUS_ERROR     container terminated abnormally
--status FILTER_POD_STATUS_WAITING   container cannot start: CrashLoopBackOff,
                                     ImagePullBackOff, OOMKilled restarts
--phase Pending                      unschedulable, or waiting on resources
--phase Failed                       terminated, including Evicted
--phase Unknown                      the control plane cannot reach the node
```

**First measure, then fetch.** Only `-o json` carries `pagination.total`, and one
JSON page costs about 8 KB even at `--page-size 1`. Pipe it through `jq` so the
count is all that comes back:

```
dce container-management core list-cluster-pods --cluster <cluster> \
  --status FILTER_POD_STATUS_WAITING --page-size 1 -o json | jq -r '.pagination.total'
```

Repeat for each of the five filters. Then fetch only what the totals justify:

- totals in the tens — fetch them all with `-o table`
- totals in the hundreds or more — the cluster has a systemic problem, not a
  pod-level one. Report the scale first, then sample the most recent ones with
  `--sort-by created_at --sort-dir desc --page-size 50 -o table` and say plainly
  that the sample is a sample.

`--sort-by` accepts only `field_name`, `state`, `workspace`, `cluster`,
`namespace`, and `created_at`. **There is no server-side sort by restart
count**, so ranking by restarts would mean pulling every pod — which defeats the
point. Rank by recency instead, and use restart counts only to compare the pods
already in hand.

`metadata.creationTimestamp` comes back as a Unix epoch integer, not an ISO
string; convert before reasoning about age.

Switch to `-o json` only for the specific pods you carry into Step 2.

### Step 2 — Collect the Pod's Situation
One command gathers the pod, its events, and every pod on its node:

- `dce pod-diagnose --cluster <cluster> --namespace <namespace> --pod <pod> -o json`

It resolves the node from the pod itself, so you do not spend a round trip
reading `spec.nodeName` and issuing a second command. The result is a **JSON
string**, not an object — parse it before reading fields:

```
dce pod-diagnose --cluster <c> --namespace <ns> --pod <pod> -o json | jq 'fromjson'
```

It carries three keys:

- `pod` — the full pod, including `spec.nodeName`, `spec.containers[]` and
  `metadata.ownerReferences[]` needed by Steps 3 and 4
- `events` — events naming this pod
- `neighbors` — every pod scheduled on the same node

Read container states, restart counts, exit codes and event reasons from here.
A node crowded with failing `neighbors` points at the node rather than at this
workload.

Additionally, fetch cluster-scoped events to catch scheduler and node-level
signals that namespace-scoped events miss:

- `dce container-management core list-cluster-events --cluster <cluster> --name <pod> -o json`

**Never pass `--kind` without `--kind-name`** — the server answers 500.

### Step 3 — Retrieve Container Logs
Container names come from `pod.spec.containers[]` in Step 2. One command per
container:

- `dce container-management insight get-pod-container-log --cluster <cluster> --namespace <namespace> --name <pod> --container <container> -o json`

### Step 4 — Inspect Related Workloads
Take `pod.metadata.ownerReferences[0]` from Step 2. If it is absent the pod is
standalone and this step does not apply.

- `dce container-management core list-pods --cluster <cluster> --namespace <namespace> --kind <owner-kind> --kind-name <owner-name> -o table`

`--kind` accepts `Deployment`, `StatefulSet`, `DaemonSet`, `Service`, `Job`,
`CronJob`, `ReplicaSet`, or `NetworkPolicy`, matching the `kind` in
`ownerReferences`. Compare replica counts, restart counts, and whether siblings
share the failure.

Steps 3 and 4 both read from Step 2 and do not depend on each other — issue them
together.

## User omitted cluster name
Run `dce container-management cluster list-clusters -o json`, present list, ask user to pick one.

## User omitted pod name
Run the Step 1 filters, present the shortlist, ask the user to pick one. Do not
dump the cluster's pods to make the user choose.

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

- Prefer `-o json` for machine-readable output, except when listing a cluster's
  pods: use `-o table` there and take `-o json` only for the pods you diagnose.
- Do not guess flags or body shape. Confirm with `dce commands show` before executing unfamiliar commands.
- Report empty API responses as "no resources found" rather than silently skipping.
- Do not perform remediation (restart, delete, scale). This skill is read-only.
- If multiple pods are affected, shortlist by recency server-side, then rank the
  shortlist by restart count. Restart count cannot be sorted server-side, so
  never pull the whole pod list in order to rank it.
- Put the conclusion first. Do not write the final answer as a troubleshooting
  transcript.
- Use tables for indicators whenever possible.
- Recommended actions must be specific and executable.
