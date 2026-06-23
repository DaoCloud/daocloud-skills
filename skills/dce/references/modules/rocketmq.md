# Module `rocketmq`

## Source

- Backend: `swagger`
- Repository: https://github.com/DaoCloud/daocloud-api-docs.git
- Pinned tag: `dab35e0f167a06a05f0547c89bc898b662341987`
- Files: `docs/openapi/mcamel/rocketmq/rocketmq-v0.19.0.json`
- Resolved SHA: `dab35e0f167a06a05f0547c89bc898b662341987`

## CloudShellService

### `dce rocketmq cloudshellservice create-cloud-shell`

- Summary: CloudShellService_CreateCloudShell
- HTTP: `POST /apis/mcamel.io/rocketmq/v1alpha2/cloudshells`
- Auth: required
- Body: required
- Flags: none

### `dce rocketmq cloudshellservice delete-cloud-shell`

- Summary: DeleteCloudShell delete a cloudshell in golobal cluster.
- HTTP: `DELETE /apis/mcamel.io/rocketmq/v1alpha2/cloudshells/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name

### `dce rocketmq cloudshellservice get-cloud-shell`

- Summary: GetCloudShell get a cloudshell in golobal cluster.
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/cloudshells/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name

## Cluster

### `dce rocketmq cluster get-all-event-kinds-list`

- Summary: Cluster_GetAllEventKindsList
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{cluster}/all-events-kinds`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
- Output: list path `data`

### `dce rocketmq cluster get-all-event-list`

- Summary: Cluster_GetAllEventList
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/{cluster}/{namespace}/{name}/all-events`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--sort-dir` (query, default `ASC`, one of: ASC|DESC): sortDir
  - `--sort-by` (query): sortBy
  - `--search-key` (query): searchKey
  - `--event-type` (query, default `EVENT_TYPE_UNSPECIFIED`, one of: EVENT_TYPE_UNSPECIFIED|Normal|Warning): - EVENT_TYPE_UNSPECIFIED: This is only a meaningless placeholder, to avoid zero not return.
  - `--kind-name` (query): kindName
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `kind`, `type`, `metadata.creationTimestamp`, `apiVersion`; pagination `offset`

### `dce rocketmq cluster get-all-visible-workspace-cluster-list`

- Summary: Cluster_GetAllVisibleWorkspaceClusterList
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/clusters`
- Auth: required
- Body: none
- Flags: none
- Output: list path `clusters`; columns `metadata.name`

### `dce rocketmq cluster get-all-visible-workspace-cluster-namespace-list`

- Summary: Cluster_GetAllVisibleWorkspaceClusterNamespaceList
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{cluster}/namespaces`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
- Output: list path `items`; columns `namespace`, `cluster`, `workspaceId`, `workspaceName`

### `dce rocketmq cluster get-all-visible-workspace-permissions-list`

- Summary: Cluster_GetAllVisibleWorkspacePermissionsList
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/permissions`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (query, int64): workspaceId
- Output: list path `permissions`

### `dce rocketmq cluster get-cluster`

- Summary: Cluster_GetCluster
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/clusters/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int64): workspaceId
  - `--name` (path, required): @inject_tag: v:"required#choose clusterName!"

### `dce rocketmq cluster get-cluster-hostnetwork-ports`

- Summary: Cluster_GetClusterHostnetworkPorts
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/hostnetwork-ports`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--cluster` (query): @inject_tag: v:"required#Input Cluster"
- Output: list path `items`

### `dce rocketmq cluster get-cluster-list`

- Summary: Cluster_GetClusterList
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/clusters`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--search-key` (query): searchKey
- Output: list path `items`

### `dce rocketmq cluster get-cluster-namespace-list`

- Summary: Cluster_GetClusterNamespaceList
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/{cluster}/namespaces`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"required#请输入WSid"
  - `--cluster` (path, required): @inject_tag: v:"required#请输入Cluster"
- Output: list path `items`

### `dce rocketmq cluster get-cluster-node-label-list`

- Summary: Cluster_GetClusterNodeLabelList
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{cluster}/nodelabels`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): @inject_tag: v:"required#请输入Cluster"
- Output: list path `items`; columns `key`

### `dce rocketmq cluster get-cluster-node-list`

- Summary: Cluster_GetClusterNodeList
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/clusters/{cluster}/nodes`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
- Output: list path `items`; columns `name`

