# Module `redis`

## Source

- Backend: `swagger`
- Repository: https://github.com/DaoCloud/daocloud-api-docs.git
- Pinned tag: `dab35e0f167a06a05f0547c89bc898b662341987`
- Files: `docs/openapi/mcamel/redis/redis-v0.31.0.json`
- Resolved SHA: `dab35e0f167a06a05f0547c89bc898b662341987`

## CloudShellService

### `dce redis cloudshellservice create-cloud-shell`

- Summary: CloudShellService_CreateCloudShell
- HTTP: `POST /apis/mcamel.io/redis/v1alpha2/cloudshells`
- Auth: required
- Body: required
- Flags: none

### `dce redis cloudshellservice delete-cloud-shell`

- Summary: DeleteCloudShell delete a cloudshell in golobal cluster.
- HTTP: `DELETE /apis/mcamel.io/redis/v1alpha2/cloudshells/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name

### `dce redis cloudshellservice get-cloud-shell`

- Summary: GetCloudShell get a cloudshell in golobal cluster.
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/cloudshells/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name

## Cluster

### `dce redis cluster get-all-event-kinds-list`

- Summary: Cluster_GetAllEventKindsList
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/{cluster}/all-events-kinds`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
- Output: list path `data`

### `dce redis cluster get-all-event-list`

- Summary: Cluster_GetAllEventList
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/{workspaceId}/{cluster}/{namespace}/{name}/all-events`
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

### `dce redis cluster get-all-visible-workspace-cluster-list`

- Summary: Cluster_GetAllVisibleWorkspaceClusterList
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/clusters`
- Auth: required
- Body: none
- Flags: none
- Output: list path `clusters`; columns `metadata.name`

### `dce redis cluster get-all-visible-workspace-cluster-namespace-list`

- Summary: Cluster_GetAllVisibleWorkspaceClusterNamespaceList
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/{cluster}/namespaces`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
- Output: list path `items`; columns `namespace`, `cluster`, `workspaceId`, `workspaceName`

### `dce redis cluster get-all-visible-workspace-permissions-list`

- Summary: Cluster_GetAllVisibleWorkspacePermissionsList
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/permissions`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (query, int64): workspaceId
- Output: list path `permissions`

### `dce redis cluster get-cluster`

- Summary: Cluster_GetCluster
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/{workspaceId}/clusters/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int64): workspaceId
  - `--name` (path, required): @inject_tag: v:"required#choose clusterName!"

### `dce redis cluster get-cluster-hostnetwork-ports`

- Summary: Cluster_GetClusterHostnetworkPorts
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/{workspaceId}/hostnetwork-ports`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--cluster` (query): @inject_tag: v:"required#Input Cluster"
- Output: list path `items`

### `dce redis cluster get-cluster-list`

- Summary: Cluster_GetClusterList
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/{workspaceId}/clusters`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--search-key` (query): searchKey
- Output: list path `items`

### `dce redis cluster get-cluster-namespace-list`

- Summary: Cluster_GetClusterNamespaceList
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/{workspaceId}/{cluster}/namespaces`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"required#请输入WSid"
  - `--cluster` (path, required): @inject_tag: v:"required#请输入Cluster"
- Output: list path `items`

### `dce redis cluster get-cluster-node-label-list`

- Summary: Cluster_GetClusterNodeLabelList
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/{cluster}/nodelabels`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): @inject_tag: v:"required#请输入Cluster"
- Output: list path `items`; columns `key`

### `dce redis cluster get-cluster-node-list`

- Summary: Cluster_GetClusterNodeList
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/clusters/{cluster}/nodes`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
- Output: list path `items`; columns `name`

### `dce redis cluster get-cluster-node-port-list`

- Summary: Cluster_GetClusterNodePortList
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/{cluster}/nodeports`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): @inject_tag: v:"required#请输入Cluster"
- Output: list path `items`

### `dce redis cluster get-cluster-node-taint-list`

- Summary: Cluster_GetClusterNodeTaintList
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/clusters/{cluster}/nodes/taints`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--node-name` (query): nodeName
- Output: list path `items`; columns `effect`, `key`, `nodeName`, `value`

