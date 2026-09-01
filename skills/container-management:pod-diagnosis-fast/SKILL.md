---
name: container-management:pod-diagnosis-fast
description: >
  Use when a user wants a specific Pod diagnosed AND explicitly asks for the
  workflow or the fast path: 用 workflow 排查 pod、走 pod-diagnose 工作流、
  快速诊断 pod、一次调用查 pod、fast pod diagnosis. It collects the pod, its
  events and its node neighbours through a single `dce pod-diagnose` call
  instead of one command per resource. For a plain pod-troubleshooting request
  that does not name a workflow or ask for speed — 排查 Pod 故障原因、pod 一直
  重启、CrashLoopBackOff、ImagePullBackOff、Pending — use
  container-management:pod-diagnosis instead.
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
`--phase` is the pod-level phase. How far the two overlap **varies by cluster**,
so neither substitutes for the other:

- A pod in CrashLoopBackOff or ImagePullBackOff still reports phase `Running`.
  Filtering on phase alone misses it — observed: a `github-runner` pod at `0/1`
  ready that only `--status WAITING` returned. This direction holds everywhere.
- `--status ERROR` against `--phase Failed` is the unpredictable pair. Observed
  on one cluster: `ERROR` 1, `Failed` 12364. Observed on another: `ERROR` 3,
  `Failed` 3, naming the same three pods. Do not assume either result.

Run every filter and take the union.

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

Skip this step only when the container has genuinely never run: `restartCount`
is 0 **and** `lastState` is empty, or `pod.status.containerStatuses` is an empty
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
dead call burns 7-23 seconds and returns nothing — on a two-container pod that
is most of the turn spent waiting for the same failure twice. Record it once,
say in the report that logs were unavailable, and finish from `events` and
`pod`. A missing log section never justifies withholding the diagnosis.

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

### Step 5 — Scheduling Constraints and Node Fit
**Issue no new commands here.** `neighbors` from Step 2 already holds every pod
on the node, and the rest comes from `pod.spec` — calling `list-pods-by-node`
would spend the round trip Step 2 exists to save.

Read from `neighbors`: how many pods on this node are unready, and are they
failing the same way? One sick pod among healthy neighbours points at the
workload; a node full of them points at the node.

Then check the pod's own placement and sizing in `pod.spec`:

- `nodeSelector`, `affinity`, `tolerations` — does the pod's placement itself
  explain where it landed?
- `affinity.podAntiAffinity` — **verify its `labelSelector` actually matches
  `pod.metadata.labels`.** A selector naming a label the pod does not carry is
  silently inert: the rule never fires, replicas can pile onto one node, and
  nothing anywhere reports an error. Chart-provided rules and chart-provided
  labels drift apart across upgrades, so compare the two literally rather than
  assuming a rule that exists is a rule that applies.
- `containers[].resources` — a container with no memory limit is unbounded; one
  whose requests exceed every node's allocatable never schedules.
- `status.cpuUsage` / `status.memoryUsage` against `memoryLimit` — zero usage on
  a pod reporting phase `Running` means the process is not actually up, and
  rules out OOM as the cause.

When Step 4 found a healthy sibling, compare against it: identical image and
template on two nodes with opposite outcomes localises the fault to the node
rather than the workload.

## User omitted cluster name
Run `dce container-management cluster list-clusters -o json`, present list, ask user to pick one.

## User omitted pod name
Run the Step 1 filters, present the shortlist, ask the user to pick one. Do not
dump the cluster's pods to make the user choose.

## Auth not established

**HTTP 401 from any step means the token expired.** It is not a permission
problem — that would be 403 — and it says nothing about the pod being
diagnosed. Stop there instead of working through the remaining steps; every
later call fails identically and only adds latency.

`pod-diagnose` surfaces it wrapped, as
`workflow step "pod" failed: GET request failed with HTTP 401`. Read the status
code out of that message; it is an expired token, not a defect in the workflow.

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
