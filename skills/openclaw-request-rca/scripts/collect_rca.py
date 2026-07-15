#!/usr/bin/env python3
"""Collect a compact OpenClaw RCA data set using only Python's standard library."""

import json
import os
import shutil
import subprocess
import sys
import time
from collections import Counter, defaultdict
from concurrent.futures import ThreadPoolExecutor, as_completed
from datetime import datetime, timezone
from typing import Any, Dict, Iterable, List, Optional, Sequence, Tuple


Json = Dict[str, Any]
Result = Tuple[int, Optional[Json], str]
Pair = Tuple[str, str]
DEADLINE: Optional[float] = None


def emit(value: Json) -> None:
    print(json.dumps(value, ensure_ascii=False, separators=(",", ":")))


def run(command: Sequence[str], payload: Optional[Json] = None) -> Result:
    remaining = DEADLINE - time.monotonic() if DEADLINE is not None else None
    if remaining is not None and remaining <= 0:
        return 124, None, "collection time budget exhausted"
    timeout = float(os.environ.get("OPENCLAW_RCA_DCE_TIMEOUT", "5"))
    if remaining is not None:
        timeout = min(timeout, max(0.1, remaining))
    try:
        completed = subprocess.run(
            list(command),
            input=json.dumps(payload, separators=(",", ":")) if payload is not None else None,
            text=True,
            capture_output=True,
            check=False,
            timeout=timeout,
        )
    except subprocess.TimeoutExpired as error:
        return 124, None, str(error)
    if completed.returncode != 0:
        return completed.returncode, None, completed.stderr + completed.stdout
    try:
        return 0, json.loads(completed.stdout), completed.stderr
    except json.JSONDecodeError:
        return 1, None, completed.stderr + completed.stdout


def data(result: Result) -> Json:
    return result[1] or {}


def items(value: Json) -> List[Json]:
    rows = value.get("items", [])
    return rows if isinstance(rows, list) else []


def total(value: Json) -> int:
    pagination = value.get("pagination") or {}
    raw = pagination.get("total")
    if raw is None:
        return len(items(value))
    try:
        return int(raw)
    except (TypeError, ValueError):
        return len(items(value))


def number(value: Any) -> float:
    try:
        return float(value)
    except (TypeError, ValueError):
        return 0.0


def tidy(value: float) -> Any:
    return int(value) if value.is_integer() else value


def counts(rows: Iterable[Json], field: str, output_field: str) -> List[Json]:
    values = Counter(row.get(field) for row in rows)
    return [
        {output_field: key, "count": count}
        for key, count in sorted(values.items(), key=lambda pair: str(pair[0]))
    ]


def span_payload(cluster: str, namespace: str, start: str, end: str, page_size: int, **extra: Any) -> Json:
    payload: Json = {
        "clusterName": cluster,
        "namespace": namespace,
        "start": start,
        "end": end,
        "sort": "duration,desc",
        "page": 1,
        "pageSize": page_size,
        "tags": [
            {
                "key": "otel.scope.name",
                "operation": "EQUAL",
                "value": "openclaw-otel-plugin",
            }
        ],
    }
    payload.update(extra)
    return payload


def query_spans(payload: Json) -> Result:
    return run(
        ["dce", "insight", "tracing", "query-spans", "--file", "-", "-o", "json"],
        payload,
    )


def source_error(source: str, cluster: str, result: Result, namespace: Optional[str] = None) -> Json:
    record: Json = {
        "source": source,
        "cluster": cluster,
        "exitStatus": result[0],
    }
    if namespace:
        record["namespace"] = namespace
    return record


def not_ready_pods(pods: List[Json]) -> List[Json]:
    output = []
    for pod in pods:
        phase = pod.get("phase")
        ready = pod.get("containerNumSummary") or {}
        unhealthy_phase = phase in ("POD_PHASE_PENDING", "POD_PHASE_UNKNOWN", "POD_PHASE_FAILED")
        incomplete = phase == "POD_PHASE_RUNNING" and ready.get("readyNum") != ready.get("totalNum")
        if unhealthy_phase or incomplete:
            output.append(
                {
                    "namespace": pod.get("namespace"),
                    "name": pod.get("name"),
                    "phase": phase,
                    "ready": ready,
                    "restarts": pod.get("restartCount"),
                }
            )
    return output[:20]


def alert_summary(alerts: List[Json]) -> Json:
    grouped: Dict[Tuple[Any, ...], List[Json]] = defaultdict(list)
    for alert in alerts:
        key = tuple(alert.get(field) for field in ("ruleName", "severity", "namespace", "status"))
        grouped[key].append(alert)
    rules = []
    for key in sorted(grouped, key=lambda value: tuple(str(item) for item in value)):
        rows = grouped[key]
        starts = [number(row.get("startAt")) for row in rows if row.get("startAt") is not None]
        descriptions = sorted(
            {row.get("description") for row in rows if row.get("description")}
        )
        rules.append(
            {
                "ruleName": key[0],
                "severity": key[1],
                "namespace": key[2],
                "status": key[3],
                "count": len(rows),
                "latestStartAt": str(tidy(max(starts))) if starts else None,
                "descriptions": descriptions[:1],
            }
        )
    return {
        "total": len(alerts),
        "bySeverity": counts(alerts, "severity", "severity"),
        "byRule": rules,
    }


