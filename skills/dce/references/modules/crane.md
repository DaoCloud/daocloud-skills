# Module `crane`

## Source

- Backend: `swagger`
- Repository: `unknown`
- Pinned tag: ``unknown``
- Files: `specs/crane/crane.swagger.json`

## BusinessOperationService

### `dce crane businessoperationservice get-application-agent-count`

- Summary: GetApplicationAgentCount returns the estimated application / agent count KPI.
- HTTP: `GET /api/v1alpha1/business-operation/application-agent-count`
- Auth: required
- Body: none
- Flags:
  - `--start-time` (query, date-time): Start time for the statistics period (UTC, inclusive).
  - `--end-time` (query, date-time): End time for the statistics period (UTC, exclusive).
  - `--limit` (query, int32): Limit for top-N style queries.
  - `--period` (query): Preset period key, such as thisMonth / lastMonth / thisQuarter / thisYear.
  - `--model` (query): Optional model keyword filter.
- Output: pagination `cursor`

### `dce crane businessoperationservice get-application-type-distribution`

- Summary: GetApplicationTypeDistribution returns the estimated application type distribution panel.
- HTTP: `GET /api/v1alpha1/business-operation/application-type-distribution`
- Auth: required
- Body: none
- Flags:
  - `--start-time` (query, date-time): Start time for the statistics period (UTC, inclusive).
  - `--end-time` (query, date-time): End time for the statistics period (UTC, exclusive).
  - `--limit` (query, int32): Limit for top-N style queries.
  - `--period` (query): Preset period key, such as thisMonth / lastMonth / thisQuarter / thisYear.
  - `--model` (query): Optional model keyword filter.
- Output: list path `items`; columns `name`, `cost`, `displayValue`, `rank`, `revenue`, `userName`; pagination `cursor`

### `dce crane businessoperationservice get-average-package-consumption-rate`

- Summary: GetAveragePackageConsumptionRate returns the average workspace quota consumption rate.
- HTTP: `GET /api/v1alpha1/business-operation/average-package-consumption-rate`
- Auth: required
- Body: none
- Flags:
  - `--start-time` (query, date-time): Start time for the statistics period (UTC, inclusive).
  - `--end-time` (query, date-time): End time for the statistics period (UTC, exclusive).
  - `--limit` (query, int32): Limit for top-N style queries.
  - `--period` (query): Preset period key, such as thisMonth / lastMonth / thisQuarter / thisYear.
  - `--model` (query): Optional model keyword filter.
- Output: pagination `cursor`

### `dce crane businessoperationservice get-department-application-model-gpu-flow`

- Summary: GetDepartmentApplicationModelGpuFlow returns the department -> application -> model -> GPU flow panel.
- HTTP: `GET /api/v1alpha1/business-operation/department-application-model-gpu-flow`
- Auth: required
- Body: none
- Flags:
  - `--start-time` (query, date-time): Start time for the statistics period (UTC, inclusive).
  - `--end-time` (query, date-time): End time for the statistics period (UTC, exclusive).
  - `--limit` (query, int32): Limit for top-N style queries.
  - `--period` (query): Preset period key, such as thisMonth / lastMonth / thisQuarter / thisYear.
  - `--model` (query): Optional model keyword filter.
- Output: pagination `cursor`

### `dce crane businessoperationservice get-department-budget-usage-rate`

- Summary: GetDepartmentBudgetUsageRate returns the department budget usage rate KPI.
- HTTP: `GET /api/v1alpha1/business-operation/department-budget-usage-rate`
- Auth: required
- Body: none
- Flags:
  - `--start-time` (query, date-time): Start time for the statistics period (UTC, inclusive).
  - `--end-time` (query, date-time): End time for the statistics period (UTC, exclusive).
  - `--limit` (query, int32): Limit for top-N style queries.
  - `--period` (query): Preset period key, such as thisMonth / lastMonth / thisQuarter / thisYear.
  - `--model` (query): Optional model keyword filter.
- Output: pagination `cursor`

### `dce crane businessoperationservice get-department-monthly-allocated-cost`

- Summary: GetDepartmentMonthlyAllocatedCost returns the monthly allocated cost KPI.
- HTTP: `GET /api/v1alpha1/business-operation/department-monthly-allocated-cost`
- Auth: required
- Body: none
- Flags:
  - `--start-time` (query, date-time): Start time for the statistics period (UTC, inclusive).
  - `--end-time` (query, date-time): End time for the statistics period (UTC, exclusive).
  - `--limit` (query, int32): Limit for top-N style queries.
  - `--period` (query): Preset period key, such as thisMonth / lastMonth / thisQuarter / thisYear.
  - `--model` (query): Optional model keyword filter.
- Output: pagination `cursor`

### `dce crane businessoperationservice get-department-unit-business-cost`

- Summary: GetDepartmentUnitBusinessCost returns the estimated unit business cost KPI.
- HTTP: `GET /api/v1alpha1/business-operation/department-unit-business-cost`
- Auth: required
- Body: none
- Flags:
  - `--start-time` (query, date-time): Start time for the statistics period (UTC, inclusive).
  - `--end-time` (query, date-time): End time for the statistics period (UTC, exclusive).
  - `--limit` (query, int32): Limit for top-N style queries.
  - `--period` (query): Preset period key, such as thisMonth / lastMonth / thisQuarter / thisYear.
  - `--model` (query): Optional model keyword filter.
- Output: pagination `cursor`

### `dce crane businessoperationservice get-department-unit-business-cost-comparison`

- Summary: GetDepartmentUnitBusinessCostComparison returns the unit business cost comparison panel.
- HTTP: `GET /api/v1alpha1/business-operation/department-unit-business-cost-comparison`
- Auth: required
- Body: none
- Flags:
  - `--start-time` (query, date-time): Start time for the statistics period (UTC, inclusive).
  - `--end-time` (query, date-time): End time for the statistics period (UTC, exclusive).
  - `--limit` (query, int32): Limit for top-N style queries.
  - `--period` (query): Preset period key, such as thisMonth / lastMonth / thisQuarter / thisYear.
  - `--model` (query): Optional model keyword filter.
- Output: list path `items`; columns `name`, `cost`, `displayValue`, `rank`, `revenue`, `userName`; pagination `cursor`

### `dce crane businessoperationservice get-monthly-arpu`

- Summary: GetMonthlyARPU returns the average revenue per active tenant in the given window.
- HTTP: `GET /api/v1alpha1/business-operation/monthly-arpu`
- Auth: required
- Body: none
- Flags:
  - `--start-time` (query, date-time): Start time for the statistics period (UTC, inclusive).
  - `--end-time` (query, date-time): End time for the statistics period (UTC, exclusive).
  - `--limit` (query, int32): Limit for top-N style queries.
  - `--period` (query): Preset period key, such as thisMonth / lastMonth / thisQuarter / thisYear.
  - `--model` (query): Optional model keyword filter.
- Output: pagination `cursor`

### `dce crane businessoperationservice get-monthly-revenue`

- Summary: GetMonthlyRevenue returns bill revenue in the given window.
- HTTP: `GET /api/v1alpha1/business-operation/monthly-revenue`
- Auth: required
- Body: none
- Flags:
  - `--start-time` (query, date-time): Start time for the statistics period (UTC, inclusive).
  - `--end-time` (query, date-time): End time for the statistics period (UTC, exclusive).
  - `--limit` (query, int32): Limit for top-N style queries.
  - `--period` (query): Preset period key, such as thisMonth / lastMonth / thisQuarter / thisYear.
  - `--model` (query): Optional model keyword filter.
