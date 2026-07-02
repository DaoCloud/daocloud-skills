# Module `microservice-engine`

## Source

- Backend: `swagger`
- Repository: https://github.com/DaoCloud/daocloud-api-docs.git
- Pinned tag: `9fd0dfafa1400e6d98b14b85c9a27cd1c151f9bd`
- Files: `docs/openapi/skoala/v0.55.0.json`
- Resolved SHA: `9fd0dfafa1400e6d98b14b85c9a27cd1c151f9bd`

## AIGateway

### `dce microservice-engine aigateway create-ai-gateway`

- Summary: 创建 AI 网关
- HTTP: `POST /apis/sesame.skoala.io/v1alpha3/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/aigateways`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName

### `dce microservice-engine aigateway delete-ai-gateway`

- Summary: 删除 AI 网关
- HTTP: `DELETE /apis/sesame.skoala.io/v1alpha3/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/aigateways/{gatewayName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName

### `dce microservice-engine aigateway get-ai-gateway`

- Summary: 获取 AI 网关详情
- HTTP: `GET /apis/sesame.skoala.io/v1alpha3/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/aigateways/{gatewayName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName

### `dce microservice-engine aigateway get-ai-gateway-config`

- Summary: 获取 AI 网关配置
- HTTP: `GET /apis/sesame.skoala.io/v1alpha3/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/aigateways/{gatewayName}/config`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName

### `dce microservice-engine aigateway get-ai-gateway-menus`

- Summary: 获取 AI 网关菜单
- HTTP: `GET /apis/sesame.skoala.io/v1alpha3/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/aigateways/{gatewayName}/menus`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
- Output: list path `items`; columns `name`, `id`, `enName`, `hash`, `icon`, `order`

### `dce microservice-engine aigateway list-ai-gateway`

- Summary: 获取 AI 网关列表
- HTTP: `GET /apis/sesame.skoala.io/v1alpha3/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/aigateways`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (query): gatewayName
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `clusterName`, `clusterPhase`, `consoleUrl`, `createdAt`, `gatewayName`, `namespaceName`; pagination `offset`

### `dce microservice-engine aigateway refresh-ai-gateway-helm-status`

- Summary: 刷新 AI 网关 Helm 状态
- HTTP: `POST /apis/sesame.skoala.io/v1alpha3/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/aigateways/{gatewayName}/refresh-gateway-status`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName

### `dce microservice-engine aigateway update-ai-gateway`

- Summary: 更新 AI 网关
- HTTP: `PUT /apis/sesame.skoala.io/v1alpha3/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/aigateways/{gatewayName}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName

## ConfigCenter

### `dce microservice-engine configcenter list-hosted`

- Summary: 托管配置中心列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/hosted_config_center`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (query): clusterName
  - `--namespace-name` (query): namespaceName
  - `--type` (query): type
  - `--name` (query): name
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `name`, `type`, `clusterName`, `configCount`, `createdAt`, `healthNodeCount`; pagination `offset`

## Gateway

### `dce microservice-engine gateway create`

- Summary: 创建网关
- HTTP: `POST /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName

### `dce microservice-engine gateway create-gateway-rls-rule`

- Summary: 设置(insert)限流规则
- HTTP: `POST /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/plugins/rls/rules`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName

### `dce microservice-engine gateway create-secret`

- Summary: 创建网关 Secret
- HTTP: `POST /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/secrets`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName

### `dce microservice-engine gateway delete`

- Summary: 删除网关
- HTTP: `DELETE /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName

### `dce microservice-engine gateway delete-gateway-check`

- Summary: 删除网关检查
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/deletecheck`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
- Output: list path `gatewayUsage`; columns `canDelete`, `resourceCount`, `sesameResourceType`

### `dce microservice-engine gateway delete-gateway-rls-rule`

- Summary: 删除限流规则
- HTTP: `DELETE /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/plugins/rls/rules/{ruleName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--rule-name` (path, required): ruleName

### `dce microservice-engine gateway diagnostic`

- Summary: 网关诊断模式
- HTTP: `POST /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/diagnostic`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): TODO: common it ?
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName

### `dce microservice-engine gateway gateway-log-export`

- Summary: 导出网关日志
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/requestlogs/export`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--request-id` (query): 请求ID 精确查询
  - `--fqdn` (query): 域名 精确查询
  - `--request-path` (query): 请求路径 模糊查询
  - `--http-code` (query): http请求状态码，支持2xx,3xx,4xx,5xx和100-500
  - `--grpc-code` (query): grpc状态码
  - `--request-method` (query): 请求方法数组 精确匹配
  - `--start-time` (query, int64): 请求开始时间，毫秒
  - `--end-time` (query, int64): 请求结束时间 毫秒
  - `--sort-order.order-by` (query, default `desc`, one of: desc|asc): 正序或倒序
  - `--sort-order.sort-by` (query): 排序条件
  - `--api-name` (query): api名称，精确查询
  - `--log-type` (query, default `ALL_LOG`, one of: ALL_LOG|ACCESS_LOG|DEBUG_LOG): 日志类型
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: pagination `offset`

### `dce microservice-engine gateway gateway-log-export-url`

- Summary: 网关日志导出请求地址
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/requestlogs/exporturl`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--request-id` (query): 请求ID 精确查询
  - `--fqdn` (query): 域名 精确查询
  - `--request-path` (query): 请求路径 模糊查询
  - `--http-code` (query): http请求状态码，支持2xx,3xx,4xx,5xx和100-500
  - `--grpc-code` (query): grpc状态码
  - `--request-method` (query): 请求方法数组 精确匹配
  - `--start-time` (query, int64): 请求开始时间，毫秒
  - `--end-time` (query, int64): 请求结束时间 毫秒
  - `--sort-order.order-by` (query, default `desc`, one of: desc|asc): 正序或倒序
  - `--sort-order.sort-by` (query): 排序条件
  - `--api-name` (query): api名称，精确查询
  - `--log-type` (query, default `ALL_LOG`, one of: ALL_LOG|ACCESS_LOG|DEBUG_LOG): 日志类型
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: pagination `offset`

### `dce microservice-engine gateway gateway-overview-api-stats`

- Summary: 网关概览api调用相关数据增量统计
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/stats/api`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--topk-by` (query, default `Total`, one of: Total|Succeeded|Failed|Xx4|Xx5|Ok|ExecTime): - Total: total
  - `--begin-time` (query, int32): in second
  - `--end-time` (query, int32): default to now
- Output: list path `items`; columns `name`, `namespace`, `fail`, `ok`, `resTime`, `success`

### `dce microservice-engine gateway gateway-overview-api-top-time`

- Summary: 网关概览api调用相关数据时间段统计
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/stats/api/top/time`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--top-n` (query, int32): 查询topN
  - `--start-time` (query, int64): 开始时间
  - `--end-time` (query, int64): 结束时间
  - `--interval` (query, int64): interval
  - `--unit` (query, default `TIME_UNIT_UNSPECIFIED`, one of: TIME_UNIT_UNSPECIFIED|Day|Hour|Minute|Second|Millisecond): 时间单位
- Output: list path `items`; columns `apiName`, `count`, `duration`

### `dce microservice-engine gateway gateway-overview-basic-data`

- Summary: 网关概览基本数据
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/stats/basicdata`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName

### `dce microservice-engine gateway gateway-overview-realtime-http-stats`

- Summary: 网关概览http调用相关数据实时统计
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/stats/http/now`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--kind` (query, default `HTTP_STATS_KIND_UNSPECIFIED`, one of: HTTP_STATS_KIND_UNSPECIFIED|HttpStatsKindGateway|HttpStatsKindService|HttpStatsKindAPI): kind
- Output: list path `items`; columns `name`, `namespace`, `fail`, `ok`, `resTime`, `success`

### `dce microservice-engine gateway gateway-overview-request-count`

- Summary: 网关概览请求次数统计
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/stats/request/count`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): 集群名称
  - `--namespace-name` (path, required): 命名空间
  - `--gateway-name` (path, required): 网关名称
  - `--start-time` (query, int64): 请求开始时间,毫秒,优先级高
  - `--end-time` (query, int64): 请求结束时间,毫秒
  - `--interval` (query, int64): interval
  - `--unit` (query, default `TIME_UNIT_UNSPECIFIED`, one of: TIME_UNIT_UNSPECIFIED|Day|Hour|Minute|Second|Millisecond): 时间单位

### `dce microservice-engine gateway get`

- Summary: 网关详情
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName

### `dce microservice-engine gateway get-gateway-authz`

- Summary: 获取外部鉴权服务器当前状态:启/停
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/plugins/authz`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName

### `dce microservice-engine gateway get-gateway-authz-config`

- Summary: 获取外部鉴权服务器当前配置
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/plugins/authz/config`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName

### `dce microservice-engine gateway get-gateway-metric-dashboard`

- Summary: 网关指标数据 Grafana 面板地址
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/metrics/dashboard/{dashboardType}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--dashboard-type` (path, required, one of: DASHBOARD_TYPE_UNSPECIFIED|AppsSentinel|SesameContour|SesameEnvoy|Nacos|SentinelDashboard|AppsJvm|Seata): dashboardType
  - `--gateway-name` (query): gatewayName
  - `--from` (query): 开始时间: 时间戳(s)
  - `--to` (query): 结束时间: 时间戳(s)

### `dce microservice-engine gateway get-gateway-namespace`

- Summary: 网关所在及所纳管的 Namespace 列表
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/namespaces`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
- Output: list path `namespaces`

### `dce microservice-engine gateway get-gateway-pod`

- Summary: 网关 Pod 详情
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/pods/{podName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--pod-name` (path, required): podName

### `dce microservice-engine gateway get-gateway-rls`

- Summary: 获取限流器当前状态:启/停
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/plugins/rls`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName

### `dce microservice-engine gateway get-gateway-rls-config`

- Summary: 获取限流器当前配置
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/plugins/rls/config`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName

### `dce microservice-engine gateway get-gateway-rls-rule`

- Summary: 获取限流器当前限流规则
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/plugins/rls/rules/{ruleName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--rule-name` (path, required): ruleName

### `dce microservice-engine gateway get-pod-container-log`

- Summary: 网关 Pod 中容器日志
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/pod/{podName}/container/{container}/logs`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--pod-name` (path, required): podName
  - `--container` (path, required): container
  - `--start-time` (query, int64): 请求开始时间，毫秒
  - `--end-time` (query, int64): 请求结束时间 毫秒
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--log-search` (query): 模糊查询
- Output: list path `items`; columns `log`, `timeStamp`; pagination `offset`

### `dce microservice-engine gateway get-provisioned-components`

- Summary: 网关可用组件信息
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/components`
- Auth: required
- Body: none
- Flags: none

### `dce microservice-engine gateway get-working-components`

- Summary: 网关组件信息
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/components`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName

### `dce microservice-engine gateway list-all`

- Summary: 工作空间中网关列表
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/gateways`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--filter` (query): optional
  - `--status` (query, default `GATEWAY_STATUS_UNSPECIFIED`, one of: GATEWAY_STATUS_UNSPECIFIED|Unknown|Error|Starting|Running): - GATEWAY_STATUS_UNSPECIFIED: unknown
- Output: list path `items`; columns `apiCount`, `clusterName`, `clusterPhase`, `createdAt`, `gatewayName`, `namespaceName`; pagination `offset`

### `dce microservice-engine gateway list-cluster-gateway`

- Summary: 集群中网关列表
- HTTP: `POST /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/gateways`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
- Output: list path `items`; columns `apiCount`, `clusterName`, `clusterPhase`, `createdAt`, `gatewayName`, `namespaceName`

### `dce microservice-engine gateway list-gateway-log`

- Summary: 网关访问日志列表
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/requestlogs`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--request-id` (query): 请求ID 精确查询
  - `--fqdn` (query): 域名 精确查询
  - `--request-path` (query): 请求路径 模糊查询
  - `--http-code` (query): http请求状态码，支持2xx,3xx,4xx,5xx和100-500
  - `--grpc-code` (query): grpc状态码
  - `--request-method` (query): 请求方法数组 精确匹配
  - `--start-time` (query, int64): 请求开始时间，毫秒
  - `--end-time` (query, int64): 请求结束时间 毫秒
  - `--sort-order.order-by` (query, default `desc`, one of: desc|asc): 正序或倒序
  - `--sort-order.sort-by` (query): 排序条件
  - `--api-name` (query): api名称，精确查询
  - `--log-type` (query, default `ALL_LOG`, one of: ALL_LOG|ACCESS_LOG|DEBUG_LOG): 日志类型
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `apiName`, `authority`, `bytesReceived`, `bytesSent`, `downstreamDirectRemoteAddress`, `duration`; pagination `offset`

### `dce microservice-engine gateway list-gateway-pods`

- Summary: 网关 Pod 列表
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/pods`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--phases` (query): - PodPhaseUnknown: PodUnknown means that for some reason the state of the pod could not be obtained, typically due
  - `--component` (query, default `GATEWAY_COMPONENT_TYPE_UNSPECIFIED`, one of: GATEWAY_COMPONENT_TYPE_UNSPECIFIED|Contour|Envoy): component
  - `--page` (query, int32): page
  - `--page-size` (query, int32): Size is the data number shown per page.
- Output: list path `items`; columns `phase`, `ipFixed`, `namespaceName`, `podIp`, `podName`, `workloadName`; pagination `offset`

### `dce microservice-engine gateway list-gateway-pods-by-type`

- Summary: 网关组件的 Pod 列表
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/type/{component}/pods`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--component` (path, required, one of: GATEWAY_COMPONENT_TYPE_UNSPECIFIED|Contour|Envoy): component
- Output: list path `items`; columns `podName`

### `dce microservice-engine gateway list-gateway-rls-rule`

- Summary: 限流规则列表
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/plugins/rls/rules`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--rule-name` (query): 限流规则名称，支持模糊搜索
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `name`, `Unlimited`, `aliasName`, `key`, `value`; pagination `offset`

### `dce microservice-engine gateway list-secret`

- Summary: 网关 Secret 列表
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/secrets`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--secret-namespace-name` (query): secretNamespaceName
  - `--secret-name` (query): secretName
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `errMsg`, `secretName`, `secretNamespaceName`; pagination `offset`

### `dce microservice-engine gateway query-gateway-by-params`

- Summary: 查询网关
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/gateways/query`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--root-namespace` (query): 安装网关/或被其管辖的名字空间,即它在网关的root namespaces列表中

### `dce microservice-engine gateway query-gateway-deployments-metric`

- Summary: 基于时间点获取网关 Deployment 的 Metrics 信息
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/metric/deployments/query`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--at-time` (query, int32): atTime

### `dce microservice-engine gateway query-gateway-deployments-metric-range`

- Summary: 基于时间区间获取网关 Deployment 的 Metrics 信息
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterId}/namespaces/{namespaceName}/gateways/{gatewayName}/metric/deployments/queryrange`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-id` (path, required): clusterId
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--start-time` (query, int32): startTime
  - `--end-time` (query, int32): endTime
  - `--step` (query, int32): step
- Output: list path `contour`; columns `errorMessage`, `status`

### `dce microservice-engine gateway query-gateway-pod-metric`

- Summary: 基于时间点获取网关 Pod 的 Metrics 信息
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterId}/namespaces/{namespaceName}/gateways/{gatewayName}/metric/pods/{podName}/query`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-id` (path, required): clusterId
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--pod-name` (path, required): podName
  - `--at-time` (query, int32): atTime
- Output: list path `items`; columns `errorMessage`, `status`

### `dce microservice-engine gateway query-gateway-pod-metric-range`

- Summary: 基于时间区间获取网关 Pod 的 Metrics 信息
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterId}/namespaces/{namespaceName}/gateways/{gatewayName}/metric/pods/{podName}/queryrange`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-id` (path, required): clusterId
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--pod-name` (path, required): podName
  - `--start-time` (query, int32): startTime
  - `--end-time` (query, int32): endTime
  - `--step` (query, int32): step
- Output: list path `items`; columns `errorMessage`, `status`

### `dce microservice-engine gateway set-gateway-authz-config`

- Summary: 更新外部鉴权服务器配置
- HTTP: `PUT /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/plugins/authz/config`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName

### `dce microservice-engine gateway set-gateway-rls-config`

- Summary: 设置(update/insert)限流器配置
- HTTP: `PUT /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/plugins/rls/config`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName

### `dce microservice-engine gateway switch-gateway-authz`

- Summary: 启/停外部鉴权服务器
- HTTP: `PUT /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/plugins/authz`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName

### `dce microservice-engine gateway switch-gateway-rls`

- Summary: 启/停限流器
- HTTP: `PUT /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/plugins/rls`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName

### `dce microservice-engine gateway update`

- Summary: 更新网关
- HTTP: `PUT /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName

### `dce microservice-engine gateway update-gateway-rls-rule`

- Summary: 更新限流规则
- HTTP: `PUT /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/plugins/rls/rules/{ruleName}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--rule-name` (path, required): ruleName

## GatewayAPI

### `dce microservice-engine gatewayapi batch-operation-api`

- Summary: 批量更新 API 状态
- HTTP: `PUT /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/apis/batch`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
- Output: list path `failApi`; columns `apiName`, `reason`

### `dce microservice-engine gatewayapi create-api`

- Summary: 创建 API
- HTTP: `POST /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/apis`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName

### `dce microservice-engine gatewayapi create-gateway-api`

- Summary: 创建 API
- HTTP: `POST /apis/sesame.skoala.io/v1alpha2/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/apis`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName

### `dce microservice-engine gatewayapi debug-gateway-api`

- Summary: API 调用测试
- HTTP: `POST /apis/sesame.skoala.io/v1alpha2/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/apis/{apiName}/debug`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--api-name` (path, required): apiName

### `dce microservice-engine gatewayapi delete-api`

- Summary: 删除 API
- HTTP: `DELETE /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/apis/{apiName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--api-name` (path, required): apiName

### `dce microservice-engine gatewayapi export-api`

- Summary: 导出 API
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/apis/export`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--api-name` (query): apiName
  - `--all` (query): all

### `dce microservice-engine gatewayapi export-apiurl`

- Summary: 导出 API 请求地址
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/apis/exporturl`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--api-name` (query): apiName
  - `--all` (query): all

### `dce microservice-engine gatewayapi get-api`

- Summary: API 详情
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/apis/{apiName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--api-name` (path, required): apiName
  - `--api-group` (query): apiGroup

### `dce microservice-engine gatewayapi get-gateway-api`

- Summary: API 详情
- HTTP: `GET /apis/sesame.skoala.io/v1alpha2/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/apis/{apiName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--api-name` (path, required): apiName
- Output: list path `routeRules`

### `dce microservice-engine gatewayapi get-gateway-api-doc`

- Summary: API 文档详情
- HTTP: `GET /apis/sesame.skoala.io/v1alpha2/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/apis/{apiName}/doc`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--api-name` (path, required): apiName

### `dce microservice-engine gatewayapi import-api`

- Summary: 导入 API
- HTTP: `POST /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/apis/import`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
- Output: list path `failApi`; columns `apiName`, `reason`

### `dce microservice-engine gatewayapi import-api-check`

- Summary: 导入 API 检查
- HTTP: `POST /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/apis/import/check`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
- Output: list path `failApi`; columns `apiName`, `reason`

### `dce microservice-engine gatewayapi list-api`

- Summary: API 列表
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/apis`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--api-name` (query): apiName
  - `--api-group` (query): apiGroup
  - `--fqdn` (query): fqdn
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `apiCreateType`, `apiGroup`, `apiName`, `enabled`, `fqdn`, `matchType`; pagination `offset`

### `dce microservice-engine gatewayapi list-api-group`

- Summary: API 分组列表
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/groups`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
- Output: list path `groupNames`

### `dce microservice-engine gatewayapi list-gateway-api`

- Summary: API 列表
- HTTP: `GET /apis/sesame.skoala.io/v1alpha2/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/apis`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--api-name` (query): apiName
  - `--api-group` (query): apiGroup
  - `--fqdn` (query): fqdn
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `apiCreateType`, `apiGroup`, `apiName`, `enabled`, `fqdn`, `matchType`; pagination `offset`

### `dce microservice-engine gatewayapi query-api-by-params`

- Summary: API 查询
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/apis/query`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--service-name` (query): serviceName
- Output: list path `apiNames`

### `dce microservice-engine gatewayapi query-api-stats-metric-range`

- Summary: 查询指定时间区间内的API调用统计信息
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/apis/{apiName}/stats/http`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--api-name` (path, required): apiName
  - `--begin-time` (query, int32): in second
  - `--end-time` (query, int32): default to now
  - `--step` (query, int32): in second
  - `--calc-step` (query, int32): the step for calc

### `dce microservice-engine gatewayapi update-api`

- Summary: 更新 API
- HTTP: `PUT /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/apis/{apiName}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--api-name` (path, required): apiName

### `dce microservice-engine gatewayapi update-api-policy`

- Summary: 更新 API 高级策略
- HTTP: `PUT /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/apis/{apiName}/policies`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--api-name` (path, required): apiName

### `dce microservice-engine gatewayapi update-api-status`

- Summary: API 上下线
- HTTP: `PUT /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/apis/{apiName}/status/{enabled}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--api-name` (path, required): apiName
  - `--enabled` (path, required): true为上线 false为下线

### `dce microservice-engine gatewayapi update-gateway-api`

- Summary: 更新 API
- HTTP: `PUT /apis/sesame.skoala.io/v1alpha2/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/apis/{apiName}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--api-name` (path, required): apiName

### `dce microservice-engine gatewayapi update-gateway-api-advanced-policy`

- Summary: 更新 API 高级策略
- HTTP: `PUT /apis/sesame.skoala.io/v1alpha2/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/apis/{apiName}/policies`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--api-name` (path, required): apiName

## GatewayAPIMetrics

### `dce microservice-engine gatewayapimetrics get-api-avg-response-time`

- Summary: API 平均响应时间
- HTTP: `GET /apis/sesame.skoala.io/v1alpha2/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/apis/{apiName}/metrics/avg_response_time`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--api-name` (path, required): apiName
  - `--start-time` (query, int64): 请求开始时间,毫秒,优先级高
  - `--end-time` (query, int64): 请求结束时间,毫秒
  - `--interval` (query, int64): interval
  - `--unit` (query, default `TIME_UNIT_UNSPECIFIED`, one of: TIME_UNIT_UNSPECIFIED|Day|Hour|Minute|Second|Millisecond): 时间单位
- Output: list path `avgTimeStatistics`; columns `time`, `value`

## GatewayService

### `dce microservice-engine gatewayservice create-service`

- Summary: 创建网关接入服务
- HTTP: `POST /apis/sesame.skoala.io/v1alpha2/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/services`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName

### `dce microservice-engine gatewayservice create-service`

- Summary: 创建网关服务
- HTTP: `POST /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/services`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName

### `dce microservice-engine gatewayservice delete-service`

- Summary: 删除网关服务
- HTTP: `DELETE /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/services/{sesameId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--sesame-id` (path, required): sesameId

### `dce microservice-engine gatewayservice get-service`

- Summary: 网关服务详情
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/services/{sesameId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--sesame-id` (path, required): 服务id 格式为 sesame_service_name.sesame_namespace_name
- Output: list path `api`; columns `apiCreateType`, `apiGroup`, `apiName`, `enabled`, `fqdn`, `matchType`

### `dce microservice-engine gatewayservice get-service`

- Summary: 网关服务详情
- HTTP: `GET /apis/sesame.skoala.io/v1alpha2/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/services/{sesameId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--sesame-id` (path, required): 服务id 格式为 sesame_service_name.sesame_namespace_name
- Output: list path `api`; columns `apiCreateType`, `apiGroup`, `apiName`, `enabled`, `fqdn`, `matchType`

### `dce microservice-engine gatewayservice list-service`

- Summary: 网关服务列表
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/services`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): 网关所在的命名空间
  - `--gateway-name` (path, required): gatewayName
  - `--service-namespace-name` (query): 服务所在的命名空间
  - `--service-name` (query): 服务名称 -> 模糊搜索
  - `--service-type` (query, default `EXTERNAL_SERVICE`, one of: EXTERNAL_SERVICE|MANAGE_SERVICE|PLUGIN_SERVICE|LANE_SERVICE): 服务类型
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `apiCount`, `createdAt`, `serviceName`, `serviceType`, `sesameId`; pagination `offset`

### `dce microservice-engine gatewayservice list-service`

- Summary: 网关服务列表
- HTTP: `GET /apis/sesame.skoala.io/v1alpha2/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/services`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): 网关所在的命名空间
  - `--gateway-name` (path, required): gatewayName
  - `--service-namespace-name` (query): 服务所在的命名空间
  - `--service-name` (query): 服务名称 -> 模糊搜索
  - `--service-type` (query, default `EXTERNAL_SERVICE`, one of: EXTERNAL_SERVICE|MANAGE_SERVICE|PLUGIN_SERVICE|LANE_SERVICE): 服务类型
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `apiCount`, `createdAt`, `serviceName`, `serviceType`, `sesameId`; pagination `offset`

### `dce microservice-engine gatewayservice list-service-secret`

- Summary: 网关服务可用 Secret 列表
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/servicesecrets`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
- Output: list path `items`; columns `secretName`, `secretNamespaceName`

### `dce microservice-engine gatewayservice update-service`

- Summary: 更新网关服务
- HTTP: `PUT /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/services/{sesameId}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--sesame-id` (path, required): 服务id 格式为 sesame_service_name.sesame_namespace_name

### `dce microservice-engine gatewayservice update-service`

- Summary: 更新网关接入服务
- HTTP: `PUT /apis/sesame.skoala.io/v1alpha2/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/services/{sesameId}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--sesame-id` (path, required): 服务id 格式为 sesame_service_name.sesame_namespace_name

### `dce microservice-engine gatewayservice update-service-policy`

- Summary: 更新网关服务策略
- HTTP: `PUT /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/services/{sesameId}/policies`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--sesame-id` (path, required): sesameId

### `dce microservice-engine gatewayservice update-service-policy`

- Summary: 更新网关服务策略
- HTTP: `PUT /apis/sesame.skoala.io/v1alpha2/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/services/{sesameId}/policies`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--sesame-id` (path, required): sesameId

## Grafana

### `dce microservice-engine grafana get-apps-sentinel-grafana`

- Summary: Sentinel 治理的服务（App）指标 Grafana 面板 URL
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/sentinels/{sentinel}/apps/{app}/grafana`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--sentinel` (path, required): sentinel
  - `--app` (path, required): app
  - `--instance-ips` (query): 实例 ip
  - `--resource` (query): 资源
  - `--from` (query): 开始时间: 时间戳(s)
  - `--to` (query): 结束时间: 时间戳(s)
- Output: list path `url`

### `dce microservice-engine grafana get-nacos-grafana`

- Summary: Nacos 指标 Grafana 面板 URL
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/grafana`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--from` (query): 开始时间: 时间戳(s)
  - `--to` (query): 结束时间: 时间戳(s)

### `dce microservice-engine grafana get-seata-grafana`

- Summary: Seata 指标 Grafana 面板 URL
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/seata/{seataName}/grafana`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--seata-name` (path, required): seataName
  - `--from` (query): 开始时间: 时间戳(s)
  - `--to` (query): 结束时间: 时间戳(s)

### `dce microservice-engine grafana get-sentinel-dash-grafana`

- Summary: Sentinel Dashboard 指标 Grafana 面板 URL
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/grafana`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--instance-ip` (query): 实例 ip
  - `--from` (query): 开始时间: 时间戳(s)
  - `--to` (query): 结束时间: 时间戳(s)

## Hive

### `dce microservice-engine hive get-components`

- Summary: 组件版本信息
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/components/version`
- Auth: required
- Body: none
- Flags: none
- Output: list path `components`; columns `name`

### `dce microservice-engine hive get-version`

- Summary: 版本信息
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/version`
- Auth: required
- Body: none
- Flags: none

## Lane

### `dce microservice-engine lane action-lane`

- Summary: 更新流量泳道状态
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/lanes/{laneName}/actions/{actionName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--lane-name` (path, required): laneName
  - `--action-name` (path, required, one of: ACTION_UNSPECIFIED|ACTIVE|INACTIVE): actionName

### `dce microservice-engine lane add-lane-service`

- Summary: 添加流量泳道服务
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/lanes/{laneName}/services`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--lane-name` (path, required): laneName

### `dce microservice-engine lane create-lane`

- Summary: 创建流量泳道
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/lanes`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId

### `dce microservice-engine lane create-lane-drainage-rule`

- Summary: 创建泳道引流规则
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/lanes/{laneName}/drainagerule`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--lane-name` (path, required): laneName

### `dce microservice-engine lane delete-lane`

- Summary: 删除流量泳道
- HTTP: `DELETE /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/lanes/{laneName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--lane-name` (path, required): laneName

### `dce microservice-engine lane delete-lane-drainage-rule`

- Summary: 删除泳道引流规则
- HTTP: `DELETE /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/lanes/{laneName}/drainagerule`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--lane-name` (path, required): laneName

### `dce microservice-engine lane delete-lane-service`

- Summary: 移除流量泳道服务
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/lanes/{laneName}/services`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--lane-name` (path, required): laneName

### `dce microservice-engine lane get-lane`

- Summary: 流量泳道详情
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/lanes/{laneName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--lane-name` (path, required): laneName
- Output: list path `failedReason`

### `dce microservice-engine lane get-lane-drainage-rule`

- Summary: 泳道引流规则列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/lanes/{laneName}/drainagerule`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--lane-name` (path, required): laneName

### `dce microservice-engine lane get-lane-graph`

- Summary: 泳道拓扑
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/lanes/{laneName}/services/graph`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--lane-name` (path, required): laneName
  - `--start` (query, int64): 数据范围, 单位：秒（s）
  - `--end` (query, int64): end
- Output: list path `edges`; columns `id`, `source`, `target`

### `dce microservice-engine lane list-lane`

- Summary: 流量泳道列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/lanes`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--page-search` (query): 搜索, 形式如：name=abc或name=abc;phase=PHASE_ACTIVE
- Output: list path `items`; columns `phase`, `laneName`, `meshId`; pagination `offset`

### `dce microservice-engine lane list-lane-service`

- Summary: 流量泳道服务列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/lanes/{laneName}/services`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--lane-name` (path, required): laneName
- Output: list path `items`; columns `availableReplicas`, `namespaceName`, `replicas`, `serviceName`, `status`, `subset`

### `dce microservice-engine lane list-lane-service-gateway`

- Summary: 泳道服务的网关信息
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/lanes/{laneName}/services/{serviceName}/gateways`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--lane-name` (path, required): laneName
  - `--service-name` (path, required): serviceName
  - `--service-namespace-name` (query): serviceNamespaceName
  - `--page` (query, int32): 分页
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `gatewayCluster`, `gatewayName`, `gatewayNamespace`, `sidecarInject`; pagination `offset`

### `dce microservice-engine lane list-mesh-service`

- Summary: 可加入流量泳道的服务列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--lane-name` (query): 空值时返回所有service
- Output: list path `services`

### `dce microservice-engine lane list-mesh-service-port`

- Summary: 泳道服务端口列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/lanes/{laneName}/namespaces/{namespaceName}/services/{serviceName}/ports`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--lane-name` (path, required): laneName
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
- Output: list path `ports`

### `dce microservice-engine lane list-mesh-service-version`

- Summary: 流量泳道的服务版本列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/versions`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
- Output: list path `subsets`

### `dce microservice-engine lane update-lane-drainage-rule`

- Summary: 更新泳道引流规则
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/lanes/{laneName}/drainagerule`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--lane-name` (path, required): laneName

### `dce microservice-engine lane update-lane-drainage-rule-status`

- Summary: 更新泳道引流规则状态
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/lanes/{laneName}/drainagerule/status/{enabled}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--lane-name` (path, required): laneName
  - `--enabled` (path, required): true为上线 false为下线

## Mesh

### `dce microservice-engine mesh create-connection-pool`

- Summary: 创建云原生微服务的服务治理端口熔断规则
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/connection_pool`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName

### `dce microservice-engine mesh create-fault`

- Summary: 创建云原生微服务的服务治理端口故障注入
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/fault/{port}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--port` (path, required, int64): port

### `dce microservice-engine mesh create-mesh-resource`

- Summary: 创建服务网格对应类型的资源
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/mesh/{meshId}/istio-resources/{type}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--mesh-id` (path, required): meshId
  - `--type` (path, required, one of: RESOURCE_TYPE_UNSPECIFIED|VIRTUAL_SERVICE|DESTINATION_RULE|GATEWAY|SERVICE_ENTRY|ENVOY_FILTER|PROXY_CONFIG|SIDECAR|WORKLOAD_GROUP|WORKLOAD_ENTRY|AUTHORIZATION_POLICY|PEER_AUTHENTICATION|REQUEST_AUTHENTICATION|WASM_PLUGIN|TELEMETRY): type

### `dce microservice-engine mesh create-outlier-detection`

- Summary: 创建云原生微服务的服务治理端口离群检测
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/outlier_detection`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName

### `dce microservice-engine mesh create-retry`

- Summary: 创建云原生微服务的服务治理端口重试规则
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/retry`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName

### `dce microservice-engine mesh create-rewrite`

- Summary: 创建云原生微服务的服务治理端口重写规则
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/rewrite`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName

### `dce microservice-engine mesh create-service-istio-plugin`

- Summary: 创建云原生微服务的服务治理插件
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/ports/{ports}/istioplugin`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--ports` (path, required): ports

### `dce microservice-engine mesh create-service-istio-plugin-rls-rules`

- Summary: 为云原生微服务的服务全局限流端口绑定限流规则
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/ports/{port}/istioplugin/rls/rules`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--port` (path, required, int64): port

### `dce microservice-engine mesh create-timeout`

- Summary: 创建云原生微服务的服务治理端口超时规则
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/timeout`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName

### `dce microservice-engine mesh delete-connection-pool`

- Summary: 删除云原生微服务的服务治理端口熔断规则
- HTTP: `DELETE /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/connection_pool/{port}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--port` (path, required, int64): port

### `dce microservice-engine mesh delete-fault`

- Summary: 删除云原生微服务的服务治理端口故障注入
- HTTP: `DELETE /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/fault/{port}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--port` (path, required, int64): port

### `dce microservice-engine mesh delete-mesh-resource`

- Summary: 删除服务网格对应类型的资源
- HTTP: `DELETE /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/mesh/{meshId}/istio-resources/{type}/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--mesh-id` (path, required): meshId
  - `--type` (path, required, one of: RESOURCE_TYPE_UNSPECIFIED|VIRTUAL_SERVICE|DESTINATION_RULE|GATEWAY|SERVICE_ENTRY|ENVOY_FILTER|PROXY_CONFIG|SIDECAR|WORKLOAD_GROUP|WORKLOAD_ENTRY|AUTHORIZATION_POLICY|PEER_AUTHENTICATION|REQUEST_AUTHENTICATION|WASM_PLUGIN|TELEMETRY): type
  - `--name` (path, required): name

### `dce microservice-engine mesh delete-outlier-detection`

- Summary: 删除云原生微服务的服务治理端口离群检测
- HTTP: `DELETE /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/outlier_detection/{port}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--port` (path, required, int64): port

### `dce microservice-engine mesh delete-retry`

- Summary: 删除云原生微服务的服务治理端口重试规则
- HTTP: `DELETE /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/retry/{port}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--port` (path, required, int64): port

### `dce microservice-engine mesh delete-rewrite`

- Summary: 删除云原生微服务的服务治理端口重写规则
- HTTP: `DELETE /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/rewrite/{port}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--port` (path, required, int64): port

### `dce microservice-engine mesh delete-service-istio-plugin`

- Summary: 删除云原生微服务的服务治理插件
- HTTP: `DELETE /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/istioplugin/{pluginName}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--plugin-name` (path, required): 要删除的插件名称列表

### `dce microservice-engine mesh delete-service-istio-plugin-rls-rules`

- Summary: 为云原生微服务的服务全局限流端口删除限流规则
- HTTP: `DELETE /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/ports/{port}/istioplugin/rls/rules`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--port` (path, required, int64): port

### `dce microservice-engine mesh delete-timeout`

- Summary: 删除云原生微服务的服务治理端口超时规则
- HTTP: `DELETE /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/timeout/{port}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--port` (path, required, int64): port

### `dce microservice-engine mesh export-service`

- Summary: 将网格服务导入到云原生微服务中
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/services`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId

### `dce microservice-engine mesh get-any-type-name-by-resource-type`

- Summary: 将网格中的数据类型转化为 @type（辅助 API，无功能体现）
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/istio-resources/{type}/type-value`
- Auth: required
- Body: none
- Flags:
  - `--type` (path, required, one of: RESOURCE_TYPE_UNSPECIFIED|VIRTUAL_SERVICE|DESTINATION_RULE|GATEWAY|SERVICE_ENTRY|ENVOY_FILTER|PROXY_CONFIG|SIDECAR|WORKLOAD_GROUP|WORKLOAD_ENTRY|AUTHORIZATION_POLICY|PEER_AUTHENTICATION|REQUEST_AUTHENTICATION|WASM_PLUGIN|TELEMETRY): type

### `dce microservice-engine mesh get-connection-pool`

- Summary: 云原生微服务的服务治理端口熔断规则详情
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/connection_pool/{port}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--port` (path, required, int64): port

### `dce microservice-engine mesh get-fault`

- Summary: 云原生微服务的服务治理端口故障注入详情
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/fault/{port}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--port` (path, required, int64): port

### `dce microservice-engine mesh get-lb`

- Summary: 云原生微服务的服务治理端口负载均衡详情
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/lb/{port}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--port` (path, required, int64): port

### `dce microservice-engine mesh get-mesh-resource`

- Summary: 服务网格对应类型的资源详情
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/mesh/{meshId}/istio-resources/{type}/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--mesh-id` (path, required): meshId
  - `--type` (path, required, one of: RESOURCE_TYPE_UNSPECIFIED|VIRTUAL_SERVICE|DESTINATION_RULE|GATEWAY|SERVICE_ENTRY|ENVOY_FILTER|PROXY_CONFIG|SIDECAR|WORKLOAD_GROUP|WORKLOAD_ENTRY|AUTHORIZATION_POLICY|PEER_AUTHENTICATION|REQUEST_AUTHENTICATION|WASM_PLUGIN|TELEMETRY): type
  - `--name` (path, required): name
  - `--output` (query, default `OUTPUT_FORMAT_UNSPECIFIED`, one of: OUTPUT_FORMAT_UNSPECIFIED|YAML|SPEC): - OUTPUT_FORMAT_UNSPECIFIED: Unspecified type.

### `dce microservice-engine mesh get-outlier-detection`

- Summary: 云原生微服务的服务治理端口离群检测详情
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/outlier_detection/{port}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--port` (path, required, int64): port

### `dce microservice-engine mesh get-retry`

- Summary: 云原生微服务的服务治理端口重试规则详情
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/retry/{port}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--port` (path, required, int64): port

### `dce microservice-engine mesh get-rewrite`

- Summary: 云原生微服务的服务治理端口重写规则详情
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/rewrite/{port}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--port` (path, required, int64): port

### `dce microservice-engine mesh get-service`

- Summary: 云原生微服务的服务详情基本信息
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
- Output: list path `ports`

### `dce microservice-engine mesh get-service-govern`

- Summary: 云原生微服务的服务治理规则
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/ports/{port}/protocols/{protocol}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--port` (path, required, int64): port
  - `--protocol` (path, required, one of: GOVERN_PROTOCOL_UNSPECIFIED|GOVERN_TCP|GOVERN_HTTP|GOVERN_HTTP2|GOVERN_HTTPS|GOVERN_TLS|GOVERN_GRPC|GOVERN_UNSUPPORTED): protocol

### `dce microservice-engine mesh get-service-istio-plugin`

- Summary: 云原生微服务的服务治理插件详情
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/istioplugin/{pluginName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--plugin-name` (path, required): 插件名称，传列表的第一个元素的名称即可

### `dce microservice-engine mesh get-service-istio-plugin-rls-rules`

- Summary: 云原生微服务的服务全局限流端口限流规则详情
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/ports/{port}/istioplugin/rls/rules`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--port` (path, required, int64): port

### `dce microservice-engine mesh get-service-monitor`

- Summary: 云原生微服务的服务的监控信息
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/monitor`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--start` (query, int64): start
  - `--end` (query, int64): end

### `dce microservice-engine mesh get-timeout`

- Summary: 云原生微服务的服务治理端口超时规则详情
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/timeout/{port}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--port` (path, required, int64): port

### `dce microservice-engine mesh list-connection-pool`

- Summary: 云原生微服务的服务治理熔断规则列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/connection_pool`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
- Output: list path `items`; columns `port`

### `dce microservice-engine mesh list-export-service`

- Summary: 云原生微服务待导入服务列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/export-services`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (query): 不传或传空字符代表全部
  - `--service-name` (query): 服务名
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `name`, `namespace`, `status`; pagination `offset`

### `dce microservice-engine mesh list-fault`

- Summary: 云原生微服务的服务治理故障注入列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/fault`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
- Output: list path `items`; columns `port`

### `dce microservice-engine mesh list-lb`

- Summary: 云原生微服务的服务治理负载均衡列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/lb`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
- Output: list path `items`; columns `lb`, `port`

### `dce microservice-engine mesh list-mesh-resource`

- Summary: 服务网格对应类型的资源列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/mesh/{meshId}/istio-resources/{type}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--mesh-id` (path, required): meshId
  - `--type` (path, required, one of: RESOURCE_TYPE_UNSPECIFIED|VIRTUAL_SERVICE|DESTINATION_RULE|GATEWAY|SERVICE_ENTRY|ENVOY_FILTER|PROXY_CONFIG|SIDECAR|WORKLOAD_GROUP|WORKLOAD_ENTRY|AUTHORIZATION_POLICY|PEER_AUTHENTICATION|REQUEST_AUTHENTICATION|WASM_PLUGIN|TELEMETRY): type
  - `--output` (query, default `OUTPUT_FORMAT_UNSPECIFIED`, one of: OUTPUT_FORMAT_UNSPECIFIED|YAML|SPEC): - OUTPUT_FORMAT_UNSPECIFIED: Unspecified type.
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--page-search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `namespace`, `type`, `createTime`, `meshId`, `yaml`; pagination `offset`

### `dce microservice-engine mesh list-outlier-detection`

- Summary: 云原生微服务的服务治理离群检测列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/outlier_detection`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
- Output: list path `items`; columns `port`

### `dce microservice-engine mesh list-port`

- Summary: 云原生微服务的服务治理规则详情的端口列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/rules/{ruleName}/ports`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--rule-name` (path, required, one of: RULE_UNSPECIFIED|RULE_CONN_POOL|RULE_OUTLIER_DETECTION|RULE_REWRITE|RULE_FAULT|RULE_RETRY|RULE_TIMEOUT|RULE_LB): ruleName
- Output: list path `ports`

### `dce microservice-engine mesh list-retry`

- Summary: 云原生微服务的服务治理重试规则列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/retry`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
- Output: list path `items`; columns `port`

### `dce microservice-engine mesh list-rewrite`

- Summary: 云原生微服务的服务治理重写规则列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/rewrite`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
- Output: list path `items`; columns `port`

### `dce microservice-engine mesh list-service`

- Summary: 云原生微服务服务列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/services`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (query): 不传或传空字符代表全部
  - `--service-type` (query, default `GOVERN_TYPE_UNSPECIFIED`, one of: GOVERN_TYPE_UNSPECIFIED|NORMAL|SPRING_CLOUD|DUBBO): 服务类型
  - `--service-name` (query): 服务名
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `name`, `namespace`, `type`, `status`; pagination `offset`

### `dce microservice-engine mesh list-service-istio-plugin`

- Summary: 云原生微服务的服务治理插件列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/ports/{port}/istioplugin`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--port` (path, required): 不筛选传0
  - `--plugin-type` (query, default `JWT`, one of: JWT|AUTH|RATELIMIT|WASM|EXTPROC|UNDEFINE): - EXTPROC: ext-proc
- Output: list path `items`; columns `pluginName`, `pluginType`, `ports`, `showName`

### `dce microservice-engine mesh list-service-istio-plugin-rls-ports`

- Summary: 云原生微服务的服务全局限流端口列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/istioplugin/rls/ports`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
- Output: list path `ports`; columns `domain`, `port`, `ratelimitPluginName`

### `dce microservice-engine mesh list-service-istio-plugin-rls-rules`

- Summary: 云原生微服务的服务全局限流端口限流规则列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/istioplugin/rls/rules`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
- Output: list path `items`; columns `domain`, `port`, `ratelimitPluginName`

### `dce microservice-engine mesh list-service-port`

- Summary: 云原生微服务的服务详情端口列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/ports`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
- Output: list path `items`; columns `port`, `protocol`

### `dce microservice-engine mesh list-timeout`

- Summary: 云原生微服务的服务治理超时规则列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/timeout`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
- Output: list path `items`; columns `port`, `timeout`

### `dce microservice-engine mesh remove-service`

- Summary: 移除云原生微服务的服务
- HTTP: `DELETE /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName

### `dce microservice-engine mesh sort-service-istio-plugin`

- Summary: 对云原生微服务的服务治理插件排序
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/ports/{port}/istioplugin/sort`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--port` (path, required, int64): port

### `dce microservice-engine mesh update-connection-pool`

- Summary: 更新云原生微服务的服务治理端口熔断规则
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/connection_pool/{port}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--port` (path, required, int64): port

### `dce microservice-engine mesh update-fault`

- Summary: 更新云原生微服务的服务治理端口故障注入
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/fault/{port}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--port` (path, required, int64): port

### `dce microservice-engine mesh update-lb`

- Summary: 更新云原生微服务的服务治理端口负载均衡
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/lb/{port}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--port` (path, required, int64): port

### `dce microservice-engine mesh update-mesh-resource`

- Summary: 更新服务网格对应类型的资源
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/mesh/{meshId}/istio-resources/{type}/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--mesh-id` (path, required): meshId
  - `--type` (path, required, one of: RESOURCE_TYPE_UNSPECIFIED|VIRTUAL_SERVICE|DESTINATION_RULE|GATEWAY|SERVICE_ENTRY|ENVOY_FILTER|PROXY_CONFIG|SIDECAR|WORKLOAD_GROUP|WORKLOAD_ENTRY|AUTHORIZATION_POLICY|PEER_AUTHENTICATION|REQUEST_AUTHENTICATION|WASM_PLUGIN|TELEMETRY): type
  - `--name` (path, required): name

### `dce microservice-engine mesh update-outlier-detection`

- Summary: 更新云原生微服务的服务治理端口离群检测
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/outlier_detection/{port}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--port` (path, required, int64): port

### `dce microservice-engine mesh update-retry`

- Summary: 更新云原生微服务的服务治理端口重试规则
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/retry/{port}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--port` (path, required, int64): port

### `dce microservice-engine mesh update-rewrite`

- Summary: 更新云原生微服务的服务治理端口重写规则
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/rewrite/{port}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--port` (path, required, int64): port

### `dce microservice-engine mesh update-service-govern`

- Summary: 更新云原生微服务的服务治理规则
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/ports/{port}/protocols/{protocol}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--port` (path, required, int64): port
  - `--protocol` (path, required, one of: GOVERN_PROTOCOL_UNSPECIFIED|GOVERN_TCP|GOVERN_HTTP|GOVERN_HTTP2|GOVERN_HTTPS|GOVERN_TLS|GOVERN_GRPC|GOVERN_UNSUPPORTED): protocol

### `dce microservice-engine mesh update-service-istio-plugin`

- Summary: 更新云原生微服务的服务治理插件
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/istioplugin/{pluginName}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--plugin-name` (path, required): pluginName

### `dce microservice-engine mesh update-service-istio-plugin-rls-rules`

- Summary: 为云原生微服务的服务全局限流端口更新限流规则
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/ports/{port}/istioplugin/rls/rules`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--port` (path, required, int64): port

### `dce microservice-engine mesh update-timeout`

- Summary: 更新云原生微服务的服务治理端口超时规则
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces/{namespaceName}/services/{serviceName}/timeout/{port}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (path, required): namespaceName
  - `--service-name` (path, required): serviceName
  - `--port` (path, required, int64): port

## Nacos

### `dce microservice-engine nacos check-config`

- Summary: 检查托管 Nacos 命名空间中的配置是否存在
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces/{nacosNamespace}/configs/{dataId}/check`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (path, required): nacosNamespace
  - `--data-id` (path, required): dataId
  - `--group` (query): group

### `dce microservice-engine nacos check-namespace`

- Summary: 检查托管 Nacos 命名空间的状态
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces/{nacosNamespace}/check`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (path, required): nacosNamespace
  - `--op` (query, default `Create`, one of: Create|Delete|All): - Create: check for create

### `dce microservice-engine nacos create`

- Summary: 创建托管 Nacos
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName

### `dce microservice-engine nacos create-config`

- Summary: 创建托管 Nacos 命名空间中的配置
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces/{nacosNamespace}/configs`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (path, required): nacosNamespace

### `dce microservice-engine nacos create-namespace`

- Summary: 创建托管 Nacos 命名空间
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName

### `dce microservice-engine nacos create-service-api`

- Summary: 创建托管 Nacos 命名空间中服务的 API 信息
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces/{nacosNamespace}/services/{nacosService}/apis`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (path, required): nacosNamespace
  - `--nacos-service` (path, required): nacosService

### `dce microservice-engine nacos delete`

- Summary: 删除托管 Nacos
- HTTP: `DELETE /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName

### `dce microservice-engine nacos delete-beta-config`

- Summary: 删除托管 Nacos 命名空间中配置的灰度配置
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces/{nacosNamespace}/configs/beta`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (path, required): nacosNamespace

### `dce microservice-engine nacos delete-config`

- Summary: 删除托管 Nacos 命名空间中的配置
- HTTP: `DELETE /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces/{nacosNamespace}/configs`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (path, required): nacosNamespace

### `dce microservice-engine nacos delete-namespace`

- Summary: 删除托管 Nacos 命名空间
- HTTP: `DELETE /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces/{nacosNamespace}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (path, required): nacosNamespace

### `dce microservice-engine nacos delete-service`

- Summary: 删除托管 Nacos 命名空间中的服务
- HTTP: `DELETE /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces/{nacosNamespace}/services/{nacosService}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (path, required): nacosNamespace
  - `--nacos-service` (path, required): nacosService
  - `--nacos-group-name` (query): nacosGroupName

### `dce microservice-engine nacos delete-service-api`

- Summary: 删除托管 Nacos 命名空间中服务的 API 信息
- HTTP: `DELETE /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces/{nacosNamespace}/services/{nacosService}/apis/{apiId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (path, required): nacosNamespace
  - `--nacos-service` (path, required): nacosService
  - `--api-id` (path, required, int32): apiId
  - `--nacos-group-name` (query): nacosGroupName

### `dce microservice-engine nacos get`

- Summary: 托管 Nacos 详情
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName

### `dce microservice-engine nacos get-beta-config`

- Summary: 获取托管 Nacos 命名空间中配置的灰度配置
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces/{nacosNamespace}/configs/{dataId}/beta`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (path, required): nacosNamespace
  - `--data-id` (path, required): dataId
  - `--group` (query): group

### `dce microservice-engine nacos get-config`

- Summary: 托管 Nacos 命名空间中的配置详情
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces/{nacosNamespace}/configs/{dataId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (path, required): nacosNamespace
  - `--data-id` (path, required): dataId
  - `--group` (query): group

### `dce microservice-engine nacos get-config-history`

- Summary: 托管 Nacos 命名空间中的配置的历史记录详情
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces/{nacosNamespace}/configs/{dataId}/histories/{historyNid}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (path, required): nacosNamespace
  - `--data-id` (path, required): dataId
  - `--history-nid` (path, required): historyNid
  - `--group` (query): group

### `dce microservice-engine nacos get-namespace`

- Summary: 托管 Nacos 命名空间详情
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces/{nacosNamespace}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (path, required): nacosNamespace

### `dce microservice-engine nacos get-resource-info`

- Summary: 托管 Nacos 使用资源信息
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/info`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName

### `dce microservice-engine nacos get-service`

- Summary: 托管 Nacos 命名空间中的服务详情
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces/{nacosNamespace}/services/{nacosService}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (path, required): nacosNamespace
  - `--nacos-service` (path, required): nacosService
  - `--nacos-group-name` (query): nacosGroupName
- Output: list path `clusters`; columns `name`, `defaultCheckPort`, `defaultPort`, `serviceName`, `useIpPort4Check`

### `dce microservice-engine nacos get-service-api`

- Summary: 托管 Nacos 命名空间中服务的 API 信息
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces/{nacosNamespace}/services/{nacosService}/apis`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (path, required): nacosNamespace
  - `--nacos-service` (path, required): nacosService
  - `--nacos-group-name` (query): nacosGroupName

### `dce microservice-engine nacos get-service-insight`

- Summary: 托管 Nacos 命名空间中的服务可观测信息
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces/{nacosNamespace}/services/{nacosService}/insight`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (path, required): nacosNamespace
  - `--nacos-service` (path, required): nacosService

### `dce microservice-engine nacos get-service-instance`

- Summary: 托管 Nacos 命名空间中服务的实例详情
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces/{nacosNamespace}/services/{nacosService}/instances/{nacosInstanceId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (path, required): nacosNamespace
  - `--nacos-service` (path, required): nacosService
  - `--nacos-instance-id` (path, required): nacosInstanceId
  - `--nacos-group-name` (query): nacosGroupName
  - `--nacos-cluster-name` (query): nacosClusterName
  - `--ip` (query): ip
  - `--port` (query, int32): port
  - `--ephemeral` (query): ephemeral

### `dce microservice-engine nacos get-service-instance-insight`

- Summary: 托管 Nacos 命名空间中服务的实例可观测信息
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces/{nacosNamespace}/services/{nacosService}/instances/{nacosInstanceId}/insight`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (path, required): nacosNamespace
  - `--nacos-service` (path, required): nacosService
  - `--nacos-instance-id` (path, required): nacosInstanceId

### `dce microservice-engine nacos leave-node`

- Summary: 托管 Nacos 的集群下线
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/nodes/leave`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName

### `dce microservice-engine nacos list`

- Summary: 托管 Nacos 列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha3/nacoses`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (query): workspaceId
  - `--cluster-name` (query): clusterName
  - `--namespace-name` (query): namespaceName
  - `--nacos-name` (query): nacosName
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `type`, `certificationEnabled`, `clusterName`, `clusterPhase`, `consoleAddress`, `createAt`; pagination `offset`

### `dce microservice-engine nacos list`

- Summary: 托管 Nacos 列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/nacoses`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (query): clusterName
  - `--namespace-name` (query): namespaceName
  - `--nacos-name` (query): nacosName
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `type`, `certificationEnabled`, `clusterName`, `clusterPhase`, `consoleAddress`, `createAt`; pagination `offset`

### `dce microservice-engine nacos list-config`

- Summary: 托管 Nacos 命名空间中的配置列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces/{nacosNamespace}/configs`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (path, required): nacosNamespace
  - `--data-id` (query): dataId
  - `--group` (query): group
  - `--app-name` (query): appName
  - `--tags` (query): tags
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `type`, `id`, `appName`, `content`, `dataId`, `existBeta`; pagination `offset`

### `dce microservice-engine nacos list-config-history`

- Summary: 托管 Nacos 命名空间中的配置历史记录列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces/{nacosNamespace}/configs/{dataId}/histories`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (path, required): nacosNamespace
  - `--data-id` (path, required): dataId
  - `--group` (query): group
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `id`, `appName`, `content`, `createTime`, `dataId`, `group`; pagination `offset`

### `dce microservice-engine nacos list-config-listener`

- Summary: 托管 Nacos 命名空间中的配置监听者列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces/{nacosNamespace}/configs/{dataId}/listeners`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (path, required): nacosNamespace
  - `--data-id` (path, required): dataId
  - `--group` (query): group
  - `--ip` (query): ip
- Output: list path `items`; columns `dataId`, `group`, `ip`, `md5`

### `dce microservice-engine nacos list-ins-for-grafana`

- Summary: 托管 Nacos 命名空间中服务的实例 IP 列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces/{nacosNamespace}/services/{nacosService}/ins_for_grafana`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (path, required): nacosNamespace
  - `--nacos-service` (path, required): 多个cluster的情况下以,隔开
  - `--nacos-group-name` (query): nacosGroupName
- Output: list path `ips`

### `dce microservice-engine nacos list-namespace`

- Summary: 托管 Nacos 命名空间列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `namespace`, `type`, `configCount`, `namespaceShowName`, `quota`; pagination `offset`

### `dce microservice-engine nacos list-node`

- Summary: 托管 Nacos 的集群信息
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/nodes`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
- Output: list path `items`; columns `name`, `type`, `abilities`, `address`, `failAccessCnt`, `ip`

### `dce microservice-engine nacos list-service`

- Summary: 托管 Nacos 命名空间中的服务列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces/{nacosNamespace}/services`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (path, required): nacosNamespace
  - `--service-name` (query): serviceName
  - `--group-name` (query): groupName
  - `--is-empty` (query): isEmpty
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `name`, `clusterCount`, `governed`, `groupName`, `healthyInstanceCount`, `ipCount`; pagination `offset`

### `dce microservice-engine nacos list-service-instance`

- Summary: List service instances in a hosted Nacos namespace
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces/{nacosNamespace}/services/{nacosService}/instances`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (path, required): nacosNamespace
  - `--nacos-service` (path, required): nacosService
  - `--nacos-group-name` (query): nacosGroupName
  - `--nacos-cluster-name` (query): 多个cluster的情况下以,隔开
  - `--metadata` (query): TODO: https://github.com/alibaba/nacos/blob/develop/istio/src/main/resources/proto/mcp/v1alpha1/metadata.proto
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): pageSize
- Output: list path `items`; columns `clusterName`, `enabled`, `ephemeral`, `healthy`, `instanceHeartBeatInterval`, `instanceHeartBeatTimeOut`; pagination `offset`
- Example:

```
dce microservice-engine nacos list-service-instance \
  --workspace-id <workspace-id> \
  --cluster-name <cluster-name> \
  --namespace-name <namespace-name> \
  --nacos-name <nacos-name> \
  --nacos-namespace <nacos-namespace> \
  --nacos-service <service-name> \
  --page 1 --page-size 20
```

### `dce microservice-engine nacos list-service-subscriber`

- Summary: 托管 Nacos 命名空间中的服务订阅者列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces/{nacosNamespace}/services/{nacosService}/subscribers`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (path, required): nacosNamespace
  - `--nacos-service` (path, required): nacosService
  - `--nacos-group-name` (query): nacosGroupName
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `addrStr`, `agent`, `app`, `cluster`, `ip`, `namespaceId`; pagination `offset`

### `dce microservice-engine nacos nacos-status`

- Summary: 获取托管Nacos当前的状态
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/status`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName

### `dce microservice-engine nacos query-service-instance`

- Summary: 按metadata查询托管 Nacos服务的实例列表
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/instances`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
- Output: list path `items`; columns `clusterName`, `enabled`, `ephemeral`, `healthy`, `instanceHeartBeatInterval`, `instanceHeartBeatTimeOut`

### `dce microservice-engine nacos report-node`

- Summary: 托管 Nacos 的集群上线
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/nodes/report`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName

### `dce microservice-engine nacos restart`

- Summary: 重启托管 Nacos
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/restart`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName

### `dce microservice-engine nacos rollback-config`

- Summary: 回滚托管 Nacos 命名空间中的配置
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces/{nacosNamespace}/configs/{dataId}/rollback`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (path, required): nacosNamespace
  - `--data-id` (path, required): dataId

### `dce microservice-engine nacos update`

- Summary: 更新托管 Nacos
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName

### `dce microservice-engine nacos update-config`

- Summary: 更新托管 Nacos 命名空间中的配置
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces/{nacosNamespace}/configs/{dataId}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (path, required): nacosNamespace
  - `--data-id` (path, required): dataId

### `dce microservice-engine nacos update-namespace`

- Summary: 更新托管 Nacos 命名空间
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces/{nacosNamespace}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (path, required): nacosNamespace

### `dce microservice-engine nacos update-service`

- Summary: 更新托管 Nacos 命名空间中的服务
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces/{nacosNamespace}/services/{nacosService}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (path, required): nacosNamespace
  - `--nacos-service` (path, required): nacosService

### `dce microservice-engine nacos update-service-api`

- Summary: 更新托管 Nacos 命名空间中服务的 API 信息
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces/{nacosNamespace}/services/{nacosService}/apis/{apiId}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (path, required): nacosNamespace
  - `--nacos-service` (path, required): nacosService
  - `--api-id` (path, required, int32): apiId

### `dce microservice-engine nacos update-service-instance`

- Summary: 更新托管 Nacos 命名空间中服务的实例详情
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/namespaces/{nacosNamespace}/services/{nacosService}/instances/{nacosInstanceId}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (path, required): nacosNamespace
  - `--nacos-service` (path, required): nacosService
  - `--nacos-instance-id` (path, required): nacosInstanceId

### `dce microservice-engine nacos update-user-password`

- Summary: 修改托管 Nacos 用户密码
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacoses/{nacosName}/users`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName

## NacosPlugin

### `dce microservice-engine nacosplugin get`

- Summary: 托管 Nacos 的插件详情
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespace}/nacoses/{nacosName}/plugins/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace` (path, required): namespace
  - `--nacos-name` (path, required): nacosName
  - `--name` (path, required): name

### `dce microservice-engine nacosplugin get-govern`

- Summary: 托管 Nacos 基础信息中的服务治理信息
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespace}/nacoses/{nacosName}/governs`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace` (path, required): namespace
  - `--nacos-name` (path, required): nacosName

### `dce microservice-engine nacosplugin list`

- Summary: 托管 Nacos 的插件列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespace}/nacoses/{nacosName}/plugins`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace` (path, required): namespace
  - `--nacos-name` (path, required): nacosName
- Output: list path `items`; columns `name`, `enabled`, `meshStatus`, `seataStatus`, `sentinelStatus`

### `dce microservice-engine nacosplugin update`

- Summary: 更新托管 Nacos 的插件详情
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespace}/nacoses/{nacosName}/plugins`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace` (path, required): namespace
  - `--nacos-name` (path, required): nacosName

## Registry

### `dce microservice-engine registry create`

- Summary: 创建接入注册中心
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/registries`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId

### `dce microservice-engine registry create-service-api`

- Summary: 创建接入注册中心服务的 API 文档
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/registries/{registryId}/services/{serviceName}/apis`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--registry-id` (path, required): registryId
  - `--service-name` (path, required): serviceName

### `dce microservice-engine registry delete`

- Summary: 移除接入注册中心
- HTTP: `DELETE /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/registries/{registryId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--registry-id` (path, required): [(validator.field) = {regex: "^(ireg|book|hreg|hgtw){1}-(\\w){6,30}$"}];

### `dce microservice-engine registry delete-service-api`

- Summary: 删除接入注册中心服务的 API 文档
- HTTP: `DELETE /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/registries/{registryId}/services/{serviceName}/apis/{apiId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--registry-id` (path, required): registryId
  - `--service-name` (path, required): serviceName
  - `--api-id` (path, required, int32): apiId
  - `--data-type` (query, default `DATA_TYPE_UNSPECIFIED`, one of: DATA_TYPE_UNSPECIFIED|swagger|markdown): dataType
  - `--detail` (query): detail

### `dce microservice-engine registry get`

- Summary: 接入注册中心详情
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/registries/{registryId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--registry-id` (path, required): [(validator.field) = {regex: "^(ireg|book|hreg|hgtw){1}-(\\w){6,30}$"}];

### `dce microservice-engine registry get-instance`

- Summary: 接入注册中心服务的实例详情
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/registries/{registryId}/services/{serviceName}/instances/{instanceId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--registry-id` (path, required): registryId
  - `--service-name` (path, required): serviceName
  - `--instance-id` (path, required): instanceId
  - `--namespace-id` (query): namespaceId
  - `--group-name` (query): groupName

### `dce microservice-engine registry get-instance-insight`

- Summary: 接入注册中心服务的实例可观测信息
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/registries/{registryId}/services/{serviceName}/instances/{instanceId}/insight`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--registry-id` (path, required): registryId
  - `--service-name` (path, required): serviceName
  - `--instance-id` (path, required): instanceId

### `dce microservice-engine registry get-service`

- Summary: 接入注册中心服务详情
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/registries/{registryId}/services/{serviceName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--registry-id` (path, required): registryId
  - `--service-name` (path, required): serviceName
  - `--namespace-id` (query): namespaceId
  - `--group-name` (query): groupName
  - `--start` (query, int64): start
  - `--end` (query, int64): end

### `dce microservice-engine registry get-service-api`

- Summary: 接入注册中心服务的 API 文档
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/registries/{registryId}/services/{serviceName}/apis`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--registry-id` (path, required): registryId
  - `--service-name` (path, required): serviceName

### `dce microservice-engine registry get-service-insight`

- Summary: 接入注册中心服务的可观测数据
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/registries/{registryId}/services/{serviceName}/insight`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--registry-id` (path, required): registryId
  - `--service-name` (path, required): serviceName

### `dce microservice-engine registry list`

- Summary: 接入注册中心列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/registries`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--type` (query): type
  - `--name` (query): name
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `name`, `type`, `createdAt`, `extId`, `healthInstanceCount`, `isAuth`; pagination `offset`

### `dce microservice-engine registry list-hosted`

- Summary: 托管注册中心列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/hosted_registries`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (query): clusterName
  - `--namespace-name` (query): namespaceName
  - `--type` (query): type
  - `--name` (query): name
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `name`, `type`, `clusterName`, `createdAt`, `healthNodeCount`, `namespaceName`; pagination `offset`

### `dce microservice-engine registry list-instance`

- Summary: 接入注册中心服务的实例列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/registries/{registryId}/services/{serviceName}/instances`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--registry-id` (path, required): registryId
  - `--service-name` (path, required): serviceName
  - `--namespace-id` (query): namespaceId
  - `--group-name` (query): groupName
  - `--instance-id` (query): instanceId
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--disable-insight` (query): 是否获取insight数据，默认为获取
- Output: list path `items`; columns `id`, `enabled`, `frameworkType`, `host`, `instanceStatus`, `serviceName`; pagination `offset`

### `dce microservice-engine registry list-service`

- Summary: 接入注册中心服务列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/registries/{registryId}/services`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--registry-id` (path, required): registryId
  - `--service-name` (query): serviceName
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `name`, `healthInstanceCount`, `instanceCount`; pagination `offset`

### `dce microservice-engine registry ping`

- Summary: 接入注册中心可用性检测
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/registries/ping`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
- Output: list path `namespaces`; columns `name`, `id`

### `dce microservice-engine registry update`

- Summary: 更新接入注册中心
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/registries/{registryId}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--registry-id` (path, required): [(validator.field) = {regex: "^(ireg|book|hreg|hgtw){1}-(\\w){6,30}$"}];

### `dce microservice-engine registry update-instance`

- Summary: 更新接入注册中心服务的实例
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/registries/{registryId}/services/{serviceName}/instances/{instanceId}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--registry-id` (path, required): registryId
  - `--service-name` (path, required): serviceName
  - `--instance-id` (path, required): instanceId

### `dce microservice-engine registry update-service-api`

- Summary: 更新接入注册中心服务的 API 文档
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/registries/{registryId}/services/{serviceName}/apis/{apiId}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--registry-id` (path, required): registryId
  - `--service-name` (path, required): serviceName
  - `--api-id` (path, required, int32): apiId

## Seata

### `dce microservice-engine seata list-lock`

- Summary: 全局锁信息列表页
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/seatas/{seataName}/locks`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--seata-name` (path, required): seataName
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--time-start` (query): 创建开始时间：时间戳（ms）
  - `--time-end` (query): 创建结束时间：时间戳（ms）
  - `--xid` (query): xid
  - `--table-name` (query): tableName
  - `--transaction-id` (query): transactionId
  - `--branch-id` (query): branchId
  - `--authorization` (query): authorization
- Output: list path `items`; columns `branchId`, `gmtCreate`, `gmtModified`, `pk`, `resourceId`, `rowKey`; pagination `offset`

### `dce microservice-engine seata list-tx`

- Summary: 事务信息列表页
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/seatas/{seataName}/tx`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--seata-name` (path, required): seataName
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--with-branch` (query): 是否包含分支事务
  - `--authorization` (query): authorization
  - `--xid` (query): xid
  - `--application-id` (query): applicationId
  - `--time-start` (query): 创建开始时间：时间戳（ms）
  - `--time-end` (query): 创建结束时间：时间戳（ms）
  - `--status` (query, default `Tx_Unspecified`, one of: Tx_Unspecified|Begin|Committing|CommitRetrying|Rollbacking|RollbackRetrying|TimeoutRollbacking|TimeoutRollbackRetrying|AsyncCommitting|Committed|CommitFailed|Rollbacked|RollbackFailed|TimeoutRollbacked|TimeoutRollbackFailed|Finished|CommitRetryTimeout|RollbackRetryTimeout|UnKnown): status
- Output: list path `items`; columns `applicationData`, `applicationId`, `beginTime`, `status`, `timeout`, `transactionId`; pagination `offset`

## Sentinel

### `dce microservice-engine sentinel create-authority-rule`

- Summary: 创建服务中的 Sentinel 授权规则
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/authority-rules`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): 注册在 sentinel dashboard 的服务名

### `dce microservice-engine sentinel create-degrade-rule`

- Summary: 创建服务中的 Sentinel 熔断规则
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/degrade-rules`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): 注册在 sentinel dashboard 的服务名

### `dce microservice-engine sentinel create-flow-rule`

- Summary: 创建服务中的 Sentinel 流控规则
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/flow-rules`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): 注册在 sentinel dashboard 的服务名

### `dce microservice-engine sentinel create-or-update-token-server`

- Summary: 创建/更新服务中的 Sentinel Token 服务器
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/token-servers`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): 注册在 sentinel dashboard 的服务名

### `dce microservice-engine sentinel create-param-flow-rule`

- Summary: 创建服务中的 Sentinel 热点规则
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/param-flow-rules`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): 注册在 sentinel dashboard 的服务名

### `dce microservice-engine sentinel create-system-rule`

- Summary: 创建服务中的 Sentinel 系统规则
- HTTP: `POST /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/system-rules`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): 注册在 sentinel dashboard 的服务名

### `dce microservice-engine sentinel delete-authority-rule`

- Summary: 删除服务中的 Sentinel 授权规则
- HTTP: `DELETE /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/authority-rules/{ruleId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): 注册在 sentinel dashboard 的服务名
  - `--rule-id` (path, required, int64): ruleId

### `dce microservice-engine sentinel delete-cluster-flow`

- Summary: 删除服务中的 Sentinel 集群流控
- HTTP: `DELETE /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/cluster-flows/{serverId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): 注册在 sentinel dashboard 的服务名
  - `--server-id` (path, required): serverId

### `dce microservice-engine sentinel delete-degrade-rule`

- Summary: 删除服务中的 Sentinel 熔断规则
- HTTP: `DELETE /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/degrade-rules/{ruleId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): 注册在 sentinel dashboard 的服务名
  - `--rule-id` (path, required, int64): ruleId

### `dce microservice-engine sentinel delete-flow-rule`

- Summary: 删除服务中的 Sentinel 流控规则
- HTTP: `DELETE /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/flow-rules/{ruleId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): 注册在 sentinel dashboard 的服务名
  - `--rule-id` (path, required, int64): ruleId

### `dce microservice-engine sentinel delete-ins-govern`

- Summary: 移除服务实例中的 Sentinel 治理详情
- HTTP: `DELETE /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/governs/services/{serviceName}/instances/{instanceIp}/heartbeat-ports/{heartbeatPort}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--service-name` (path, required): serviceName
  - `--instance-ip` (path, required): instanceIp
  - `--heartbeat-port` (path, required, int32): 心跳端口

### `dce microservice-engine sentinel delete-param-flow-rule`

- Summary: 删除服务中的 Sentinel 热点规则
- HTTP: `DELETE /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/param-flow-rules/{ruleId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): 注册在 sentinel dashboard 的服务名
  - `--rule-id` (path, required, int64): ruleId

### `dce microservice-engine sentinel delete-system-rule`

- Summary: 删除服务中的 Sentinel 系统规则
- HTTP: `DELETE /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/system-rules/{ruleId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): 注册在 sentinel dashboard 的服务名
  - `--rule-id` (path, required, int64): ruleId

### `dce microservice-engine sentinel get-authority-rule`

- Summary: 服务中的 Sentinel 授权规则详情
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/authority-rules/{ruleId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): 注册在 sentinel dashboard 的服务名
  - `--rule-id` (path, required, int64): ruleId

### `dce microservice-engine sentinel get-cluster-flow`

- Summary: 服务中的 Sentinel 集群流控 Token 服务器详情
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/tokenservers/{tokenServer}/cluster-flows`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): 注册在 sentinel dashboard 的服务名
  - `--token-server` (path, required): token server id，格式比如为 10.64.1.158@8722
- Output: list path `clients`

### `dce microservice-engine sentinel get-degrade-rule`

- Summary: 服务中的 Sentinel 熔断规则详情
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/degrade-rules/{ruleId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): 注册在 sentinel dashboard 的服务名
  - `--rule-id` (path, required, int64): ruleId

### `dce microservice-engine sentinel get-flow-rule`

- Summary: 服务中的 Sentinel 流控规则详情
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/flow-rules/{ruleId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): 注册在 sentinel dashboard 的服务名
  - `--rule-id` (path, required, int64): ruleId

### `dce microservice-engine sentinel get-ins-govern`

- Summary: 服务实例中的 Sentinel 治理详情
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/governs`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--service-name` (query): serviceName
  - `--instance-ip` (query): instanceIp
  - `--nacos-namespace` (query): nacosNamespace
  - `--nacos-group` (query): nacosGroup

### `dce microservice-engine sentinel get-param-flow-rule`

- Summary: 服务中的 Sentinel 热点规则详情
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/param-flow-rules/{ruleId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): 注册在 sentinel dashboard 的服务名
  - `--rule-id` (path, required, int64): ruleId

### `dce microservice-engine sentinel get-rules-count`

- Summary: 服务中的 Sentinel 治理规则总数
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/counts`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): appName

### `dce microservice-engine sentinel get-system-rule`

- Summary: 服务中的 Sentinel 系统规则详情
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/system-rules/{ruleId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): 注册在 sentinel dashboard 的服务名
  - `--rule-id` (path, required, int64): ruleId

### `dce microservice-engine sentinel list-app`

- Summary: Sentinel 中的服务（App）列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
- Output: list path `items`

### `dce microservice-engine sentinel list-authority-rule`

- Summary: 服务中的 Sentinel 授权规则列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/authority-rules`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): 注册在 sentinel dashboard 的服务名
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--resource` (query): 模糊搜索资源名字段
- Output: list path `items`; columns `id`, `app`, `ip`, `limitApp`, `port`, `resource`; pagination `offset`

### `dce microservice-engine sentinel list-cluster-flow`

- Summary: 服务中的 Sentinel 集群流控列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/cluster-flows`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): 注册在 sentinel dashboard 的服务名
  - `--server-id` (query): 模糊搜索服务器标识字段
- Output: list path `items`

### `dce microservice-engine sentinel list-degrade-rule`

- Summary: 服务中的 Sentinel 熔断规则列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/degrade-rules`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): 注册在 sentinel dashboard 的服务名
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--resource` (query): 模糊搜索资源名字段
- Output: list path `items`; columns `id`, `app`, `count`, `grade`, `ip`, `limitApp`; pagination `offset`

### `dce microservice-engine sentinel list-flow-rule`

- Summary: 服务中的 Sentinel 流控规则列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/flow-rules`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): 注册在 sentinel dashboard 的服务名
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--resource` (query): 模糊搜索资源名字段
- Output: list path `items`; columns `id`, `app`, `clusterMode`, `controlBehavior`, `count`, `grade`; pagination `offset`

### `dce microservice-engine sentinel list-param-flow-rule`

- Summary: 服务中的 Sentinel 热点规则列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/param-flow-rules`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): 注册在 sentinel dashboard 的服务名
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--resource` (query): 模糊搜索资源名字段
- Output: list path `items`; columns `id`, `app`, `count`, `durationInSec`, `grade`, `ip`; pagination `offset`

### `dce microservice-engine sentinel list-resource`

- Summary: 服务中的 Sentinel 资源列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/resources`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): 注册在 sentinel dashboard 的服务名
  - `--instance-ips` (query): 实例 ip
