---
name: container-management:pod-diagnosis-batch
description: >
  Use when a user asks for a cluster-wide Pod anomaly scan, batch Pod
  diagnosis, abnormal Pod inventory, or a Pod health patrol in a Kubernetes
  cluster managed by the DCE/kpanda module. Also use for Chinese requests like
  全量排查 Pod、批量诊断 Pod、Pod 巡检、查看全局异常 Pod、统计 Pending 或
  Failed Pod、集群里哪些 Pod 有异常. When the user explicitly asks to deep
  diagnose one candidate found by this scan, delegate that one Pod to
  container-management:pod-diagnosis-fast.
---

# Kpanda Pod Batch Diagnosis

Perform a read-only, cluster-wide triage of abnormal Pods. This skill finds the
scope and distribution of problems; it does **not** automatically run a
full root-cause diagnosis for every matching Pod.

**REQUIRED SUB-SKILL:** Use `dce` for all command execution, auth checks, and
catalog discovery.

## Scope and Boundaries

- Default scope is every namespace in the specified cluster. If the user gives
  a namespace, add `--namespace <namespace>` to every Pod query and state the
  narrower scope in the report.
- A named Pod is out of scope. Route that request to
  `container-management:pod-diagnosis-fast`.
- This skill establishes complete counts for each anomaly category, then takes
  bounded, recent samples. It is not a bulk per-Pod root-cause loop.
- A candidate is identified by the complete tuple
  `<cluster>/<namespace>/<pod>`. Deduplicate candidates by that tuple before
  presenting or selecting them: one Pod can match several categories.
- Default deep-diagnosis limit is zero. Only an explicit request to diagnose a
  named candidate or to "deep diagnose the most severe one" can raise it, and
  then diagnose exactly one Pod through `container-management:pod-diagnosis-fast`.
- The five category counts are **not** a distinct abnormal-Pod total: a Pod may
  appear in both a container-status category and a phase category. Never add
  them together unless identities have been explicitly deduplicated.
- Do not restart, delete, scale, or otherwise modify resources.

## Workflow

### Step 1 — Identify the Cluster

If the user omitted the cluster name, run:

```bash
dce container-management cluster list-clusters -o json
```

Present the available clusters and ask the user to choose one. Do not begin the
scan until the cluster is known.

### Step 2 — Measure Every Anomaly Category

Never request the unfiltered cluster Pod list with `-o json`: it returns full
Pod objects and is too large for a cluster-wide scan. A one-item JSON request is
allowed only to read `pagination.total`.

**Preserve command failures.** In shells that support it, enable `pipefail`
before every count pipeline; otherwise, run `dce` first and parse its output
only after it succeeds. Do not use `// 0`: a missing total is a failed
measurement, not an empty category.

Run the following query once for each filter. Add `--namespace <namespace>` when
the user limited the scope.

```bash
set -o pipefail
dce container-management core list-cluster-pods --cluster <cluster> \
  <filter> --page-size 1 -o json | jq -er '.pagination.total'
```

Use these five filters:

| Category | Filter | What it finds |
|---|---|---|
| Container error | `--status FILTER_POD_STATUS_ERROR` | Containers that terminated abnormally |
| Container waiting | `--status FILTER_POD_STATUS_WAITING` | Startup failures such as CrashLoopBackOff or ImagePullBackOff |
| Pending | `--phase Pending` | Unscheduled Pods or Pods waiting for resources or volumes |
| Failed | `--phase Failed` | Terminated Pods, including evictions |
| Unknown | `--phase Unknown` | Pods whose node or control-plane state cannot be determined |

Record each returned total and its collection time separately. A failed query is
unknown, not zero; say which category could not be measured and continue with
the remaining ones.

### Step 3 — Fetch a Bounded, Recent Sample

For every nonzero category, fetch only the evidence needed for triage:

- When the total is 50 or fewer, fetch that category with `--page-size 50 -o table`.
- When the total exceeds 50, fetch the 50 most recently created Pods using
  `--sort-by created_at --sort-dir desc --page-size 50 -o table`. Label it as a
  sample in the report.

Example:

```bash
dce container-management core list-cluster-pods --cluster <cluster> \
  --status FILTER_POD_STATUS_WAITING \
  --sort-by created_at --sort-dir desc --page-size 50 -o table
```

`created_at` is the only supported recency sort for this command. Do not pull
every Pod to rank by restart count or a field that the server cannot sort.

For a category measured at 50 or fewer, reconcile the count and the returned
table rows before calling it fully listed:

1. Count the returned data rows, excluding the table header.
2. If the row count equals the measured total, mark it `reconciled at <time>`.
3. If it differs, immediately repeat only that category's one-item count with
   the error-safe command from Step 2.
4. If the repeat count equals the returned rows, mark it `state changed between
   observations`; otherwise mark it `partial or inconsistent`. Do not call
   either result a complete inventory.

For a category above 50, mark the rows as a recent sample and do not try to
reconcile the sample size with the total.

### Step 4 — Optional Complete Inventory