### `dce redis cluster get-cluster-pod-label-list`

- Summary: Cluster_GetClusterPodLabelList
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/{cluster}/podlabels`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): @inject_tag: v:"required#请输入Cluster"
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--search-key` (query): searchKey
  - `--filter-namespace` (query): filterNamespace
- Output: list path `items`; columns `key`; pagination `offset`

### `dce redis cluster get-event-list`

- Summary: pod 列表上会使用
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/{cluster}/{namespace}/events`
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

### `dce redis cluster get-insight-agent-status`

- Summary: Cluster_GetInsightAgentStatus
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/{cluster}/insight/status`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster

### `dce redis cluster get-install-version`

- Summary: Cluster_GetInstallVersion
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/{cluster}/install-version`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster

### `dce redis cluster get-metallb-ip-address-pools-list`

- Summary: Cluster_GetMetallbIPAddressPoolsList
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/{cluster}/lbaddress/pools`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): mcamel_type is holdplace for mcamel type.
- Output: list path `items`; columns `name`, `autoAssign`, `avoidBuggyIPs`

### `dce redis cluster get-permissions-list`

- Summary: Cluster_GetPermissionsList
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/{workspaceId}/permissions`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int64): workspaceId
- Output: list path `permissions`

### `dce redis cluster get-resource-quota`

- Summary: Cluster_GetResourceQuota
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/{cluster}/{namespace}/resourcequota`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): @inject_tag: v:"required#choose cluster"
  - `--namespace` (path, required): @inject_tag: v:"required#choose namespace"

### `dce redis cluster get-workspace-list`

- Summary: Cluster_GetWorkspaceList
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/workspaces`
- Auth: required
- Body: none
- Flags:
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--sort-dir` (query, default `ASC`, one of: ASC|DESC): sortDir
  - `--sort-by` (query): sortBy
  - `--search-key` (query): searchKey
- Output: list path `items`; columns `alias`, `visible`, `workspaceId`; pagination `offset`

### `dce redis cluster install-file`

- Summary: Cluster_InstallFile
- HTTP: `POST /apis/mcamel.io/redis/v1alpha2/{cluster}/install-file`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster

### `dce redis cluster restart-instance`

- Summary: Cluster_RestartInstance
- HTTP: `POST /apis/mcamel.io/redis/v1alpha2/{workspaceId}/restart`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int64): workspaceId

## Metric

### `dce redis metric get-alerts-list`

