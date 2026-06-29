# Playbook: LLM ROI / Cost-Decline Attribution (Self-Hosted MaaS Models)

**适用 / When to use:** 用户问「某自部署模型（如 DeepSeek-R1）ROI 为什么下降 / 成本为什么涨 / 当前服务模板和资源池配置是否合理」。Use when the user asks why a self-hosted model (e.g. DeepSeek-R1) has declining ROI / rising cost, or whether its current serving template and resource-pool config are reasonable.

Stance: this playbook performs **differential diagnosis** — pull data, compute signals, give a **ranked list of possible causes + items to confirm**, and hand judgment back to the user. Do NOT assert "the root cause must be X". A perfectly valid conclusion is **"normal fluctuation, no action needed"** — do not invent a problem just to produce a conclusion.

Focus: analyze ONLY ROI (revenue / cost / utilization / capacity). Do NOT branch into infra details like region baseUrl, gpu-types, or cluster observability — that is a different category, unrelated to ROI attribution, and only adds noise.

Decision goal: **cost is the main line, SLA is only a guardrail alarm** — analyze cost/ROI as the primary axis; SLA only alarms when scaling down would breach it, never as an optimization target.

Applies only to **self-hosted models** (sale price/token self-set, cost = GPU node unit price × time × replicas). Resold upstream API is pass-through (fixed cost/token, no analysis room) — confirm the model is self-hosted before using this playbook.

## Data sources (dce commands, three modules)

Three modules: `llm-studio` (hydra, config), `billing-center` (leopard, revenue), `operations-management` (gmagpie, cost). Confirm flags with `dce commands show <path> --json` before executing.

| Need | Command (mind the group) |
|---|---|
| serving replicas/template/namespace/sku | `dce llm-studio modelservingmanagement list-model-serving --page.search <model> -o json`; detail `... get-model-serving --id <id> -o json` |
| revenue (**primary**, reads bills table) | `dce billing-center bill list-bills -o json` (filter by product + time window, sum `amountDue`) |
| revenue (secondary, aggregation, backend impl varies by deploy version) | `dce billing-center bill get-account-bill-aggregation --workspace-id <ws> --start-time <unixSec> --end-time <unixSec> -o json` |
| sale price/token | `dce billing-center product get-sku-price --id <skuId> -o json` |
| pod cost (cpu/mem/storage/gpu_fee) | `dce operations-management fee list-pods-fee --start <date> --end <date> -o json` (filter pod prefix) |
| pod utilization | `dce operations-management report list-pods -o json` |
| GPU utilization detail | `dce operations-management gpu get-gpu-metrics -o json` |
| resource unit price | `dce operations-management price get-price -o json`; GPU model price `... price get-gpu-models -o json` |

> Prefer `list-bills` for revenue (definitely reads the bills table); `get-account-bill-aggregation` backend impl varies by deploy version — use as a secondary cross-check.
>
> No standalone read API for token volume → **derive: token = revenue ÷ sale-price/token** (input/output separately). Depends on a stable price; reverse-deriving during a price change distorts it.

## Three-repo join key

```
hydra ModelServing(model_id=<model>)
  ├─ cluster + namespace + (pod = serving.name + "-*")  → gmagpie fee/report/gpu-metrics (cost/utilization)
  └─ sku_id / model_id                                  → leopard sku-price / bills (revenue/sale price)
```

## Calculation

```
unit cost    C/tok  = Σ(gpu_fee in window) / Σ(token in window)   # token = revenue ÷ sale price
gross margin margin = (sale/tok − C/tok) / sale/tok
ROI trend           = margin this period vs last (period-over-period)
```

## Diagnosis — differential (read signals first, then list possible causes; don't jump to a single verdict)

**Step 1: compute 4 signals** (tag each with "level" and "trend")

| Signal | How to compute | Source |
|---|---|---|
| A Demand | revenue/token series → level + trend (up/flat/down/jittery-no-trend) | billing-center |
| B Cost/capacity | replicas + gpu_fee series → flat / step / up-down | llm-studio + operations-management fee |
| C Utilization | avg_gpu_use_ratio → level (high>60% / mid / low<30%) + trend | operations-management report/gpu |
| D Gross margin | (revenue−cost)/revenue → level (positive/negative) + trend | derived from the three above |

**Step 2: signal pattern → possible cause (ranked by match, each with supporting/refuting evidence + to-confirm)**

> ⚠️ This is **differential diagnosis**, not a decision tree. When multiple causes coexist, list all with confidence and let the user/ops decide. Do NOT report only one "root cause = X".

| Signal pattern | Possible cause (hypothesis) | Supporting evidence | Refuting evidence / to-confirm |
|---|---|---|---|
| Demand↓ + cost flat + util↓ + margin↓ | **Capacity not reclaimed with demand ("not scaled down")** | utilization falls in step with demand, replicas unchanged | fails if demand is only a short blip → check the trend persists ≥2 weeks |
| Demand flat + util **high·stable(>60%)** + margin **negative·stable** | **Price inversion (sale price < unit cost)** | capacity fully used yet still loss → not a capacity problem | scaling down breaks SLA (util already high); to-confirm: `get-sku-price` vs unit cost |
| Demand flat + util **low·stable(<30%)** + margin negative | **Over-provisioned (never right-sized)** | utilization always low, no downtrend trigger → over-allocated from the start | distinct from "not scaled down": demand did **not** drop; to-confirm whether GPU choice/replicas were always excess |
| Demand flat + cost **step↑** + util drops with it + margin plunges | **Cost-side spike (added cards / upstream or unit-price hike)** | cost curve has a step, revenue unmoved | to-confirm: does the step align with a replica change or a `get-price` repricing |
| Margin **positive·stable** + util healthy + everything **no-trend/jitter only** | **Normal fluctuation, no action** | no sustained deterioration, margin positive | don't mistake noise for trend; if cautious, keep observing |