- Output: pagination `cursor`

### `dce crane businessoperationservice get-monthly-token-consumption`

- Summary: GetMonthlyTokenConsumption returns token consumption metrics in the given window.
- HTTP: `GET /api/v1alpha1/business-operation/monthly-token-consumption`
- Auth: required
- Body: none
- Flags:
  - `--start-time` (query, date-time): Start time for the statistics period (UTC, inclusive).
  - `--end-time` (query, date-time): End time for the statistics period (UTC, exclusive).
  - `--limit` (query, int32): Limit for top-N style queries.
  - `--period` (query): Preset period key, such as thisMonth / lastMonth / thisQuarter / thisYear.
  - `--model` (query): Optional model keyword filter.
- Output: pagination `cursor`

### `dce crane businessoperationservice get-tenant-growth-trend-top5`

- Summary: GetTenantGrowthTrendTop5 returns the top-5 tenant growth trend panel.
- HTTP: `GET /api/v1alpha1/business-operation/tenant-growth-trend-top5`
- Auth: required
- Body: none
- Flags:
  - `--start-time` (query, date-time): Start time for the statistics period (UTC, inclusive).
  - `--end-time` (query, date-time): End time for the statistics period (UTC, exclusive).
  - `--limit` (query, int32): Limit for top-N style queries.
  - `--period` (query): Preset period key, such as thisMonth / lastMonth / thisQuarter / thisYear.
  - `--model` (query): Optional model keyword filter.
- Output: pagination `cursor`

### `dce crane businessoperationservice get-tenant-model-gpu-token-flow`

- Summary: GetTenantModelGpuTokenFlow returns the tenant -> model -> GPU -> token flow panel.
- HTTP: `GET /api/v1alpha1/business-operation/tenant-model-gpu-token-flow`
- Auth: required
- Body: none
- Flags:
  - `--start-time` (query, date-time): Start time for the statistics period (UTC, inclusive).
  - `--end-time` (query, date-time): End time for the statistics period (UTC, exclusive).
  - `--limit` (query, int32): Limit for top-N style queries.
  - `--period` (query): Preset period key, such as thisMonth / lastMonth / thisQuarter / thisYear.
  - `--model` (query): Optional model keyword filter.
- Output: pagination `cursor`

### `dce crane businessoperationservice get-tenant-value-quadrant`

- Summary: GetTenantValueQuadrant returns the tenant token vs revenue quadrant panel.
- HTTP: `GET /api/v1alpha1/business-operation/tenant-value-quadrant`
- Auth: required
- Body: none
- Flags:
  - `--start-time` (query, date-time): Start time for the statistics period (UTC, inclusive).
  - `--end-time` (query, date-time): End time for the statistics period (UTC, exclusive).
  - `--limit` (query, int32): Limit for top-N style queries.
  - `--period` (query): Preset period key, such as thisMonth / lastMonth / thisQuarter / thisYear.
  - `--model` (query): Optional model keyword filter.
- Output: list path `points`; columns `name`, `size`, `x`, `y`; pagination `cursor`

### `dce crane businessoperationservice list-active-departments`

- Summary: ListActiveDepartments returns the count of active departments.
- HTTP: `GET /api/v1alpha1/business-operation/active-departments`
- Auth: required
- Body: none
- Flags:
  - `--start-time` (query, date-time): Start time for the statistics period (UTC, inclusive).
  - `--end-time` (query, date-time): End time for the statistics period (UTC, exclusive).
  - `--limit` (query, int32): Limit for top-N style queries.
  - `--period` (query): Preset period key, such as thisMonth / lastMonth / thisQuarter / thisYear.
  - `--model` (query): Optional model keyword filter.
- Output: pagination `cursor`

### `dce crane businessoperationservice list-active-tenants`

- Summary: ListActiveTenants returns the count of active tenants with token consumption.
- HTTP: `GET /api/v1alpha1/business-operation/active-tenants`
- Auth: required
- Body: none
- Flags:
  - `--start-time` (query, date-time): Start time for the statistics period (UTC).
  - `--end-time` (query, date-time): End time for the statistics period (UTC, exclusive).
  - `--period` (query): Preset period key, such as thisMonth / lastMonth / thisQuarter / thisYear.
  - `--model` (query): Optional model keyword filter.

### `dce crane businessoperationservice list-business-models`

- Summary: ListBusinessModels returns the model options for the business dashboard filter.
- HTTP: `GET /api/v1alpha1/business-operation/models`
- Auth: required
- Body: none
- Flags:
  - `--start-time` (query, date-time): Start time for the statistics period (UTC, inclusive).
  - `--end-time` (query, date-time): End time for the statistics period (UTC, exclusive).
  - `--limit` (query, int32): Limit for top-N style queries.
  - `--period` (query): Preset period key, such as thisMonth / lastMonth / thisQuarter / thisYear.
  - `--model` (query): Optional model keyword filter.
- Output: list path `models`; pagination `cursor`

### `dce crane businessoperationservice list-business-operation-suggestions`

- Summary: ListBusinessOperationSuggestions returns the aggregated tenant and department suggestions panel.
- HTTP: `GET /api/v1alpha1/business-operation/suggestions`
- Auth: required
- Body: none
- Flags:
  - `--start-time` (query, date-time): Start time for the statistics period (UTC, inclusive).
  - `--end-time` (query, date-time): End time for the statistics period (UTC, exclusive).
  - `--limit` (query, int32): Limit for top-N style queries.
  - `--period` (query): Preset period key, such as thisMonth / lastMonth / thisQuarter / thisYear.
  - `--model` (query): Optional model keyword filter.
- Output: list path `items`; columns `type`, `content`; pagination `cursor`

### `dce crane businessoperationservice list-department-token-consumption-top`

- Summary: ListDepartmentTokenConsumptionTop returns the top department token consumers.
- HTTP: `GET /api/v1alpha1/business-operation/department-token-consumption-top`
- Auth: required
- Body: none
- Flags:
  - `--start-time` (query, date-time): Start time for the statistics period (UTC, inclusive).
  - `--end-time` (query, date-time): End time for the statistics period (UTC, exclusive).
  - `--limit` (query, int32): Limit for top-N style queries.
  - `--period` (query): Preset period key, such as thisMonth / lastMonth / thisQuarter / thisYear.
  - `--model` (query): Optional model keyword filter.
- Output: list path `items`; columns `department`, `rank`, `totalTokens`; pagination `cursor`

### `dce crane businessoperationservice list-tenant-risk-objects`

- Summary: ListTenantRiskObjects returns the tenant risk object ranking panel.
- HTTP: `GET /api/v1alpha1/business-operation/tenant-risk-objects`
- Auth: required
- Body: none
- Flags:
  - `--start-time` (query, date-time): Start time for the statistics period (UTC, inclusive).
  - `--end-time` (query, date-time): End time for the statistics period (UTC, exclusive).
  - `--limit` (query, int32): Limit for top-N style queries.
  - `--period` (query): Preset period key, such as thisMonth / lastMonth / thisQuarter / thisYear.
  - `--model` (query): Optional model keyword filter.
- Output: list path `items`; columns `action`, `detail`, `level`, `riskType`, `tenant`, `userName`; pagination `cursor`

### `dce crane businessoperationservice list-tenant-token-consumption-top`

