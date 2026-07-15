---
name: ai-ops-daily-summary
description: Generate a concise leadership-facing AI operations daily summary and business-value analysis from DaoCloud Enterprise DCE / LLM Studio / Hydra data. Use when the user asks for today's AI operations summary, AI usage report, LLM Studio operating metrics, boss/leadership AI daily report, token/API key/model service overview, business value, operating value, risk identification, or wants available DCE CLI data turned into the most important conclusions, especially in table form.
---

# AI Ops Daily Summary

## Goal

Produce a concise, leadership-facing AI daily summary from data retrieved in the current run. Put the conclusion first, favor compact tables, and keep the collection process out of the final answer.

## Collection

Use the bundled Python collector for the verified CSP fast path. Resolve it relative to this `SKILL.md` and invoke it exactly once:

```bash
python3 scripts/collect_summary.py '<YYYY-MM-DD>' '<timezone>'
```

Date and timezone default to today and `Asia/Shanghai`. The default profile is `usage-cost`:

```bash
# Default: Token usage and calculated charge
python3 scripts/collect_summary.py --profile usage-cost

# Follow-up: usage, API Key health, and infrastructure alerts
python3 scripts/collect_summary.py --profile operations

# Explicit deep request: all above plus cost, serving, and model supply
python3 scripts/collect_summary.py --profile full
```

The collector uses only Python 3 standard-library modules and `dce`, runs selected command groups concurrently, emits compact secret-free NDJSON, and keeps successful partial results. Do not run separate DCE commands after a successful collector invocation. Direct DCE CLI calls are allowed only when the collector reports a runtime-mode mismatch, a failed source materially blocks the requested answer, or the user asks for a custom scope.

Use a 12-second total budget for `usage-cost` and `full`, a 6-second budget for `operations`, and a 5-second per-command timeout. Do not retry optional failures in the normal path. `AI_OPS_DETAIL=1` remains a compatibility alias for `--profile full`.

## Profile Selection

- Use `usage-cost` unless the user explicitly asks for governance, alerts, reliability, risks, model serving, or a complete operating view.
- Use `operations` for API Key health, alert posture, and operational risk. It intentionally omits pricing.
- Use `full` only when the same answer needs cost plus operational, serving, and model-supply data.
- After every default `usage-cost` report, briefly state the current scope and ask whether to continue: `当前分析仅覆盖 Token 用量与费用视角。是否继续分析 API Key 健康、基础设施告警等完整运营视角？`

## Data Integrity

- Use only values retrieved in the current run. Never guess, backfill, extrapolate, or invent values.
- Omit unavailable metrics instead of writing placeholders such as `N/A`, `unknown`, `-`, or `0`.
- Keep measured and calculated values distinct. State the formula briefly when a calculation drives a conclusion.
- Never expose raw API keys, tokens, credentials, or secrets. API Key output is counts and status summaries only.
- Keep partial data when an optional source fails. Mention a gap only when it materially affects confidence.
- In CSP mode, global totals do not prove which users or API Keys were active. Do not infer attribution without per-key or per-user usage data.

## Cost Rules

Calculate charge only when current-run model usage and matching prices are both present:

```text
model charge = input_tokens / 1000 * inputPerKTokens
             + output_tokens / 1000 * outputPerKTokens
```

- Join names such as `public/<model-id>` to the corresponding published model price.
- If a used model has no price, report the priced subset and Token coverage; do not label it total cost.
- If the API provides no currency, use `pricing units`, never CNY or USD.
- A calculated token charge is not infrastructure cost, gross profit, or ROI.

## Interpretation

- For an in-progress day, state the local collection cutoff or latest usage timestamp; do not imply a completed full day.
- Treat retrieved zero usage as zero consumption, but do not interpret missing usage as zero.
- A firing `CRITICAL` alert may set overall risk to Critical even if model-serving records are healthy. Distinguish platform reliability from model availability.
- For API Keys, summarize total, disabled, expired, zero-quota, unlimited, never-used, stale, and latest-use counts. Never print key values.
- If nonzero global usage conflicts with all-key zero quota or stale metadata, call it a metering/attribution consistency risk, not quota bypass.
- Financial, capacity, quota, and risk conclusions must each be supported by retrieved evidence.

## Response

Match the user's language. Use no more than three findings and two actions unless the user requests detail.

```markdown
# 结论

<1–2 sentences with the current judgment and material limitation, if any>

## 核心指标

| 指标 | 当前值 | 判断 |
|---|---:|---|
| Token 用量 | <retrieved input/output/total> | <concise read> |
| 估算费用 | <retrieved calculated charge and coverage, when available> | <concise read> |
| 峰值或主要模型 | <retrieved value> | <concise read> |

## 主要发现

1. <highest-value evidence-backed finding>
2. <second finding only when material>

## 建议

1. <specific action tied to retrieved evidence, only when needed>

当前分析仅覆盖 Token 用量与费用视角。是否继续分析 API Key 健康、基础设施告警等完整运营视角？
```

For `operations` or `full`, replace or extend the metric rows with API Key health, active alerts, model serving, or model supply as actually retrieved. Do not include the follow-up prompt when the requested complete operating view has already been delivered.

## Runtime Fallback

The fast path assumes global CSP scope. Only when the collector marks usage as a mode mismatch:

1. Probe one visible workspace read endpoint and one global CSP read endpoint.
2. Classify the runtime as WS, CSP, mixed, or undetermined from successful responses, not command help text.
3. Collect only the supported scope and deduplicate overlapping usage in mixed mode.
4. Label the result `workspace aggregate`, `global CSP`, or `mixed`.

Hydra data is normally accessed through successful `dce llm-studio ...` commands. Do not claim a separate Hydra CLI was used unless it actually was.
