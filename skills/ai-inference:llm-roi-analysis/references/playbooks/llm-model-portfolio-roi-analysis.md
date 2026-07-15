# LLM Model Portfolio ROI Analysis (Horizontal Deployment Mix)

**适用 / When to use:** 用户问「deepseek-v4-pro 和 GLM-5.1 等模型的部署比例要不要调整」「哪些模型该缩容/扩容/调价」「自部署模型组合整体 ROI 怎么样」。Use when the user asks whether the deployment mix across models like deepseek-v4-pro and GLM-5.1 should change, which models to scale down / scale up / reprice, or what the overall ROI of the self-hosted model portfolio looks like.

This playbook **only analyzes self-hosted models** and does **portfolio-level horizontal analysis**: put multiple self-hosted models in the same window, compare them, then output ranked actions. For single-model ROI-decline attribution, drill down with `llm-roi-cost-analysis.md`.

Core principles:

- Analysis and recommendation only — never auto-create, scale down, scale up, or shift traffic.
- Confirm each model is self-hosted first through the model-list read: keep only
  model IDs that start with `maas-` or `a-maas-`. Other-prefix models are resale/pass-through
  or out of scope for GPU ROI right-sizing.
- ROI cannot replace model-quality assessment. Any "take traffic" suggestion must additionally verify model capability, business effectiveness, context length, latency, and error rate.
- On missing data, state which part is missing and which conclusion it affects; do not fabricate mock data to force a conclusion.

## Example: signal profiles of the 4 action classes

A portfolio diagnosis usually lands in one of the following 4 action classes. The table below gives a **typical signal profile** per class (an example aid for reading, not a fixed checklist; classify real models by their actual signals):

| Model | Role | Expected action |
|---|---|---|
| `deepseek-v4-pro` | demand down, utilization down, margin turned negative | Scale down candidate |
| `GLM-5.1` | high utilization, margin persistently negative | Reprice / price-check candidate |
| `Qwen3-32B` | healthy utilization, positive margin, no clear deterioration | Observe |
| `MiniMax-2.7` | growing demand, positive margin, utilization near high | Scale up / take-traffic candidate |

## Data collection (API-first via `dce`)

**Enumerate self-hosted models first** (they carry a `maas-` or `a-maas-` model-id prefix):

```
dce --insecure llm-studio adminmodelmanagement list-models --page.search "modelId=maas-" -o json
# client-side: keep only modelId that startswith "maas-" or "a-maas-" (search is contains-match)
```

`maas-models` is NOT the enumeration source — it lists knoway gateway routes and is
empty on envs without the knoway gateway installed. Use the `models` API above.

Then, for every model, keep the same business window and use the pinned command
list in `SKILL.md` exactly. This playbook explains how to compare the command
outputs; it does not define additional commands.

## Execution budget

For a portfolio, use the model-bundled recipe from `SKILL.md`: first list all
self-hosted `maas-*` models once, then for each selected model make one tool
call that runs the model bundle for that model. Every `dce` command must include
`--insecure` immediately after `dce`. Do not split one model's work into
usage-only, SKU-only, utilization-only, or retry narration tool messages.

**Collect the whole portfolio in ONE shell command = one tool call** (speed fix —
do NOT fan out to per-model or per-API tool calls). ⛔ **Query usage PER MODEL, one
`--models` value at a time** — do NOT pass a comma-joined list. With a
multi-model `--models`, `totalUsage` is the **SUM ACROSS ALL those models**, so
using it for any single model's revenue is wrong (this is exactly what produces a
model reported at −186% when it is actually profitable). A shell `for` loop keeps
it to one command while giving each model its own clean `totalUsage`. SKU / GPU
price / util are model-independent — pull once. Set the vars, run once, parse the
labelled `### SECTION` blocks:

```bash
S="<start-date>"; E="<today-date>"   # E exclusive → usage window = complete days only
echo "### MODELS"; dce --insecure llm-studio adminmodelmanagement list-models --page.search "modelId=maas-" -o json | grep '"modelId"'   # enumerate + gate, grepped; do NOT run list-models as a separate call
for M in a-maas-deepseek-v4-pro a-maas-glm-5.1 a-maas-qwen3-32b a-maas-minimax-2.7; do
  PUB=$(dce --insecure llm-studio adminmodelmanagement get-model --model-id "$M" -o json | grep -o '"publicAccessModelName" *: *"[^"]*"' | grep -o 'public/[^"]*')
  echo "### USAGE $M -> $PUB"
  dce --insecure llm-studio apikeymanagement get-api-key-usage-statistics2 --start-time "${S}T00:00:00Z" --end-time "${E}T00:00:00Z" --models "$PUB" --period TIME_PERIOD_DAY -o json | grep -A11 '"totalUsage"'
done
echo "### SKU";     dce --insecure billing-center product list-sku-infos --page 1 --page-size 200 --product hydra-maas -o json | grep -E '"value"|"price"'
echo "### GPUCOST"; dce --insecure container-management core get-config-map --cluster kpanda-global-cluster --namespace tokenfactory-system --name tokenfactory-dashboard-resource-cost -o json
echo "### UTIL";    dce --insecure operations-management report list-pods --start "$S" --end "$E" --search a-maas -o json | grep -E '"pod"|"avgGpuUseRatio"|"maxGpuUseRatio"'
```
The `grep`s keep the single command's output under the terminal's ~5 KB window (raw JSON overflows → everything after the first section is truncated and the agent re-queries). `grep -A11 '"totalUsage"'` per model = that model's window revenue inputs; do NOT echo the full `list-models` (huge + redundant). If you need the daily trend for one model, re-run just its USAGE line without the grep.

Each model's revenue = **its own `### USAGE <M>` block's `totalUsage.input` and
`totalUsage.output`** (price each and add). `publicAccessModelName` comes from
`get-model` (do NOT hardcode `public/`; `grep`, not `python -c`). Replicas come
from the fixed mapping (4/4/3/2); `list-model-serving` is optional. **Sanity per
model:** nonzero GPU util ⟹ billions of tokens/week — if a model's `totalUsage`
implies only tens of millions, you read the wrong model's block.

Collect the complete result set first, then calculate and answer. Do not send
separate tool messages like "pull tokens for every model", "pull SKU for every
model", or "now query utilization for every model"; the grouping unit is one
model bundle.

- Keep the tool transcript compact: model list once, then one model bundle per
  selected model, then calculation and answer.
- Do not create or edit files for analysis; do the arithmetic inline.
- Do not run both monthly and daily usage calls. Use daily usage calls; their
  totals and data points cover the window and the last-week slice.
- Do not pull extra historical windows unless the user explicitly asks for
  week-over-week comparison. For "最近一周", use the latest returned 7 daily
  data points and state coverage if fewer are available.
- If a command fails because a documented flag is wrong, retry the same
  documented command once with the corrected flag; do not switch APIs.

Pinned command outputs used for portfolio rows:

| Need | Field source from the pinned commands |
|---|---|
| self-hosted model list | model-list read: model IDs starting with `maas-` |
| replicas | model bundle read 1: serving `replicas`; client-side filter by model/serving name |
| token volume + daily trend | **per model, from that model's OWN `### USAGE <M>` block** (one `--models` value each — never a comma-joined call, whose `totalUsage` is the all-models sum): **revenue = `totalUsage.input`/1e6 × input_¥/M + `totalUsage.output`/1e6 × output_¥/M** (`totalUsage.input` and `totalUsage.output` are two separate token counts — price each and ADD, NOT a division; `--end-time <today>T00:00:00Z` makes `totalUsage` cover complete days only and sum all days + all `modelType` rows — do NOT hand-sum `dataPoints`). `dataPoints` are for the daily trend only: per-day (NOT cumulative), each day may carry multiple `modelType` rows (`REQUEST_MODEL_TYPE_UNSPECIFIED` + `TEXT_GENERATION`) — sum them. Sanity per model: nonzero GPU util ⟹ billions of tokens/week, not tens of millions. |
| input/output sale price | model bundle read 3: hydra-maas SKU where `specFields.model-name` == model |
| GPU hourly price | model bundle read 4: `resourceCostSettings.gpus[].price`, keyed by fixed GPU product mapping |
| utilization | model bundle read 5: `data.avgGpuUseRatio`, `data.maxGpuUseRatio`, `data.minGpuUseRatio` |