- Summary: ListTenantTokenConsumptionTop returns the top tenant token consumers.
- HTTP: `GET /api/v1alpha1/business-operation/tenant-token-consumption-top`
- Auth: required
- Body: none
- Flags:
  - `--start-time` (query, date-time): Start time for the statistics period (UTC, inclusive).
  - `--end-time` (query, date-time): End time for the statistics period (UTC, exclusive).
  - `--limit` (query, int32): Limit for top-N style queries.
  - `--period` (query): Preset period key, such as thisMonth / lastMonth / thisQuarter / thisYear.
  - `--model` (query): Optional model keyword filter.
- Output: list path `items`; columns `rank`, `tenantId`, `totalTokens`, `userName`; pagination `cursor`

## BusinessValueService

### `dce crane businessvalueservice get-api-key-count`

- Summary: GetApiKeyCount returns the count of distinct API keys used in the given time window.
- HTTP: `GET /api/v1alpha1/business-value/api-key-count`
- Auth: required
- Body: none
- Flags:
  - `--start-time` (query, date-time): Start of the query window (UTC, inclusive).
  - `--end-time` (query, date-time): End of the query window (UTC, exclusive).

### `dce crane businessvalueservice get-app-consumption-distribution`

- Summary: GetAppConsumptionDistribution returns the consumption distribution across applications.
- HTTP: `GET /api/v1alpha1/business-value/app-consumption-distribution`
- Auth: required
- Body: none
- Flags:
  - `--time-range` (query): Time range filter: "today", "this-week", "this-month", "this-quarter". Default is "today".
  - `--cluster` (query): Cluster filter (optional). If empty, all clusters are included football.
- Output: list path `items`; columns `appName`, `percentage`

### `dce crane businessvalueservice get-capacity-bottleneck-forecast`

- Summary: GetCapacityBottleneckForecast returns the predicted number of days until
- HTTP: `GET /api/v1alpha1/business-value/capacity-bottleneck-forecast`
- Auth: required
- Body: none
- Flags: none

### `dce crane businessvalueservice get-cumulative-output`

- Summary: GetCumulativeOutput returns the cumulative token output and growth rate for a given time range.
- HTTP: `GET /api/v1alpha1/business-value/cumulative-output`
- Auth: required
- Body: none
- Flags:
  - `--time-range` (query): Time range filter: "today", "this-week", "this-month", "this-quarter".
- Output: list path `historyPoints`; columns `growthRatePercent`, `time`, `totalTokens`

### `dce crane businessvalueservice get-department-token-usage`

- Summary: GetDepartmentTokenUsage returns per-department token usage and budget for the given time window.
- HTTP: `GET /api/v1alpha1/business-value/department-token-usage`
- Auth: required
- Body: none
- Flags:
  - `--start-time` (query, date-time): Start of the query window (UTC, inclusive).
  - `--end-time` (query, date-time): End of the query window (UTC, exclusive).
- Output: list path `items`; columns `budgetTokenTotal`, `departmentName`, `tokenTotal`

### `dce crane businessvalueservice get-internal-business-structure-distribution`

- Summary: GetInternalBusinessStructureDistribution returns internal business structure distribution for WS mode.
- HTTP: `GET /api/v1alpha1/business-value/internal-business-structure-distribution`
- Auth: required
- Body: none
- Flags:
  - `--time-range` (query): Time range filter: "today", "this-week", "this-month", "this-quarter". Default is "today".
  - `--cluster` (query): Cluster filter (optional). If empty, all clusters are included.
- Output: list path `items`; columns `name`, `value`

### `dce crane businessvalueservice get-month-end-forecast-metrics`

- Summary: GetMonthEndForecastMetrics returns month-end revenue and gross profit forecast metrics.
- HTTP: `GET /api/v1alpha1/business-value/month-end-forecast`
- Auth: required
- Body: none
- Flags: none

### `dce crane businessvalueservice get-rated-capacity`

- Summary: GetRatedCapacity returns the rated capacity value (in millions).
- HTTP: `GET /api/v1alpha1/business-value/rated-capacity`
- Auth: required
- Body: none
- Flags: none

### `dce crane businessvalueservice get-revenue-and-profit-metrics`

- Summary: GetRevenueAndProfitMetrics returns revenue, cost, gross profit metrics and optional history.
- HTTP: `GET /api/v1alpha1/business-value/revenue-profit`
- Auth: required
- Body: none
- Flags:
  - `--time-range` (query): Time range filter: "today", "this-week", "this-month", "this-quarter".
- Output: list path `history`; columns `grossMarginPercent`, `grossMarginYoyRatePp`, `grossProfit`, `revenue`, `revenueGrowthRatePercent`, `time`

### `dce crane businessvalueservice get-revenue-margin-trend-forecast`

- Summary: GetRevenueMarginTrendForecast returns 37 daily points (30 historical + 7 forecast)
- HTTP: `GET /api/v1alpha1/business-value/revenue-margin-trend-forecast`
- Auth: required
- Body: none
- Flags: none
- Output: list path `points`; columns `cost`, `date`, `grossProfit`, `revenue`

### `dce crane businessvalueservice get-risk-suggestions`

- Summary: GetRiskSuggestions returns the current risk identification and business suggestions.
- HTTP: `GET /api/v1alpha1/business-value/risk-suggestions`
- Auth: required
- Body: none
- Flags: none
- Output: list path `suggestions`; columns `type`, `content`

### `dce crane businessvalueservice get-tenant-token-usage`

- Summary: GetTenantTokenUsage returns per-tenant token usage and charge amount for the given time window.
- HTTP: `GET /api/v1alpha1/business-value/tenant-token-usage`
- Auth: required
- Body: none
- Flags:
  - `--start-time` (query, date-time): Start of the query window (UTC, inclusive).
  - `--end-time` (query, date-time): End of the query window (UTC, exclusive).
- Output: list path `items`; columns `price`, `tenantId`, `tenantName`, `tokenTotal`

### `dce crane businessvalueservice get-token-throughput`

- Summary: GetTokenThroughput returns the current per-second Token throughput.
- HTTP: `GET /api/v1alpha1/business-value/token-throughput`
- Auth: required
- Body: none
- Flags: none

### `dce crane businessvalueservice get-value-attribution-module-boosts`

- Summary: GetValueAttributionModuleBoosts returns module boost percentages from config.
- HTTP: `GET /api/v1alpha1/business-value/value-attribution-module-boosts`
- Auth: required
- Body: none
- Flags:
  - `--time-range` (query): Time range filter: "today", "this-week", "this-month", "this-quarter".
- Output: list path `moduleItems`; columns `costSavings`, `moduleName`, `sharePercent`

## ComputePowerCollaborationService

### `dce crane computepowercollaborationservice get-carbon-account`

- Summary: ComputePowerCollaborationService_GetCarbonAccount
- HTTP: `GET /api/v1alpha1/compute-power-collaboration/carbon-account`
- Auth: required
- Body: none
- Flags:
  - `--query.cluster` (query): Optional cluster filter; when empty, all clusters are aggregated.
  - `--query.range` (query): Optional time range token: 24h, 7d or 1m. Defaults to 24h.
  - `--query.timezone` (query): Optional IANA timezone (e.g. "Asia/Shanghai") for rendering x-axis
- Output: list path `items`; columns `id`, `precision`, `status`, `trend`, `trendPrecision`, `trendUnit`

### `dce crane computepowercollaborationservice get-carbon-path`