- Output: list path `items`; columns `resource`

### `dce microservice-engine sentinel list-system-rule`

- Summary: 服务中的 Sentinel 系统规则列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/system-rules`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): 注册在 sentinel dashboard 的服务名
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `id`, `app`, `avgRt`, `highestCpuUsage`, `highestSystemLoad`, `ip`; pagination `offset`

### `dce microservice-engine sentinel list-token-server`

- Summary: 服务中的 Sentinel Token 服务器列表
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/token-servers`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): 注册在 sentinel dashboard 的服务名
- Output: list path `items`

### `dce microservice-engine sentinel update-authority-rule`

- Summary: 更新服务中的 Sentinel 授权规则
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/authority-rules/{ruleId}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): 注册在 sentinel dashboard 的服务名
  - `--rule-id` (path, required, int64): ruleId

### `dce microservice-engine sentinel update-degrade-rule`

- Summary: 更新服务中的 Sentinel 熔断规则
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/degrade-rules/{ruleId}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): 注册在 sentinel dashboard 的服务名
  - `--rule-id` (path, required, int64): ruleId

### `dce microservice-engine sentinel update-flow-rule`

- Summary: 更新服务中的 Sentinel 流控规则
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/flow-rules/{ruleId}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): 注册在 sentinel dashboard 的服务名
  - `--rule-id` (path, required, int64): ruleId

