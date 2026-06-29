# LLM Model Portfolio ROI Analysis (Horizontal Deployment Mix)

**适用 / When to use:** 用户问「DeepSeek-R1 和 GLM-4.5 等模型的部署比例要不要调整」「哪些模型该缩容/扩容/调价」「自部署模型组合整体 ROI 怎么样」。Use when the user asks whether the deployment mix across models like DeepSeek-R1 and GLM-4.5 should change, which models to scale down / scale up / reprice, or what the overall ROI of the self-hosted model portfolio looks like.

This playbook **only analyzes self-hosted models** and does **portfolio-level horizontal analysis**: put multiple self-hosted models in the same window, compare them, then output ranked actions. For single-model ROI-decline attribution, drill down with `llm-roi-cost-analysis.md`.

Core principles:

- Analysis and recommendation only — never auto-create, scale down, scale up, or shift traffic.
- Confirm each model is self-hosted first: the Hydra internal model-catalog field `hydra.model.source=BUILTIN` marks a platform built-in catalog entry; the API side does not always directly expose `source`, so also combine `publicEndpointEnabled=false`, the presence of a model deployment/serving, GPU resource fields, and cost coming from local GPU Pods and Gmagpie fees to decide.
- ROI cannot replace model-quality assessment. Any "take traffic" suggestion must additionally verify model capability, business effectiveness, context length, latency, and error rate.
- On missing data, state which part is missing and which conclusion it affects; do not fabricate mock data to force a conclusion.

## Example: signal profiles of the 4 action classes

A portfolio diagnosis usually lands in one of the following 4 action classes. The table below gives a **typical signal profile** per class (an example aid for reading, not a fixed checklist; classify real models by their actual signals):

| Model | Role | Expected action |
|---|---|---|
| `deepseek-r1-32b` | demand down, utilization down, margin turned negative | Scale down candidate |
| `glm-4.5` | high utilization, margin persistently negative | Reprice / price-check candidate |
| `qwen2.5-72b` | healthy utilization, positive margin, no clear deterioration | Observe |
| `qwen3-235b` | growing demand, positive margin, utilization near high | Scale up / take-traffic candidate |

## Data collection

Run the same command set for every model, keeping the same business window, e.g. `2026-06-01` to `2026-06-28`:

```bash
# 0. confirm self-hosted first
dce llm-studio modelmanagement get-model --model-id <model> -o json

# 1. serving config: replicas / namespace / sku_id / enable_metrics
dce llm-studio modelservingmanagement list-model-serving --page.search "name=<serving>" -o json

# 2. revenue: read bills by resource_id + time window
dce billing-center bill list-bills \
  --resource-id <resource_id> \
  --billing-time-start 2026-06-01 \
  --billing-time-end 2026-06-28 \
  --page 1 \
  --page-size 100 \
  -o json

# 3. sale price: read input/output SKU separately
dce billing-center product get-sku-price --id <sku_id> -o json

# 4. cost: filter cost by pod prefix
dce operations-management fee list-pods-fee \
  --start 2026-06-01 \
  --end 2026-06-29 \
  --search <pod_prefix> \
  --page 1 \
  --page-size 100 \
  -o json

# 5. utilization: read avg/max/min, max as the SLA scale-down guardrail
dce operations-management report list-pods \
  --start 2026-06-01 \
  --end 2026-06-29 \
  --search <pod_prefix> \
  --page 1 \
  --page-size 100 \
  -o json
```

To cross-check GPU detail, add:

```bash
dce operations-management gpu get-gpu-metrics -o json
```

## Time-window conventions

The output must state the business window and the **effective coverage window** of each data class:

- Business window: `2026-06-01` to `2026-06-28`, inclusive of `2026-06-28` by calendar day.
- Reconcile Leopard bills by `billingTime` / `billingCycle`, earliest and latest bill day.
- Query Gmagpie cost and utilization with `--start 2026-06-01 --end 2026-06-29` to cover June 1–28; if the actual API only returns through `2026-06-27`, you must write "effective coverage window is 2026-06-01 to 2026-06-27".
- Do not mix 27-day cost with 28-day revenue into one ROI. On mismatched coverage days, re-query to align first; if still not alignable, mark reduced confidence in the table.

Each key judgment must cite at least two time points or segments:

| Evidence | Requirement |
|---|---|
| First week | revenue, avg GPU utilization, margin for `2026-06-01` to `2026-06-07` |
| Last week | revenue, avg GPU utilization, margin for `2026-06-22` to `2026-06-28` |
| Full window | full-window revenue, GPU cost, ROI, avg/min/max GPU utilization |

If the live API only returns aggregates, still note "API returns aggregate only; first/last week from bill details". Do not give only the final ROI table while omitting time-point evidence.