- Summary: ComputePowerCollaborationService_GetCarbonPath
- HTTP: `GET /api/v1alpha1/compute-power-collaboration/carbon-path`
- Auth: required
- Body: none
- Flags:
  - `--query.cluster` (query): Optional cluster filter; when empty, all clusters are aggregated.
  - `--query.range` (query): Optional time range token: 24h, 7d or 1m. Defaults to 24h.
  - `--query.timezone` (query): Optional IANA timezone (e.g. "Asia/Shanghai") for rendering x-axis
- Output: list path `items`; columns `emissionKg`, `month`, `offsetKg`, `targetKg`

### `dce crane computepowercollaborationservice get-clusters`

- Summary: ComputePowerCollaborationService_GetClusters
- HTTP: `GET /api/v1alpha1/compute-power-collaboration/clusters`
- Auth: required
- Body: none
- Flags: none
- Output: list path `clusters`; columns `name`

### `dce crane computepowercollaborationservice get-dc-regions`

- Summary: ComputePowerCollaborationService_GetDcRegions
- HTTP: `GET /api/v1alpha1/compute-power-collaboration/dc-regions`
- Auth: required
- Body: none
- Flags:
  - `--query.cluster` (query): Optional cluster filter; when empty, all clusters are aggregated.
  - `--query.range` (query): Optional time range token: 24h, 7d or 1m. Defaults to 24h.
  - `--query.timezone` (query): Optional IANA timezone (e.g. "Asia/Shanghai") for rendering x-axis
- Output: list path `items`; columns `capacityPct`, `cluster`, `clusterPhase`, `gpuCount`, `greenRatioPct`, `isOffline`

### `dce crane computepowercollaborationservice get-green-energy`

- Summary: ComputePowerCollaborationService_GetGreenEnergy
- HTTP: `GET /api/v1alpha1/compute-power-collaboration/green-energy`
- Auth: required
- Body: none
- Flags:
  - `--query.cluster` (query): Optional cluster filter; when empty, all clusters are aggregated.
  - `--query.range` (query): Optional time range token: 24h, 7d or 1m. Defaults to 24h.
  - `--query.timezone` (query): Optional IANA timezone (e.g. "Asia/Shanghai") for rendering x-axis
- Output: list path `items`; columns `id`, `precision`, `status`, `trend`, `trendPrecision`, `trendUnit`

### `dce crane computepowercollaborationservice get-green-load-scheduling`

- Summary: ComputePowerCollaborationService_GetGreenLoadScheduling
- HTTP: `GET /api/v1alpha1/compute-power-collaboration/green-load-scheduling`
- Auth: required
- Body: none
- Flags:
  - `--query.cluster` (query): Optional cluster filter; when empty, all clusters are aggregated.
  - `--query.range` (query): Optional time range token: 24h, 7d or 1m. Defaults to 24h.
  - `--query.timezone` (query): Optional IANA timezone (e.g. "Asia/Shanghai") for rendering x-axis
- Output: list path `items`; columns `elastic`, `greenRatio`, `hour`, `rigid`

### `dce crane computepowercollaborationservice get-green-scheduling`

- Summary: ComputePowerCollaborationService_GetGreenScheduling
- HTTP: `GET /api/v1alpha1/compute-power-collaboration/green-scheduling`
- Auth: required
- Body: none
- Flags:
  - `--query.cluster` (query): Optional cluster filter; when empty, all clusters are aggregated.
  - `--query.range` (query): Optional time range token: 24h, 7d or 1m. Defaults to 24h.
  - `--query.timezone` (query): Optional IANA timezone (e.g. "Asia/Shanghai") for rendering x-axis
- Output: list path `params`; columns `key`, `value`

### `dce crane computepowercollaborationservice get-green-suggestions`

- Summary: ComputePowerCollaborationService_GetGreenSuggestions
- HTTP: `GET /api/v1alpha1/compute-power-collaboration/green-suggestions`
- Auth: required
- Body: none
- Flags:
  - `--query.cluster` (query): Optional cluster filter; when empty, all clusters are aggregated.
  - `--query.range` (query): Optional time range token: 24h, 7d or 1m. Defaults to 24h.
  - `--query.timezone` (query): Optional IANA timezone (e.g. "Asia/Shanghai") for rendering x-axis
- Output: list path `items`; columns `code`, `messageKey`, `severity`

### `dce crane computepowercollaborationservice get-green-supply-trend`

- Summary: ComputePowerCollaborationService_GetGreenSupplyTrend
- HTTP: `GET /api/v1alpha1/compute-power-collaboration/green-supply-trend`
- Auth: required
- Body: none
- Flags:
  - `--query.cluster` (query): Optional cluster filter; when empty, all clusters are aggregated.
  - `--query.range` (query): Optional time range token: 24h, 7d or 1m. Defaults to 24h.
  - `--query.timezone` (query): Optional IANA timezone (e.g. "Asia/Shanghai") for rendering x-axis
- Output: list path `series`; columns `id`

### `dce crane computepowercollaborationservice get-kpis`

- Summary: ComputePowerCollaborationService_GetKpis
- HTTP: `GET /api/v1alpha1/compute-power-collaboration/kpis`
- Auth: required
- Body: none
- Flags:
  - `--query.cluster` (query): Optional cluster filter; when empty, all clusters are aggregated.
  - `--query.range` (query): Optional time range token: 24h, 7d or 1m. Defaults to 24h.
  - `--query.timezone` (query): Optional IANA timezone (e.g. "Asia/Shanghai") for rendering x-axis
- Output: list path `items`; columns `id`, `precision`, `status`, `trend`, `trendPrecision`, `trendUnit`

### `dce crane computepowercollaborationservice get-power-trend`

- Summary: ComputePowerCollaborationService_GetPowerTrend
- HTTP: `GET /api/v1alpha1/compute-power-collaboration/power-trend`
- Auth: required
- Body: none
- Flags:
  - `--query.cluster` (query): Optional cluster filter; when empty, all clusters are aggregated.
  - `--query.range` (query): Optional time range token: 24h, 7d or 1m. Defaults to 24h.
  - `--query.timezone` (query): Optional IANA timezone (e.g. "Asia/Shanghai") for rendering x-axis
- Output: list path `series`; columns `id`

### `dce crane computepowercollaborationservice get-protection-strategy`

- Summary: ComputePowerCollaborationService_GetProtectionStrategy
- HTTP: `GET /api/v1alpha1/compute-power-collaboration/protection-strategy`
- Auth: required
- Body: none
- Flags:
  - `--query.cluster` (query): Optional cluster filter; when empty, all clusters are aggregated.
  - `--query.range` (query): Optional time range token: 24h, 7d or 1m. Defaults to 24h.
  - `--query.timezone` (query): Optional IANA timezone (e.g. "Asia/Shanghai") for rendering x-axis
- Output: list path `greenRules`; columns `band`, `impactCode`, `strategyCode`, `targetCode`

### `dce crane computepowercollaborationservice get-suggestions`

- Summary: ComputePowerCollaborationService_GetSuggestions
- HTTP: `GET /api/v1alpha1/compute-power-collaboration/suggestions`
- Auth: required
- Body: none
- Flags:
  - `--query.cluster` (query): Optional cluster filter; when empty, all clusters are aggregated.
  - `--query.range` (query): Optional time range token: 24h, 7d or 1m. Defaults to 24h.
  - `--query.timezone` (query): Optional IANA timezone (e.g. "Asia/Shanghai") for rendering x-axis