### `dce microservice-engine sentinel update-param-flow-rule`

- Summary: 更新服务中的 Sentinel 热点规则
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/param-flow-rules/{ruleId}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): 注册在 sentinel dashboard 的服务名
  - `--rule-id` (path, required, int64): ruleId

### `dce microservice-engine sentinel update-system-rule`

- Summary: 更新服务中的 Sentinel 系统规则
- HTTP: `PUT /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/sentinels/{sentinelName}/apps/{appName}/system-rules/{ruleId}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--sentinel-name` (path, required): sentinelName
  - `--app-name` (path, required): 注册在 sentinel dashboard 的服务名
  - `--rule-id` (path, required, int64): ruleId

## Sesame

### `dce microservice-engine sesame get-components`

- Summary: 组件版本信息
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/components/version`
- Auth: required
- Body: none
- Flags: none
- Output: list path `components`; columns `name`

### `dce microservice-engine sesame get-version`

- Summary: 版本信息
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/version`
- Auth: required
- Body: none
- Flags: none

## Skoala

### `dce microservice-engine skoala check-mid-module`

- Summary: 检测某集群的中间件模块支持情况
- HTTP: `GET /apis/skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/check_mid_module`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: pagination `offset`

### `dce microservice-engine skoala get-node-port-status`

