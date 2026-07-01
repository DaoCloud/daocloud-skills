---
name: ai-inference:token-capacity-planning
description: >
  Use when a user asks to plan AI inference token capacity, token budget,
  supply plans, SLA commitments, QoS targets, or cost boundaries. Covers token
  modeling, GPU resource mapping, phased rollout, QoS/SLA design, availability,
  latency, throughput, quota allocation, and pricing strategy. Also use for
  Chinese requests like 推理服务 SLA 怎么设计、Token 容量规划、年度 Token 预算、
  供给计划、成本边界、可用性/延迟/吞吐承诺、SLA 违约补偿. Example prompts include
  "18 billion Tokens next year", "how to split N tokens into supply/cost/SLA",
  "AI inference budget planning", and "token quota allocation".
---

# AI Inference Token Capacity Planning

Help enterprise customers plan AI inference capacity by converting an annual
Token target into a concrete supply plan, SLA commitments, and cost boundaries.

**SCOPE:** Analysis and recommendation only. This skill does NOT provision
resources or modify infrastructure.

**RELATED SKILL:** If the deployment mode is on-premise GPU clusters, use
`container-management:gpu-bottleneck-analysis` to verify actual cluster capacity after the
plan is drafted.

## Interaction Gate

Before any calculation, recommendation, or final structured report, check
whether the user has provided enough planning inputs.

**MUST ask clarifying questions first** when any of these required inputs are
missing:

- Total Tokens, or at least a target period and rough token volume
- Model Type, or a known model family/size to estimate from
- Deployment Mode (`API` or `on-premise GPU cluster`)
- Usage Pattern (`real-time` or `batch`)
- Business Criticality or target SLA tier

When required inputs are missing, the response is a clarification turn, not the
final plan:

- Do not use the final Output Format.
- Do not include `Conclusion`, `Key Metrics`, calculations, SLA commitments,
  cost tables, or capacity tables.
- Ask 1-3 focused questions only.
- Prefer compact multiple-choice questions when helpful.
- Mention optional defaults only after the required inputs are covered.

Only produce the final structured plan after the required inputs are available,
or when the user explicitly asks for a rough illustrative example based on
assumptions.

## Current State Integration

For on-premise GPU deployments, token/SLA planning must use current cluster
reality whenever possible. Do not rely only on theoretical token-to-GPU sizing
when the user has a DCE environment available.

Before the final plan for an on-premise GPU deployment:

1. Use `container-management:gpu-bottleneck-analysis` to inspect actual GPU
   pool capacity, allocation, utilization, VRAM pressure, current load, and
   likely bottlenecks.
2. If the user has not specified target clusters, discover GPU-enabled clusters
   through the GPU bottleneck skill and ask the user to confirm scope when
   multiple candidates exist.
3. If DCE auth is not established, ask the user to authenticate before claiming
   actual capacity has been verified.
4. If live GPU data cannot be obtained, still produce a planning estimate only
   after required planning inputs are available, and clearly mark GPU capacity
   validation as missing.

The final recommendation should combine planned token demand, SLA targets,
peak/burst assumptions, actual GPU pool headroom and bottleneck evidence, and
practical actions such as scale, throttle, route, reconfigure, quota allocation,
or phased rollout changes.

When current GPU data changes the recommendation, prefer the live-state finding
over generic sizing heuristics.

## When to Use

- "We need 1.8 billion Tokens next year. How do we plan supply, SLA, and cost?"
- "Token capacity planning for enterprise AI"
- "How to allocate token quota across business units?"
- "AI inference budget: tokens, GPUs, and cost boundaries"
- "Design SLA for LLM inference service"

## Workflow

### Step 1 — Gather Requirements

Follow the Interaction Gate before calculating or producing the final
structured plan. Do not skip directly to calculations when the request is only
"design an SLA", "plan token capacity", or similarly broad.