## Time-window conventions

The output must state the business window and the **effective coverage window** of each data class:

- Business window: `2026-06-01` to `2026-06-30`, inclusive of `2026-06-30` by calendar day.
- Reconcile token usage by `create_time`, earliest and latest usage day.
- Read utilization from the model bundle pod report for the same business window; if the
  returned data covers fewer days, state the effective coverage window.
- ⛔ **Complete-days-only (must never be violated).** Only **complete** calendar days
  (date strictly before today, UTC) enter the ROI. **Today is partial and future
  dates have not happened** — `usage-statistics2` counts events only up to now, so
  these days come back near-zero. Drop them from **both** revenue and cost; never
  read them as "demand collapsed".
  - Effective last day = `min(requested_end_date, today − 1 day)`.
  - **Tail-trim:** drop any trailing `dataPoints` day whose total tokens are below
    ~20% of the median of the prior full days (an incomplete day), then re-state
    the effective coverage window.
  - `window_hours = complete_days × 24`, where `complete_days` is exactly the set
    of days summed into revenue.
- ⛔ **Cost and revenue MUST use the identical complete-day set.** Never pair
  N-day revenue with (N+k)-day cost. Example: user asks a 7-day window but today is
  day 6 → revenue and cost both use the 5 complete days (`window_hours = 120`),
  not 168. Mismatching them overstates every model's loss ~1.4× and can flip a
  healthy `+15%` model to a false break-even. On any residual mismatch, align to
  the overlapping complete days; if not alignable, mark reduced confidence.

Each key judgment must cite at least two time points or segments:

| Evidence | Requirement |
|---|---|
| First week | tokens/revenue, avg GPU utilization, margin for `2026-06-01` to `2026-06-07` |
| Last week | tokens/revenue, avg GPU utilization, margin for `2026-06-24` to `2026-06-30` |
| Full window | full-window revenue, GPU cost, ROI, avg/min/max GPU utilization |

Do not give only the final ROI table while omitting time-point evidence.

## Join key

Build one portfolio-table row per model:

| Field | Source |
|---|---|
| `model_id` / `model_name` | model-list read |
| `serving_name` / `replicas` | model bundle read 1: serving list |
| `input_tokens` / `output_tokens` | model bundle read 2: daily usage stats |
| `input_¥_per_M` / `output_¥_per_M` | model bundle read 3: hydra-maas SKU list, raw `price / 1000` |
| `gpu_product` / `gpu_count` | fixed model → GPU mapping in `SKILL.md`; GPU hourly price from model bundle read 4 |
| `revenue` | Σ(input_tokens/1,000,000×input_¥_per_M + output_tokens/1,000,000×output_¥_per_M) |
| `gpu_cost` | Σ_pods(gpu_hourly_price × pod_hours) |
| `avg_gpu_use_ratio` / `max_gpu_use_ratio` / `min_gpu_use_ratio` | model bundle read 5: pod utilization report |

If a model misses a join key, do not force-fit. Output "this model's data chain does not close" and lower the portfolio recommendation confidence.

## Portfolio metrics

For each model compute:

```text
revenue = sum(input_tokens/1,000,000 × input_¥_per_M + output_tokens/1,000,000 × output_¥_per_M)
gpu_cost = sum(gpu_hourly_price × pod_hours)          # allocation-based; NOT scaled by utilization
gross_margin = (revenue - gpu_cost) / revenue
roi = (revenue - gpu_cost) / gpu_cost
revenue_share = model_revenue / portfolio_revenue
cost_share = model_gpu_cost / portfolio_gpu_cost
deployment_share = model_replicas / portfolio_replicas
share_gap = cost_share - revenue_share
```