- Output: list path `items`; columns `code`, `messageKey`, `severity`

### `dce crane computepowercollaborationservice get-synergy-value`

- Summary: ComputePowerCollaborationService_GetSynergyValue
- HTTP: `GET /api/v1alpha1/compute-power-collaboration/synergy-value`
- Auth: required
- Body: none
- Flags:
  - `--query.cluster` (query): Optional cluster filter; when empty, all clusters are aggregated.
  - `--query.range` (query): Optional time range token: 24h, 7d or 1m. Defaults to 24h.
  - `--query.timezone` (query): Optional IANA timezone (e.g. "Asia/Shanghai") for rendering x-axis
- Output: list path `items`; columns `id`, `precision`, `status`, `trend`, `trendPrecision`, `trendUnit`

## FinopsPanelService

### `dce crane finopspanelservice get-allocation-summary`

- Summary: FinopsPanelService_GetAllocationSummary
- HTTP: `GET /api/v1alpha1/finops/allocation-summary`
- Auth: required
- Body: none
- Flags:
  - `--financial-period` (query, default `FINANCIAL_PERIOD_THIS_MONTH`, one of: FINANCIAL_PERIOD_THIS_MONTH|FINANCIAL_PERIOD_LAST_MONTH|FINANCIAL_PERIOD_THIS_QUARTER|FINANCIAL_PERIOD_THIS_YEAR): financialPeriod
  - `--accounting-scope` (query, default `ACCOUNTING_SCOPE_MERGED`, one of: ACCOUNTING_SCOPE_MERGED|ACCOUNTING_SCOPE_EXTERNAL_REVENUE|ACCOUNTING_SCOPE_INTERNAL_ALLOCATION): accountingScope
- Output: list path `rows`; columns `type`, `allocCost`, `object`, `revenue`, `roi`, `tokenUsage`

### `dce crane finopspanelservice get-asset-machine-count`

- Summary: FinopsPanelService_GetAssetMachineCount
- HTTP: `GET /api/v1alpha1/finops/asset-machine-count`
- Auth: required
- Body: none
- Flags:
  - `--financial-period` (query, default `FINANCIAL_PERIOD_THIS_MONTH`, one of: FINANCIAL_PERIOD_THIS_MONTH|FINANCIAL_PERIOD_LAST_MONTH|FINANCIAL_PERIOD_THIS_QUARTER|FINANCIAL_PERIOD_THIS_YEAR): financialPeriod
  - `--accounting-scope` (query, default `ACCOUNTING_SCOPE_MERGED`, one of: ACCOUNTING_SCOPE_MERGED|ACCOUNTING_SCOPE_EXTERNAL_REVENUE|ACCOUNTING_SCOPE_INTERNAL_ALLOCATION): accountingScope

### `dce crane finopspanelservice get-asset-return-matrix`

- Summary: FinopsPanelService_GetAssetReturnMatrix
- HTTP: `GET /api/v1alpha1/finops/asset-return-matrix`
- Auth: required
- Body: none
- Flags:
  - `--financial-period` (query, default `FINANCIAL_PERIOD_THIS_MONTH`, one of: FINANCIAL_PERIOD_THIS_MONTH|FINANCIAL_PERIOD_LAST_MONTH|FINANCIAL_PERIOD_THIS_QUARTER|FINANCIAL_PERIOD_THIS_YEAR): financialPeriod
  - `--accounting-scope` (query, default `ACCOUNTING_SCOPE_MERGED`, one of: ACCOUNTING_SCOPE_MERGED|ACCOUNTING_SCOPE_EXTERNAL_REVENUE|ACCOUNTING_SCOPE_INTERNAL_ALLOCATION): accountingScope
- Output: list path `points`; columns `bookValue`, `machine`, `profitValue`, `status`, `utilization`

### `dce crane finopspanelservice get-average-machine-profit`

- Summary: FinopsPanelService_GetAverageMachineProfit
- HTTP: `GET /api/v1alpha1/finops/average-machine-profit`
- Auth: required
- Body: none
- Flags:
  - `--financial-period` (query, default `FINANCIAL_PERIOD_THIS_MONTH`, one of: FINANCIAL_PERIOD_THIS_MONTH|FINANCIAL_PERIOD_LAST_MONTH|FINANCIAL_PERIOD_THIS_QUARTER|FINANCIAL_PERIOD_THIS_YEAR): financialPeriod
  - `--accounting-scope` (query, default `ACCOUNTING_SCOPE_MERGED`, one of: ACCOUNTING_SCOPE_MERGED|ACCOUNTING_SCOPE_EXTERNAL_REVENUE|ACCOUNTING_SCOPE_INTERNAL_ALLOCATION): accountingScope

### `dce crane finopspanelservice get-average-machine-revenue`

- Summary: FinopsPanelService_GetAverageMachineRevenue
- HTTP: `GET /api/v1alpha1/finops/average-machine-revenue`
- Auth: required
- Body: none
- Flags:
  - `--financial-period` (query, default `FINANCIAL_PERIOD_THIS_MONTH`, one of: FINANCIAL_PERIOD_THIS_MONTH|FINANCIAL_PERIOD_LAST_MONTH|FINANCIAL_PERIOD_THIS_QUARTER|FINANCIAL_PERIOD_THIS_YEAR): financialPeriod
  - `--accounting-scope` (query, default `ACCOUNTING_SCOPE_MERGED`, one of: ACCOUNTING_SCOPE_MERGED|ACCOUNTING_SCOPE_EXTERNAL_REVENUE|ACCOUNTING_SCOPE_INTERNAL_ALLOCATION): accountingScope

### `dce crane finopspanelservice get-budget-forecast`

- Summary: FinopsPanelService_GetBudgetForecast
- HTTP: `GET /api/v1alpha1/finops/budget-forecast`
- Auth: required
- Body: none
- Flags:
  - `--financial-period` (query, default `FINANCIAL_PERIOD_THIS_MONTH`, one of: FINANCIAL_PERIOD_THIS_MONTH|FINANCIAL_PERIOD_LAST_MONTH|FINANCIAL_PERIOD_THIS_QUARTER|FINANCIAL_PERIOD_THIS_YEAR): financialPeriod
  - `--accounting-scope` (query, default `ACCOUNTING_SCOPE_MERGED`, one of: ACCOUNTING_SCOPE_MERGED|ACCOUNTING_SCOPE_EXTERNAL_REVENUE|ACCOUNTING_SCOPE_INTERNAL_ALLOCATION): accountingScope
- Output: list path `categories`

### `dce crane finopspanelservice get-budget-remaining`

- Summary: FinopsPanelService_GetBudgetRemaining
- HTTP: `GET /api/v1alpha1/finops/budget-remaining`
- Auth: required
- Body: none
- Flags:
  - `--financial-period` (query, default `FINANCIAL_PERIOD_THIS_MONTH`, one of: FINANCIAL_PERIOD_THIS_MONTH|FINANCIAL_PERIOD_LAST_MONTH|FINANCIAL_PERIOD_THIS_QUARTER|FINANCIAL_PERIOD_THIS_YEAR): financialPeriod
  - `--accounting-scope` (query, default `ACCOUNTING_SCOPE_MERGED`, one of: ACCOUNTING_SCOPE_MERGED|ACCOUNTING_SCOPE_EXTERNAL_REVENUE|ACCOUNTING_SCOPE_INTERNAL_ALLOCATION): accountingScope