| Parameter | Question | Why It Matters |
|-----------|----------|----------------|
| **Total Tokens** | What is the annual Token target? (e.g., 1.8B) | Baseline for all calculations |
| **Input/Output Split** | What is the estimated input:output ratio? (default: 3:1) | Input and output have different costs and latency |
| **Model Type** | Which model(s) will be used? (e.g., GPT-4, Claude 3.5, Llama 3 70B) | Determines per-token cost, latency, and GPU requirements |
| **Deployment Mode** | API call (pay-per-token) or on-premise GPU cluster? | Determines cost structure and resource ownership |
| **GPU Cluster Scope** | For on-premise mode, which cluster(s) or GPU pool(s) should be checked? | Allows the plan to use current capacity instead of only theoretical sizing |
| **Usage Pattern** | Real-time (interactive) or batch (offline)? | Affects SLA design and peak-to-average ratio |
| **Growth Curve** | Linear growth, S-curve, or seasonal spikes? | Determines phased supply plan |
| **Peak Factor** | What is the expected peak-to-average traffic ratio? (default: 3x) | Determines headroom and burst capacity |
| **Business Criticality** | Is this business-critical (needs 99.9% uptime) or best-effort? | Affects SLA tier and cost |

#### 1.1 Input Completeness Gate

Required before calculation:

- Total Tokens, or at least a target period and rough token volume
- Model Type, or a known model family/size to estimate from
- Deployment Mode (`API` or `on-premise GPU cluster`)
- Usage Pattern (`real-time` or `batch`)
- Business Criticality or target SLA tier
- For on-premise GPU mode: target cluster(s), GPU pool(s), or permission to
  discover GPU-enabled clusters

If any required input is missing, stop at a clarification turn as described in
the Interaction Gate.

Optional defaults, only if the user does not know:

- Input/Output Split: default to `3:1`
- Growth Curve: default to `linear`
- Peak Factor: default to `3x`
- Buffer Factor: default to `1.3x`
- Currency: default to USD

If using optional defaults, state them clearly in the final answer. Do not use
defaults for the required inputs above unless the user explicitly asks for a
rough illustrative example.

**After gathering, summarize:**
"Customer needs X Tokens/year, Y% input, model Z, deployed as [API/on-prem],
usage pattern [real-time/batch], peak factor Wx, criticality [critical/normal]."

### Step 2 — Token Modeling

#### 2.1 Annual Token Breakdown

```
Total Tokens = Input Tokens + Output Tokens
Input Tokens  = Total * (input_ratio / (input_ratio + output_ratio))
Output Tokens = Total * (output_ratio / (input_ratio + output_ratio))
```

Default assumption if user does not specify: **input:output = 3:1**

Example for 1.8B Tokens:
- Input: 1.35B (75%)
- Output: 0.45B (25%)

#### 2.2 Monthly / Quarterly Distribution

Based on growth curve:

| Growth Pattern | Distribution Rule | Use Case |
|----------------|-------------------|----------|
| **Linear** | Equal per month (Total / 12) | Steady business growth |
| **S-Curve** | 10% → 20% → 30% → 40% per quarter | New product rollout |
| **Seasonal** | Apply seasonal multipliers (e.g., Q4 = 1.5x) | Retail, holiday campaigns |
| **Front-loaded** | 40% → 30% → 20% → 10% per quarter | Project-based, deadline-driven |

#### 2.3 Peak vs Average

```
Average Daily Tokens = Monthly Tokens / 30
Peak Daily Tokens    = Average Daily * Peak Factor
Peak Hourly Tokens   = Peak Daily / 24  (uniform) OR Peak Daily / Peak Hours
```

**After modeling, summarize:**
"Monthly average: X M Tokens, peak day: Y M Tokens, peak hour: Z K Tokens."

### Step 3 — Resource Mapping

#### 3.1 API Call Mode

If using commercial API (OpenAI, Anthropic, etc.):

| Model | Input Cost ($/M tokens) | Output Cost ($/M tokens) | Latency (TTFT) | Latency (TPOT) |
|-------|------------------------|--------------------------|----------------|----------------|
| GPT-4o | $2.50 | $10.00 | ~0.3s | ~0.01s |
| GPT-4o-mini | $0.15 | $0.60 | ~0.2s | ~0.005s |
| Claude 3.5 Sonnet | $3.00 | $15.00 | ~0.5s | ~0.02s |
| Claude 3 Haiku | $0.25 | $1.25 | ~0.2s | ~0.008s |