- Summary: Metric_GetAlertsList
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/{workspaceId}/{cluster}/{namespace}/{name}/alerts`
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

## RedisV1alpha2

### `dce redis redisv1alpha2 create-redis`

- Summary: RedisV1alpha2_CreateRedis
- HTTP: `POST /apis/mcamel.io/redis/v1alpha2/{workspaceId}/redis`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId

### `dce redis redisv1alpha2 create-redis-backup`

- Summary: RedisV1alpha2_CreateRedisBackup
- HTTP: `POST /apis/mcamel.io/redis/v1alpha2/redis/{workspaceId}/backup`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId

### `dce redis redisv1alpha2 create-redis-recover`

- Summary: RedisV1alpha2_CreateRedisRecover
- HTTP: `POST /apis/mcamel.io/redis/v1alpha2/redis/{workspaceId}/{cluster}/{namespace}/{name}/recover`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1#choose workspace_id!"
  - `--cluster` (path, required): @inject_tag: v:"update
  - `--namespace` (path, required): @inject_tag: v:"required#choose Namespace"
  - `--name` (path, required): name is source redis cluster get config from source mysql cluster

### `dce redis redisv1alpha2 create-redis-shake-sync`

- Summary: RedisV1alpha2_CreateRedisShakeSync
- HTTP: `POST /apis/mcamel.io/redis/v1alpha2/{workspaceId}/redis-shake`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId

### `dce redis redisv1alpha2 delete-redis`

- Summary: RedisV1alpha2_DeleteRedis
- HTTP: `DELETE /apis/mcamel.io/redis/v1alpha2/redis/{workspaceId}/{instanceType}/{cluster}/{namespace}/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--instance-type` (path, required, one of: RedisStandalone|RedisFailover|RedisCluster): instanceType
  - `--cluster` (path, required): @inject_tag: v:"delete|required#RBAC error|unkonwn clusterName!"
  - `--namespace` (path, required): @inject_tag: v:"required#unkonwn namespace!"
  - `--name` (path, required): @inject_tag: v:"regex:^[a-z][a-z0-9-]{0,38}[a-z0-9]$#unknown name!"

### `dce redis redisv1alpha2 delete-redis-backup`

- Summary: RedisV1alpha2_DeleteRedisBackup
- HTTP: `DELETE /apis/mcamel.io/redis/v1alpha2/redis/{workspaceId}/backups/{cluster}/{namespace}/{backupName}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--cluster` (path, required): @inject_tag: v:"delete|required#RBAC error|unkonwn clusterName!"
  - `--namespace` (path, required): @inject_tag: v:"required#unkonwn namespace!"
  - `--backup-name` (path, required): backupName

### `dce redis redisv1alpha2 delete-rediss`

- Summary: RedisV1alpha2_DeleteRediss
- HTTP: `POST /apis/mcamel.io/redis/v1alpha2/rediss`
- Auth: required
- Body: required
- Flags: none

### `dce redis redisv1alpha2 get-all-visible-workspace-redis-list`

- Summary: RedisV1alpha2_GetAllVisibleWorkspaceRedisList
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/rediss`
- Auth: required
- Body: none
- Flags:
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--search-key` (query): @inject_tag: v:"listSearchKey#invalid search key"
  - `--filter-cluster` (query): filterCluster
  - `--filter-namespace` (query): filterNamespace
  - `--filter-namespaces` (query): filterNamespaces
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `kind`, `spec.version`, `metadata.creationTimestamp`, `apiVersion`; pagination `offset`

### `dce redis redisv1alpha2 get-minio-list`

- Summary: RedisV1alpha2_GetMinioList
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/{workspaceId}/minios`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1#choose workspace_id!"
  - `--page` (query, int32): common.PageInfoReq = 1;
  - `--page-size` (query, int32): pageSize
  - `--sort-dir` (query, default `ASC`, one of: ASC|DESC): sortDir
  - `--sort-by` (query): sortBy
  - `--search-key` (query): searchKey
- Output: list path `items`; columns `kind`, `apiVersion`; pagination `offset`

### `dce redis redisv1alpha2 get-pods-and-roles`

- Summary: RedisV1alpha2_GetPodsAndRoles
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/redis/{workspaceId}/{instanceType}/{cluster}/{namespace}/{name}/pods_and_roles`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"required#choose WorkspaceId"
  - `--instance-type` (path, required, one of: RedisStandalone|RedisFailover|RedisCluster): instanceType
  - `--cluster` (path, required): @inject_tag: v:"required#choose clusterName!"
  - `--namespace` (path, required): @inject_tag: v:"required#choose Namespace"
  - `--name` (path, required): @inject_tag: v:"required#choose Name"
  - `--filter-shard-name` (query): filterShardName
- Output: list path `replica`; columns `podName`, `podStatus`

### `dce redis redisv1alpha2 get-redis`

- Summary: RedisV1alpha2_GetRedis
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/redis/{workspaceId}/{instanceType}/{cluster}/{namespace}/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--instance-type` (path, required, one of: RedisStandalone|RedisFailover|RedisCluster): instanceType
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name

### `dce redis redisv1alpha2 get-redis-backup-list`

- Summary: RedisV1alpha2_GetRedisBackupList
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/redis/{workspaceId}/backups`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--sort-dir` (query, default `ASC`, one of: ASC|DESC): sortDir
  - `--sort-by` (query): sortBy
  - `--search-key` (query): searchKey
  - `--cluster` (query): cluster
  - `--namespace` (query): namespace
  - `--name` (query): name
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `spec.provider`, `metadata.creationTimestamp`; pagination `offset`