def compact_span(row: Json) -> Json:
    return {
        field: row.get(field)
        for field in (
            "traceId",
            "spanId",
            "serviceName",
            "operationName",
            "duration",
            "startTime",
            "status",
            "method",
            "protocol",
        )
    }


def compact_trace(detail: Json) -> List[Json]:
    allowed_tags = {
        "agent_runtime",
        "agent_version",
        "k8s.namespace.name",
        "service.namespace",
        "process.runtime.version",
        "runtime_environment",
    }
    output = []
    for trace in detail.get("traces", []) or []:
        processes = []
        process_map = trace.get("processMap") or {}
        for process_entry in process_map.values():
            process = (process_entry or {}).get("process") or {}
            tags = []
            for tag in process.get("tags", []) or []:
                if tag.get("key") in allowed_tags:
                    value = next(
                        (tag.get(field) for field in ("vStr", "vInt64", "vFloat64", "vBool") if tag.get(field) is not None),
                        None,
                    )
                    tags.append({"key": tag.get("key"), "value": value})
            processes.append({"serviceName": process.get("serviceName"), "tags": tags})
        output.append(
            {
                field: trace.get(field)
                for field in (
                    "traceId",
                    "operationName",
                    "duration",
                    "startTime",
                    "status",
                    "statusCode",
                    "spanCount",
                    "warnings",
                )
            }
        )
        output[-1]["processes"] = processes
    return output