**Important:** Use the user's actual model prices if provided. The table above
is reference only and may be outdated.

#### 3.2 On-Premise GPU Mode

If using self-hosted GPU clusters:

```
Tokens per second per GPU = Model throughput (tokens/s)
Required GPUs (average)   = Peak Hourly Tokens / 3600 / Tokens_per_GPU
Required GPUs (with HA)   = Required GPUs * HA_factor (default: 1.5x)
```

Approximate throughput per GPU (A100 80GB, FP16):

| Model | Tokens/s per GPU | VRAM per GPU |
|-------|------------------|--------------|
| Llama 3 8B | ~800 | 16 GB |
| Llama 3 70B | ~150 | 80 GB |
| Qwen 72B | ~120 | 80 GB |
| Mixtral 8x7B | ~200 | 80 GB |

**For on-premise deployments, after calculating GPU demand, use
`container-management:gpu-bottleneck-analysis` to verify whether the existing GPU clusters
can meet the calculated demand.**

#### 3.3 Current GPU Reality Check

For on-premise GPU deployments, run the GPU bottleneck workflow before final
recommendations whenever DCE access is available.

Compare theoretical demand against live cluster evidence:

| Planning Output | Live GPU Evidence |
|-----------------|-------------------|
| Required GPUs | Total / allocated GPU capacity by pool and mode |
| Peak tokens/s | Current QPS and projected load |
| SLA latency target | Core utilization and scheduling headroom |
| Output/context size pressure | VRAM allocated/used headroom |
| HA/buffer factor | Multi-cluster routing and spare capacity |

If live GPU evidence shows the planned demand cannot fit, adjust the supply
plan and recommendations instead of presenting the original theoretical plan as
valid.

**After mapping, summarize:**
"API mode: estimated $X/month. On-prem mode: estimated Y GPUs needed."

### Step 4 — Supply Plan

#### 4.1 Phased Rollout

Based on the growth curve from Step 2, create a phased supply plan:

| Phase | Period | Token Target | Resource Allocation | Milestone |
|-------|--------|-------------|---------------------|-----------|
| Pilot | Month 1-2 | 5% of annual | Minimal / shared infra | Validate model choice |
| Ramp-up | Month 3-6 | 25% of annual | Scale to 50% capacity | Core feature launch |
| Scale | Month 7-10 | 50% of annual | Full capacity | Business-as-usual |
| Steady | Month 11-12 | 20% of annual | Maintain + buffer | Optimize cost |

#### 4.2 Buffer Strategy

Always include capacity buffer:

```
Planned Capacity = Predicted Demand * Buffer Factor
Buffer Factor:
  - Conservative: 1.5x (50% headroom)
  - Standard: 1.3x (30% headroom)
  - Aggressive: 1.15x (15% headroom)
```

**Recommendation:** Use 1.3x for most enterprise customers.

#### 4.3 Quota Allocation (Multi-Tenant)

If tokens are shared across teams/products:

| Tenant | Priority | Quota % | Burst Allowed? | Fallback |
|--------|----------|---------|----------------|----------|
| Team A (Core) | High | 50% | Yes (up to 2x) | Guaranteed |
| Team B (Growth) | Medium | 30% | Yes (up to 1.5x) | Best-effort |
| Team C (Experimental) | Low | 20% | No | Reject if full |

**After drafting supply plan, summarize:**
"Supply plan: Phase 1 (X Tokens), Phase 2 (Y Tokens), total capacity with 30% buffer: Z Tokens."

### Step 5 — SLA Design

Design SLA based on deployment mode and business criticality.

#### 5.1 Core SLA Metrics