### `dce rocketmq cluster get-cluster-node-port-list`

- Summary: Cluster_GetClusterNodePortList
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{cluster}/nodeports`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): @inject_tag: v:"required#请输入Cluster"
- Output: list path `items`

### `dce rocketmq cluster get-cluster-node-taint-list`

- Summary: Cluster_GetClusterNodeTaintList
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/clusters/{cluster}/nodes/taints`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--node-name` (query): nodeName
- Output: list path `items`; columns `effect`, `key`, `nodeName`, `value`

### `dce rocketmq cluster get-cluster-pod-label-list`

- Summary: Cluster_GetClusterPodLabelList
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{cluster}/podlabels`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): @inject_tag: v:"required#请输入Cluster"
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--search-key` (query): searchKey
  - `--filter-namespace` (query): filterNamespace
- Output: list path `items`; columns `key`; pagination `offset`

### `dce rocketmq cluster get-event-list`

- Summary: pod 列表上会使用
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{cluster}/{namespace}/events`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents the name of deployment belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the deployment belongs to.
  - `--kind` (query, default `KIND_UNSPECIFIED`, one of: KIND_UNSPECIFIED|Pod): Kind represents what type of event is needed.
  - `--kind-name` (query): The name of involvedObject.
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--type` (query): Type is used for query, showing events of specified type.
- Output: list path `items`; columns `type`, `lastTimestamp`, `message`, `reason`; pagination `offset`

### `dce rocketmq cluster get-insight-agent-status`

- Summary: Cluster_GetInsightAgentStatus
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{cluster}/insight/status`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster

### `dce rocketmq cluster get-install-version`

- Summary: Cluster_GetInstallVersion
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{cluster}/install-version`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster

### `dce rocketmq cluster get-metallb-ip-address-pools-list`

- Summary: Cluster_GetMetallbIPAddressPoolsList
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{cluster}/lbaddress/pools`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): mcamel_type is holdplace for mcamel type.
- Output: list path `items`; columns `name`, `autoAssign`, `avoidBuggyIPs`

### `dce rocketmq cluster get-permissions-list`

- Summary: Cluster_GetPermissionsList
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/permissions`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int64): workspaceId
- Output: list path `permissions`

### `dce rocketmq cluster get-resource-quota`

- Summary: Cluster_GetResourceQuota
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{cluster}/{namespace}/resourcequota`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): @inject_tag: v:"required#choose cluster"
  - `--namespace` (path, required): @inject_tag: v:"required#choose namespace"

### `dce rocketmq cluster get-workspace-list`

- Summary: Cluster_GetWorkspaceList
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/workspaces`
- Auth: required
- Body: none
- Flags:
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--sort-dir` (query, default `ASC`, one of: ASC|DESC): sortDir
  - `--sort-by` (query): sortBy
  - `--search-key` (query): searchKey
- Output: list path `items`; columns `alias`, `visible`, `workspaceId`; pagination `offset`

### `dce rocketmq cluster install-file`

- Summary: Cluster_InstallFile
- HTTP: `POST /apis/mcamel.io/rocketmq/v1alpha2/{cluster}/install-file`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster

### `dce rocketmq cluster restart-instance`

- Summary: Cluster_RestartInstance
- HTTP: `POST /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/restart`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int64): workspaceId

## Metric

### `dce rocketmq metric get-alerts-list`