- Summary: 集群 NodePort 占用检测
- HTTP: `GET /apis/skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/nodeport/{portNumber}/status`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--port-number` (path, required, int32): portNumber

### `dce microservice-engine skoala get-prerequisite`

- Summary: 环境前置条件检测
- HTTP: `GET /apis/skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/prerequisites/{prerequisite}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--prerequisite` (path, required, one of: PREREQUISITE_UNSPECIFIED|InsightAgent|SkoalaInit|InsightTracing|MetalLb): prerequisite

### `dce microservice-engine skoala get-resource-quota`

- Summary: 资源 Quota 检测
- HTTP: `GET /apis/skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/resource_quota/{resourceQuotaName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--resource-quota-name` (path, required): resourceQuotaName

### `dce microservice-engine skoala get-swagger-detail`

- Summary: 获取swagger
- HTTP: `GET /apis/skoala.io/v1alpha1/swagger`
- Auth: required
- Body: none
- Flags:
  - `--swagger-url` (query): swaggerUrl

### `dce microservice-engine skoala get-workspace`

- Summary: Workspace 详情
- HTTP: `GET /apis/skoala.io/v1alpha1/workspaces/{workspaceId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId

### `dce microservice-engine skoala list-alerts`

- Summary: 告警信息列表
- HTTP: `GET /apis/skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/{componentsType}/{componentsName}/alerts`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--components-type` (path, required, one of: nacos|gateway): 组件类型 nacos,gateway
  - `--components-name` (path, required): 组件name
- Output: list path `items`; columns `description`, `ruleName`, `severity`, `startAt`, `targetName`, `targetType`

### `dce microservice-engine skoala list-audit`

- Summary: 审计日志列表
- HTTP: `GET /apis/skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/audits`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--start-time` (query, int32): 以秒计
  - `--end-time` (query, int32): endTime
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `name`, `id`, `logTime`, `resourceName`, `resourceType`, `status`; pagination `offset`

### `dce microservice-engine skoala list-cluster`

- Summary: 集群列表
- HTTP: `GET /apis/skoala.io/v1alpha1/workspaces/{workspaceId}/clusters`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `clusters`; columns `name`, `id`, `clusterPhase`, `clusterProvider`, `version`; pagination `offset`

### `dce microservice-engine skoala list-cluster-lb-addr-pool`

- Summary: 集群中负载均衡器 IP Pool 列表
- HTTP: `GET /apis/skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/lb/{lbType}/addrpools`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--lb-type` (path, required, one of: LB_TYPE_UNSPECIFIED|MetalLB|Other): lbType
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `name`, `autoAssign`, `avoidBuggyIps`; pagination `offset`

### `dce microservice-engine skoala list-cluster-namespace`

- Summary: Namespace 列表
- HTTP: `GET /apis/skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--gateway-status` (query, default `NoFilter`, one of: NoFilter|Available|Unavailable): gatewayStatus
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `namespaceNames`; pagination `offset`

### `dce microservice-engine skoala list-cluster-namespace-service`

- Summary: Service 列表
- HTTP: `GET /apis/skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/services`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (query): namespaceName
  - `--service-type` (query, default `ALL`, one of: ALL|SESAME|K8S): - ALL: 全部服务
  - `--service-name` (query): serviceName
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `createdAt`, `namespaceName`, `serviceName`, `sesameId`, `sesameNamespaceName`, `sesameServiceName`; pagination `offset`

### `dce microservice-engine skoala list-cluster-namespace-service`

- Summary: Service 列表
- HTTP: `GET /apis/skoala.io/v1alpha2/workspaces/{workspaceId}/clusters/{clusterName}/services`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): 集群名称
  - `--service-cluster-name` (query): 服务所属集群名称
  - `--service-namespace-name` (query): 服务所属命名空间名称
  - `--service-type` (query, default `ALL`, one of: ALL|SESAME|K8S): 服务类型,废弃
  - `--service-name` (query): 服务名称
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `createdAt`, `namespaceName`, `serviceName`, `serviceType`, `sesameId`, `sesameNamespaceName`; pagination `offset`

### `dce microservice-engine skoala list-cluster-storage-classes`

- Summary: StorageClass 列表
- HTTP: `GET /apis/skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/storage_classes`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
- Output: list path `items`

### `dce microservice-engine skoala list-hosted-registry-service-instances`

- Summary: List instances for a service in a hosted registry
- HTTP: `GET /apis/skoala.io/v1alpha2/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/nacos/{nacosName}/services/{nacosService}/instances`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--nacos-name` (path, required): nacosName
  - `--nacos-service` (path, required): nacosService
  - `--nacos-namespace` (query): nacosNamespace
  - `--nacos-group-name` (query): nacosGroupName
  - `--nacos-cluster-name` (query): 多个cluster的情况下以,隔开
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): pageSize
- Output: list path `hosts`; pagination `offset`
- Example:

```
dce microservice-engine skoala list-hosted-registry-service-instances \
  --workspace-id <workspace-id> \
  --cluster-name <cluster-name> \
  --namespace-name <namespace-name> \
  --nacos-name <nacos-name> \
  --nacos-service <service-name> \
  --page 1 --page-size 20
```

### `dce microservice-engine skoala list-mesh`

- Summary: 网格实例列表
- HTTP: `GET /apis/skoala.io/v1alpha1/workspaces/{workspaceId}/meshes`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `name`, `phase`, `id`, `meshVersion`; pagination `offset`

### `dce microservice-engine skoala list-mesh-namespace-services`

- Summary: 网格 Service 列表
- HTTP: `GET /apis/skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/services`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (query): namespaceName
  - `--service-name` (query): serviceName
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `namespaceName`, `serviceName`, `sesameId`; pagination `offset`

### `dce microservice-engine skoala list-mesh-namespace-services`

- Summary: 网格 Service 列表
- HTTP: `GET /apis/skoala.io/v1alpha2/workspaces/{workspaceId}/clusters/{clusterName}/meshes/{meshId}/services`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): 集群名称
  - `--mesh-id` (path, required): meshId
  - `--namespace-name` (query): namespaceName
  - `--service-name` (query): serviceName
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `namespaceName`, `serviceName`, `serviceType`, `sesameId`; pagination `offset`

