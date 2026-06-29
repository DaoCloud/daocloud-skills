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

## When to Use

- "We need 1.8 billion Tokens next year. How do we plan supply, SLA, and cost?"
- "Token capacity planning for enterprise AI"
- "How to allocate token quota across business units?"
- "AI inference budget: tokens, GPUs, and cost boundaries"
- "Design SLA for LLM inference service"

## Workflow

### Step 1 — Gather Requirements

Ask the user (one question at a time if details are missing):

| Parameter | Question | Why It Matters |
|-----------|----------|----------------|
| **Total Tokens** | What is the annual Token target? (e.g., 1.8B) | Baseline for all calculations |
| **Input/Output Split** | What is the estimated input:output ratio? (default: 3:1) | Input and output have different costs and latency |
| **Model Type** | Which model(s) will be used? (e.g., GPT-4, Claude 3.5, Llama 3 70B) | Determines per-token cost, latency, and GPU requirements |
| **Deployment Mode** | API call (pay-per-token) or on-premise GPU cluster? | Determines cost structure and resource ownership |
| **Usage Pattern** | Real-time (interactive) or batch (offline)? | Affects SLA design and peak-to-average ratio |
| **Growth Curve** | Linear growth, S-curve, or seasonal spikes? | Determines phased supply plan |
| **Peak Factor** | What is the expected peak-to-average traffic ratio? (default: 3x) | Determines headroom and burst capacity |
| **Business Criticality** | Is this business-critical (needs 99.9% uptime) or best-effort? | Affects SLA tier and cost |

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

Present a structured capacity plan in this order:

1. **Executive Summary**
   - Customer: `<name>`
   - Annual Target: `<X> Tokens` (Input: Y%, Output: Z%)
   - Model: `<model>`
   - Deployment: `<API / On-prem>`
   - Recommended SLA Tier: `<Critical / Standard / Best-effort>`
   - Estimated Annual TCO: `$X`
   - Recommended Price: `$Y/M tokens`

2. **Token Supply Plan**
   - Table: Phase | Period | Token Target | Capacity (with buffer) | Resource |
   - Monthly/quarterly breakdown

3. **SLA Commitments**
   - Availability: `<X%>`
   - TTFT: `<Y ms>` (p99)
   - TPOT: `<Z ms>`
   - Burst allowance: `<W%>` over committed
   - Overage rate: `$V/M tokens`
   - Penalty structure

4. **Cost Boundaries**
   - Table: Phase | Tokens | Cost | Unit Cost | Cumulative
   - Cost optimization recommendations
   - Breakeven analysis (if applicable)

5. **Risk and Mitigation**
   - Risk 1: `<description>` → Mitigation: `<action>`
   - Risk 2: `<description>` → Mitigation: `<action>`

6. **Next Steps**
   - Step 1: `<action>` (Owner: `<team>`, Timeline: `<date>`)
   - Step 2: `<action>`

## Rules

- **No fabrication:** All numbers must be calculated from user-provided inputs
  or explicit assumptions. State every assumption clearly.
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
- **Currency:** Use the user's preferred currency. Default to USD if unspecified.
