# Module `operations-management`

## Source

- Backend: `swagger`
- Repository: https://github.com/DaoCloud/daocloud-api-docs.git
- Pinned tag: `0bb0ec92f301b9c8a56deafebd4138e333f92cec`
- Files: `docs/openapi/gmagpie/v0.13.0.json`
- Resolved SHA: `0bb0ec92f301b9c8a56deafebd4138e333f92cec`

## Fee

### `dce operations-management fee list-clusters-fee`

- Summary: List cluster cost allocation records
- HTTP: `GET /apis/gmagpie.io/v1alpha1/fee/clusters`
- Auth: required
- Body: none
- Flags:
  - `--start` (query): Start time for the cost query window
  - `--end` (query): End time for the cost query window
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): Number of results per page
  - `--search` (query): Fuzzy search keyword
- Output: list path `items`; columns `cluster`, `nodeCount`; pagination `offset`
- Example:

```
dce operations-management fee list-clusters-fee --page 1 --page-size 20
dce operations-management fee list-clusters-fee --start 2026-05-01 --end 2026-05-28 --search prod -o json
```

### `dce operations-management fee list-namespaces-fee`

- Summary: List namespace cost allocation records
- HTTP: `GET /apis/gmagpie.io/v1alpha1/fee/namespaces`
- Auth: required
- Body: none
- Flags:
  - `--start` (query): Start time for the cost query window
  - `--end` (query): End time for the cost query window
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): Number of results per page
  - `--search` (query): Fuzzy search keyword
  - `--workspace` (query): Filter by workspace name or ID
- Output: list path `items`; columns `namespace`, `cluster`, `podCount`, `workspace`; pagination `offset`
- Example:

```
dce operations-management fee list-namespaces-fee --workspace <workspace> --page 1 --page-size 20
dce operations-management fee list-namespaces-fee --start 2026-05-01 --end 2026-05-28 -o json
```

### `dce operations-management fee list-nodes-fee`

- Summary: List node cost allocation records
- HTTP: `GET /apis/gmagpie.io/v1alpha1/fee/nodes`
- Auth: required
- Body: none
- Flags:
  - `--start` (query): Start time for the cost query window
  - `--end` (query): End time for the cost query window
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): Number of results per page
  - `--search` (query): Fuzzy search keyword
  - `--cluster` (query): Filter by cluster name or ID
- Output: list path `items`; columns `type`, `cluster`, `ip`, `node`; pagination `offset`
- Example:

```
dce operations-management fee list-nodes-fee --cluster <cluster> --page 1 --page-size 20
dce operations-management fee list-nodes-fee --start 2026-05-01 --end 2026-05-28 -o json
```

### `dce operations-management fee list-pods-fee`

- Summary: List pod cost allocation records
- HTTP: `GET /apis/gmagpie.io/v1alpha1/fee/pods`
- Auth: required
- Body: none
- Flags:
  - `--start` (query): Start time for the cost query window
  - `--end` (query): End time for the cost query window
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): Number of results per page
  - `--search` (query): Fuzzy search keyword
  - `--workspace` (query): Filter by workspace name or ID
  - `--namespace` (query): Filter by namespace
  - `--cluster` (query): Filter by cluster name or ID
- Output: list path `items`; columns `namespace`, `cluster`, `pod`, `workspace`; pagination `offset`
- Example:

```
dce operations-management fee list-pods-fee --cluster <cluster> --namespace <namespace> --page 1 --page-size 20
dce operations-management fee list-pods-fee --workspace <workspace> --search app -o json
```

### `dce operations-management fee list-workspaces-fee`

- Summary: List workspace cost allocation records
- HTTP: `GET /apis/gmagpie.io/v1alpha1/fee/workspaces`
- Auth: required
- Body: none
- Flags:
  - `--start` (query): Start time for the cost query window
  - `--end` (query): End time for the cost query window
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): Number of results per page
  - `--search` (query): Fuzzy search keyword
- Output: list path `items`; columns `namespaceCount`, `podCount`, `workspace`; pagination `offset`
- Example:

```
dce operations-management fee list-workspaces-fee --page 1 --page-size 20
dce operations-management fee list-workspaces-fee --start 2026-05-01 --end 2026-05-28 --search team -o json
```

## GPU

### `dce operations-management gpu get-gpu-metrics`

