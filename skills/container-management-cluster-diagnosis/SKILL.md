---
name: container-management:cluster-diagnosis
description: >
  Use when a user asks to inspect, health-check, patrol/巡检, diagnose, or
  troubleshoot a Kubernetes cluster managed by the DCE/kpanda module. Covers
  cluster health overview, node status, abnormal Pods, events, cluster
  unavailability, node NotReady, pending or failed Pods, and Chinese requests
  like 集群巡检、集群体检、检查集群健康状态、排查集群异常、查看集群状态.
---

# Kpanda Cluster Diagnosis

Diagnose cluster health through a standardized 4-step inspection workflow.

**REQUIRED SUB-SKILL:** Use `dce` for all command execution, auth checks, and catalog discovery.

## Workflow

### Step 1 — Cluster Overview
- `dce container-management cluster get-cluster --name <cluster> -o json`
- Verify cluster exists and status is Running. If not, report immediately.

### Step 2 — Node Health
- `dce container-management core list-nodes --cluster <cluster> -o json`
- Flag NotReady, Cordoned, or pressured nodes. Continue regardless.

### Step 3 — Abnormal Pod Discovery
- `dce container-management core list-pods --cluster <cluster> -o json`
- Find Pods not in Running/Succeeded. Collect by namespace. If none, skip Step 4.

### Step 4 — Deep Diagnosis
- `dce container-management core list-cluster-events --cluster <cluster> -o json`
- `dce container-management core get-pod --cluster <cluster> --namespace <ns> --name <pod> -o json`
- Correlate events with Pod states to infer root cause.

## User omitted cluster name
Run `dce container-management cluster list-clusters -o json`, present list, ask user to pick one.

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
fields when available: cluster status, node Ready ratio, NotReady/Cordoned node
count, abnormal Pod count, warning event count, and top affected namespace.

| Metric | Current Value | Status |
|--------|---------------|--------|
| Cluster status | `<value>` | `<normal/watch/risk/critical>` |

If the cluster has meaningful abnormalities, include supporting detail tables
under this section, such as:

- Node health: `Node | Ready | Schedulable | Pressure | Key condition`
- Pod anomalies: `Namespace | Phase/Reason | Count | Impact`
- Event highlights: `Type | Reason | Object | Last seen | Impact`

## Main Findings

Use a numbered list with 2-3 findings. Each finding must explain the impact.
Do not collapse multiple independent cluster risks into one generic finding; if
nodes, Pods, and events point to different risks, keep them distinct.

## Cause Analysis

Analyze 2-3 causes around the main findings. For each cause, include:

Cause N: `<cause>`

Evidence: `<specific event, node state, pod state, or metric>`.

Impact: `<user-visible or operational impact>`.

## Recommended Actions

Group concrete actions by:

### Immediate

### Monitor

### Optimize Later

## Follow-up Questions

Provide 2-3 copyable follow-up questions in the user's language. They should
guide the user toward deeper root-cause analysis, remediation planning, or an
exportable stakeholder report.

## Rules

- Prefer `-o json` for machine-readable output.
- Do not guess flags or body shape. Confirm with `dce commands show` before executing unfamiliar commands.
- Report empty API responses as "no resources found" rather than silently skipping.
- Do not perform remediation (restart, delete, scale). This skill is read-only.
- Put the conclusion first. Do not write the final answer as a troubleshooting
  transcript.
- Use tables for indicators whenever possible.
- Recommended actions must be specific and executable.