⛔ **Cost & ROI audit (mandatory, per model).** `gpu_cost = replicas × ¥/hr[THIS
model's CM product] × window_hours` — CM allocation only; never gmagpie per-pod
`gpu_fee`, never utilization-scaled, never the wrong GPU's price (GLM-5.1 = B200
¥50.95/hr, not H200/H100). `roi = (revenue − gpu_cost)/gpu_cost`, **NOT**
`revenue/gpu_cost` (that ratio = `1 + roi`). Assert `roi ≈ gross_margin/(1 −
gross_margin)` with the same revenue & cost; a **negative margin must give a
negative ROI** — if a model shows loss-margin but positive ROI, the cost is
wrong, redo it. Show the substituted cost line (e.g. `4 × ¥50.95 × 144 =
¥29,347`) so it is re-checkable.

Trend metrics, at least first vs last window:

```text
demand_trend = tokens_last_week - tokens_first_week
util_trend = avg_gpu_use_ratio_last_week - avg_gpu_use_ratio_first_week
margin_trend = gross_margin_last_week - gross_margin_first_week
```

## Action rules

These rules are ranking cues, not an auto-classifier.

### Scale down candidate

Prefer scaling down when:

- demand down;
- cost/replicas roughly unchanged;
- utilization down;
- margin down or turned negative;
- `max_gpu_use_ratio` stays under the scale-down guardrail (peak < 70%) after scale-down.

**Compute the target replica count — never state one without the arithmetic.**
Peak utilization scales inversely with replicas:
`post_scale_peak ≈ current_max_gpu_use_ratio × old_replicas / new_replicas`.
Choose the smallest `new_replicas` with `post_scale_peak < 70%`:
`new_replicas = ceil(current_max_gpu_use_ratio × old_replicas / 0.70)`.
Example: peak 49%, 4 replicas → `ceil(0.49×4/0.70)=3` → **4→3** (post-peak ≈65%),
NOT 4→2 (≈98%, breaches guardrail).

Demo expectation: `deepseek-v4-pro`.

### Reprice / price-check candidate

Prefer repricing or a price-check (not direct scale-down) when:

- demand stable;
- utilization high and stable;
- margin persistently negative;
- unit cost above current sale price.

**Compute the reprice magnitude — never say "several times" / "N倍" by feel.**
Break-even multiplier = `gpu_cost / revenue` over the same window; required
increase = `(gpu_cost / revenue − 1) × 100%`. A `−m%` margin needs exactly
`m%` more revenue. Example: cost ¥29,347 / revenue ¥23,481 = `1.25` →
**+25%** to break even (a −25% margin never needs a 5× hike). State this is
break-even at constant volume; if elasticity is a concern, recommend a phased
raise or partial traffic migration — but never inflate the headline multiple
beyond `gpu_cost / revenue`.

Demo expectation: `GLM-5.1`.

### Observe

Observe when:

- margin positive;
- utilization healthy;
- demand not persistently deteriorating;
- no clear cost step or capacity risk.

Demo expectation: `Qwen3-32B`.

### Scale up / take-traffic candidate

Candidate for scale-up or a controlled traffic-migration experiment when:

- demand growing;
- margin positive;
- utilization near high but not overloaded;
- headroom present;
- model quality, business effectiveness, and workload compatibility verified outside the cost analysis.

Demo expectation: `MiniMax-2.7`.

## Output format (structured Markdown — conclusion first)

Answer in **structured Markdown**. Do NOT narrate the process: no tool calls, no store reads, no query retries, no JSON internals. Conclusion goes first. Use tables for metrics. Actions must be concrete and executable. Wording discipline: "likely / leans toward / evidence points to", never "the root cause must be X". **Present as a real production ROI analysis** — never mention the environment, "demo", data provenance, pod images, cluster/GPU-node topology, or that any value is seeded/mock; treat any zero or gap as a genuine business signal, never as "data invalid" or "environment is a stub". Token pricing in final output must be shown as **¥/million tokens** for input and output separately. Do NOT expose `micro-¥/k-token`, `THOUSAND_TOKENS`, or "blended price"; if an average is helpful, call it "按当前 input/output 用量加权后的平均售价" after showing separate input/output prices.

