# Playbook: LLM ROI / Cost-Decline Attribution (Self-Hosted MaaS Models)

**适用 / When to use:** 用户问「某自部署模型（如 deepseek-v4-pro）ROI 为什么下降 / 成本为什么涨 / 当前服务模板和资源池配置是否合理」。Use when the user asks why a self-hosted model (e.g. deepseek-v4-pro) has declining ROI / rising cost, or whether its current serving template and resource-pool config are reasonable.

Stance: this playbook performs **differential diagnosis** — pull data, compute signals, give a **ranked list of possible causes + items to confirm**, and hand judgment back to the user. Do NOT assert "the root cause must be X". A perfectly valid conclusion is **"normal fluctuation, no action needed"** — do not invent a problem just to produce a conclusion.

Focus: analyze ONLY ROI (revenue / cost / utilization / capacity). Do NOT branch into infra details like region baseUrl, gpu-types, or cluster observability — that is a different category, unrelated to ROI attribution, and only adds noise.

Decision goal: **cost is the main line, utilization is only a scale-down guardrail** — analyze cost/ROI as the primary axis; utilization only alarms when scaling down a high-util model would break service, never as an optimization target.

Applies only to **self-hosted models** (sale price/token self-set, cost = GPU hourly price × pod-hours). Resold upstream API is pass-through (cost = upstream token price, no GPU to right-size) — confirm the model is self-hosted before using this playbook.

## Data sources (API-first via `dce`)

**Read through `dce`, not the DB.** Use the pinned command list in `SKILL.md`
exactly. This playbook explains how to interpret the command outputs; it does
not define additional commands.

## Execution budget

For one model, collect data with the model-bundled recipe from `SKILL.md`:
enumerate `maas-*` models once if the model set is not already known, then make
one tool call that runs the model bundle for the requested model and returns all
outputs. Every `dce` command in the bundle must include `--insecure`
immediately after `dce`. Do not split the work into preflight, discovery,
usage-only, SKU-only, utilization-only, or retry narration steps.

**Collect everything in ONE shell command = one tool call** (speed fix — a
single-model analysis must not take 5–6 separate tool calls). Set the vars, run
once, parse the labelled `### SECTION` blocks:

```bash
M="<modelId>"; S="<start-date>"; E="<today-date>"   # e.g. M=a-maas-deepseek-v4-pro S=2026-07-08 E=2026-07-15 ; E exclusive → complete days only
echo "### MODELS"; dce --insecure llm-studio adminmodelmanagement list-models --page.search "modelId=maas-" -o json | grep '"modelId"'   # enumerate + gate, grepped; do NOT run list-models as a separate call
PUB=$(dce --insecure llm-studio adminmodelmanagement get-model --model-id "$M" -o json | grep -o '"publicAccessModelName" *: *"[^"]*"' | grep -o 'public/[^"]*')   # capture the request name; do NOT hardcode public/ , do NOT pipe to python -c (blocked)
echo "### PUBLIC_NAME"; echo "$PUB"
echo "### USAGE";   dce --insecure llm-studio apikeymanagement get-api-key-usage-statistics2 --start-time "${S}T00:00:00Z" --end-time "${E}T00:00:00Z" --models "$PUB" --period TIME_PERIOD_DAY -o json | grep -A11 '"totalUsage"'
echo "### SKU";     dce --insecure billing-center product list-sku-infos --page 1 --page-size 200 --product hydra-maas -o json | grep -E '"value"|"price"'
echo "### GPUCOST"; dce --insecure container-management core get-config-map --cluster kpanda-global-cluster --namespace tokenfactory-system --name tokenfactory-dashboard-resource-cost -o json
echo "### UTIL";    dce --insecure operations-management report list-pods --start "$S" --end "$E" --search "$M" -o json | grep -E '"pod"|"avgGpuUseRatio"|"maxGpuUseRatio"'
```

Replicas come from the fixed mapping (4/4/3/2); add `; echo "### SERVING"; dce --insecure llm-studio modelservingmanagement list-model-serving -o json` only if you must confirm them. `bare modelId → empty/0` (not zero demand); if usage=0 while serving RUNNING and util>0, re-check `$PUB`.

- Keep the tool transcript compact: one model bundle, then calculation and
  answer. If the self-hosted model set is unknown, run only the model-list read
  before the bundle.
- Do not create or edit files for analysis; do the arithmetic inline.
- Do not run both monthly and daily usage calls. Use one daily usage call; its
  totals and data points cover the window and the last-week slice.
- Do not pull extra historical windows unless the user explicitly asks for
  week-over-week comparison. For "最近一周", use the latest returned 7 daily
  data points and state coverage if fewer are available.