Only when the user explicitly asks for every matching Pod or an export, retrieve
the selected category page by page with `-o table`, using `--page <n>` and
`--page-size 50` until the measured total is covered. Keep category labels on
the rows and do not claim rows are unique across categories. Recount once after
the final page: if the total changed, report an inventory window rather than a
point-in-time complete inventory. If a page fails, stop that category and report
the completed pages and the missing remainder.

Do not use complete-inventory mode merely because a category has a large total,
and do not turn it into a per-Pod diagnosis loop.

### Step 5 — Optional Single-Pod Deep Diagnosis

Keep the batch result as the primary output. Invoke
`container-management:pod-diagnosis-fast` only in either of these cases:

- The user names one candidate by `<namespace>/<pod>` or selects one candidate
  table row.
- The user explicitly asks to "deep diagnose the most severe one". Select one
  deduplicated candidate from successfully measured categories using this
  triage order: `Unknown`, `ERROR`, `WAITING`, `Pending`, `Failed`; within the
  same category use the most recently created Pod already present in the
  sample. State that this is a triage choice, not proof of severity.

Pass the selected tuple to fast:

```text
cluster: <cluster>
namespace: <namespace>
pod: <pod>
```

Fast skips its own target-discovery step when it has this tuple, then performs
its standard pod, events, logs, and related-workload inspection. Do not repeat
the five batch filters, and do not invoke fast for every sample. If fast fails
or returns incomplete evidence, preserve the batch result and report the deep
diagnosis as partial.

If the user says only "deep diagnose one" and more than one candidate exists,
present the deduplicated candidate table and ask the user to choose; do not
guess. Do not automatically select a candidate from a category marked `partial
or inconsistent`.

### Step 6 — Escalate Deliberately

Treat widespread counts, a shared namespace, or a repeated failure pattern in
the samples as a potential systemic issue, not as proof of a single root cause.
State the pattern and its scope, then offer one of these next actions:

1. Select one representative Pod for `container-management:pod-diagnosis-fast`.
2. Narrow this batch scan to an affected namespace.
3. Produce the complete category inventory when the user needs an export.

Do not automatically invoke `pod-diagnosis` or `pod-diagnosis-fast` for every
sampled Pod. The user must choose the representative Pod or explicitly request
the one-Pod triage mode from Step 5.

## Auth Not Established

Stop and instruct the user to run:

```bash
dce auth login --hostname <host>
```

## Output Format

Present the final answer as structured Markdown. Do not include a command
transcript, raw JSON, or a large unfiltered Pod list unless the user explicitly
requested an inventory export.

# Conclusion

State the scan scope, overall risk (`normal` / `watch` / `risk` / `critical`),
and whether the evidence suggests isolated or potentially systemic problems.
Localize labels to the user's language.

## Scan Results

Use this table and preserve unavailable values as `not measured`:

| Category | Filter | Count at | Sample / inventory status | Interpretation |
|---|---|---:|---|---|
| Container error | `ERROR` | `<count or not measured>` | `<reconciled / sample / changed / partial>` | `<interpretation>` |
| Container waiting | `WAITING` | `<count or not measured>` | `<reconciled / sample / changed / partial>` | `<interpretation>` |
| Pending | `Pending` | `<count or not measured>` | `<reconciled / sample / changed / partial>` | `<interpretation>` |
| Failed | `Failed` | `<count or not measured>` | `<reconciled / sample / changed / partial>` | `<interpretation>` |
| Unknown | `Unknown` | `<count or not measured>` | `<reconciled / sample / changed / partial>` | `<interpretation>` |

Add this note directly below the table: category counts can overlap and do not
form a unique abnormal-Pod total.

## Sample Evidence

Show at most 3 representative rows per nonzero category in the final answer.
For each row include `Namespace | Pod | Phase | Age | Matching Categories`.
Deduplicate rows by `<cluster>/<namespace>/<pod>` and state whether the category
was reconciled, sampled, changed during collection, or partial. Do not present
samples as a complete inventory.

## Optional Representative Pod Diagnosis

Include this section only if Step 5 invoked fast. Show the chosen tuple, why it
was selected, and a concise fast result. Keep the cluster-level conclusion and
the selected Pod's root-cause conclusion separate; evidence from one Pod cannot
establish the cause for every matching Pod.

## Findings

Give 2-3 evidence-backed findings about scale, affected namespaces, and shared
patterns. Keep confirmed facts separate from hypotheses; counts alone do not
prove a root cause.

## Recommended Next Actions

Group concrete, read-only next actions under:

### Investigate Now

### Monitor

### Export or Scope Further

End with 2-3 copyable follow-up questions in the user's language, including a
question that selects a representative Pod for detailed diagnosis.

## Rules

- Confirm unfamiliar commands and flags with `dce commands show` before use.
- Report an empty successful response as "no resources found".
- State partial results and failed categories explicitly; never silently omit them.
- Preserve the upstream `dce` exit status when parsing JSON. A connection or
  auth error is not an empty result.
- Never label a small category "fully listed" until its table rows reconcile
  with a count collected in the same observation window.
- Put the conclusion first and use tables for counts and samples.