- Summary: Metric_GetAlertsList
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/{cluster}/{namespace}/{name}/alerts`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--cluster` (path, required): @inject_tag: v:"required#input cluster!"
  - `--namespace` (path, required): @inject_tag: v:"required#input namespace!"
  - `--name` (path, required): @inject_tag: v:"required#input name!"
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--sort-dir` (query, default `ASC`, one of: ASC|DESC): sortDir
  - `--sort-by` (query): sortBy
  - `--search-key` (query): searchKey
- Output: list path `items`; columns `namespace`, `id`, `clusterName`, `description`, `groupId`, `groupName`; pagination `offset`

## RocketMqV2

### `dce rocketmq rocketmqv2 create-rocket-mq`

- Summary: RocketMqV2_CreateRocketMq
- HTTP: `POST /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/rocketmq`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"required#choose workspace_id!"

### `dce rocketmq rocketmqv2 delete-rocket-mq`

- Summary: RocketMqV2_DeleteRocketMq
- HTTP: `DELETE /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/rocketmq/{cluster}/{namespace}/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--cluster` (path, required): @inject_tag: v:"delete|required#RBAC error|unkonwn clusterName!"
  - `--namespace` (path, required): @inject_tag: v:"required#unkonwn namespace!"
  - `--name` (path, required): @inject_tag: v:"regex:^[a-z][a-z0-9-]{0,38}[a-z0-9]$#unknown name!"

### `dce rocketmq rocketmqv2 delete-rocket-mqs`

- Summary: RocketMqV2_DeleteRocketMqs
- HTTP: `POST /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/rocketmqs`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1|get#choose workspace_id!RBAC error"

### `dce rocketmq rocketmqv2 get-all-visible-workspace-rocket-mq-list`

- Summary: RocketMqV2_GetAllVisibleWorkspaceRocketMqList
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/rocketmqs`
- Auth: required
- Body: none
- Flags:
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--search-key` (query): search_key 中间件实例名称
  - `--filter-cluster` (query): filterCluster
  - `--filter-namespace` (query): filterNamespace
  - `--filter-namespaces` (query): filterNamespaces
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `kind`, `spec.version`, `metadata.creationTimestamp`, `apiVersion`; pagination `offset`

### `dce rocketmq rocketmqv2 get-rocket-mq`

- Summary: RocketMqV2_GetRocketMq
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/rocketmq/{cluster}/{namespace}/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name

### `dce rocketmq rocketmqv2 get-rocket-mq-confs`

- Summary: RocketMqV2_GetRocketMqConfs
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/rocketmq/{cluster}/{namespace}/{name}/confs`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--cluster` (path, required): @inject_tag: v:"required#choose clusterName!"
  - `--namespace` (path, required): @inject_tag: v:"required#choose Namespace"
  - `--name` (path, required): @inject_tag: v:"required#input name!"
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--sort-dir` (query, default `ASC`, one of: ASC|DESC): sortDir
  - `--sort-by` (query): sortBy
  - `--search-key` (query): searchKey
- Output: list path `items`; columns `paramName`, `paramType`, `value`; pagination `offset`

### `dce rocketmq rocketmqv2 get-rocket-mq-grafana-addr`

- Summary: RocketMqV2_GetRocketMqGrafanaAddr
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/rocketmq/{cluster}/{namespace}/{name}/grafana`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--from` (query): from
  - `--to` (query): to

### `dce rocketmq rocketmqv2 get-rocket-mq-list`

- Summary: RocketMqV2_GetRocketMqList
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/rocketmqs`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1|get#choose workspace_id!|RBAC error"
  - `--page` (query, int32): common.PageInfoReq = 1;
  - `--page-size` (query, int32): pageSize
  - `--sort-dir` (query, default `ASC`, one of: ASC|DESC): sortDir
  - `--sort-by` (query): sortBy
  - `--search-key` (query): @inject_tag: v:"listSearchKey#invalid search key"
  - `--filter-cluster` (query): filterCluster
  - `--filter-namespace` (query): filterNamespace
  - `--filter-namespaces` (query): filterNamespaces
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `kind`, `spec.version`, `metadata.creationTimestamp`, `apiVersion`; pagination `offset`

### `dce rocketmq rocketmqv2 get-rocket-mq-operator-version-list`

- Summary: RocketMqV2_GetRocketMqOperatorVersionList
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/rocketmq-operator/versions`
- Auth: required
- Body: none
- Flags: none
- Output: list path `items`; columns `name`, `namespace`, `cluster`, `version`

### `dce rocketmq rocketmqv2 get-rocket-mq-param`