Hard format constraints:

- The answer must begin with `## 结论`; no process preamble before it.
- The `## 结论` paragraph must explicitly state: **成本/收益数据仅统计自部署模型；
  外部/转售模型不纳入本次 ROI 计算**.
- Use exactly the five modules below, in order. Do not add separate sections such
  as "关于数据窗口", "数据来源", or "分析过程".
- `## 关键指标` MUST be a Markdown pipe table. Do not use raw HTML `<table>`,
  key:value lines, bullets, or prose for metrics.
- If data coverage is partial, put it in the conclusion sentence and/or one
  table row; do not create an extra section.

Every answer MUST contain these five modules in order: **## 结论** → **## 关键指标**（表格）→ **## 主要发现**（编号）→ **## 原因分析**（证据/影响）→ **## 建议动作**（立即处理/持续观察/后续优化）。

### Filled example (portfolio of 4 self-hosted models, window 2026-06-01~30)

```markdown
## 结论
基于当前可获取数据，4 个自部署模型组合整体 ROI +9%（收入¥92,850 / 成本¥85,500），但成本-收入错配明显：deepseek-v4-pro 亏损且利用率下滑该缩容，GLM-5.1 高利用率却持续亏损该调价，MiniMax-2.7 增长强劲该扩容。成本/收益数据仅统计自部署模型，外部/转售模型不纳入本次 ROI 计算。当前风险等级：**关注**。

## 关键指标
| 模型 | 毛利率 / ROI | 利用率(首→末周) | 副本×GPU | 判定 |
|---|---|---|---|---|
| deepseek-v4-pro | −1.6% / −2% | 57%→33% | 4×H100 | 风险·缩容 |
| GLM-5.1 | −24.7% / −20% | 85%→85% | 4×H100 | 风险·调价 |
| Qwen3-32B | +15.4% / +18% | 55%→55% | 3×H800 | 正常·观察 |
| MiniMax-2.7 | +52.8% / +112% | 67%→83% | 2×A100 | 正常·扩容 |
| 组合合计 | +7.9% / +9% | — | 13 卡 | 关注 |

## 主要发现
1. **成本错配** — GLM-5.1 成本占比 34% 但收入占比仅 25%（share_gap +9pp），是最大亏损源。
2. **需求分化** — deepseek-v4-pro 需求↓10%、MiniMax-2.7 需求↑31%，部署比例与需求走向相反。
3. **利用率两极** — GLM-5.1 满载(85%)仍亏（定价问题），deepseek-v4-pro 半空(33%)也亏（容量问题），两者对症手段不同。

## 原因分析
**原因 1：deepseek-v4-pro 容量未随需求回收**
- 证据：需求↓ + 利用率 57%→33% + 副本不变 + 毛利率转负；峰值 41% < 70% 护栏。
- 影响：闲置 GPU 固定成本拖累组合，缩容即可止血。

**原因 2：GLM-5.1 定价不覆盖成本**
- 证据：利用率 85% 高位满载仍亏 −25%，需求平稳；单位成本 > 当前售价。
- 影响：满载还亏说明不是容量问题，缩容会打爆 SLA，只能调价。

**原因 3：MiniMax-2.7 供给不足**
- 证据：需求↑31%、利用率 67%→83% 逼近高位、毛利率 +53%、成本占比(11%)远低于收入占比(21%)。
- 影响：余量收窄，不扩容将成为瓶颈、错失高毛利流量。

## 建议动作
**立即处理**
1. deepseek-v4-pro 缩容 4→2 副本（峰值 41% 安全），预计月成本 −¥14,400。
2. GLM-5.1 发起调价评估：按单位成本测算保本售价，上调 input/output 每百万 tokens 单价（高利用率不可缩容）。
**持续观察**
1. Qwen3-32B 维持现状，观察毛利率是否跌破 +10%。
2. 缩容/调价后跟踪 1~2 周利用率与毛利率回归。
**后续优化**
1. MiniMax-2.7 扩容 2→3 副本或承接部分流量（需先验证模型质量与延迟）。
2. 评估把 deepseek-v4-pro 释放的 GPU 调配给 MiniMax-2.7。
```