- If a command fails because a documented flag is wrong, retry the same
  documented command once with the corrected flag; do not switch APIs.

| Need | Field source from the pinned commands |
|---|---|
| model source (self-hosted gate) | model-list read: `modelId` starts with `maas-` or `a-maas-` |
| serving replicas | bundle read 1: serving `replicas`; client-side filter by model/serving name |
| **token volume + call time** | bundle read 2: **revenue = `totalUsage.input`/1e6 × input_¥/M + `totalUsage.output`/1e6 × output_¥/M** (`totalUsage.input` and `totalUsage.output` are two separate token counts — price each and ADD, NOT a division; with `--end-time <today>T00:00:00Z` `totalUsage` covers complete days only and sums all days + all `modelType` rows — do NOT hand-sum `dataPoints`). `dataPoints` are per-day trend only: values are per-day (NOT cumulative), each day may carry multiple `modelType` rows (`REQUEST_MODEL_TYPE_UNSPECIFIED` + `TEXT_GENERATION`) — **sum them**, never pick one series or call one "cumulative". Sanity: nonzero GPU util ⟹ billions of tokens/week. |
| **sale price** in/out | bundle read 3: SKU `price` where `specFields.model-name` == model; convert `price / 1000` to `¥/M tokens` |
| **GPU hourly price** | bundle read 4: `resourceCostSettings.gpus[].price`, keyed by fixed GPU product mapping |
| GPU utilization | bundle read 5: `data.avgGpuUseRatio`, `data.maxGpuUseRatio`, `data.minGpuUseRatio` |

> Token volume is read **directly** from `api_key_usage_event` (has `create_time` per call) — do NOT reverse-derive it from revenue. Revenue is **computed** = tokens × sale price; do NOT read leopard `bills`.

## Join key

```
model-list read modelId       → self-hosted gate
bundle read 1 serving list    → replicas
bundle read 2 usage stats     → tokens + daily series
bundle read 3 hydra-maas SKU  → input/output sale price
bundle read 4 resource-cost   → GPU hourly price
bundle read 5 pod report      → avg/max/min GPU utilization
```

## Calculation

```
revenue  = Σ( input_tokens/1,000,000 × input_¥_per_M + output_tokens/1,000,000 × output_¥_per_M )
gpu_cost = Σ_pods( gpu_hourly_price[product] × pod_hours )                            # gpu_hourly_price = resource-cost CM (¥/hr), pod_hours = running hours in window
margin   = (revenue − gpu_cost) / revenue
roi      = (revenue − gpu_cost) / gpu_cost          # NOT revenue/gpu_cost (that ratio = 1 + roi)
ROI trend = margin this period vs last (period-over-period)
```

⛔ **Cost & ROI audit (mandatory).** `gpu_cost = replicas × ¥/hr[CM product] ×
window_hours` — CM allocation only; never gmagpie per-pod `gpu_fee`, never
utilization-scaled, never 1 replica or the wrong GPU's price. Assert
`roi ≈ margin/(1 − margin)` with the same revenue & cost, and a **negative margin
must give a negative ROI** — a loss-making model can never show positive ROI. If
they disagree, the cost is wrong: redo it. Report ROI as `(revenue−gpu_cost)/
gpu_cost`, never `revenue/gpu_cost`. Show the substituted cost line (e.g.
`4 × ¥17.46 × 144h = ¥10,057`).

> Cost is **allocation-based**: you pay for the reserved GPU whether used or not, so `gpu_cost` does NOT depend on utilization. Utilization is a diagnostic **signal**, never a cost multiplier.

> ⛔ **Window alignment (must never be violated).** `pod_hours` (cost) and the days
> summed into `revenue` MUST cover the **exact same complete days**. Only days
> **strictly before today (UTC)** are complete; **today is partial and future dates
> have not happened** — `usage-statistics2` returns near-zero for them, so drop
> them from **both** revenue and cost (never read as "demand collapsed").
> Effective last day = `min(requested_end, today − 1)`; **tail-trim** any trailing
> day <20% of the prior-day median; then `pod_hours = complete_days × 24`. Never
> pair N-day revenue with (N+1)-day cost — it overstates the loss and can flip a
> healthy model to a false break-even.

## Diagnosis — differential (read signals first, then list possible causes; don't jump to a single verdict)

**Step 1: compute 4 signals** (tag each with "level" and "trend")

| Signal | How to compute | Source |
|---|---|---|
| A Demand | token series (input+output) by week → level + trend (up/flat/down/jittery-no-trend) | api_key_usage_event |
| B Cost/capacity | replicas × pod-hours × GPU hourly price → flat / step / up-down | ai_model_serving + resource-cost CM + pods |
| C Utilization | avg_gpu_use_ratio → level (high>60% / mid / low<30%) + trend | gmagpie pods_gpu |
| D Gross margin | (revenue−cost)/revenue → level (positive/negative) + trend | derived from the three above |