| Metric | Business-Critical | Standard | Best-Effort |
|--------|-------------------|----------|-------------|
| **Availability** | 99.9% (8.76h downtime/year) | 99.5% (43.8h) | 99% (87.6h) |
| **TTFT (Time to First Token)** | < 500ms (p99) | < 1s (p99) | < 3s (p99) |
| **TPOT (Time per Output Token)** | < 20ms | < 50ms | < 100ms |
| **End-to-End Latency** | < 5s for 1K output | < 10s | < 30s |
| **Throughput (Tokens/s)** | As agreed per model | As agreed | Best effort |
| **Error Rate** | < 0.1% | < 1% | < 5% |
| **Retry SLA** | Auto-retry 3x, < 2s | Auto-retry 1x | Manual retry |

#### 5.2 Token Quota SLA

| Metric | Commitment |
|--------|------------|
| **Committed Tokens** | X per month (from supply plan) |
| **Burst Tokens** | Up to Y% over committed (e.g., 20%) |
| **Overage Rate** | $Z per M tokens over quota |
| **Underutilization** | Unused tokens: roll over / expire / refund? |

#### 5.3 Penalty and Remediation

| SLA Breach | Penalty | Remediation |
|------------|---------|-------------|
| Availability < target | Service credit: X% of monthly fee | Root cause analysis + fix plan within 48h |
| Latency > target | Service credit: Y% of monthly fee | Performance optimization or capacity addition |
| Token quota exceeded | Charge overage rate | Alert + auto-throttle or scale |

**After SLA design, summarize:**
"SLA tier: [Critical/Standard/Effort]. Key commitments: TTFT < X, availability Y%, burst up to Z%."

### Step 6 — Cost Boundary

#### 6.1 Total Cost of Ownership (TCO)

**API Mode:**
```
Monthly Cost = (Input Tokens * Input Price + Output Tokens * Output Price) / 1M
Annual Cost  = Monthly Cost * 12
```

**On-Premise Mode:**
```
Monthly Cost = GPU Rental Cost + Electricity + Network + Ops Headcount
GPU Rental   = Num GPUs * $/GPU/hour * 730 hours
```

#### 6.2 Cost Breakdown by Phase

| Phase | Tokens | Cost | Cumulative | Cost per M Tokens |
|-------|--------|------|------------|-------------------|
| Pilot | X | $Y | $Y | $Z |
| Ramp-up | X | $Y | $Y | $Z |
| Scale | X | $Y | $Y | $Z |
| Steady | X | $Y | $Y | $Z |

#### 6.3 Cost Optimization Levers

| Lever | Saving | Trade-off |
|-------|--------|-----------|
| Use smaller model | 50-80% | May reduce quality |
| Batch processing | 30-50% | Higher latency |
| Reserved capacity | 20-40% | Upfront commitment |
| Prompt caching | 10-30% | Requires repeated context |
| Output token limit | 10-20% | May truncate responses |

#### 6.4 Pricing to Customer

If the customer is internal (chargeback) or external (revenue):

```
Customer Price = TCO * (1 + Margin)
Margin:
  - Internal chargeback: 1.0x (at cost) to 1.2x
  - External SaaS: 2.0x to 3.0x
  - Enterprise deal: Custom, often volume discount
```

**After cost analysis, summarize:**
"Annual TCO: $X. Per-M-token cost: $Y. Recommended customer price: $Z/M tokens."

## Output Format

Present the final answer as structured Markdown. Do not include a step-by-step
reasoning transcript, skill loading details, API lookup details, pricing-table
lookup details, spreadsheet-style scratch work, or other internal process unless
the user explicitly asks for them. If data is incomplete, explicitly say that
the plan is based on currently available inputs and assumptions in the
conclusion.

This Output Format applies only to the final plan. It does not apply to
clarification turns required by the Interaction Gate.

Use these top-level sections in this order. Treat the template as the report
spine, not as a limit on evidence: preserve domain-specific tables and details
inside the matching sections when they are needed to support the conclusion.

# Conclusion

Use 1-2 sentences to state the current planning judgment, risk level
(`normal` / `watch` / `risk` / `critical`), the recommended SLA tier, and the
most important constraint across token supply, SLA, or cost.
For user-facing answers, localize the section title and risk labels to the
user's language.

