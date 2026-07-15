#!/usr/bin/env bash
set -uo pipefail

# Collect the CSP AI operations daily-summary data set in one terminal call.
# DCE requests run concurrently and only compact, secret-free NDJSON is emitted.

TIMEZONE="${2:-Asia/Shanghai}"
REPORT_DATE="${1:-$(TZ="$TIMEZONE" date +%Y-%m-%d)}"
STALE_DAYS="${AI_OPS_STALE_DAYS:-30}"

command -v dce >/dev/null || { printf 'dce is required\n' >&2; exit 127; }
command -v jq >/dev/null || { printf 'jq is required\n' >&2; exit 127; }

WORK_DIR="$(mktemp -d "${TMPDIR:-/tmp}/ai-ops-summary.XXXXXX")"
trap 'rm -rf "$WORK_DIR"' EXIT

timezone_offset() {
  local raw
  if raw="$(TZ="$TIMEZONE" date -j -f '%Y-%m-%d %H:%M:%S' "$REPORT_DATE 12:00:00" +%z 2>/dev/null)"; then
    :
  elif raw="$(TZ="$TIMEZONE" date -d "$REPORT_DATE 12:00:00" +%z 2>/dev/null)"; then
    :
  else
    printf 'invalid date or timezone: %s %s\n' "$REPORT_DATE" "$TIMEZONE" >&2
    return 2
  fi
  printf '%s:%s\n' "${raw:0:3}" "${raw:3:2}"
}

if OFFSET="$(timezone_offset)"; then
  :
else
  exit 2
fi
START_TIME="${REPORT_DATE}T00:00:00${OFFSET}"
END_TIME="${REPORT_DATE}T23:59:59${OFFSET}"
COLLECTED_AT="$(TZ="$TIMEZONE" date '+%Y-%m-%dT%H:%M:%S%z')"
COLLECTED_AT="${COLLECTED_AT:0:22}:${COLLECTED_AT:22:2}"
NOW_EPOCH="$(date -u +%s)"
STALE_BEFORE_EPOCH="$((NOW_EPOCH - STALE_DAYS * 86400))"

run_call() {
  local name="$1"
  shift
  if "$@" >"$WORK_DIR/$name.json" 2>"$WORK_DIR/$name.err"; then
    printf '0\n' >"$WORK_DIR/$name.status"
  else
    printf '%s\n' "$?" >"$WORK_DIR/$name.status"
  fi
}

run_call usage \
  dce llm-studio apikeymanagement get-api-key-usage-statistics2 \
  --start-time "$START_TIME" --end-time "$END_TIME" \
  --period TIME_PERIOD_HOUR -o json &
PIDS=("$!")

run_call models \
  dce llm-studio modelmanagement list-models \
  --page.page-size -1 --show-public-model-price -o json &
PIDS+=("$!")

run_call api_keys \
  dce llm-studio apikeymanagement list-api-key \
  --page.page-size -1 -o json &
PIDS+=("$!")

run_call model_serving \
  dce llm-studio modelservingmanagement list-model-serving \
  --page.page-size -1 -o json &
PIDS+=("$!")

run_call maas_models \
  dce llm-studio maasservice list-maas-models \
  --page.page-size -1 -o json &
PIDS+=("$!")

run_call admin_models \
  dce llm-studio adminmodelmanagement list-models \
  --page.page-size -1 --show-deploy-template --selector ALL -o json &
PIDS+=("$!")

run_call alerts \
  dce insight alert list-alerts --all -o json &
PIDS+=("$!")

for pid in "${PIDS[@]}"; do
  wait "$pid" || true
done

jq -nc \
  --arg date "$REPORT_DATE" --arg timezone "$TIMEZONE" \
  --arg start "$START_TIME" --arg end "$END_TIME" \
  --arg collectedAt "$COLLECTED_AT" \
  '{type:"meta",mode:"CSP",scope:"global CSP",date:$date,timezone:$timezone,start:$start,end:$end,collectedAt:$collectedAt}'