## Join key

Build one portfolio-table row per model:

| Field | Source |
|---|---|
| `model_id` / `model_name` | Hydra model / serving |
| `serving_name` | Hydra `ai_model_serving.name` |
| `resource_id` | Leopard bills |
| `sku_id` | Hydra serving + Leopard skus |
| `namespace` / `pod_prefix` | Hydra serving + Gmagpie pods |
| `replicas` | Hydra serving |
| `revenue` | Leopard `amountDue` sum |
| `gpu_cost` | Gmagpie `gpu_fee` sum |
| `avg_gpu_use_ratio` / `max_gpu_use_ratio` / `min_gpu_use_ratio` | Gmagpie report / gpu |

If a model misses a join key, do not force-fit. Output "this model's data chain does not close" and lower the portfolio recommendation confidence.

## Portfolio metrics

For each model compute:

```text
revenue = sum(amountDue)
gpu_cost = sum(gpu_fee)
gross_margin = (revenue - gpu_cost) / revenue
roi = (revenue - gpu_cost) / gpu_cost
revenue_share = model_revenue / portfolio_revenue
cost_share = model_gpu_cost / portfolio_gpu_cost
deployment_share = model_replicas / portfolio_replicas
share_gap = cost_share - revenue_share
```

Trend metrics, at least first vs last window:

```text
demand_trend = revenue_last_week - revenue_first_week
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
- `max_gpu_use_ratio` stays under the SLA guardrail after scale-down.

Demo expectation: `deepseek-r1-32b`.

### Reprice / price-check candidate

Prefer repricing or a price-check (not direct scale-down) when:

- demand stable;
- utilization high and stable;
- margin persistently negative;
- unit cost above current sale price.

Demo expectation: `glm-4.5`.

### Observe

Observe when:

- margin positive;
- utilization healthy;
- demand not persistently deteriorating;
- no clear cost step or SLA risk.

Demo expectation: `qwen2.5-72b`.

### Scale up / take-traffic candidate

Candidate for scale-up or a controlled traffic-migration experiment when:

- demand growing;
- margin positive;
- utilization near high but not overloaded;
- SLA headroom present;
- model quality, business effectiveness, and workload compatibility verified outside the cost analysis.

Demo expectation: `qwen3-235b`.

## Output template

The output must contain the following fixed sections. The user's prompt need not repeat these format requirements; whenever the user asks about portfolio ROI / deployment-mix adjustment, answer with this template.

### 1. Data scope

First state data source, time window, and confidence:

```text
Data source: live dce API
Business window: 2026-06-01 ~ 2026-06-28
Effective coverage window: revenue 2026-06-01 ~ 2026-06-28; Gmagpie 2026-06-01 ~ 2026-06-28
Confidence: high / medium / low; explain any downgrade, e.g. missing a join key, API returns aggregate only, mismatched coverage days
Conclusion type: portfolio ROI horizontal recommendation; not an auto-scaling command
```

### 2. Join-key closure

List whether each model's join key closes; do not give strong action advice when it does not:

| Model | model_id | serving_name | resource_id | sku_id | namespace / pod_prefix | replicas | Closure |
|---|---|---|---|---|---|---:|---|
| deepseek-r1-32b | ... | ... | ... | ... | ... | ... | closed / missing field |
| glm-4.5 | ... | ... | ... | ... | ... | ... | closed / missing field |
| qwen2.5-72b | ... | ... | ... | ... | ... | ... | closed / missing field |
| qwen3-235b | ... | ... | ... | ... | ... | ... | closed / missing field |

### 3. Analysis process and evidence chain

The output must show an auditable analysis process and evidence chain: which steps ran, which APIs executed, what data was queried, how many rows each API returned, and which fields fed the computation. Do not output a hidden chain-of-thought; output steps, commands, filters, and data summaries the user can re-check.

First the step table:

| Step | Purpose | API / command | Key filter | Return count / pagination | Fields used |
|---|---|---|---|---:|---|
| 1 | confirm model-catalog attrs | `dce llm-studio modelmanagement get-model` | `modelId=<model>` | ... | `publicEndpointEnabled`, `modelDeploymentsExists`, `providerId` |
| 2 | read serving config | `dce llm-studio modelservingmanagement list-model-serving` | `name=<serving>` | ... | `replicas`, `skuId`, `namespace`, `enableMetrics` |
| 3 | read revenue | `dce billing-center bill list-bills` | `resourceId=<resource_id>`, `billingTimeStart/End` | ... | `amountDue`, `billingCycle`, `skuId`, `billingItem` |
| 4 | read GPU cost | `dce operations-management fee list-pods-fee` | `search=<pod_prefix>`, `start/end` | ... | `gpuFee`, `pod`, `namespace`, `workspace` |
| 5 | read GPU utilization | `dce operations-management report list-pods` | `search=<pod_prefix>`, `start/end` | ... | `avgGpuUseRatio`, `maxGpuUseRatio`, `minGpuUseRatio` |
| 6 | price-check | `dce billing-center product get-sku-price` | `id=<sku_id>` | ... | `price`, `specId`, `productName` |

Then list the actual `dce` commands or key filters used. The report must include an "actual collection commands or filters" block, at least:

```text
Model source: dce llm-studio modelmanagement get-model --model-id <model>
Serving config: dce llm-studio modelservingmanagement list-model-serving --page.search "name=<serving>"
Revenue: dce billing-center bill list-bills --resource-id <resource_id> --billing-time-start <start> --billing-time-end <end>
Cost: dce operations-management fee list-pods-fee --start <start> --end <next_day_after_end> --search <pod_prefix>
Utilization: dce operations-management report list-pods --start <start> --end <next_day_after_end> --search <pod_prefix>
```

Do not just write "from live API"; the reader must be able to reproduce the filter scope. If a paginated command returns `total > pageSize`, state whether you paged through fully; if not, mark that data as a sample, not a complete aggregate.

### 4. Data excerpts and supporting metrics

Before the final judgment, show more data that supports the conclusion. At least three groups:

| Data group | Must show |
|---|---|
| Model/serving excerpt | `model_id`, `publicEndpointEnabled`, `modelDeploymentsExists`, `serving_name`, `replicas`, `sku_id`, `namespace`, `pod_prefix`; if validated via DB, add `hydra.model.source` |
| Bill excerpt | per model: bill count, earliest/latest bill day, input/output SKU, input/output amount, total revenue |
| Gmagpie excerpt | per model: pod count, pod-day count, GPU cost, avg/min/max GPU utilization, earliest/latest cost date |

If the data volume is large, don't paste full JSON; output aggregated evidence tables and 2–3 representative samples. The point is checkable data behind the conclusion, not just a recommendation table.

### 5. Full-window portfolio table

| Model | Revenue | GPU cost | Margin | ROI | replicas | Util avg(min-max) | Revenue share | Cost share | Recommendation |
|---|---:|---:|---:|---:|---:|---|---:|---:|---|
| deepseek-r1-32b | ... | ... | ... | ... | 4 | ... | ... | ... | Scale down candidate |
| glm-4.5 | ... | ... | ... | ... | 4 | ... | ... | ... | Reprice / price-check |
| qwen2.5-72b | ... | ... | ... | ... | 3 | ... | ... | ... | Observe |
| qwen3-235b | ... | ... | ... | ... | 2 | ... | ... | ... | Scale up / take-traffic candidate |

### 6. First-week / last-week evidence table

Trend judgments must give first-week and last-week evidence, not just full-window averages:

| Model | First-week revenue | Last-week revenue | Revenue change | First-week GPU util | Last-week GPU util | Util change | Explanation |
|---|---:|---:|---:|---:|---:|---:|---|
| deepseek-r1-32b | ... | ... | ... | ... | ... | ... | demand and utilization fall together |
| glm-4.5 | ... | ... | ... | ... | ... | ... | demand stable but margin negative |
| qwen2.5-72b | ... | ... | ... | ... | ... | ... | healthy fluctuation |
| qwen3-235b | ... | ... | ... | ... | ... | ... | demand and utilization rise together |

### 7. Conclusion-to-evidence mapping

Every action recommendation must write a "conclusion <- evidence" mapping with at least 3 quantitative signals:

| Model | Recommendation | Supporting evidence |
|---|---|---|
| deepseek-r1-32b | Scale down candidate | revenue down, GPU utilization down, cost/replicas not down, `maxGpuUseRatio` usable as scale-down guardrail |
| glm-4.5 | Reprice / price-check candidate | margin/ROI negative, utilization high-stable, demand not clearly down, direct scale-down may hurt SLA |
| qwen2.5-72b | Observe | margin positive, utilization healthy, revenue and utilization not deteriorating |
| qwen3-235b | Scale up / take-traffic candidate | revenue growing, margin positive, utilization near high, cost share below revenue share |

### 8. Action ranking and guardrails

Finally rank the actions, each explicitly a recommendation, not an execution command:

1. Handle the highest-certainty loss mismatch first: scale down `deepseek-r1-32b`, provided it passes the `max_gpu_use_ratio` guardrail.
2. Price-review `glm-4.5`; high-utilization negative-margin is not a scale-down signal.
3. Keep `qwen2.5-72b` under observation.
4. List `qwen3-235b` as a scale-up or take-traffic experiment candidate, but verify model quality and SLA before migrating.