## Key Metrics

Start with a Markdown summary table with 3-6 key indicators. Prefer these
fields when available: annual token target, monthly committed tokens, peak-hour
token demand, recommended SLA tier, required GPU count or API budget, estimated
annual TCO, unit cost per M tokens, burst allowance, and confidence.
For on-premise GPU plans, include at least one live GPU capacity or bottleneck
indicator when current DCE data is available.

| Metric | Current Value | Status |
|--------|---------------|--------|
| Annual token target | `<value>` | `<normal/watch/risk/critical>` |

Preserve the core capacity-planning evidence with supporting detail tables
under this section when data is available:

- Token supply plan: `Phase | Period | Token Target | Capacity with Buffer | Resource`
- SLA commitments: `Metric | Commitment | Tier | Risk/Notes`
- Cost boundaries: `Phase | Tokens | Cost | Unit Cost | Cumulative`
- Quota allocation: `Tenant | Priority | Quota | Burst Allowed | Fallback`
- On-prem resource mapping: `Model | Peak Tokens/s | Required GPUs | HA Factor | Confidence`
- Current GPU reality check: `Cluster/GPU Pool | Mode | Required GPUs | Available Headroom | Bottleneck | Recommendation`

## Main Findings

Use a numbered list with 2-3 findings. Each finding must explain the business,
SLA, capacity, or cost impact.
The findings must preserve the planning decision logic: token demand shape,
SLA tier, supply/resource mapping, cost boundary, and the most important
trade-off.
For on-premise GPU plans, include how the current GPU state affects the
recommendation.

## Cause Analysis

Analyze 2-3 causes around the main findings. For each cause, include:

Cause N: `<cause>`

Evidence: `<specific input, assumption, token model result, SLA target, cost calculation, or GPU mapping fact>`.

Impact: `<supply, SLA, cost, pricing, or delivery impact>`.
For on-premise GPU plans, evidence should include live GPU headroom or
bottleneck data when available.

## Recommended Actions

Group concrete actions by:

### Immediate

### Monitor

### Optimize Later

Actions should name the planning target, owner or responsible team when known,
and the concrete decision to make, such as quota allocation, SLA tier selection,
pricing validation, GPU capacity validation, or phased supply approval.

## Follow-up Questions

Provide 2-3 copyable follow-up questions in the user's language. They should
guide the user toward SLA refinement, cost validation, GPU capacity verification,
or an exportable stakeholder report.

## Rules

- **No fabrication:** All numbers must be calculated from user-provided inputs
  or explicit assumptions. State every assumption clearly.
- **Ask before calculating:** If required inputs from the Input Completeness
  Gate are missing, ask clarifying questions instead of producing a final plan.
  Only proceed with assumptions when the user explicitly asks for a rough
  illustrative estimate.
- **No final template during clarification:** When asking for missing required
  inputs, do not use the final report sections or provide partial calculations.
- **Conservative estimates:** When data is uncertain, present a range
  (optimistic / expected / pessimistic) rather than a single number.
- **Model prices:** Always ask user for current model pricing. If unavailable,
  use the reference table but flag it as "estimated, please verify."
- **GPU throughput:** Use the reference table as starting point, but actual
  throughput varies by batch size, quantization, and implementation. Flag as
  approximate.
- **Cross-reference GPU capacity:** For on-premise deployments, always suggest
  verifying calculated GPU demand against actual cluster capacity using
  `container-management:gpu-bottleneck-analysis`.
- **Use live GPU state when available:** For on-premise deployments, use
  `container-management:gpu-bottleneck-analysis` before final recommendations
  whenever DCE auth and target cluster scope are available. If live data is not
  available, state that actual GPU capacity validation is missing.
- **Currency:** Use the user's preferred currency. Default to USD if unspecified.
- **Conclusion first:** Put the conclusion first and avoid planning-process
  transcripts in the final answer.
- **Use tables for indicators:** Prefer tables for token, SLA, cost, and
  capacity indicators.
- **Concrete actions:** Recommended actions must be specific and executable.