- Summary: RocketMqV2_GetRocketMqParam
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/rocketmq-params/{cluster}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--cluster` (path, required): cluster

### `dce rocketmq rocketmqv2 get-rocket-mq-pod-list`

- Summary: RocketMqV2_GetRocketMqPodList
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/rocketmq/{cluster}/{namespace}/{name}/pods`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--sort-dir` (query, default `ASC`, one of: ASC|DESC): sortDir
  - `--sort-by` (query): sortBy
  - `--search-key` (query): searchKey
- Output: list path `items`; columns `cpuLimit`, `cpuUsage`, `createTimestamp`, `ip`, `memoryLimit`, `memoryUsage`; pagination `offset`

### `dce rocketmq rocketmqv2 get-rocket-mq-users`

- Summary: RocketMqV2_GetRocketMqUsers
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/rocketmq/{cluster}/{namespace}/{name}/users`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--cluster` (path, required): WHY check update?
  - `--namespace` (path, required): @inject_tag: v:"required#choose Namespace"
  - `--name` (path, required): @inject_tag: v:"required#input name!"
- Output: list path `users`; columns `password`, `username`

### `dce rocketmq rocketmqv2 update-rocket-mq-conf`

- Summary: RocketMqV2_UpdateRocketMqConf
- HTTP: `PUT /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/rocketmq/{cluster}/{namespace}/{name}/conf`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--cluster` (path, required): @inject_tag: v:"update|required#RBAC error|choose clusterName!"
  - `--namespace` (path, required): @inject_tag: v:"required#choose Namespace"
  - `--name` (path, required): @inject_tag: v:"required#input name!"

### `dce rocketmq rocketmqv2 update-rocket-mq-params`

- Summary: RocketMqV2_UpdateRocketMqParams
- HTTP: `PUT /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/rocketmq/{cluster}/{namespace}/{name}/params`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"required#choose workspace_id!"
  - `--cluster` (path, required): WHY check update?
  - `--namespace` (path, required): @inject_tag: v:"required#choose Namespace"
  - `--name` (path, required): @inject_tag: v:"required|regex:^[a-z][a-z0-9-]{0,38}[a-z0-9]$#input name!|input invalid name!"

## StorageConfig

### `dce rocketmq storageconfig create-storage-config`

- Summary: StorageConfig_CreateStorageConfig
- HTTP: `POST /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/storage-config`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"configUpdate|min:1#RBAC error|choose workspace_id!"

### `dce rocketmq storageconfig create-storage-config-bucket-check-job`

- Summary: StorageConfig_CreateStorageConfigBucketCheckJob
- HTTP: `POST /apis/mcamel.io/rocketmq/v1alpha2/storage-config/bucket/check-job`
- Auth: required
- Body: required
- Flags: none

### `dce rocketmq storageconfig delete-storage-config`

- Summary: StorageConfig_DeleteStorageConfig
- HTTP: `DELETE /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/storage-config/{cluster}/{namespace}/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"configDelete|min:1#RBAC error|choose workspace_id!"
  - `--cluster` (path, required): @inject_tag: v:"required#input cluster!"
  - `--namespace` (path, required): @inject_tag: v:"required#input namespace!"
  - `--name` (path, required): @inject_tag: v:"required#input name!"

### `dce rocketmq storageconfig get-storage-config`

- Summary: StorageConfig_GetStorageConfig
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/storage-config/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1#choose workspace_id!"
  - `--name` (path, required): @inject_tag: v:"required#input name!"
  - `--namespace` (query): @inject_tag: v:"required#input namespace!"
  - `--cluster` (query): @inject_tag: v:"required#input cluster!"

### `dce rocketmq storageconfig get-storage-config-consumers`

- Summary: StorageConfig_GetStorageConfigConsumers
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/storage-config/{name}/consumers`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1#choose workspace_id!"
  - `--name` (path, required): @inject_tag: v:"required#input name!"
- Output: list path `consumers`; columns `name`, `namespace`, `type`, `cluster`

### `dce rocketmq storageconfig get-storage-config-list`

- Summary: StorageConfig_GetStorageConfigList
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/storage-configs`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1|configGet#choose workspace_id!RBAC error"
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--sort-dir` (query, default `ASC`, one of: ASC|DESC): sortDir
  - `--sort-by` (query): sortBy
  - `--search-key` (query): searchKey
- Output: list path `items`; pagination `offset`

### `dce rocketmq storageconfig get-storage-config-param`