### `dce crane finopspanelservice get-cost-recovery-rate`

- Summary: FinopsPanelService_GetCostRecoveryRate
- HTTP: `GET /api/v1alpha1/finops/cost-recovery-rate`
- Auth: required
- Body: none
- Flags:
  - `--financial-period` (query, default `FINANCIAL_PERIOD_THIS_MONTH`, one of: FINANCIAL_PERIOD_THIS_MONTH|FINANCIAL_PERIOD_LAST_MONTH|FINANCIAL_PERIOD_THIS_QUARTER|FINANCIAL_PERIOD_THIS_YEAR): financialPeriod
  - `--accounting-scope` (query, default `ACCOUNTING_SCOPE_MERGED`, one of: ACCOUNTING_SCOPE_MERGED|ACCOUNTING_SCOPE_EXTERNAL_REVENUE|ACCOUNTING_SCOPE_INTERNAL_ALLOCATION): accountingScope

### `dce crane finopspanelservice get-cost-structure-breakdown`

- Summary: FinopsPanelService_GetCostStructureBreakdown
- HTTP: `GET /api/v1alpha1/finops/cost-structure-breakdown`
- Auth: required
- Body: none
- Flags:
  - `--financial-period` (query, default `FINANCIAL_PERIOD_THIS_MONTH`, one of: FINANCIAL_PERIOD_THIS_MONTH|FINANCIAL_PERIOD_LAST_MONTH|FINANCIAL_PERIOD_THIS_QUARTER|FINANCIAL_PERIOD_THIS_YEAR): financialPeriod
  - `--accounting-scope` (query, default `ACCOUNTING_SCOPE_MERGED`, one of: ACCOUNTING_SCOPE_MERGED|ACCOUNTING_SCOPE_EXTERNAL_REVENUE|ACCOUNTING_SCOPE_INTERNAL_ALLOCATION): accountingScope
- Output: list path `items`; columns `name`, `displayValue`, `rank`, `value`

### `dce crane finopspanelservice get-expansion-impact`

- Summary: FinopsPanelService_GetExpansionImpact
- HTTP: `GET /api/v1alpha1/finops/expansion-impact`
- Auth: required
- Body: none
- Flags:
  - `--financial-period` (query, default `FINANCIAL_PERIOD_THIS_MONTH`, one of: FINANCIAL_PERIOD_THIS_MONTH|FINANCIAL_PERIOD_LAST_MONTH|FINANCIAL_PERIOD_THIS_QUARTER|FINANCIAL_PERIOD_THIS_YEAR): financialPeriod
  - `--accounting-scope` (query, default `ACCOUNTING_SCOPE_MERGED`, one of: ACCOUNTING_SCOPE_MERGED|ACCOUNTING_SCOPE_EXTERNAL_REVENUE|ACCOUNTING_SCOPE_INTERNAL_ALLOCATION): accountingScope
- Output: list path `rows`; columns `addedCost`, `expectedRevenue`, `plan`, `profitImpact`, `recommendation`, `recoveryPeriod`

### `dce crane finopspanelservice get-finops-suggestions`

- Summary: FinopsPanelService_GetFinopsSuggestions
- HTTP: `GET /api/v1alpha1/finops/suggestions`
- Auth: required
- Body: none
- Flags:
  - `--financial-period` (query, default `FINANCIAL_PERIOD_THIS_MONTH`, one of: FINANCIAL_PERIOD_THIS_MONTH|FINANCIAL_PERIOD_LAST_MONTH|FINANCIAL_PERIOD_THIS_QUARTER|FINANCIAL_PERIOD_THIS_YEAR): financialPeriod
  - `--accounting-scope` (query, default `ACCOUNTING_SCOPE_MERGED`, one of: ACCOUNTING_SCOPE_MERGED|ACCOUNTING_SCOPE_EXTERNAL_REVENUE|ACCOUNTING_SCOPE_INTERNAL_ALLOCATION): accountingScope
- Output: list path `items`; columns `type`, `content`

### `dce crane finopspanelservice get-machine-asset-ranking`

- Summary: FinopsPanelService_GetMachineAssetRanking
- HTTP: `GET /api/v1alpha1/finops/machine-asset-ranking`
- Auth: required
- Body: none
- Flags:
  - `--financial-period` (query, default `FINANCIAL_PERIOD_THIS_MONTH`, one of: FINANCIAL_PERIOD_THIS_MONTH|FINANCIAL_PERIOD_LAST_MONTH|FINANCIAL_PERIOD_THIS_QUARTER|FINANCIAL_PERIOD_THIS_YEAR): financialPeriod
  - `--accounting-scope` (query, default `ACCOUNTING_SCOPE_MERGED`, one of: ACCOUNTING_SCOPE_MERGED|ACCOUNTING_SCOPE_EXTERNAL_REVENUE|ACCOUNTING_SCOPE_INTERNAL_ALLOCATION): accountingScope
- Output: list path `rows`; columns `bookValue`, `config`, `depreciation`, `machine`, `monthToken`, `payback`

### `dce crane finopspanelservice get-monthly-cost`

- Summary: FinopsPanelService_GetMonthlyCost
- HTTP: `GET /api/v1alpha1/finops/monthly-cost`
- Auth: required
- Body: none
- Flags:
  - `--financial-period` (query, default `FINANCIAL_PERIOD_THIS_MONTH`, one of: FINANCIAL_PERIOD_THIS_MONTH|FINANCIAL_PERIOD_LAST_MONTH|FINANCIAL_PERIOD_THIS_QUARTER|FINANCIAL_PERIOD_THIS_YEAR): financialPeriod
  - `--accounting-scope` (query, default `ACCOUNTING_SCOPE_MERGED`, one of: ACCOUNTING_SCOPE_MERGED|ACCOUNTING_SCOPE_EXTERNAL_REVENUE|ACCOUNTING_SCOPE_INTERNAL_ALLOCATION): accountingScope

### `dce crane finopspanelservice get-monthly-profit`

- Summary: FinopsPanelService_GetMonthlyProfit
- HTTP: `GET /api/v1alpha1/finops/monthly-profit`
- Auth: required
- Body: none
- Flags:
  - `--financial-period` (query, default `FINANCIAL_PERIOD_THIS_MONTH`, one of: FINANCIAL_PERIOD_THIS_MONTH|FINANCIAL_PERIOD_LAST_MONTH|FINANCIAL_PERIOD_THIS_QUARTER|FINANCIAL_PERIOD_THIS_YEAR): financialPeriod
  - `--accounting-scope` (query, default `ACCOUNTING_SCOPE_MERGED`, one of: ACCOUNTING_SCOPE_MERGED|ACCOUNTING_SCOPE_EXTERNAL_REVENUE|ACCOUNTING_SCOPE_INTERNAL_ALLOCATION): accountingScope

### `dce crane finopspanelservice get-monthly-revenue`

- Summary: FinopsPanelService_GetMonthlyRevenue
- HTTP: `GET /api/v1alpha1/finops/monthly-revenue`
- Auth: required
- Body: none
- Flags:
  - `--financial-period` (query, default `FINANCIAL_PERIOD_THIS_MONTH`, one of: FINANCIAL_PERIOD_THIS_MONTH|FINANCIAL_PERIOD_LAST_MONTH|FINANCIAL_PERIOD_THIS_QUARTER|FINANCIAL_PERIOD_THIS_YEAR): financialPeriod
  - `--accounting-scope` (query, default `ACCOUNTING_SCOPE_MERGED`, one of: ACCOUNTING_SCOPE_MERGED|ACCOUNTING_SCOPE_EXTERNAL_REVENUE|ACCOUNTING_SCOPE_INTERNAL_ALLOCATION): accountingScope