### `dce microservice-engine skoala list-mesh-namespaces`

- Summary: 网格 Namespace 列表
- HTTP: `GET /apis/skoala.io/v1alpha1/workspaces/{workspaceId}/meshes/{meshId}/namespaces`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--mesh-id` (path, required): meshId
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; pagination `offset`

### `dce microservice-engine skoala list-mysql`

- Summary: 中间件 MySQL 实例列表
- HTTP: `GET /apis/skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/mysqls`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `name`, `id`, `address`; pagination `offset`

### `dce microservice-engine skoala list-node-labels`

- Summary: 节点标签列表
- HTTP: `GET /apis/skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/node_labels`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `nodeName`; pagination `offset`

### `dce microservice-engine skoala list-prerequisite`

- Summary: 环境前置条件检测
- HTTP: `GET /apis/skoala.io/v1alpha1/workspaces/{workspaceId}/prerequisites/{prerequisite}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--prerequisite` (path, required, one of: PREREQUISITE_UNSPECIFIED|InsightAgent|SkoalaInit|InsightTracing|MetalLb): prerequisite
- Output: list path `items`; columns `chartVersion`, `clusterName`, `ok`

### `dce microservice-engine skoala list-redis`

- Summary: 中间件 Redis 实例列表
- HTTP: `GET /apis/skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/redis`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `name`, `id`, `address`; pagination `offset`

### `dce microservice-engine skoala list-registry-service-instances`

- Summary: 注册中心中服务实例列表
- HTTP: `GET /apis/skoala.io/v1alpha2/workspaces/{workspaceId}/registry/{registryId}/services/{serviceName}/instances`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--registry-id` (path, required): registryId
  - `--service-name` (path, required): serviceName
  - `--namespace-id` (query): namespaceId
  - `--group-name` (query): groupName
  - `--instance-id` (query): instanceId
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `hosts`; pagination `offset`

