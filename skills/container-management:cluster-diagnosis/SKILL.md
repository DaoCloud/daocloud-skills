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

Present a concise report in this order:

1. **Cluster State** — name, status, version, provider
2. **Node Summary** — total, Ready count, anomalies
3. **Pod Anomalies** — count by non-Running phase, top affected namespaces
4. **Root-Cause Hypothesis** — inferred from events + Pod states
5. **Recommended Action** — one or two concrete next steps

## Rules

- Prefer `-o json` for machine-readable output.
- Do not guess flags or body shape. Confirm with `dce commands show` before executing unfamiliar commands.
- Report empty API responses as "no resources found" rather than silently skipping.
- Do not perform remediation (restart, delete, scale). This skill is read-only.