### `dce crane finopspanelservice get-revenue-cost-trend`

- Summary: FinopsPanelService_GetRevenueCostTrend
- HTTP: `GET /api/v1alpha1/finops/revenue-cost-trend`
- Auth: required
- Body: none
- Flags:
  - `--financial-period` (query, default `FINANCIAL_PERIOD_THIS_MONTH`, one of: FINANCIAL_PERIOD_THIS_MONTH|FINANCIAL_PERIOD_LAST_MONTH|FINANCIAL_PERIOD_THIS_QUARTER|FINANCIAL_PERIOD_THIS_YEAR): financialPeriod
  - `--accounting-scope` (query, default `ACCOUNTING_SCOPE_MERGED`, one of: ACCOUNTING_SCOPE_MERGED|ACCOUNTING_SCOPE_EXTERNAL_REVENUE|ACCOUNTING_SCOPE_INTERNAL_ALLOCATION): accountingScope
- Output: list path `categories`

### `dce crane finopspanelservice get-unit-token-cost`

- Summary: FinopsPanelService_GetUnitTokenCost
- HTTP: `GET /api/v1alpha1/finops/unit-token-cost`
- Auth: required
- Body: none
- Flags:
  - `--financial-period` (query, default `FINANCIAL_PERIOD_THIS_MONTH`, one of: FINANCIAL_PERIOD_THIS_MONTH|FINANCIAL_PERIOD_LAST_MONTH|FINANCIAL_PERIOD_THIS_QUARTER|FINANCIAL_PERIOD_THIS_YEAR): financialPeriod
  - `--accounting-scope` (query, default `ACCOUNTING_SCOPE_MERGED`, one of: ACCOUNTING_SCOPE_MERGED|ACCOUNTING_SCOPE_EXTERNAL_REVENUE|ACCOUNTING_SCOPE_INTERNAL_ALLOCATION): accountingScope

### `dce crane finopspanelservice get-unit-token-profit`

- Summary: FinopsPanelService_GetUnitTokenProfit
- HTTP: `GET /api/v1alpha1/finops/unit-token-profit`
- Auth: required
- Body: none
- Flags:
  - `--financial-period` (query, default `FINANCIAL_PERIOD_THIS_MONTH`, one of: FINANCIAL_PERIOD_THIS_MONTH|FINANCIAL_PERIOD_LAST_MONTH|FINANCIAL_PERIOD_THIS_QUARTER|FINANCIAL_PERIOD_THIS_YEAR): financialPeriod
  - `--accounting-scope` (query, default `ACCOUNTING_SCOPE_MERGED`, one of: ACCOUNTING_SCOPE_MERGED|ACCOUNTING_SCOPE_EXTERNAL_REVENUE|ACCOUNTING_SCOPE_INTERNAL_ALLOCATION): accountingScope

### `dce crane finopspanelservice get-unit-token-revenue`

- Summary: FinopsPanelService_GetUnitTokenRevenue
- HTTP: `GET /api/v1alpha1/finops/unit-token-revenue`
- Auth: required
- Body: none
- Flags:
  - `--financial-period` (query, default `FINANCIAL_PERIOD_THIS_MONTH`, one of: FINANCIAL_PERIOD_THIS_MONTH|FINANCIAL_PERIOD_LAST_MONTH|FINANCIAL_PERIOD_THIS_QUARTER|FINANCIAL_PERIOD_THIS_YEAR): financialPeriod
  - `--accounting-scope` (query, default `ACCOUNTING_SCOPE_MERGED`, one of: ACCOUNTING_SCOPE_MERGED|ACCOUNTING_SCOPE_EXTERNAL_REVENUE|ACCOUNTING_SCOPE_INTERNAL_ALLOCATION): accountingScope

### `dce crane finopspanelservice get-weighted-payback-period`

- Summary: FinopsPanelService_GetWeightedPaybackPeriod
- HTTP: `GET /api/v1alpha1/finops/weighted-payback-period`
- Auth: required
- Body: none
- Flags:
  - `--financial-period` (query, default `FINANCIAL_PERIOD_THIS_MONTH`, one of: FINANCIAL_PERIOD_THIS_MONTH|FINANCIAL_PERIOD_LAST_MONTH|FINANCIAL_PERIOD_THIS_QUARTER|FINANCIAL_PERIOD_THIS_YEAR): financialPeriod
  - `--accounting-scope` (query, default `ACCOUNTING_SCOPE_MERGED`, one of: ACCOUNTING_SCOPE_MERGED|ACCOUNTING_SCOPE_EXTERNAL_REVENUE|ACCOUNTING_SCOPE_INTERNAL_ALLOCATION): accountingScope

## PlatformConfigService

### `dce crane platformconfigservice get-runtime-mode`

- Summary: GetRuntimeMode returns the current deployment runtime mode (csp or ws).
- HTTP: `GET /api/v1alpha1/platform-config/runtime-mode`
- Auth: required
- Body: none
- Flags: none

## ProductionOperationsService

### `dce crane productionoperationsservice get-realtime-headlines`

- Summary: ProductionOperationsService_GetRealtimeHeadlines
- HTTP: `GET /api/v1alpha1/production-ops/realtime/headlines`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): cluster
- Output: list path `groupStates`; columns `key`, `message`, `status`

### `dce crane productionoperationsservice get-realtime-tab`

- Summary: ProductionOperationsService_GetRealtimeTab
- HTTP: `GET /api/v1alpha1/production-ops/realtime`
- Auth: required
- Body: none
- Flags:
  - `--time-window` (query): timeWindow
  - `--cluster` (query): cluster
  - `--sla-baseline` (query): slaBaseline
- Output: list path `groupStates`; columns `key`, `message`, `status`

### `dce crane productionoperationsservice get-synergy-tab`

- Summary: ProductionOperationsService_GetSynergyTab
- HTTP: `GET /api/v1alpha1/production-ops/synergy`
- Auth: required
- Body: none
- Flags:
  - `--time-window` (query): timeWindow
  - `--cluster` (query): cluster
  - `--sla-baseline` (query): slaBaseline
- Output: list path `gpuPoolRank`; columns `cardCount`, `dailyOutputPerCard`, `memoryUtilization`, `note`, `poolName`, `powerDraw`

## ResourceCostService

### `dce crane resourcecostservice get-cost-attribution`

- Summary: GetCostAttribution returns cost attribution breakdown.
- HTTP: `GET /api/v1alpha1/resource-cost/attribution`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): Optional cluster name filter. Empty means all clusters.
  - `--time-range` (query, default `THIS_MONTH`, one of: THIS_MONTH|THIS_WEEK|LAST_MONTH|LAST_7_DAYS|LAST_30_DAYS): Time range for token/revenue queries. Default is THIS_MONTH.
- Output: list path `items`; columns `name`, `cost`, `key`, `percent`

### `dce crane resourcecostservice get-cost-kpis`

- Summary: GetCostKpis returns GPU KPI summary metrics.
- HTTP: `GET /api/v1alpha1/resource-cost/kpis`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): Optional cluster name filter. Empty means all clusters.
  - `--time-range` (query, default `THIS_MONTH`, one of: THIS_MONTH|THIS_WEEK|LAST_MONTH|LAST_7_DAYS|LAST_30_DAYS): Time range for token/revenue queries. Default is THIS_MONTH.

