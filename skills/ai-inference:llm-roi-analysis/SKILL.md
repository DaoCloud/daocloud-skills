---
name: ai-inference:llm-roi-analysis
description: >
  Use when a user asks why a self-hosted LLM's ROI is dropping, why its
  inference cost is rising, whether a model's serving template / resource pool
  is right-sized, or whether the deployment mix across several self-hosted
  models should change (scale down / scale up / reprice / shift traffic). Covers
  single-model cost-decline attribution and portfolio-level deployment-mix ROI.
  Also use for Chinese requests like 自部署模型 ROI 为什么下降、成本为什么涨、
  当前副本/资源池配置是否合理、要不要缩容/扩容/调价、DeepSeek-R1 和 GLM-4.5 的
  部署比例要不要调整、模型组合整体 ROI 怎么样、哪些模型该承接流量. Triggers on
  model names like DeepSeek-R1, GLM-4.5, Qwen and terms gross margin, GPU
  utilization, 毛利率, 利用率, 单位成本, 缩容护栏.
---

# LLM ROI / Cost Analysis (Self-Hosted Models)

Diagnose the ROI of **self-hosted MaaS models** by pulling real revenue, cost,
and utilization data through the `dce` CLI across three modules, then return a
**ranked list of possible causes + items to confirm** — not a single verdict.

**SCOPE:** Analysis and recommendation only. This skill does NOT create, scale,
reprice, or shift traffic. It never auto-executes any change.

**STANCE — differential diagnosis, not a verdict tree.** When several causes are
plausible, list them all with confidence + supporting/refuting evidence and hand
the judgment back to the user. A perfectly valid conclusion is **"normal
fluctuation, no action needed"** — do not invent a problem just to deliver one.

**COST IS THE MAIN LINE; SLA IS ONLY A GUARDRAIL.** Optimize against
cost/ROI. SLA enters only as a scale-down guardrail (a smaller replica count
must not saturate the survivors) — never as an optimization target.

## Self-Hosted Gate (check FIRST)

This skill applies **only to self-hosted models** — where the platform owns the
GPUs and sets the per-token price (cost = GPU node unit price × time ×
replicas). **Resold upstream API is pass-through** (fixed cost/token, no margin
to analyze) and is OUT OF SCOPE.

Before any analysis, confirm self-hosting with
`dce llm-studio modelmanagement get-model --model-id <model> -o json` and check
`source`/`publicEndpointEnabled`/GPU resource fields. If `source=EXTERNAL`, GPU
is empty, or the endpoint points at an external upstream, **stop** and tell the
user the model is a resale/pass-through — GPU pod cost will not close against it.

## Cross-Reference

Command discovery and execution go through the **`dce`** skill. Use
`dce commands show <path> --json` to confirm flags before running any command,
and `dce auth status` when a command requires auth.

## Which Playbook

| User question | Read |
|---------------|------|
| One self-hosted model's ROI is dropping / cost is rising; is its serving template & resource pool right-sized? (e.g. "DeepSeek-R1 ROI 下降：用户少了但没缩容") | `references/playbooks/llm-roi-cost-analysis.md` |
| Across several self-hosted models, should the deployment mix change — which to scale down / reprice / observe / scale up & take traffic? | `references/playbooks/llm-model-portfolio-roi-analysis.md` |

Start at the **portfolio** playbook for a horizontal compare across models, then
drill into the **single-model** playbook for any model that needs root-cause
attribution. Read the matching playbook in full before assembling commands — it
carries the data sources, three-repo join keys, signal math, and output template.

## Data Sources (three modules)

- `llm-studio` (hydra) — serving config: replicas, namespace, sku_id, model source.
- `billing-center` (leopard) — revenue (read `bills`) and per-token sale price.
- `operations-management` (gmagpie) — GPU cost (`gpu_fee`) and utilization (avg/max/min).

Token volume has no direct read API → **derive: token = revenue ÷ sale-price**
(input/output separately). This depends on a stable price; reverse-deriving
across a price change distorts the result.

## Data-Trust Caveat (read before concluding)

gmagpie unit prices (`price` / `gpu_price`) and the hydra cost-mock are
**manually entered**, not real billing. Every conclusion must be flagged "cost
based on entered unit price," and you should run `get-price` to sanity-check the
unit price before drawing a conclusion.

## Rules

- **No fabrication:** every number must come from a pulled command result or an
  explicitly stated assumption. Show the data-collection trace (which commands
  were run, what came back) before any conclusion.
- **Ranked hypotheses, not a single root cause:** word it as "likely / leans
  toward / evidence points to," never "the root cause must be X."
- **SLA guardrail before scale-down:** verify peak concurrency / k replicas ≤
  per-replica saturation threshold before recommending k replicas.
- **ROI ≠ model quality:** any "take traffic" / scale-up suggestion must be
  separately validated for model capability, latency, and error rate.
- **Don't widen scope:** stay on revenue/cost/utilization/capacity. Don't chase
  region baseUrl, gpu-types, or cluster observability — that's a different
  category and only adds noise.