### `dce redis redisv1alpha2 get-redis-confs`

- Summary: RedisV1alpha2_GetRedisConfs
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/redis/{workspaceId}/{instanceType}/{cluster}/{namespace}/{name}/confs`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--instance-type` (path, required, one of: RedisStandalone|RedisFailover|RedisCluster): instanceType
  - `--cluster` (path, required): @inject_tag: v:"required#choose clusterName!"
  - `--namespace` (path, required): @inject_tag: v:"required#choose Namespace"
  - `--name` (path, required): @inject_tag: v:"required#input name!"
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--sort-dir` (query, default `ASC`, one of: ASC|DESC): sortDir
  - `--sort-by` (query): sortBy
  - `--search-key` (query): searchKey
- Output: list path `items`; columns `paramName`, `paramType`, `value`; pagination `offset`

### `dce redis redisv1alpha2 get-redis-grafana-addr`

- Summary: RedisV1alpha2_GetRedisGrafanaAddr
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/redis/{workspaceId}/{instanceType}/{cluster}/{namespace}/{name}/grafana`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--instance-type` (path, required, one of: RedisStandalone|RedisFailover|RedisCluster): instanceType
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--from` (query): from
  - `--to` (query): to

### `dce redis redisv1alpha2 get-redis-list`

- Summary: RedisV1alpha2_GetRedisList
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/{workspaceId}/rediss`
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

### `dce redis redisv1alpha2 get-redis-node-list`

- Summary: RedisV1alpha2_GetRedisNodeList
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/redis/{workspaceId}/{instanceType}/{cluster}/{namespace}/{name}/nodes`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--instance-type` (path, required, one of: RedisStandalone|RedisFailover|RedisCluster): instanceType
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--sort-dir` (query, default `ASC`, one of: ASC|DESC): sortDir
  - `--sort-by` (query): sortBy
  - `--search-key` (query): searchKey
- Output: list path `items`; columns `cpuLimit`, `cpuUsage`, `createTimestamp`, `ip`, `memoryLimit`, `memoryUsage`; pagination `offset`

### `dce redis redisv1alpha2 get-redis-operator-version-list`

- Summary: RedisV1alpha2_GetRedisOperatorVersionList
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/redis-operator/versions`
- Auth: required
- Body: none
- Flags: none
- Output: list path `items`; columns `namespace`, `cluster`

### `dce redis redisv1alpha2 get-redis-param`

- Summary: RedisV1alpha2_GetRedisParam
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/redis-params/{cluster}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--instance-type` (query, default `RedisStandalone`, one of: RedisStandalone|RedisFailover|RedisCluster): instanceType

### `dce redis redisv1alpha2 get-redis-slow-log-list`

- Summary: RedisV1alpha2_GetRedisSlowLogList
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/redis/{workspaceId}/{instanceType}/{cluster}/{namespace}/{name}/slowlogs`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--instance-type` (path, required, one of: RedisStandalone|RedisFailover|RedisCluster): instanceType
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--page` (query, int32): common.PageInfoReq = 1;
  - `--page-size` (query, int32): pageSize
  - `--sort-dir` (query, default `ASC`, one of: ASC|DESC): sortDir
  - `--sort-by` (query): sortBy
  - `--search-key` (query): searchKey
  - `--date` (query): date
  - `--refresh` (query): refresh
- Output: list path `items`; columns `id`, `ip`, `spent`, `timestamp`; pagination `offset`

### `dce redis redisv1alpha2 get-redis-topology`

- Summary: RedisV1alpha2_GetRedisTopology
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/redis/{workspaceId}/{instanceType}/{cluster}/{namespace}/{name}/topology`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--instance-type` (path, required, one of: RedisStandalone|RedisFailover|RedisCluster): instanceType
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
- Output: list path `edges`; columns `source`, `target`

### `dce redis redisv1alpha2 get-redis-users`

- Summary: RedisV1alpha2_GetRedisUsers
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/redis/{workspaceId}/{instanceType}/{cluster}/{namespace}/{name}/users`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--instance-type` (path, required, one of: RedisStandalone|RedisFailover|RedisCluster): @inject_tag: v:"required#input instance type!"
  - `--cluster` (path, required): WHY check update?
  - `--namespace` (path, required): @inject_tag: v:"required#choose Namespace"
  - `--name` (path, required): @inject_tag: v:"required#input name!"
- Output: list path `users`; columns `password`, `username`

### `dce redis redisv1alpha2 switch-master`

- Summary: RedisV1alpha2_SwitchMaster
- HTTP: `POST /apis/mcamel.io/redis/v1alpha2/redis/{workspaceId}/{instanceType}/{cluster}/{namespace}/{name}/switch/master`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--instance-type` (path, required, one of: RedisStandalone|RedisFailover|RedisCluster): instanceType
  - `--cluster` (path, required): @inject_tag: v:"required#unkonwn cluster!"
  - `--namespace` (path, required): @inject_tag: v:"required#unkonwn namespace!"
  - `--name` (path, required): @inject_tag: v:"required#unkonwn instance name!"