- Summary: GPU_GetGPUMetrics
- HTTP: `GET /apis/gmagpie.io/v1alpha1/gpu/metrics/{id}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required, int32): id

## PermissionService

### `dce operations-management permissionservice list-permissions`

- Summary: List operations-management permission definitions
- HTTP: `GET /apis/gmagpie.io/v1alpha1/permissions`
- Auth: required
- Body: none
- Flags: none
- Example: `dce operations-management permissionservice list-permissions -o json`

## Price

### `dce operations-management price get-gpu-models`

- Summary: Price_GetGPUModels
- HTTP: `GET /apis/gmagpie.io/v1alpha1/gpu_models`
- Auth: required
- Body: none
- Flags: none
- Output: list path `models`; columns `memory`, `model`

### `dce operations-management price get-price`

- Summary: Price_GetPrice
- HTTP: `GET /apis/gmagpie.io/v1alpha1/price`
- Auth: required
- Body: none
- Flags: none
- Output: list path `gpuPrice`; columns `model`, `price`

## Report

### `dce operations-management report list-alarms`

- Summary: List alarm report records
- HTTP: `GET /apis/gmagpie.io/v1alpha1/report/alarms`
- Auth: required
- Body: none
- Flags:
  - `--start` (query): Start time for the report query window
  - `--end` (query): End time for the report query window
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Number of results per page
  - `--search` (query): Fuzzy search keyword
- Output: list path `items`; columns `cluster`, `critical`, `info`, `ip`, `node`, `total`; pagination `offset`
- Example:

```
dce operations-management report list-alarms --page 1 --page-size 20
dce operations-management report list-alarms --start 2026-05-01 --end 2026-05-28 --search warning -o json
```

### `dce operations-management report list-audit-resources`

- Summary: List audit report records grouped by resource
- HTTP: `GET /apis/gmagpie.io/v1alpha1/report/audit-resources`
- Auth: required
- Body: none
- Flags:
  - `--start` (query): Start time for the report query window
  - `--end` (query): End time for the report query window
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Number of results per page
  - `--search` (query): Fuzzy search keyword
- Output: list path `items`; columns `event`, `resourceType`, `total`; pagination `offset`
- Example:

```
dce operations-management report list-audit-resources --page 1 --page-size 20
dce operations-management report list-audit-resources --start 2026-05-01 --end 2026-05-28 --search delete -o json
```

### `dce operations-management report list-audit-users`

- Summary: List audit report records grouped by user
- HTTP: `GET /apis/gmagpie.io/v1alpha1/report/audit-users`
- Auth: required
- Body: none
- Flags:
  - `--start` (query): Start time for the report query window
  - `--end` (query): End time for the report query window
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Number of results per page
  - `--search` (query): Fuzzy search keyword
- Output: list path `items`; columns `failed`, `success`, `total`, `username`; pagination `offset`
- Example:

```
dce operations-management report list-audit-users --page 1 --page-size 20
dce operations-management report list-audit-users --start 2026-05-01 --end 2026-05-28 --search alice -o json
```

### `dce operations-management report list-clusters`

- Summary: List cluster report records
- HTTP: `GET /apis/gmagpie.io/v1alpha1/report/clusters`
- Auth: required
- Body: none
- Flags:
  - `--start` (query): Start time for the report query window
  - `--end` (query): End time for the report query window
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Number of results per page
  - `--search` (query): Fuzzy search keyword
- Output: list path `items`; columns `cluster`, `nodeCount`; pagination `offset`
- Example:

```
dce operations-management report list-clusters --page 1 --page-size 20
dce operations-management report list-clusters --start 2026-05-01 --end 2026-05-28 --search prod -o json
```

### `dce operations-management report list-namespaces`

- Summary: List namespace report records
- HTTP: `GET /apis/gmagpie.io/v1alpha1/report/namespaces`
- Auth: required
- Body: none
- Flags:
  - `--start` (query): Start time for the report query window
  - `--end` (query): End time for the report query window
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Number of results per page
  - `--search` (query): Fuzzy search keyword
  - `--workspace` (query): Filter by workspace name or ID
- Output: list path `items`; columns `namespace`, `cluster`, `podCount`, `workspace`; pagination `offset`
- Example:

```
dce operations-management report list-namespaces --workspace <workspace> --page 1 --page-size 20
dce operations-management report list-namespaces --start 2026-05-01 --end 2026-05-28 -o json
```

### `dce operations-management report list-nodes`

- Summary: List node report records
- HTTP: `GET /apis/gmagpie.io/v1alpha1/report/nodes`
- Auth: required
- Body: none
- Flags:
  - `--start` (query): Start time for the report query window
  - `--end` (query): End time for the report query window
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Number of results per page
  - `--search` (query): Fuzzy search keyword
  - `--cluster` (query): Filter by cluster name or ID
- Output: list path `items`; columns `type`, `cluster`, `ip`, `node`; pagination `offset`
- Example:

```
dce operations-management report list-nodes --cluster <cluster> --page 1 --page-size 20
dce operations-management report list-nodes --start 2026-05-01 --end 2026-05-28 -o json
```

### `dce operations-management report list-pods`

- Summary: List pod report records
- HTTP: `GET /apis/gmagpie.io/v1alpha1/report/pods`
- Auth: required
- Body: none
- Flags:
  - `--start` (query): Start time for the report query window
  - `--end` (query): End time for the report query window
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Number of results per page
  - `--search` (query): Fuzzy search keyword
  - `--workspace` (query): Filter by workspace name or ID
  - `--namespace` (query): Filter by namespace
  - `--cluster` (query): Filter by cluster name or ID
- Output: list path `items`; columns `namespace`, `cluster`, `pod`, `workspace`; pagination `offset`
- Example:

```
dce operations-management report list-pods --cluster <cluster> --namespace <namespace> --page 1 --page-size 20
dce operations-management report list-pods --workspace <workspace> --search app -o json
```

### `dce operations-management report list-workspaces`

- Summary: List workspace report records
- HTTP: `GET /apis/gmagpie.io/v1alpha1/report/workspaces`
- Auth: required
- Body: none
- Flags:
  - `--start` (query): Start time for the report query window
  - `--end` (query): End time for the report query window
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Number of results per page
  - `--search` (query): Fuzzy search keyword
- Output: list path `items`; columns `namespaceCount`, `podCount`, `workspace`; pagination `offset`
- Example:

```
dce operations-management report list-workspaces --page 1 --page-size 20
dce operations-management report list-workspaces --start 2026-05-01 --end 2026-05-28 --search team -o json
```

