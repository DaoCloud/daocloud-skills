# Input Contracts

Use a commitment file when contract, sales, delivery, or SLA commitments are not
encoded in DCE. Values must come from a real source such as signed contracts,
CRM exports, delivery plans, quota approval records, or capacity reservation
spreadsheets.

## Commitment File

```json
{
  "currency": "CNY",
  "commitments": [
    {
      "id": "contract-a-2026q3",
      "customer": "Customer A",
      "workspace_id": "18",
      "resource_type": "gpu",
      "gpu_model": "A800",
      "cluster": "prod-gpu-1",
      "committed_gpu": 8,
      "start_date": "2026-07-01",
      "end_date": "2026-09-30",
      "confidence": "signed",
      "source": "contract"
    },
    {
      "id": "tenant-b-token",
      "customer": "Tenant B",
      "workspace_id": "23",
      "resource_type": "tokens",
      "model": "deepseek-r1",
      "committed_tokens_per_day": 2000000,
      "start_date": "2026-07-15",
      "end_date": "2026-12-31",
      "confidence": "reserved",
      "source": "quota-approval"
    }
  ]
}
```

Supported `resource_type` values:

- `gpu`: compare `committed_gpu` with DCE GPU inventory and utilization.
- `tokens`: compare `committed_tokens_per_day` with recent usage trend and
  serving signals.
- `queue`: compare `committed_gpu` or named flavor quota with queue capacity.
- `other`: include in evidence and gaps, but do not score as capacity unless a
  numeric unit is present.

The script treats commitments whose active window intersects the next 90 days as
in-scope. Expired commitments are ignored except for audit notes.
