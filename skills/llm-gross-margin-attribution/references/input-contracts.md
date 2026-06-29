# Input Contracts

## Model Cost File

Use only when DCE does not expose real model cost through Gmagpie pod fees or a
provider-cost endpoint. Values must come from a real finance/provider source.

```json
{
  "currency": "CNY",
  "models": {
    "deepseek-r1": {
      "input_cost_per_1k": 0.004,
      "output_cost_per_1k": 0.016,
      "cached_input_cost_per_1k": 0.0004
    },
    "qwen-max": {
      "input_cost_per_1k": 0.02,
      "output_cost_per_1k": 0.06,
      "cached_input_cost_per_1k": 0.002
    }
  }
}
```

If `cached_input_cost_per_1k` is absent, the script uses
`input_cost_per_1k * --cached-cost-ratio` and marks the cache attribution as
estimated.

## Model Serving Map

Use with `--cost-source gmagpie` to map model names to pod-cost filters.

```json
{
  "deepseek-r1": {
    "cluster": "prod-cluster",
    "namespace": "llm-serving",
    "search": "deepseek-r1"
  },
  "qwen-max": {
    "cluster": "prod-cluster",
    "namespace": "llm-serving",
    "search": "qwen-max"
  }
}
```

The script passes `cluster`, `namespace`, and `search` to
`dce operations-management fee list-pods-fee`. It allocates each model's pod cost
to workspaces by that model's token share when pod cost is model-level rather
than tenant-level.