### `dce microservice-engine skoala list-registry-services`

- Summary: 注册中心中服务列表
- HTTP: `GET /apis/skoala.io/v1alpha1/workspaces/{workspaceId}/registry/{registryId}/services/gateway`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--registry-id` (path, required): registryId
  - `--kubernetes-cluster-name` (query): kubernetesClusterName
  - `--kubernetes-namespace-name` (query): kubernetesNamespaceName
  - `--registry-name` (query): registryName
  - `--nacos-namespace-name` (query): nacosNamespaceName
  - `--is-hosted` (query): isHosted
  - `--service-name` (query): serviceName
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `isHosted`, `kubernetesClusterName`, `kubernetesNamespaceName`, `meshDeployType`, `meshId`, `meshName`; pagination `offset`

### `dce microservice-engine skoala list-registry-services`

- Summary: 注册中心中服务列表
- HTTP: `GET /apis/skoala.io/v1alpha2/workspaces/{workspaceId}/clusters/{clusterName}/registry/{registryId}/services/gateway`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--registry-id` (path, required): registryId
  - `--kubernetes-cluster-name` (query): kubernetesClusterName
  - `--kubernetes-namespace-name` (query): kubernetesNamespaceName
  - `--registry-name` (query): registryName
  - `--nacos-namespace-name` (query): nacosNamespaceName
  - `--nacos-k8s-cluster-name` (query): nacosK8sClusterName
  - `--is-hosted` (query): isHosted
  - `--service-name` (query): serviceName
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `isHosted`, `kubernetesClusterName`, `kubernetesNamespaceName`, `meshDeployType`, `meshId`, `meshName`; pagination `offset`

