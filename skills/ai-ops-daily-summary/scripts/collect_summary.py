#!/usr/bin/env python3
"""Collect compact CSP AI operations data using only the Python standard library."""

import json
import os
import re
import shutil
import subprocess
import sys
import time as monotonic_time
from collections import Counter, defaultdict
from concurrent.futures import ThreadPoolExecutor
from datetime import date, datetime, time, timedelta, timezone
from typing import Any, Dict, List, Optional, Tuple
from zoneinfo import ZoneInfo, ZoneInfoNotFoundError


Json = Dict[str, Any]
Result = Tuple[int, Optional[Json], str]
DEADLINE: Optional[float] = None


def emit(value: Json) -> None:
    print(json.dumps(value, ensure_ascii=False, separators=(",", ":")))


def number(value: Any) -> float:
    try:
        return float(value or 0)
    except (TypeError, ValueError):
        return 0.0


def tidy_number(value: float) -> Any:
    return int(value) if value.is_integer() else value


def parse_time(value: Any) -> Optional[datetime]:
    if not isinstance(value, str) or not value:
        return None
    try:
        return datetime.fromisoformat(value.replace("Z", "+00:00"))
    except ValueError:
        return None


def run(command: List[str]) -> Result:
    remaining = DEADLINE - monotonic_time.monotonic() if DEADLINE is not None else None
    if remaining is not None and remaining <= 0:
        return 124, None, "collection time budget exhausted"
    timeout = float(os.environ.get("AI_OPS_DCE_TIMEOUT", "5"))
    if remaining is not None:
        timeout = min(timeout, max(0.1, remaining))
    try:
        completed = subprocess.run(
            command,
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
        data = json.loads(completed.stdout)
    except json.JSONDecodeError:
        return 1, None, completed.stderr + completed.stdout
    return 0, data, completed.stderr


def failure(name: str, result: Result) -> Json:
    status, _, message = result
    return {
        "type": "source",
        "source": name,
        "ok": False,
        "exitStatus": str(status),
        "modeMismatch": bool(
            re.search(r"SYSTEM-REQUEST_MODE_ERROR|404|not found", message, re.IGNORECASE)
        ),
    }


def items(data: Optional[Json]) -> List[Json]:
    value = (data or {}).get("items", [])
    return value if isinstance(value, list) else []


def usage_record(usage: Json, models: Optional[Json]) -> Json:
    price_by_name: Dict[str, Json] = {}
    if models:
        for model in items(models):
            price = model.get("publicModelPrice")
            if not isinstance(price, dict):
                continue
            for name in (model.get("publicAccessModelName"), f"public/{model.get('modelId')}"):
                if name and name != "public/None":
                    price_by_name[name] = price

    grouped: Dict[str, Dict[str, float]] = defaultdict(
        lambda: {"input": 0.0, "output": 0.0, "cached": 0.0, "total": 0.0}
    )
    hourly: Dict[str, float] = defaultdict(float)
    timestamps: List[str] = []
    for point in usage.get("dataPoints", []) or []:
        model_name = point.get("model")
        if not model_name:
            continue
        point_usage = point.get("usage") or {}
        for field in ("input", "output", "cached", "total"):
            grouped[model_name][field] += number(point_usage.get(field))
        timestamp = point.get("timestamp")
        if timestamp:
            timestamps.append(timestamp)
            hourly[timestamp] += number(point_usage.get("total"))

    rows: List[Json] = []
    for model_name in sorted(grouped):
        values = grouped[model_name]
        price = price_by_name.get(model_name)
        priced = bool(
            price
            and price.get("inputPerKTokens") not in (None, "")
            and price.get("outputPerKTokens") not in (None, "")
        )
        charge = None
        if priced and price:
            charge = values["input"] / 1000 * number(price.get("inputPerKTokens"))
            charge += values["output"] / 1000 * number(price.get("outputPerKTokens"))
        row: Json = {
            "model": model_name,
            **{key: tidy_number(value) for key, value in values.items()},
        }
        if models is not None:
            row.update({"priced": priced, "calculatedCharge": charge})
        rows.append(row)

    total_tokens = sum(number(row["total"]) for row in rows)
    priced_tokens = sum(number(row["total"]) for row in rows if row.get("priced"))
    charges = [number(row["calculatedCharge"]) for row in rows if row.get("calculatedCharge") is not None]
    total_usage = usage.get("totalUsage") or {}
    peak = max(hourly.items(), key=lambda pair: pair[1]) if hourly else None
    record: Json = {
        "type": "usage",
        "ok": True,
        "totalUsage": {
            field: tidy_number(number(total_usage.get(field)))
            for field in ("input", "output", "cached", "total")
        },
        "latestTimestamp": max(timestamps) if timestamps else None,
        "peakHour": (
            {"timestamp": peak[0], "total": tidy_number(peak[1])} if peak else None
        ),
        "models": rows,
        "pricing": None,
    }
    if models is not None:
        record["pricing"] = {
            "unit": "pricing units",
            "usedModelCount": len(rows),
            "pricedModelCount": sum(1 for row in rows if row["priced"]),
            "pricedTokenCoverage": priced_tokens / total_tokens if total_tokens else None,
            "calculatedCharge": sum(charges) if charges else None,
        }
    return record


def api_key_record(data: Json, now: datetime, stale_days: int) -> Json:
    records = items(data)
    stale_before = now - timedelta(days=stale_days)
    latest_times = [value for value in (row.get("lastUsedTime") for row in records) if value]

    def expired(row: Json) -> bool:
        expiry = parse_time(row.get("expireTime"))
        return row.get("expired") is True or bool(expiry and expiry < now)

    def stale(row: Json) -> bool:
        last_used = parse_time(row.get("lastUsedTime"))
        return bool(last_used and last_used < stale_before)

    return {
        "type": "apiKeyGovernance",
        "ok": True,
        "total": len(records),
        "disabled": sum(row.get("disabled") is True for row in records),
        "expired": sum(expired(row) for row in records),
        "zeroQuota": sum(
            row.get("unlimitedQuota") is not True and number(row.get("quota")) == 0
            for row in records
        ),
        "unlimited": sum(row.get("unlimitedQuota") is True for row in records),
        "neverUsed": sum(not row.get("lastUsedTime") for row in records),
        "stale": sum(stale(row) for row in records),
        "latestUse": max(latest_times) if latest_times else None,
    }


def counts(records: List[Json], field: str, output_field: str) -> List[Json]:
    values = Counter(row.get(field) for row in records)
    return [
        {output_field: value, "count": count}
        for value, count in sorted(values.items(), key=lambda pair: str(pair[0]))
    ]


def main() -> int:
    global DEADLINE
    detail = os.environ.get("AI_OPS_DETAIL", "").lower() in ("1", "true", "yes")
    default_budget = "12" if detail else "6"
    DEADLINE = monotonic_time.monotonic() + float(os.environ.get("AI_OPS_BUDGET", default_budget))
    if not shutil.which("dce"):
        print("dce is required", file=sys.stderr)
        return 127
    timezone_name = sys.argv[2] if len(sys.argv) > 2 else "Asia/Shanghai"
    try:
        report_timezone = ZoneInfo(timezone_name)
        report_date = date.fromisoformat(sys.argv[1]) if len(sys.argv) > 1 else datetime.now(report_timezone).date()
    except (ZoneInfoNotFoundError, ValueError):
        print(f"invalid date or timezone: {sys.argv[1:]}", file=sys.stderr)
        return 2

    start = datetime.combine(report_date, time.min, report_timezone)
    end = datetime.combine(report_date, time(23, 59, 59), report_timezone)
    collected_at = datetime.now(report_timezone).replace(microsecond=0)
    now = datetime.now(timezone.utc)
    stale_days = int(os.environ.get("AI_OPS_STALE_DAYS", "30"))
    commands = {
        "usage": ["dce", "llm-studio", "apikeymanagement", "get-api-key-usage-statistics2", "--start-time", start.isoformat(), "--end-time", end.isoformat(), "--period", "TIME_PERIOD_HOUR", "-o", "json"],
        "api_keys": ["dce", "llm-studio", "apikeymanagement", "list-api-key", "--page.page-size", "-1", "-o", "json"],
        "alerts": ["dce", "insight", "alert", "list-alerts", "--all", "-o", "json"],
    }
    if detail:
        commands["models"] = ["dce", "llm-studio", "modelmanagement", "list-models", "--page.page-size", "-1", "--show-public-model-price", "-o", "json"]
        commands["admin_models"] = ["dce", "llm-studio", "adminmodelmanagement", "list-models", "--page.page-size", "-1", "--show-deploy-template", "--selector", "ALL", "-o", "json"]
        commands["model_serving"] = ["dce", "llm-studio", "modelservingmanagement", "list-model-serving", "--page.page-size", "-1", "-o", "json"]
        commands["maas_models"] = ["dce", "llm-studio", "maasservice", "list-maas-models", "--page.page-size", "-1", "-o", "json"]
    with ThreadPoolExecutor(max_workers=len(commands)) as executor:
        futures = {name: executor.submit(run, command) for name, command in commands.items()}
        results = {name: future.result() for name, future in futures.items()}

    emit({"type": "meta", "mode": "CSP", "scope": "global CSP", "detail": detail, "date": report_date.isoformat(), "timezone": timezone_name, "start": start.isoformat(), "end": end.isoformat(), "collectedAt": collected_at.isoformat()})
    usage_data = results["usage"][1]
    models_data = results.get("models", (0, None, ""))[1]
    if usage_data:
        emit(usage_record(usage_data, models_data))
        if detail and not models_data:
            emit(failure("models", results["models"]))
    else:
        emit(failure("usage", results["usage"]))
        if detail and not models_data:
            emit(failure("models", results["models"]))

    api_keys = results["api_keys"][1]
    emit(api_key_record(api_keys, now, stale_days) if api_keys else failure("api_keys", results["api_keys"]))

    if detail:
        serving = results["model_serving"][1]
        serving_items = items(serving)
        emit({"type": "modelServing", "ok": True, "total": len(serving_items), "byStatus": counts(serving_items, "status", "status")} if serving else failure("model_serving", results["model_serving"]))

        maas = results["maas_models"][1]
        admin = results["admin_models"][1]
        if maas:
            maas_items = items(maas)
            emit({"type": "modelSupply", "ok": True, "total": len(maas_items), "enabled": sum(row.get("enabled") is True for row in maas_items), "byGatewayStatus": counts(maas_items, "gatewayStatus", "status"), "adminModelCount": len(items(admin)) if admin else None})
            if not admin:
                emit(failure("admin_models", results["admin_models"]))
        else:
            emit(failure("maas_models", results["maas_models"]))
            if not admin:
                emit(failure("admin_models", results["admin_models"]))

    alerts = results["alerts"][1]
    if alerts:
        alert_items = items(alerts)
        grouped: Dict[Tuple[Any, ...], List[Json]] = defaultdict(list)
        for alert in alert_items:
            if alert.get("severity") in ("CRITICAL", "WARNING"):
                key = tuple(alert.get(field) for field in ("ruleName", "severity", "status", "clusterName", "namespace"))
                grouped[key].append(alert)
        important = []
        for key in sorted(grouped, key=lambda value: tuple(str(item) for item in value)):
            rows = grouped[key]
            starts = [number(row.get("startAt")) for row in rows if row.get("startAt") is not None]
            important.append({"ruleName": key[0], "severity": key[1], "status": key[2], "clusterName": key[3], "namespace": key[4], "count": len(rows), "latestStartAt": tidy_number(max(starts)) if starts else None})
        important.sort(key=lambda row: (0 if row["severity"] == "CRITICAL" else 1, -number(row["latestStartAt"])))
        important = important[:10]
        emit({"type": "alerts", "ok": True, "total": len(alert_items), "bySeverity": counts(alert_items, "severity", "severity"), "byStatus": counts(alert_items, "status", "status"), "important": important})
    else:
        emit(failure("alerts", results["alerts"]))
    return 0


if __name__ == "__main__":
    sys.exit(main())