### `dce redis redisv1alpha2 update-redis-auto-backup`

- Summary: RedisV1alpha2_UpdateRedisAutoBackup
- HTTP: `PUT /apis/mcamel.io/redis/v1alpha2/redis/{workspaceId}/{cluster}/{namespace}/{name}/auto-backup`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1#choose workspace_id!"
  - `--cluster` (path, required): @inject_tag: v:"update|required#RBAC error|choose clusterName!"
  - `--namespace` (path, required): @inject_tag: v:"required#choose Namespace"
  - `--name` (path, required): @inject_tag: v:"required#input name!"

### `dce redis redisv1alpha2 update-redis-conf`

- Summary: RedisV1alpha2_UpdateRedisConf
- HTTP: `PUT /apis/mcamel.io/redis/v1alpha2/redis/{workspaceId}/{instanceType}/{cluster}/{namespace}/{name}/conf`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--instance-type` (path, required, one of: RedisStandalone|RedisFailover|RedisCluster): string conf = 5;
  - `--cluster` (path, required): @inject_tag: v:"update|required#RBAC error|choose clusterName!"
  - `--namespace` (path, required): @inject_tag: v:"required#choose Namespace"
  - `--name` (path, required): @inject_tag: v:"required#input name!"

### `dce redis redisv1alpha2 update-redis-params`

- Summary: RedisV1alpha2_UpdateRedisParams
- HTTP: `PUT /apis/mcamel.io/redis/v1alpha2/redis/{workspaceId}/{instanceType}/{cluster}/{namespace}/{name}/params`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--instance-type` (path, required, one of: RedisStandalone|RedisFailover|RedisCluster): instanceType
  - `--cluster` (path, required): WHY check update?
  - `--namespace` (path, required): @inject_tag: v:"required#choose Namespace"
  - `--name` (path, required): @inject_tag: v:"required|regex:^[a-z][a-z0-9-]{0,38}[a-z0-9]$#input name!|input name!"

## StorageConfig

### `dce redis storageconfig create-storage-config`

- Summary: StorageConfig_CreateStorageConfig
- HTTP: `POST /apis/mcamel.io/redis/v1alpha2/{workspaceId}/storage-config`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"configUpdate|min:1#RBAC error|choose workspace_id!"

### `dce redis storageconfig create-storage-config-bucket-check-job`

- Summary: StorageConfig_CreateStorageConfigBucketCheckJob
- HTTP: `POST /apis/mcamel.io/redis/v1alpha2/storage-config/bucket/check-job`
- Auth: required
- Body: required
- Flags: none

### `dce redis storageconfig delete-storage-config`