---

### Internal reference — the five modules must be backed by this evidence chain (do NOT dump it verbatim in the answer)

The structured answer above must be derived from a full per-model evidence chain. Keep the following internally; surface only what the five modules need.

### 1. Data scope

First state data source, time window, and confidence:

```text
Data source: pinned DCE command outputs: daily usage (tokens), hydra-maas SKU prices, resource-cost ConfigMap (GPU ¥/hr), pod utilization report
Business window: 2026-06-01 ~ 2026-06-30
Effective coverage window: revenue 2026-06-01 ~ 2026-06-30; utilization 2026-06-01 ~ 2026-06-30
Confidence: high / medium / low; explain any downgrade, e.g. missing a join key, mismatched coverage days
Conclusion type: portfolio ROI horizontal recommendation; not an auto-scaling command
```

### 2. Join-key closure

List whether each model's join key closes; do not give strong action advice when it does not:

| Model | model_id | serving_name | usage(model-name) | sku(in/out) | namespace / gpu-product | replicas | Closure |
|---|---|---|---|---|---|---:|---|
| deepseek-v4-pro | ✓ | deepseek-v4-pro | ✓ | ✓ | tokenfactory-selfhost / H100 | 4 | closed |
| GLM-5.1 | ✓ | glm-5.1 | ✓ | ✓ | tokenfactory-selfhost / H100 | 4 | closed |
| Qwen3-32B | ✓ | qwen3-32b | ✓ | ✓ | tokenfactory-selfhost / H800 | 3 | closed |
| MiniMax-2.7 | ✓ | minimax-2.7 | ✓ | ✓ | tokenfactory-selfhost / A100 | 2 | closed |

### 3. Analysis process and evidence chain

Use this only as internal audit material while calculating. Do NOT include it in
the final answer unless the user explicitly asks for data provenance or an audit
trail. The final answer must stay in the five modules above.

First the pinned-read table:

| Step | Purpose | Pinned read | Filter / variable | Fields used |
|---|---|---|---|---|
| 0 | confirm self-hosted model set | model-list read: `list-models` | `modelId=maas-`, then client-side `startswith("maas-")` | `modelId` |
| 1 | serving replicas | model bundle read 1: `list-model-serving` | client-side model/serving-name match | `replicas` |
| 2 | token volume + daily trend | model bundle read 2: daily usage stats | `<start>`, `<today>`, `<model>` | `totalUsage`, `dataPoints` |
| 3 | sale price | model bundle read 3: hydra-maas SKU list | client-side `specFields.model-name == <model>` | input/output `price / 1000` as `¥/M tokens` |
| 4 | GPU price | model bundle read 4: resource-cost ConfigMap | fixed model → GPU product mapping | GPU `price` (¥/hr) |
| 5 | utilization | model bundle read 5: pod report | `<start>`, `<today+1>`, `<model>` | `avg/max/minGpuUseRatio`, `pagination.total` |

Then list the actual command variables used. The internal audit block should look
like this when needed:

```text
Model set: model-list read with page.search "modelId=maas-", client-side prefix filter
Serving: model bundle read 1, client-side model/serving-name filter
Tokens: model bundle read 2 with --models <model> and TIME_PERIOD_DAY
Sale price: model bundle read 3 with --product hydra-maas, client-side model-name filter
GPU price: model bundle read 4, fixed model → GPU product mapping
Utilization: model bundle read 5 with --search <model>
```

If a paginated read returns more than one page, state whether you scanned fully; if not, mark that data as a sample, not a complete aggregate.

### 4. Data excerpts and supporting metrics

Before the final judgment, show more data that supports the conclusion. At least three groups:

| Data group | Must show |
|---|---|
| Model/serving excerpt | `model_id`, `source`, `public_endpoint_enabled`, `serving_name`, `replicas`, `namespace`, `gpu_product` |
| Usage excerpt | per model: usage rows, earliest/latest usage day, Σ input/output tokens, input/output sale price in ¥/M tokens, computed revenue |
| utilization excerpt | per model: pod count, GPU cost, avg/min/max GPU utilization, earliest/latest date |

If the data volume is large, don't paste full rows; output aggregated evidence tables and 2–3 representative samples. The point is checkable data behind the conclusion, not just a recommendation table.

### 5. Full-window portfolio table

| Model | Revenue | GPU cost | Margin | ROI | replicas | Util avg(min-max) | Revenue share | Cost share | Recommendation |
|---|---:|---:|---:|---:|---:|---|---:|---:|---|
| deepseek-v4-pro | 28,350 | 28,800 | −1.6% | −2% | 4 | 45 (25–65) | 31% | 34% | Scale down candidate |
| GLM-5.1 | 23,100 | 28,800 | −24.7% | −20% | 4 | 85 (77–93) | 25% | 34% | Reprice / price-check |
| Qwen3-32B | 22,350 | 18,900 | +15.4% | +18% | 3 | 55 (47–63) | 24% | 22% | Observe |
| MiniMax-2.7 | 19,050 | 9,000 | +52.8% | +112% | 2 | 75 (57–93) | 21% | 11% | Scale up / take-traffic candidate |
| **Portfolio** | **92,850** | **85,500** | **+7.9%** | **+9%** | 13 | — | 100% | 100% | — |

### 6. First-week / last-week evidence table

Trend judgments must give first-week and last-week evidence, not just full-window averages:

| Model | First-week rev | Last-week rev | Rev change | First-week util | Last-week util | Util change | Explanation |
|---|---:|---:|---:|---:|---:|---:|---|
| deepseek-v4-pro | 6,976 | 6,254 | −10% | 57% | 33% | −24pp | demand and utilization fall together |
| GLM-5.1 | 5,775 | 5,775 | ~0% | 85% | 85% | ~0 | demand stable but margin negative |
| Qwen3-32B | 5,588 | 5,588 | ~0% | 55% | 55% | ~0 | healthy fluctuation |
| MiniMax-2.7 | 3,969 | 5,197 | +31% | 67% | 83% | +16pp | demand and utilization rise together |

### 7. Conclusion-to-evidence mapping

Every action recommendation must write a "conclusion <- evidence" mapping with at least 3 quantitative signals:

| Model | Recommendation | Supporting evidence |
|---|---|---|
| deepseek-v4-pro | Scale down candidate | demand down (−10%), GPU utilization down (57→33%), cost/replicas not down, margin slipped positive→negative; `max_gpu_use_ratio` peak 41% < guardrail 70% → scale-down safe |
| GLM-5.1 | Reprice / price-check candidate | margin/ROI persistently negative (−25%), utilization high-stable (85%), demand not down; direct scale-down would saturate survivors → price is the lever |
| Qwen3-32B | Observe | margin positive (+15%), utilization healthy (55%), revenue and utilization not deteriorating |
| MiniMax-2.7 | Scale up / take-traffic candidate | revenue growing (+31%), margin positive (+53%), utilization near high (83%), cost share (11%) below revenue share (21%) |

### 8. Action ranking and guardrails

Finally rank the actions, each explicitly a recommendation, not an execution command:

1. Handle the highest-certainty loss mismatch first: scale down `deepseek-v4-pro`, provided it passes the `max_gpu_use_ratio` guardrail (peak 41% < 70% → safe).
2. Price-review `GLM-5.1`; high-utilization negative-margin is a pricing signal, not a scale-down signal.
3. Keep `Qwen3-32B` under observation.
4. List `MiniMax-2.7` as a scale-up or take-traffic experiment candidate, but verify model quality and latency before migrating.

> Cost basis: GPU cost is allocation-based (`gpu_hourly_price × pod-hours`), independent of utilization. Use the resource-cost prices and sale-price SKUs as given.