source_ok() {
  local name="$1"
  [[ -f "$WORK_DIR/$name.status" ]] \
    && [[ "$(<"$WORK_DIR/$name.status")" == "0" ]] \
    && jq -e . "$WORK_DIR/$name.json" >/dev/null 2>&1
}

emit_failure() {
  local name="$1"
  local status="missing"
  local mode_mismatch=false
  [[ -f "$WORK_DIR/$name.status" ]] && status="$(<"$WORK_DIR/$name.status")"
  if grep -Eqs 'SYSTEM-REQUEST_MODE_ERROR|404|not found' \
    "$WORK_DIR/$name.err" "$WORK_DIR/$name.json" 2>/dev/null; then
    mode_mismatch=true
  fi
  jq -nc --arg source "$name" --arg status "$status" --argjson modeMismatch "$mode_mismatch" \
    '{type:"source",source:$source,ok:false,exitStatus:$status,modeMismatch:$modeMismatch}'
}

if source_ok usage; then
  if source_ok models; then
    jq -c --slurpfile models "$WORK_DIR/models.json" '
      def n: if type == "number" then . elif type == "string" and test("^-?[0-9]+(\\.[0-9]+)?$") then tonumber else 0 end;
      def price_for($name):
        first($models[0].items[]? | select(.publicAccessModelName == $name or ("public/" + .modelId) == $name) | .publicModelPrice) // null;
      def model_rows:
        [.dataPoints[]?]
        | sort_by(.model)
        | group_by(.model)
        | map({
            model: .[0].model,
            input: (map(.usage.input | n) | add // 0),
            output: (map(.usage.output | n) | add // 0),
            cached: (map(.usage.cached | n) | add // 0),
            total: (map(.usage.total | n) | add // 0)
          })
        | map(. as $usage | price_for(.model) as $price
          | . + {
              priced: ($price != null and ($price.inputPerKTokens // "") != "" and ($price.outputPerKTokens // "") != ""),
              calculatedCharge: (if $price != null and ($price.inputPerKTokens // "") != "" and ($price.outputPerKTokens // "") != ""
                then ((.input / 1000 * ($price.inputPerKTokens | n)) + (.output / 1000 * ($price.outputPerKTokens | n)))
                else null end)
            });
      model_rows as $rows
      | ([.dataPoints[]? | .timestamp] | max // null) as $latest
      | ([.dataPoints[]? | {timestamp, total:(.usage.total | n)}]
          | sort_by(.timestamp) | group_by(.timestamp)
          | map({timestamp:.[0].timestamp,total:(map(.total)|add)}) | max_by(.total) // null) as $peak
      | {
          type:"usage",ok:true,
          totalUsage:{
            input:(.totalUsage.input | n), output:(.totalUsage.output | n),
            cached:(.totalUsage.cached | n), total:(.totalUsage.total | n)
          },
          latestTimestamp:$latest, peakHour:$peak, models:$rows,
          pricing:{
            unit:"pricing units", usedModelCount:($rows|length),
            pricedModelCount:([$rows[]|select(.priced)]|length),
            pricedTokenCoverage:(if ([$rows[].total]|add // 0) > 0
              then (([$rows[]|select(.priced)|.total]|add // 0) / ([$rows[].total]|add)) else null end),
            calculatedCharge:([$rows[]|select(.calculatedCharge != null)|.calculatedCharge]|add // null)
          }
        }
    ' "$WORK_DIR/usage.json"
  else
    jq -c '
      def n: if type == "number" then . elif type == "string" and test("^[0-9]+$") then tonumber else 0 end;
      {
        type:"usage",ok:true,
        totalUsage:{input:(.totalUsage.input|n),output:(.totalUsage.output|n),cached:(.totalUsage.cached|n),total:(.totalUsage.total|n)},
        latestTimestamp:([.dataPoints[]?.timestamp]|max//null),
        models:([.dataPoints[]?] | sort_by(.model) | group_by(.model)
          | map({model:.[0].model,input:(map(.usage.input|n)|add//0),output:(map(.usage.output|n)|add//0),total:(map(.usage.total|n)|add//0)})),
        pricing:null
      }
    ' "$WORK_DIR/usage.json"
    emit_failure models
  fi
else
  emit_failure usage
  source_ok models || emit_failure models
fi

if source_ok api_keys; then
  jq -c --argjson now "$NOW_EPOCH" --argjson staleBefore "$STALE_BEFORE_EPOCH" '
    def epoch: if . == null or . == "" then null else (sub("\\.[0-9]+Z$";"Z") | fromdateiso8601?) end;
    [.items[]?] as $items
    | {
        type:"apiKeyGovernance",ok:true,total:($items|length),
        disabled:([$items[]|select(.disabled == true)]|length),
        expired:([$items[]|select(.expired == true or ((.expireTime|epoch) != null and (.expireTime|epoch) < $now))]|length),
        zeroQuota:([$items[]|select(.unlimitedQuota != true and ((.quota|tonumber?) // 0) == 0)]|length),
        unlimited:([$items[]|select(.unlimitedQuota == true)]|length),
        neverUsed:([$items[]|select(.lastUsedTime == null or .lastUsedTime == "")]|length),
        stale:([$items[]|select((.lastUsedTime|epoch) != null and (.lastUsedTime|epoch) < $staleBefore)]|length),
        latestUse:([$items[]|.lastUsedTime|select(. != null and . != "")]|max//null)
      }
  ' "$WORK_DIR/api_keys.json"
else emit_failure api_keys; fi

if source_ok model_serving; then
  jq -c '[.items[]?] as $items | {type:"modelServing",ok:true,total:($items|length),byStatus:($items|sort_by(.status)|group_by(.status)|map({status:.[0].status,count:length}))}' "$WORK_DIR/model_serving.json"
else emit_failure model_serving; fi

if source_ok maas_models; then
  if source_ok admin_models; then
    jq -c --slurpfile admin "$WORK_DIR/admin_models.json" '[.items[]?] as $items | {type:"modelSupply",ok:true,total:($items|length),enabled:([$items[]|select(.enabled == true)]|length),byGatewayStatus:($items|sort_by(.gatewayStatus)|group_by(.gatewayStatus)|map({status:.[0].gatewayStatus,count:length})),adminModelCount:($admin[0].items|length)}' "$WORK_DIR/maas_models.json"
  else
    jq -c '[.items[]?] as $items | {type:"modelSupply",ok:true,total:($items|length),enabled:([$items[]|select(.enabled == true)]|length),byGatewayStatus:($items|sort_by(.gatewayStatus)|group_by(.gatewayStatus)|map({status:.[0].gatewayStatus,count:length})),adminModelCount:null}' "$WORK_DIR/maas_models.json"
    emit_failure admin_models
  fi
else
  emit_failure maas_models
  source_ok admin_models || emit_failure admin_models
fi

if source_ok alerts; then
  jq -c '
    [.items[]?] as $items
    | {
        type:"alerts",ok:true,total:($items|length),
        bySeverity:($items|sort_by(.severity)|group_by(.severity)|map({severity:.[0].severity,count:length})),
        byStatus:($items|sort_by(.status)|group_by(.status)|map({status:.[0].status,count:length})),
        important:([$items[]|select(.severity == "CRITICAL" or .severity == "WARNING")]
          | sort_by([.severity,.ruleName,.status,.clusterName,.namespace])
          | group_by([.severity,.ruleName,.status,.clusterName,.namespace])
          | map({ruleName:.[0].ruleName,severity:.[0].severity,status:.[0].status,
              clusterName:.[0].clusterName,namespace:.[0].namespace,count:length,
              latestStartAt:(map(.startAt|tonumber?)|map(select(. != null))|max//null)}))
      }
  ' "$WORK_DIR/alerts.json"
else emit_failure alerts; fi