### `dce microservice-engine skoala list-workspace`

- Summary: Workspace 列表
- HTTP: `GET /apis/skoala.io/v1alpha1/workspaces`
- Auth: required
- Body: none
- Flags:
  - `--name` (query): name
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `name`, `id`; pagination `offset`

### `dce microservice-engine skoala list-workspace-role-permissions`

- Summary: 权限点列表
- HTTP: `GET /apis/skoala.io/v1alpha1/workspaces/{workspaceId}/permissions`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
- Output: list path `permissions`

## Skoala-v1alpha3

### `dce microservice-engine skoala-v1alpha3 list-all-cluster`

- Summary: 托管集群列表
- HTTP: `GET /apis/sesame.skoala.io/v1alpha3/clusters`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (query): workspaceId
  - `--cluster-name` (query): clusterName
- Output: list path `cluster`; columns `name`, `id`, `clusterPhase`, `clusterProvider`, `version`

### `dce microservice-engine skoala-v1alpha3 list-all-gateways`

- Summary: List gateways across workspaces
- HTTP: `GET /apis/sesame.skoala.io/v1alpha3/gateways`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (query): workspaceId
  - `--cluster-name` (query): clusterName
  - `--namespace-name` (query): namespaceName
  - `--gateway-type` (query, default `GatewayType_UNSPECIFIED`, one of: GatewayType_UNSPECIFIED|GatewayType_Higress|GatewayType_Contour): - GatewayType_Higress: Higress网关
  - `--gateway-name` (query): gatewayName
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): pageSize
- Output: list path `items`; columns `gatewayType`; pagination `offset`
- Example:

```
dce microservice-engine skoala-v1alpha3 list-all-gateways \
  --cluster-name <cluster-name> \
  --namespace-name <namespace-name> \
  --page 1 --page-size 20
```

### `dce microservice-engine skoala-v1alpha3 list-cluster-namespace`

- Summary: Namespace 列表
- HTTP: `GET /apis/skoala.io/v1alpha3/clusters/{clusterName}/namespaces`
- Auth: required
- Body: none
- Flags:
  - `--cluster-name` (path, required): clusterName
  - `--workspace-id` (query): workspaceId
  - `--namespace-name` (query): namespaceName
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `clusterName`, `namespaceName`, `workspaceId`, `workspaceName`; pagination `offset`

### `dce microservice-engine skoala-v1alpha3 list-gateway-namespaces`

- Summary: 获取网关命名空间列表以及状态
- HTTP: `GET /apis/sesame.skoala.io/v1alpha3/workspaces/{workspaceId}/clusters/{clusterName}/gateway-namespaces`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `namespaceName`, `status`; pagination `offset`

### `dce microservice-engine skoala-v1alpha3 list-gateways`

- Summary: List gateways in a workspace
- HTTP: `GET /apis/sesame.skoala.io/v1alpha3/workspaces/{workspaceId}/gateways`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (query): clusterName
  - `--namespace-name` (query): namespaceName
  - `--gateway-type` (query, default `GatewayType_UNSPECIFIED`, one of: GatewayType_UNSPECIFIED|GatewayType_Higress|GatewayType_Contour): - GatewayType_Higress: Higress网关
  - `--gateway-name` (query): gatewayName
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): pageSize
- Output: list path `items`; columns `gatewayType`; pagination `offset`
- Example:

```
dce microservice-engine skoala-v1alpha3 list-gateways \
  --workspace-id <workspace-id> \
  --page 1 --page-size 20
```

### `dce microservice-engine skoala-v1alpha3 list-workspace-role-permissions`

- Summary: 权限点列表
- HTTP: `GET /apis/skoala.io/v1alpha3/permissions`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (query): workspaceId
- Output: list path `permissions`

## SkoalaPlugin

### `dce microservice-engine skoalaplugin create-plugin`

- Summary: 创建插件
- HTTP: `POST /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/plugins`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceID

### `dce microservice-engine skoalaplugin delete-plugin`