- Summary: StorageConfig_GetStorageConfigParam
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/storage-config/param`
- Auth: required
- Body: none
- Flags: none

### `dce rocketmq storageconfig update-storage-config`

- Summary: StorageConfig_UpdateStorageConfig
- HTTP: `PUT /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/storage-config/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"configUpdate|min:1#RBAC error|choose workspace_id!"
  - `--name` (path, required): @inject_tag: v:"required#input name!"

## Template

### `dce rocketmq template create-template-config`

- Summary: Template_CreateTemplateConfig
- HTTP: `POST /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/template_config`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"configUpdate#RBAC error"

### `dce rocketmq template delete-template-config`

- Summary: Template_DeleteTemplateConfig
- HTTP: `DELETE /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/template_config/{name}/{version}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"configDelete#RBAC error"
  - `--name` (path, required): @inject_tag: v:"required#choose name!"
  - `--version` (path, required): @inject_tag: v:"required#choose version!"

### `dce rocketmq template get-template-config`

- Summary: Template_GetTemplateConfig
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/template_config/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--name` (path, required): @inject_tag: v:"required#choose name!"
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--sort-dir` (query, default `ASC`, one of: ASC|DESC): sortDir
  - `--sort-by` (query): sortBy
  - `--search-key` (query): searchKey
  - `--version` (query): version
  - `--template-type` (query): templateType
  - `--type` (query): type
  - `--create-timestamp` (query, int64): createTimestamp
  - `--template-instance-type` (query, default `TemplateInstanceTypeUnspecified`, one of: TemplateInstanceTypeUnspecified|MysqlMasterReplica|RedisStandalone|RedisFailover|RedisCluster|KafkaConfig|MysqlMgrConfig|MongodbConfig|PostgresqlConfig|RabbitmqConfig): templateInstanceType
- Output: pagination `offset`

### `dce rocketmq template get-template-config-list`

- Summary: Template_GetTemplateConfigList
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/template_config`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1#choose workspace_id!"
  - `--page` (query, int32): @inject_tag: v:"configGet#RBAC error"
  - `--page-size` (query, int32): pageSize
  - `--sort-dir` (query, default `ASC`, one of: ASC|DESC): sortDir
  - `--sort-by` (query): sortBy
  - `--search-key` (query): searchKey
  - `--version` (query): version
  - `--template-instance-type` (query, default `TemplateInstanceTypeUnspecified`, one of: TemplateInstanceTypeUnspecified|MysqlMasterReplica|RedisStandalone|RedisFailover|RedisCluster|KafkaConfig|MysqlMgrConfig|MongodbConfig|PostgresqlConfig|RabbitmqConfig): templateInstanceType
- Output: list path `items`; columns `name`, `type`, `createTimestamp`, `page`, `pageSize`, `searchKey`; pagination `offset`

### `dce rocketmq template get-template-config-string`

- Summary: 模版 -> string
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/template_config/{name}/to_string`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--name` (path, required): @inject_tag: v:"required#choose name!"

### `dce rocketmq template get-template-config-versions`

- Summary: Template_GetTemplateConfigVersions
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/template_config/versions`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
- Output: list path `versions`

### `dce rocketmq template get-template-instance-type-list`

- Summary: Template_GetTemplateInstanceTypeList
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/template_instance_type`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
- Output: list path `type`

### `dce rocketmq template update-template-config`

- Summary: Template_UpdateTemplateConfig
- HTTP: `PUT /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/template_config`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"configUpdate#RBAC error"

### `dce rocketmq template update-template-config-to-item`

- Summary: string -> 模版 items
- HTTP: `PUT /apis/mcamel.io/rocketmq/v1alpha2/{workspaceId}/template_config/to_template`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"configUpdate#RBAC error"
- Output: list path `items`; columns `name`, `current`, `default`, `isNeedRestart`, `updateTimestamp`, `value`

## Version

### `dce rocketmq version get`

- Summary: Version_Get
- HTTP: `GET /apis/mcamel.io/rocketmq/v1alpha2/rocketmq/version`
- Auth: required
- Body: none
- Flags: none

### `dce rocketmq version healthz`

- Summary: Version_Healthz
- HTTP: `GET /healthz`
- Auth: required
- Body: none
- Flags: none