Reading guide: **utilization level** is the watershed — high util + loss → likely a pricing problem (scaling down is dangerous); low util + demand drop → likely not-scaled-down; low util + demand flat → likely over-provisioned.

## SLA guardrail (validate only, do not optimize) — single-replica concurrency saturation proxy

No real latency data, so do not use P99. Before recommending a scale-down to k replicas, validate:

```
peak concurrency / k  ≤  single-replica saturation threshold (default 0.8 × rated QPS)
if exceeded → alarm: "scaling to k overloads; minimum safe is k+1"
```

## Thresholds (defaults, tunable)

- Utilization "low": `avg_gpu_use_ratio < 30%`
- ROI "declining": gross margin drops > 10% period-over-period
- Single-replica saturation: `peak concurrency / replica > 0.8 × rated`

## Output template (must include: ① data-collection trace ② data table ③ ASCII charts ④ ranked hypotheses)

**Show evidence + process before conclusions** — first list "which commands were run, what data came back" (the thinking process), then the data table + ASCII charts, then the ranked possible causes. Don't just drop a one-line conclusion.

**① Data-collection trace (thinking process)** — list each command run + key returns so the user can audit the source:

```
Data collection (serving=<name>, window <start>~<end>):
0. dce llm-studio modelmanagement get-model --model-id <model> -o json   # confirm self-hosted first
   → source(BUILTIN/EXTERNAL), resources_requirements.gpu, public_endpoint
   ⚠️ if source=EXTERNAL or gpu empty or it points to an external upstream → the model is **resale pass-through**, this playbook does not apply;
     the GPU pod cost will not close against it — stop and warn "routing/cost-object mismatch, first verify whether traffic goes to the self-hosted instance".
1. dce llm-studio modelservingmanagement list-model-serving --page.search "name=<name>" -o json
   → model_id=<x>, replicas=<n>, namespace=<ns>, sku_id=<sku>, enable_metrics=true
2. dce billing-center bill list-bills --resource-id <res> --billing-time-start <start> --billing-time-end <end> -o json
   → <m> bills, revenue total <¥>, weekly <series>
3. dce billing-center product get-sku-price --id <sku> -o json   → sale price <¥>/unit
4. dce operations-management fee list-pods-fee --start <start> --end <end> --search <podpfx> -o json
   → <p> pods, gpuFee <¥> (constant/step), totalFee <¥>
5. dce operations-management report list-pods --search <podpfx> ... -o json
   → avgGpuUseRatio + **maxGpuUseRatio / minGpuUseRatio** (peak/trough, guardrail uses peak)
6. dce operations-management price get-price -o json   → unit price (manually entered, to verify)
```

> Utilization must take **avg + max + min**: avg for level/trend, **max (peak)** decides whether scale-down is safe (the SLA guardrail looks at peak, not mean), min for trough volatility.

**② Time-series data table** (by week/day, ≥4 rows; utilization column gives avg and min–max):

| Week | Revenue¥ | Cost¥ | Margin | Util% avg(min–max) |
|---|---|---|---|---|
| W1 | 4667 | 3731 | +20% | 56 (50–62) |
| … | … | … | … | … |

**③ ASCII charts** (≥ three: "revenue vs cost with breakeven line", "utilization with peak line", "margin with zero axis"):

```
[Revenue vs Cost] ¥/week   cost constant=3731 (4 replicas, not scaled down)
  W1 |████████████████| 4667  profit
  W2 |██████████████··| 4123  profit
  W3 |████████████····| 3577  loss
  W4 |██████████······| 3033  loss
      ·············↑breakeven 3731
[Utilization %] ▇=avg, [ ]=min~max range; ┊=peak (guardrail watches this)
  W1 ▇▇▇▇▇▇▇▇▇▇▇ 56 [50–62]            W3 ▇▇▇▇▇▇▇ 38 [32–44]
  W2 ▇▇▇▇▇▇▇▇▇ 47 [41–53]              W4 ▇▇▇▇▇ 29 [23–35]┊peak < guardrail 80
[Margin %] zero axis = breakeven
  W1 |▲▲▲▲ +20      W3 ▽| -4
  W2 |▲▲ +10        W4 ▽▽▽▽▽| -23
```

**④ Signals + ranked hypotheses + recommendation**:

```
Model <model> ROI analysis (window <start>~<end>):
- Signals: demand <level/trend> | cost <flat/step> | util <x>%<trend> | margin <x>%<trend>
- Possible causes (ranked by confidence, not final):
  1. <best-match hypothesis> (confidence high/med) — supporting: <evidence>; to-confirm: <action>
  2. <next hypothesis> (confidence med/low) — supporting: <evidence>; to-confirm: <action>
  (if signals healthy: conclusion = normal fluctuation, no action for now)
- Checks before acting: sale price `get-sku-price` vs unit cost; pass the SLA guardrail before scale-down; was the unit price mis-entered manually
- Candidate actions (depend on the confirmed cause): scale down / reprice / change GPU choice / keep observing
```

> Wording discipline: use "likely / leans toward / evidence points to", **not** "the root cause must be X". Give ranked hypotheses + items to verify, and hand judgment back to the user.

## Resource-pool extension checklist (off the main line, for reference)

GPU over-spec, replica-concurrency mismatch, oversized node_size, fragmentation, always-on vs elastic, SLA over-provision, queue contention.

## Data-trust prerequisite (must read)

gmagpie unit prices (`price`/`gpu_price`) and the hydra cost-mock are both **manually entered**, not real billing. Conclusions must be flagged "cost based on entered unit price". Before concluding, run `get-price` to confirm the unit price is reasonably filled in.