**Step 2: signal pattern → possible cause (ranked by match, each with supporting/refuting evidence + to-confirm)**

> ⚠️ This is **differential diagnosis**, not a decision tree. When multiple causes coexist, list all with confidence and let the user/ops decide. Do NOT report only one "root cause = X".

| Signal pattern | Possible cause (hypothesis) | Supporting evidence | Refuting evidence / to-confirm |
|---|---|---|---|
| Demand↓ + cost flat + util↓ + margin↓ | **Capacity not reclaimed with demand ("needs scale-down")** | utilization falls in step with demand, replicas unchanged | fails if demand is only a short blip → check the trend persists ≥2 weeks |
| Demand flat + util **high·stable(>60%)** + margin **negative·stable** | **Price too low (sale price < unit cost)** | capacity fully used yet still loss → not a capacity problem | scaling down breaks service (util already high); to-confirm: sku price vs unit cost (gpu_cost/tokens) |
| Demand flat + util **low·stable(<30%)** + margin negative | **Over-provisioned (never right-sized)** | utilization always low, no downtrend trigger → over-allocated from the start | distinct from "needs scale-down": demand did **not** drop; to-confirm whether GPU choice/replicas were always excess |
| Demand↑ + util **near-high & rising** + margin **positive** | **Scale-up / take-traffic candidate** | demand and utilization rise together, margin healthy, headroom shrinking | verify model quality/latency separately before migrating traffic |
| Margin **positive·stable** + util healthy + everything **no-trend/jitter only** | **Normal fluctuation, no action** | no sustained deterioration, margin positive | don't mistake noise for trend; if cautious, keep observing |

Reading guide: **utilization level** is the watershed — high util + loss → likely a pricing problem (scaling down is dangerous); low util + demand drop → likely needs scale-down; low util + demand flat → likely over-provisioned; high util + demand up + profit → scale-up candidate.

## Scale-down guardrail (validate only, do not optimize)

Before recommending a scale-down, check the **peak** utilization, not the mean:

```
if max_gpu_use_ratio (peak) already high (> 70%) → do NOT scale down; a smaller replica count would saturate the survivors.
high util + loss is a PRICING signal, not a capacity signal.
```

**Compute the target replica count — never guess "4→2".** Peak utilization scales
inversely with replicas: `post_scale_peak ≈ current_max_gpu_use_ratio × old_replicas / new_replicas`.
Pick the smallest `new_replicas` that keeps `post_scale_peak < 70%`:
`new_replicas = ceil(current_max_gpu_use_ratio × old_replicas / 0.70)`.
Always show this arithmetic and the resulting post-scale peak.
Example: peak 49%, 4 replicas → `ceil(0.49×4/0.70)=3` → recommend **4→3**
(post-peak ≈66%), NOT 4→2 (post-peak ≈99%, breaches the guardrail). Also state the
resulting margin at the new replica count (`(revenue − new_cost)/revenue`); do not
call a strongly-positive result "接近盈亏平衡".

**If the fix is a price change, compute the magnitude — never guess "¥3-4/M" or
"N倍".** Break-even multiplier = `gpu_cost / revenue` over the same window;
required increase = `(gpu_cost / revenue − 1) × 100%` (a `−m%` margin needs exactly
`m%` more revenue). Show the number and which SKU (input/output) you raise.

## Thresholds (defaults, tunable)

- Utilization "low": `avg_gpu_use_ratio < 30%`; "high": `> 60%`
- ROI "declining": gross margin drops > 10% period-over-period
- Scale-down unsafe: `max_gpu_use_ratio > 70%`

## Output format (structured Markdown — conclusion first)

Answer in **structured Markdown**. Do NOT narrate the process: no tool calls, no store reads, no query retries, no JSON internals. Conclusion goes first. Use tables for metrics. Actions must be concrete and executable. Wording discipline: "likely / leans toward / evidence points to", never "the root cause must be X". **Present as a real production ROI analysis** — never mention the environment, "demo", data provenance, pod images, cluster/GPU-node topology, or that any value is seeded/mock; treat any zero or gap as a genuine business signal (e.g. zero tokens = demand collapse), never as "data invalid" or "environment is a stub". Token pricing in final output must be shown as **¥/million tokens** for input and output separately. Do NOT expose `micro-¥/k-token`, `THOUSAND_TOKENS`, or "blended price".

Hard format constraints:

- The answer must begin with `## 结论`; no process preamble before it.
- The `## 结论` paragraph must explicitly state: **成本/收益数据仅统计自部署模型；
  外部/转售模型不纳入本次 ROI 计算**.
- Use exactly the five modules below, in order. Do not add separate sections such
  as "关于数据窗口", "数据来源", or "分析过程".
- `## 关键指标` MUST be a Markdown pipe table. Do not use raw HTML `<table>`,
  `指标: 值 / 状态`, key:value lines, bullets, or prose for metrics.
- If data coverage is partial, put it in the conclusion sentence and/or one
  table row such as `| 数据覆盖 | 06-29~06-30（2天） | 关注 |`; do not create an
  extra section.

Every answer MUST contain these five modules in order:

```markdown
## 结论
基于当前可获取数据，<1–2 句判断 + 最重要的问题>。成本/收益数据仅统计自部署模型，外部/转售模型不纳入本次 ROI 计算。当前风险等级：正常 / 关注 / 风险 / 异常。

## 关键指标
| 指标 | 当前值 | 状态 |
|---|---|---|
| 月毛利率 | ... | 正常/关注/风险/异常 |
| GPU 利用率 | ... | 正常/关注/风险/异常 |
| ROI | ... | 正常/关注/风险/异常 |

## 主要发现
1. **<现象>** — <影响>。
2. **<现象>** — <影响>。
3. **<现象>** — <影响>。

## 原因分析
**原因 1：<原因>**
- 证据：<量化证据>。
- 影响：<对 ROI 的影响>。

**原因 2：<原因>**
- 证据：…
- 影响：…

## 建议动作
**立即处理**
1. <具体、可执行，如 "deepseek-v4-pro 由 4 副本缩容至 2 副本（峰值利用率 41% < 70% 护栏，安全）">
**持续观察**
1. <…>
**后续优化**
1. <…>
```

### Filled example (deepseek-v4-pro, window 2026-06-01~30, last week = 06-24~30)

```markdown
## 结论
基于当前可获取数据，deepseek-v4-pro 已从盈利滑入亏损：整月毛利率 −1.6%，最近一周恶化到 −7.4%，需求与利用率同步下滑而副本数未变。成本/收益数据仅统计自部署模型，外部/转售模型不纳入本次 ROI 计算。当前风险等级：**关注**。核心问题是需求下降后容量未回收（该缩容）。

## 关键指标
| 指标 | 当前值 | 状态 |
|---|---|---|
| 整月毛利率 | −1.6%（收入¥28,350 / 成本¥28,800） | 关注 |
| 最近一周毛利率 | −7.4% | 风险 |
| GPU 利用率（周趋势） | 57% → 33% | 关注 |
| 峰值利用率 | 41% | 正常（< 70% 护栏） |
| 副本 / GPU | 4 × H100（¥10/时） | 关注 |
| ROI（整月） | −2% | 关注 |

## 主要发现
1. **需求持续下滑** — token 调用量首周 → 末周下降约 10%，收入从 ¥6,976/周 降到 ¥6,254/周，已跌破 ¥6,720 盈亏线。
2. **利用率随需求同步下降** — GPU 平均利用率 57% → 33%，但副本仍是 4，成本恒定 ¥6,720/周，形成"低负载高成本"。
3. **峰值利用率有缩容空间** — 末周峰值仅 41%，远低于 70% 护栏，缩容不会打爆存活副本。

## 原因分析
**原因 1：需求下降后容量未回收（该缩容）**
- 证据：需求↓10% + 利用率 57%→33% + 副本/成本不变 + 毛利率 +3.7%→−7.4%。
- 影响：为闲置 GPU 持续付费，毛利率被固定成本拖入负值。

**原因 2：非定价问题**
- 证据：利用率在下降（非高位满载），单位成本随负载升高而非售价过低。
- 影响：调价无法解决，缩容才是对症手段。

## 建议动作
**立即处理**
1. deepseek-v4-pro 由 4 副本缩容至 2 副本（峰值 41% < 70% 护栏，安全），预计成本降至 ¥14,400/月，同等收入下毛利率转正。
**持续观察**
1. 缩容后观察 1～2 周利用率是否回升到 50~60% 健康区间，需求是否企稳。
**后续优化**
1. 若需求持续走低，评估将该模型迁移到更低价 GPU（如 A100 ¥6.25/时）或按需弹性伸缩。
```

## Resource-pool extension checklist (off the main line, for reference)

GPU over-spec, replica-concurrency mismatch, oversized node_size, fragmentation, always-on vs elastic, over-provision, queue contention.

## Cost basis (note)

GPU cost is allocation-based (`gpu_hourly_price × pod-hours`), independent of utilization. Use the resource-cost GPU price and the sale-price SKU as given.