### `dce crane resourcecostservice get-cost-optimization`

- Summary: GetCostOptimization returns cost optimization measures.
- HTTP: `GET /api/v1alpha1/resource-cost/optimization`
- Auth: required
- Body: none
- Flags: none
- Output: list path `items`; columns `measure`, `value`

### `dce crane resourcecostservice get-cost-suggestions`

- Summary: GetCostSuggestions returns dynamic optimization suggestions.
- HTTP: `GET /api/v1alpha1/resource-cost/suggestions`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): Optional cluster name filter. Empty means all clusters.
  - `--time-range` (query, default `THIS_MONTH`, one of: THIS_MONTH|THIS_WEEK|LAST_MONTH|LAST_7_DAYS|LAST_30_DAYS): Time range for token/revenue queries. Default is THIS_MONTH.
- Output: list path `items`; columns `type`, `content`

### `dce crane resourcecostservice get-cost-waterfall`

- Summary: GetCostWaterfall returns cost optimization waterfall data.
- HTTP: `GET /api/v1alpha1/resource-cost/waterfall`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): Optional cluster name filter. Empty means all clusters.
  - `--time-range` (query, default `THIS_MONTH`, one of: THIS_MONTH|THIS_WEEK|LAST_MONTH|LAST_7_DAYS|LAST_30_DAYS): Time range for token/revenue queries. Default is THIS_MONTH.
- Output: list path `items`; columns `key`, `label`, `value`

### `dce crane resourcecostservice get-gpu-efficiency`

- Summary: GetGpuEfficiency returns GPU model efficiency ranking.
- HTTP: `GET /api/v1alpha1/resource-cost/gpu-efficiency`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): Optional cluster name filter. Empty means all clusters.
  - `--time-range` (query, default `THIS_MONTH`, one of: THIS_MONTH|THIS_WEEK|LAST_MONTH|LAST_7_DAYS|LAST_30_DAYS): Time range for token/revenue queries. Default is THIS_MONTH.
- Output: list path `rows`; columns `count`, `dailyCost`, `dailyOutput`, `dailyProfit`, `gpuModel`, `memUtilization`

### `dce crane resourcecostservice get-model-cost-rank`

- Summary: GetModelCostRank returns model cost ranking.
- HTTP: `GET /api/v1alpha1/resource-cost/model-cost-rank`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): Optional cluster name filter. Empty means all clusters.
  - `--time-range` (query, default `THIS_MONTH`, one of: THIS_MONTH|THIS_WEEK|LAST_MONTH|LAST_7_DAYS|LAST_30_DAYS): Time range for token/revenue queries. Default is THIS_MONTH.
- Output: list path `items`; columns `name`, `costPerMToken`, `deployType`, `rank`

### `dce crane resourcecostservice list-cost-clusters`

- Summary: ListCostClusters returns all cluster names that have GPU nodes.
- HTTP: `GET /api/v1alpha1/resource-cost/clusters`
- Auth: required
- Body: none
- Flags: none
- Output: list path `clusters`

## SecurityProtectionService

### `dce crane securityprotectionservice get-agent-protection`

- Summary: SecurityProtectionService_GetAgentProtection
- HTTP: `GET /api/v1alpha1/security-protection/agent-protection`
- Auth: required
- Body: none
- Flags:
  - `--hours` (query, int32): time window in hours (1-720, default 24)
  - `--cluster` (query): filter by cluster name
  - `--level` (query): filter by risk level: high/medium/low
- Output: list path `rows`; columns `dimension`, `intercepted`, `status`, `todayCount`

### `dce crane securityprotectionservice get-clusters`

- Summary: SecurityProtectionService_GetClusters
- HTTP: `GET /api/v1alpha1/security-protection/clusters`
- Auth: required
- Body: none
- Flags: none
- Output: list path `clusters`; columns `name`, `label`

### `dce crane securityprotectionservice get-intercept-trend`

- Summary: SecurityProtectionService_GetInterceptTrend
- HTTP: `GET /api/v1alpha1/security-protection/intercept-trend`
- Auth: required
- Body: none
- Flags:
  - `--hours` (query, int32): time window in hours (1-720, default 24)
  - `--cluster` (query): filter by cluster name
  - `--level` (query): filter by risk level: high/medium/low
- Output: list path `data`

### `dce crane securityprotectionservice get-kpis`

- Summary: SecurityProtectionService_GetKpis
- HTTP: `GET /api/v1alpha1/security-protection/kpis`
- Auth: required
- Body: none
- Flags:
  - `--hours` (query, int32): time window in hours (1-720, default 24)
  - `--cluster` (query): filter by cluster name
  - `--level` (query): filter by risk level: high/medium/low
- Output: list path `items`; columns `id`, `color`, `label`, `value`

### `dce crane securityprotectionservice get-output-protection`

- Summary: SecurityProtectionService_GetOutputProtection
- HTTP: `GET /api/v1alpha1/security-protection/output-protection`
- Auth: required
- Body: none
- Flags:
  - `--hours` (query, int32): time window in hours (1-720, default 24)
  - `--cluster` (query): filter by cluster name
  - `--level` (query): filter by risk level: high/medium/low
- Output: list path `rows`; columns `dimension`, `intercepted`, `status`, `todayCount`

### `dce crane securityprotectionservice get-risk-objects`

- Summary: SecurityProtectionService_GetRiskObjects
- HTTP: `GET /api/v1alpha1/security-protection/risk-objects`
- Auth: required
- Body: none
- Flags:
  - `--hours` (query, int32): time window in hours (1-720, default 24)
  - `--cluster` (query): filter by cluster name
  - `--level` (query): filter by risk level: high/medium/low
- Output: list path `items`; columns `name`, `color`, `displayValue`, `rank`, `value`

### `dce crane securityprotectionservice get-risk-types`

- Summary: SecurityProtectionService_GetRiskTypes
- HTTP: `GET /api/v1alpha1/security-protection/risk-types`
- Auth: required
- Body: none
- Flags:
  - `--hours` (query, int32): time window in hours (1-720, default 24)
  - `--cluster` (query): filter by cluster name
  - `--level` (query): filter by risk level: high/medium/low
- Output: list path `items`; columns `name`, `color`, `displayValue`, `rank`, `value`

### `dce crane securityprotectionservice get-suggestions`

- Summary: SecurityProtectionService_GetSuggestions
- HTTP: `GET /api/v1alpha1/security-protection/suggestions`
- Auth: required
- Body: none
- Flags:
  - `--hours` (query, int32): time window in hours (1-720, default 24)
  - `--cluster` (query): filter by cluster name
  - `--level` (query): filter by risk level: high/medium/low
- Output: list path `items`; columns `id`, `desc`, `icon`, `priority`, `title`

### `dce crane securityprotectionservice get-timeline`

- Summary: SecurityProtectionService_GetTimeline
- HTTP: `GET /api/v1alpha1/security-protection/timeline`
- Auth: required
- Body: none
- Flags:
  - `--hours` (query, int32): hours
  - `--cluster` (query): cluster
  - `--level` (query): level
  - `--page` (query, int32): page number (default 1)
  - `--page-size` (query, int32): items per page (default 10, max 100)
- Output: list path `items`; columns `level`, `status`, `text`, `time`; pagination `offset`

