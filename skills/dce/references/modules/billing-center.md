# Module `billing-center`

## Source

- Backend: `swagger`
- Repository: https://github.com/DaoCloud/daocloud-api-docs.git
- Pinned tag: `8ffae87adc4776c0354f9ff44fe69b18a8ed5619`
- Files: `docs/openapi/leopard/v0.14.0.json`
- Resolved SHA: `8ffae87adc4776c0354f9ff44fe69b18a8ed5619`

## Bill

### `dce billing-center bill get-account-bill-aggregation`

- Summary: Get bill aggregation
- HTTP: `GET /apis/leopard.io/v1alpha1/bills/aggregation`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (query, int32): workspaceId
  - `--username` (query): username
  - `--start-time` (query, uint64): startTime
  - `--end-time` (query, uint64): endTime
- Output: list path `items`; columns `amountDue`, `productName`, `voucherPayment`
- Example:

```
dce billing-center bill get-account-bill-aggregation \
  --workspace-id <workspace-id> \
  --username <username> \
  --start-time <unix-seconds> \
  --end-time <unix-seconds> \
  -o json
```