- Summary: 删除插件
- HTTP: `DELETE /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/plugins/{pluginName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceID
  - `--plugin-name` (path, required): 插件名称

### `dce microservice-engine skoalaplugin get-plugin`

- Summary: 插件详情
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/plugins/{pluginName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceID
  - `--plugin-name` (path, required): 插件名称
- Output: list path `address`

### `dce microservice-engine skoalaplugin get-rls-domain`

- Summary: 限流插件的域名列表
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/plugins/rls/{pluginName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceID
  - `--plugin-name` (path, required): pluginName
- Output: list path `domain`

### `dce microservice-engine skoalaplugin get-rls-domain-rules`

- Summary: 限流插件的域名限流规则详情
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/plugins/rls/{pluginName}/domain/{domain}/rule/{rlsRuleName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceID
  - `--plugin-name` (path, required): pluginName
  - `--domain` (path, required): domain
  - `--rls-rule-name` (path, required): rlsRuleName

### `dce microservice-engine skoalaplugin list-plugin`

- Summary: 插件列表
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/plugins`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceID
  - `--plugin-name` (query): 插件名称
  - `--plugin-type` (query, default `JWT`, one of: JWT|AUTH|RATELIMIT|WASM|EXTPROC|UNDEFINE): 插件类型
  - `--disabled` (query, default `PLUGIN_STATUS_TYPE_ALL`, one of: PLUGIN_STATUS_TYPE_ALL|PLUGIN_STATUS_TYPE_DISABLED|PLUGIN_STATUS_TYPE_ENABLED): disabled
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `createdAt`, `disabled`, `inCluster`, `pluginName`, `pluginType`, `updatedAt`; pagination `offset`

### `dce microservice-engine skoalaplugin list-rls-domain-rules`

- Summary: 限流插件的域名限流规则列表
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/plugins/rls/{pluginName}/domain/{domain}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceID
  - `--plugin-name` (path, required): pluginName
  - `--domain` (path, required): domain
- Output: list path `rules`; columns `name`, `Unlimited`, `aliasName`, `key`, `value`

### `dce microservice-engine skoalaplugin skoala-plugin-usage-update`

- Summary: 更新插件使用情况
- HTTP: `PUT /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/plugins/{pluginName}/usage`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceID
  - `--plugin-name` (path, required): pluginName

### `dce microservice-engine skoalaplugin update-plugin`

- Summary: 更新插件
- HTTP: `PUT /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/plugins/{pluginName}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceID
  - `--plugin-name` (path, required): 插件名称

### `dce microservice-engine skoalaplugin update-plugin-status`

- Summary: 更新插件状态
- HTTP: `PUT /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/plugins/{pluginName}/status/{status}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceID
  - `--plugin-name` (path, required): 插件名称
  - `--status` (path, required): 插件状态，true为启用，false为禁用

## SkoalaPluginTemplate

### `dce microservice-engine skoalaplugintemplate create-plugin`

- Summary: 创建插件
- HTTP: `POST /apis/sesame.skoala.io/v1alpha2/workspaces/{workspaceId}/plugins`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceID

### `dce microservice-engine skoalaplugintemplate create-plugin-template`

- Summary: 创建插件模板
- HTTP: `POST /apis/sesame.skoala.io/v1alpha2/workspaces/{workspaceId}/plugin-templates`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceID

### `dce microservice-engine skoalaplugintemplate delete-plugin`

- Summary: 删除插件
- HTTP: `DELETE /apis/sesame.skoala.io/v1alpha2/workspaces/{workspaceId}/plugins/{pluginName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceID
  - `--plugin-name` (path, required): 插件名称

### `dce microservice-engine skoalaplugintemplate delete-plugin-template`

- Summary: 删除插件模板
- HTTP: `DELETE /apis/sesame.skoala.io/v1alpha2/workspaces/{workspaceId}/plugin-templates/{pluginTemplateName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceID
  - `--plugin-template-name` (path, required): 插件名称

### `dce microservice-engine skoalaplugintemplate get-plugin`

- Summary: 插件详情
- HTTP: `GET /apis/sesame.skoala.io/v1alpha2/workspaces/{workspaceId}/plugins/{pluginName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceID
  - `--plugin-name` (path, required): 插件名称
- Output: list path `usage`; columns `name`, `clusterName`, `meshInstance`, `namespaceName`, `needUpdate`, `resourceType`

### `dce microservice-engine skoalaplugintemplate get-plugin-template`

- Summary: 插件模板详情
- HTTP: `GET /apis/sesame.skoala.io/v1alpha2/workspaces/{workspaceId}/plugin-templates/{pluginTemplateName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceID
  - `--plugin-template-name` (path, required): 插件名称
- Output: list path `items`; columns `createType`, `createdAt`, `disabled`, `pluginName`, `pluginType`, `templateName`

### `dce microservice-engine skoalaplugintemplate list-plugin`

- Summary: 插件列表
- HTTP: `GET /apis/sesame.skoala.io/v1alpha2/workspaces/{workspaceId}/plugins`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceID
  - `--plugin-name` (query): 插件名称
  - `--plugin-type` (query, default `UNDEFINE`, one of: UNDEFINE|JWT|AUTH|RATELIMIT|WASM|EXTPROC): 插件类型
  - `--disabled` (query, default `PLUGIN_STATUS_TYPE_ALL`, one of: PLUGIN_STATUS_TYPE_ALL|PLUGIN_STATUS_TYPE_DISABLED|PLUGIN_STATUS_TYPE_ENABLED): disabled
  - `--create-type` (query, default `ALL_CREATE_TYPE`, one of: ALL_CREATE_TYPE|CUSTOM|TEMPLATE): createType
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `createType`, `createdAt`, `disabled`, `pluginName`, `pluginType`, `templateName`; pagination `offset`

### `dce microservice-engine skoalaplugintemplate list-plugin-template`

- Summary: 插件模板列表
- HTTP: `GET /apis/sesame.skoala.io/v1alpha2/workspaces/{workspaceId}/plugin-templates`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceID
  - `--plugin-template-name` (query): 插件名称
  - `--plugin-type` (query, default `UNDEFINE`, one of: UNDEFINE|JWT|AUTH|RATELIMIT|WASM|EXTPROC): 插件类型
  - `--disabled` (query, default `PLUGIN_STATUS_TYPE_ALL`, one of: PLUGIN_STATUS_TYPE_ALL|PLUGIN_STATUS_TYPE_DISABLED|PLUGIN_STATUS_TYPE_ENABLED): disabled
  - `--template-type` (query, default `ALL`, one of: ALL|OWN|IMPORT): templateType
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `createdAt`, `describe`, `disabled`, `displayName`, `icon`, `pluginTemplateName`; pagination `offset`

### `dce microservice-engine skoalaplugintemplate update-plugin`

- Summary: 更新插件
- HTTP: `PUT /apis/sesame.skoala.io/v1alpha2/workspaces/{workspaceId}/plugins/{pluginName}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceID
  - `--plugin-name` (path, required): 插件名称

### `dce microservice-engine skoalaplugintemplate update-plugin-template`

- Summary: 更新插件模板
- HTTP: `PUT /apis/sesame.skoala.io/v1alpha2/workspaces/{workspaceId}/plugin-templates/{pluginTemplateName}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceID
  - `--plugin-template-name` (path, required): 插件模版名称

## Statics

### `dce microservice-engine statics gateway-overview-basic`

- Summary: 总体概览实时数据
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/stats/gateway/basic`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--gateway-names` (query): 网关名称
  - `--start-time` (query, int64): 请求开始时间,毫秒,优先级高
  - `--end-time` (query, int64): 请求结束时间,毫秒
  - `--interval` (query, int64): interval
  - `--unit` (query, default `TIME_UNIT_UNSPECIFIED`, one of: TIME_UNIT_UNSPECIFIED|Day|Hour|Minute|Second|Millisecond): 时间单位

### `dce microservice-engine statics gateway-overview-health`

- Summary: 总体概览健康度数据
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/stats/gateway/health`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--gateway-names` (query): 网关名称
  - `--start-time` (query, int64): 请求开始时间,毫秒,优先级高
  - `--end-time` (query, int64): 请求结束时间,毫秒
  - `--interval` (query, int64): 时间
  - `--unit` (query, default `TIME_UNIT_UNSPECIFIED`, one of: TIME_UNIT_UNSPECIFIED|Day|Hour|Minute|Second|Millisecond): 时间单位
  - `--completion` (query): 是否补全缺失参数
- Output: list path `fail`; columns `gatewayName`

### `dce microservice-engine statics gateway-overview-info`

- Summary: 总体概览基本信息
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/stats/gateway/info`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
- Output: list path `errGatewayInfo`; columns `gatewayName`, `location`, `reason`

### `dce microservice-engine statics gateway-overview-rank-api-num`

- Summary: 总体概览 API 排行数据
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/stats/gateway/rank/apinum`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
- Output: list path `items`; columns `apiNum`, `gatewayName`, `location`

### `dce microservice-engine statics get-statics-registry`

- Summary: 总体概览注册配置中心相关统计信息
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/statics/registries`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: pagination `offset`

### `dce microservice-engine statics get-statics-sentinel`

- Summary: 总体概览 Sentinel 相关统计信息
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/statics/sentinels`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: pagination `offset`

### `dce microservice-engine statics list-in-workspace-gateway-names`

- Summary: 总体概览网关名称列表
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/gateway/names`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
- Output: list path `items`

### `dce microservice-engine statics list-stats-seata`

- Summary: 总体概览 Seata 相关统计信息
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/stats/seatas`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: pagination `offset`

### `dce microservice-engine statics list-top10reg-srv`

- Summary: 总体概览 Top 10 微服务统计信息
- HTTP: `GET /apis/hive.skoala.io/v1alpha1/workspaces/{workspaceId}/statics/registries/services`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--hosted-query` (query, default `ALL`, one of: ALL|NOT_HOSTED|HOSTED): - ALL: 全部
- Output: list path `items`; columns `registryName`, `serviceCount`

## Virtualhost

### `dce microservice-engine virtualhost check-virtualhost`

- Summary: 检测域名
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/virtualhosts/check`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--fqdn` (query): fqdn

### `dce microservice-engine virtualhost create-virtualhost`

- Summary: 创建域名
- HTTP: `POST /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/virtualhosts`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName

### `dce microservice-engine virtualhost delete-virtualhost`

- Summary: 删除域名
- HTTP: `DELETE /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/virtualhosts/{fqdn}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--fqdn` (path, required): fqdn

### `dce microservice-engine virtualhost get-virtualhost`

- Summary: 域名详情
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/virtualhosts/{fqdn}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--fqdn` (path, required): fqdn
- Output: list path `jwtProviders`; columns `default`, `jwtPluginName`

### `dce microservice-engine virtualhost list-virtualhost`

- Summary: 域名列表
- HTTP: `GET /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/virtualhosts`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--fqdn` (query): 域名，支持模糊搜索
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `apiCount`, `enableAuth`, `enableExtProc`, `enableGlobalRateLimit`, `enableJWT`, `fqdn`; pagination `offset`

### `dce microservice-engine virtualhost update-virtualhost`

- Summary: 更新域名
- HTTP: `PUT /apis/sesame.skoala.io/v1alpha1/workspaces/{workspaceId}/clusters/{clusterName}/namespaces/{namespaceName}/gateways/{gatewayName}/virtualhosts/{fqdn}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster-name` (path, required): clusterName
  - `--namespace-name` (path, required): namespaceName
  - `--gateway-name` (path, required): gatewayName
  - `--fqdn` (path, required): 域名名称

## ratelimitRule

### `dce microservice-engine ratelimitrule create-ratelimit-rule`

- Summary: 创建限流插件的域名限流规则
- HTTP: `POST /apis/sesame.skoala.io/v1alpha2/workspaces/{workspaceId}/ratelimit/rules`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceID

### `dce microservice-engine ratelimitrule delete-ratelimit-rule`

- Summary: 删除限流插件的域名限流规则
- HTTP: `DELETE /apis/sesame.skoala.io/v1alpha2/workspaces/{workspaceId}/ratelimit/rules/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceID
  - `--name` (path, required): name

### `dce microservice-engine ratelimitrule get-ratelimit-rule`

- Summary: 限流插件的域名限流规则详情
- HTTP: `GET /apis/sesame.skoala.io/v1alpha2/workspaces/{workspaceId}/ratelimit/rules/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceID
  - `--name` (path, required): name
- Output: list path `items`; columns `domain`

### `dce microservice-engine ratelimitrule list-ratelimit-rule`

- Summary: 限流插件的域名限流规则列表
- HTTP: `GET /apis/sesame.skoala.io/v1alpha2/workspaces/{workspaceId}/ratelimit/rules`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceID
  - `--name` (query): name
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `name`; pagination `offset`

### `dce microservice-engine ratelimitrule list-rls-domain-rules`

- Summary: 限流插件的域名限流规则列表
- HTTP: `GET /apis/sesame.skoala.io/v1alpha2/workspaces/{workspaceId}/plugins/rls/{pluginName}/domain/{domain}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceID
  - `--plugin-name` (path, required): pluginName
  - `--domain` (path, required): domain
  - `--rls-rule-type` (query, default `ALLRLSTYPE`, one of: ALLRLSTYPE|GENERICKV|REQUESTHEADER|IP): 限流规则类型
- Output: list path `rules`; columns `name`, `rlsRuleType`

### `dce microservice-engine ratelimitrule update-ratelimit-rule`

- Summary: 更新限流插件的域名限流规则
- HTTP: `PUT /apis/sesame.skoala.io/v1alpha2/workspaces/{workspaceId}/ratelimit/rules/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceID
  - `--name` (path, required): name