def main() -> int:
    global DEADLINE
    detail = os.environ.get("OPENCLAW_RCA_DETAIL", "").lower() in ("1", "true", "yes")
    default_budget = "15" if detail else "8"
    DEADLINE = time.monotonic() + float(os.environ.get("OPENCLAW_RCA_BUDGET", default_budget))
    if not shutil.which("dce"):
        print("dce is required", file=sys.stderr)
        return 127
    try:
        hours = int(sys.argv[1]) if len(sys.argv) > 1 else 24
        if hours <= 0:
            raise ValueError
    except ValueError:
        print("lookback hours must be a positive integer", file=sys.stderr)
        return 2
    slow_threshold = sys.argv[2] if len(sys.argv) > 2 else "1s"
    cluster_filter = sys.argv[3] if len(sys.argv) > 3 else ""
    parallelism = int(os.environ.get("OPENCLAW_RCA_PARALLELISM", "12"))
    page_size = int(os.environ.get("OPENCLAW_RCA_SPAN_PAGE_SIZE", "50"))
    max_namespaces = int(os.environ.get("OPENCLAW_RCA_MAX_NAMESPACES", "12"))
    end_epoch = int(time.time())
    start_epoch = end_epoch - hours * 3600
    start_rfc3339 = datetime.fromtimestamp(start_epoch, timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
    end_rfc3339 = datetime.fromtimestamp(end_epoch, timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
    end_millis = end_epoch * 1000
    lookback_millis = hours * 3_600_000

    if cluster_filter:
        clusters = [cluster_filter]
    else:
        cluster_result = run(["dce", "container-management", "cluster", "list-clusters", "--page-size", "100", "-o", "json"])
        clusters = [row.get("metadata", {}).get("name") for row in items(data(cluster_result))]
        clusters = [cluster for cluster in clusters if cluster]
    if not clusters:
        emit({"type": "error", "error": "No matching DCE cluster", "cluster": cluster_filter})
        return 2

    inventory_commands: Dict[Tuple[str, str], List[str]] = {}
    for cluster in clusters:
        inventory_commands[(cluster, "services")] = ["dce", "insight", "tracing", "get-services", "--cluster-name", cluster, "--lookback", str(lookback_millis), "--end-time", str(end_millis), "--sort", "reqRate,desc", "--page", "1", "--page-size", "500", "-o", "json"]
        inventory_commands[(cluster, "pods")] = ["dce", "insight", "resource", "list-pods", "--cluster", cluster, "--page-size", "500", "-o", "json"]
        inventory_commands[(cluster, "alerts")] = ["dce", "insight", "alert", "list-alerts", "--cluster-name", cluster, "--page-size", "100", "--sorts", "startsAt,desc", "-o", "json"]
        query = f"sum(increase(openclaw_requests_total[{hours}h])) by (openclaw_outcome,openclaw_final_state,channel,job)"
        inventory_commands[(cluster, "metrics")] = ["dce", "insight", "metric", "query-metric", "--cluster-name", cluster, "--time", str(end_epoch), "--query", query, "-o", "json"]
    with ThreadPoolExecutor(max_workers=min(parallelism, len(inventory_commands))) as executor:
        futures = {key: executor.submit(run, command) for key, command in inventory_commands.items()}
        inventory = {key: future.result() for key, future in futures.items()}

    pairs: List[Pair] = []
    for cluster in clusters:
        seen = set()
        for service in items(data(inventory[(cluster, "services")])):
            namespace = service.get("namespace")
            if namespace and namespace not in seen:
                seen.add(namespace)
                pairs.append((cluster, namespace))
                if len(seen) >= max_namespaces:
                    break

    spans: Dict[Pair, Result] = {}
    errors: Dict[Pair, Result] = {}
    slow: Dict[Pair, Result] = {}
    with ThreadPoolExecutor(max_workers=parallelism) as executor:
        future_map = {}
        for pair in pairs:
            all_payload = span_payload(pair[0], pair[1], start_rfc3339, end_rfc3339, page_size)
            error_payload = span_payload(pair[0], pair[1], start_rfc3339, end_rfc3339, page_size, onlyErrorSpans=True, sort="startTime,desc")
            slow_payload = span_payload(pair[0], pair[1], start_rfc3339, end_rfc3339, page_size, durationMin=slow_threshold)
            future_map[executor.submit(query_spans, all_payload)] = (pair, "all")
            future_map[executor.submit(query_spans, error_payload)] = (pair, "error")
            future_map[executor.submit(query_spans, slow_payload)] = (pair, "slow")
        for future in as_completed(future_map):
            pair, kind = future_map[future]
            target = spans if kind == "all" else errors if kind == "error" else slow
            target[pair] = future.result()
    openclaw_pairs = [pair for pair in pairs if total(data(spans[pair])) > 0]

    trace_requests: List[Tuple[str, str, str]] = []
    if detail:
        for pair in openclaw_pairs:
            seen = set()
            for result in (errors.get(pair, (1, None, "")), slow.get(pair, (1, None, ""))):
                for row in items(data(result)):
                    trace_id = row.get("traceId")
                    if trace_id and trace_id not in seen and len(seen) < 3:
                        seen.add(trace_id)
                        trace_requests.append((pair[0], pair[1], trace_id))
    with ThreadPoolExecutor(max_workers=parallelism) as executor:
        futures = {
            request: executor.submit(run, ["dce", "insight", "tracing", "find-jaeger-trace", "--trace-id", request[2], "--cluster-name", request[0], "--namespace", request[1], "-o", "json"])
            for request in trace_requests
        }
        trace_details = {request: future.result() for request, future in futures.items()}

    emit({"type": "meta", "detail": detail, "start": start_rfc3339, "end": end_rfc3339, "hours": hours, "slowThreshold": slow_threshold, "spanFilter": "otel.scope.name=openclaw-otel-plugin", "candidateNamespaceCount": len(pairs), "candidateStrategy": "top trace-service namespaces"})
    for cluster in clusters:
        services = data(inventory[(cluster, "services")])
        pod_data = data(inventory[(cluster, "pods")])
        pods = items(pod_data)
        alerts = items(data(inventory[(cluster, "alerts")]))
        metrics = data(inventory[(cluster, "metrics")]).get("vector", [])
        source_errors = [
            source_error(source, cluster, inventory[(cluster, source)])
            for source in ("services", "pods", "alerts", "metrics")
            if inventory[(cluster, source)][1] is None
        ]
        record: Json = {
            "type": "cluster",
            "cluster": cluster,
            "traceServiceCount": total(services),
            "openclawMetrics": metrics,
            "podSummary": {"total": total(pod_data), "notReady": not_ready_pods(pods)},
            "alertSummary": alert_summary(alerts),
        }
        if source_errors:
            record["sourceErrors"] = source_errors
        emit(record)

    span_errors = [source_error("spans", pair[0], result, pair[1]) for pair, result in spans.items() if result[1] is None]
    for record in span_errors:
        emit({"type": "source", "ok": False, **record})
    if not openclaw_pairs:
        emit({"type": "openclaw", "found": False, "spanCount": 0, "errorSpanCount": None, "classification": "no_traffic_or_telemetry_gap"})
        return 0

    for pair in openclaw_pairs:
        span_data = data(spans[pair])
        error_result = errors.get(pair, (1, None, "missing"))
        slow_result = slow.get(pair, (1, None, "missing"))
        emit({"type": "openclaw", "found": True, "cluster": pair[0], "namespace": pair[1], "spanCount": total(span_data), "errorSpanCount": total(data(error_result)) if error_result[1] is not None else None, "slowSpanCount": total(data(slow_result)) if slow_result[1] is not None else None, "slowest": [compact_span(row) for row in items(data(slow_result))[:10]], "errors": [compact_span(row) for row in items(data(error_result))[:10]]})
        if error_result[1] is None:
            emit({"type": "source", "ok": False, **source_error("errorSpans", pair[0], error_result, pair[1])})
        if slow_result[1] is None:
            emit({"type": "source", "ok": False, **source_error("slowSpans", pair[0], slow_result, pair[1])})
    for request in trace_requests:
        result = trace_details[request]
        if result[1] is not None:
            emit({"type": "traceDetail", "cluster": request[0], "namespace": request[1], "traceId": request[2], "traces": compact_trace(data(result))})
        else:
            emit({"type": "source", "ok": False, **source_error("traceDetail", request[0], result, request[1]), "traceId": request[2]})
    return 0


if __name__ == "__main__":
    sys.exit(main())