- Summary: StorageConfig_DeleteStorageConfig
- HTTP: `DELETE /apis/mcamel.io/redis/v1alpha2/{workspaceId}/storage-config/{cluster}/{namespace}/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"configDelete|min:1#RBAC error|choose workspace_id!"
  - `--cluster` (path, required): @inject_tag: v:"required#input cluster!"
  - `--namespace` (path, required): @inject_tag: v:"required#input namespace!"
  - `--name` (path, required): @inject_tag: v:"required#input name!"

### `dce redis storageconfig get-storage-config`

- Summary: StorageConfig_GetStorageConfig
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/{workspaceId}/storage-config/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1#choose workspace_id!"
  - `--name` (path, required): @inject_tag: v:"required#input name!"
  - `--namespace` (query): @inject_tag: v:"required#input namespace!"
  - `--cluster` (query): @inject_tag: v:"required#input cluster!"

### `dce redis storageconfig get-storage-config-consumers`

- Summary: StorageConfig_GetStorageConfigConsumers
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/{workspaceId}/storage-config/{name}/consumers`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1#choose workspace_id!"
  - `--name` (path, required): @inject_tag: v:"required#input name!"
- Output: list path `consumers`; columns `name`, `namespace`, `type`, `cluster`

### `dce redis storageconfig get-storage-config-list`

- Summary: StorageConfig_GetStorageConfigList
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/{workspaceId}/storage-configs`
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

### `dce redis storageconfig get-storage-config-param`

- Summary: StorageConfig_GetStorageConfigParam
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/storage-config/param`
- Auth: required
- Body: none
- Flags: none

### `dce redis storageconfig update-storage-config`

- Summary: StorageConfig_UpdateStorageConfig
- HTTP: `PUT /apis/mcamel.io/redis/v1alpha2/{workspaceId}/storage-config/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"configUpdate|min:1#RBAC error|choose workspace_id!"
  - `--name` (path, required): @inject_tag: v:"required#input name!"

## Template

### `dce redis template create-template-config`

- Summary: Template_CreateTemplateConfig
- HTTP: `POST /apis/mcamel.io/redis/v1alpha2/{workspaceId}/template_config`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"configUpdate#RBAC error"

### `dce redis template delete-template-config`

- Summary: Template_DeleteTemplateConfig
- HTTP: `DELETE /apis/mcamel.io/redis/v1alpha2/{workspaceId}/template_config/{name}/{version}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"configDelete#RBAC error"
  - `--name` (path, required): @inject_tag: v:"required#choose name!"
  - `--version` (path, required): @inject_tag: v:"required#choose version!"

### `dce redis template get-template-config`

- Summary: Template_GetTemplateConfig
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/{workspaceId}/template_config/{name}`
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

### `dce redis template get-template-config-list`

- Summary: Template_GetTemplateConfigList
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/{workspaceId}/template_config`
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

### `dce redis template get-template-config-string`

- Summary: 模版 -> string
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/{workspaceId}/template_config/{name}/to_string`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--name` (path, required): @inject_tag: v:"required#choose name!"

### `dce redis template get-template-config-versions`

- Summary: Template_GetTemplateConfigVersions
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/{workspaceId}/template_config/versions`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
- Output: list path `versions`

### `dce redis template get-template-instance-type-list`

- Summary: Template_GetTemplateInstanceTypeList
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/{workspaceId}/template_instance_type`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
- Output: list path `type`

### `dce redis template update-template-config`

- Summary: Template_UpdateTemplateConfig
- HTTP: `PUT /apis/mcamel.io/redis/v1alpha2/{workspaceId}/template_config`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"configUpdate#RBAC error"

### `dce redis template update-template-config-to-item`

- Summary: string -> 模版 items
- HTTP: `PUT /apis/mcamel.io/redis/v1alpha2/{workspaceId}/template_config/to_template`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"configUpdate#RBAC error"
- Output: list path `items`; columns `name`, `current`, `default`, `isNeedRestart`, `updateTimestamp`, `value`

## Version

### `dce redis version get`

- Summary: Version_Get
- HTTP: `GET /apis/mcamel.io/redis/v1alpha2/redis/version`
- Auth: required
- Body: none
- Flags: none

### `dce redis version healthz`

- Summary: Version_Healthz
- HTTP: `GET /healthz`
- Auth: required
- Body: none
- Flags: none

