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

### `dce billing-center bill list-bills`

- Summary: Bill_ListBills
- HTTP: `GET /apis/leopard.io/v1alpha1/bills`
- Auth: required
- Body: none
- Flags:
  - `--start` (query): start
  - `--end` (query): end
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--bill-id` (query): billId
  - `--order-id` (query): orderId
  - `--resource-id` (query): resourceId
  - `--billing-type` (query): billingType
  - `--product-name` (query): productName
  - `--username` (query): username
  - `--billing-time-start` (query): billingTimeStart
  - `--billing-time-end` (query): billingTimeEnd
- Output: list path `items`; columns `type`, `amountDue`, `billId`, `billingItem`, `billingMonth`, `billingType`; pagination `offset`

## Order

### `dce billing-center order get-products`

- Summary: Order_GetProducts
- HTTP: `GET /apis/leopard.io/v1alpha1/orders/products`
- Auth: required
- Body: none
- Flags: none
- Output: list path `products`; columns `name`, `id`

## Product

### `dce billing-center product get-sku-price`

- Summary: Product_GetSKUPrice
- HTTP: `GET /apis/leopard.io/v1alpha1/products/skus/{id}/price`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id

### `dce billing-center product list-product-sk-us`

- Summary: Product_ListProductSKUs
- HTTP: `POST /apis/leopard.io/v1alpha1/products/skus`
- Auth: required
- Body: required
- Flags: none
- Output: list path `items`; columns `id`, `available`, `billingType`, `canTransferPayAsYouGo`, `displayOrder`, `inventory`

### `dce billing-center product list-sku-infos`

- Summary: Product_ListSKUInfos
- HTTP: `GET /apis/leopard.io/v1alpha1/products/sku-infos`
- Auth: required
- Body: none
- Flags:
  - `--product` (query): product
  - `--region` (query): region
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `id`, `available`, `billingType`, `canTransferPayAsYouGo`, `displayOrder`, `inventory`; pagination `offset`

## Transaction

### `dce billing-center transaction list-transactions`

- Summary: Transaction_ListTransactions
- HTTP: `GET /apis/leopard.io/v1alpha1/transactions`
- Auth: required
- Body: none
- Flags:
  - `--start` (query): start
  - `--end` (query): end
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--serial-number` (query): serialNumber
  - `--billing-id` (query): billingId
  - `--payment-type` (query): paymentType
  - `--transaction-type` (query): transactionType
  - `--transaction-channel` (query): transactionChannel
  - `--username` (query): username
- Output: list path `items`; columns `amount`, `balance`, `billingId`, `paymentType`, `serialNumber`, `transactionChannel`; pagination `offset`

