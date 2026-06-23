# Module `mysql`

## Source

- Backend: `swagger`
- Repository: https://github.com/DaoCloud/daocloud-api-docs.git
- Pinned tag: `dab35e0f167a06a05f0547c89bc898b662341987`
- Files: `docs/openapi/mcamel/mysql/mysql-v0.30.1.json`
- Resolved SHA: `dab35e0f167a06a05f0547c89bc898b662341987`

## CloudShellService

### `dce mysql cloudshellservice create-cloud-shell`

- Summary: CloudShellService_CreateCloudShell
- HTTP: `POST /apis/mcamel.io/mysql/v1alpha3/cloudshells`
- Auth: required
- Body: required
- Flags: none

### `dce mysql cloudshellservice delete-cloud-shell`

- Summary: DeleteCloudShell delete a cloudshell in golobal cluster.
- HTTP: `DELETE /apis/mcamel.io/mysql/v1alpha3/cloudshells/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name

### `dce mysql cloudshellservice get-cloud-shell`

- Summary: GetCloudShell get a cloudshell in golobal cluster.
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/cloudshells/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name

## Cluster

### `dce mysql cluster get-all-event-kinds-list`

- Summary: Cluster_GetAllEventKindsList
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{cluster}/all-events-kinds`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
- Output: list path `data`

### `dce mysql cluster get-all-event-list`

- Summary: Cluster_GetAllEventList
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/{cluster}/{namespace}/{name}/all-events`
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

### `dce mysql cluster get-all-visible-workspace-cluster-list`

- Summary: Cluster_GetAllVisibleWorkspaceClusterList
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/clusters`
- Auth: required
- Body: none
- Flags: none
- Output: list path `clusters`; columns `metadata.name`

### `dce mysql cluster get-all-visible-workspace-cluster-namespace-list`

- Summary: Cluster_GetAllVisibleWorkspaceClusterNamespaceList
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{cluster}/namespaces`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
- Output: list path `items`; columns `namespace`, `cluster`, `workspaceId`, `workspaceName`

### `dce mysql cluster get-all-visible-workspace-permissions-list`

- Summary: Cluster_GetAllVisibleWorkspacePermissionsList
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/permissions`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (query, int64): workspaceId
- Output: list path `permissions`

### `dce mysql cluster get-cluster`

- Summary: Cluster_GetCluster
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/clusters/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int64): workspaceId
  - `--name` (path, required): @inject_tag: v:"required#choose clusterName!"

### `dce mysql cluster get-cluster-hostnetwork-ports`

- Summary: Cluster_GetClusterHostnetworkPorts
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/hostnetwork-ports`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--cluster` (query): @inject_tag: v:"required#Input Cluster"
- Output: list path `items`

### `dce mysql cluster get-cluster-list`

- Summary: Cluster_GetClusterList
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/clusters`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--search-key` (query): searchKey
- Output: list path `items`

### `dce mysql cluster get-cluster-namespace-list`

- Summary: Cluster_GetClusterNamespaceList
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/{cluster}/namespaces`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"required#请输入WSid"
  - `--cluster` (path, required): @inject_tag: v:"required#请输入Cluster"
- Output: list path `items`

### `dce mysql cluster get-cluster-node-label-list`

- Summary: Cluster_GetClusterNodeLabelList
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{cluster}/nodelabels`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): @inject_tag: v:"required#请输入Cluster"
- Output: list path `items`; columns `key`

### `dce mysql cluster get-cluster-node-list`

- Summary: Cluster_GetClusterNodeList
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/clusters/{cluster}/nodes`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
- Output: list path `items`; columns `name`

### `dce mysql cluster get-cluster-node-port-list`

- Summary: Cluster_GetClusterNodePortList
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{cluster}/nodeports`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): @inject_tag: v:"required#请输入Cluster"
- Output: list path `items`

### `dce mysql cluster get-cluster-node-taint-list`

- Summary: Cluster_GetClusterNodeTaintList
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/clusters/{cluster}/nodes/taints`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--node-name` (query): nodeName
- Output: list path `items`; columns `effect`, `key`, `nodeName`, `value`

### `dce mysql cluster get-cluster-pod-label-list`

- Summary: Cluster_GetClusterPodLabelList
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{cluster}/podlabels`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): @inject_tag: v:"required#请输入Cluster"
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--search-key` (query): searchKey
  - `--filter-namespace` (query): filterNamespace
- Output: list path `items`; columns `key`; pagination `offset`

### `dce mysql cluster get-event-list`

- Summary: pod 列表上会使用
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{cluster}/{namespace}/events`
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

### `dce mysql cluster get-insight-agent-status`

- Summary: Cluster_GetInsightAgentStatus
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{cluster}/insight/status`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster

### `dce mysql cluster get-install-version`

- Summary: Cluster_GetInstallVersion
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{cluster}/install-version`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster

### `dce mysql cluster get-metallb-ip-address-pools-list`

- Summary: Cluster_GetMetallbIPAddressPoolsList
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{cluster}/lbaddress/pools`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): mcamel_type is holdplace for mcamel type.
- Output: list path `items`; columns `name`, `autoAssign`, `avoidBuggyIPs`

### `dce mysql cluster get-permissions-list`

- Summary: Cluster_GetPermissionsList
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/permissions`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int64): workspaceId
- Output: list path `permissions`

### `dce mysql cluster get-resource-quota`

- Summary: Cluster_GetResourceQuota
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{cluster}/{namespace}/resourcequota`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): @inject_tag: v:"required#choose cluster"
  - `--namespace` (path, required): @inject_tag: v:"required#choose namespace"

### `dce mysql cluster get-workspace-list`

- Summary: Cluster_GetWorkspaceList
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/workspaces`
- Auth: required
- Body: none
- Flags:
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--sort-dir` (query, default `ASC`, one of: ASC|DESC): sortDir
  - `--sort-by` (query): sortBy
  - `--search-key` (query): searchKey
- Output: list path `items`; columns `alias`, `visible`, `workspaceId`; pagination `offset`

### `dce mysql cluster install-file`

- Summary: Cluster_InstallFile
- HTTP: `POST /apis/mcamel.io/mysql/v1alpha3/{cluster}/install-file`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster

### `dce mysql cluster restart-instance`

- Summary: Cluster_RestartInstance
- HTTP: `POST /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/restart`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int64): workspaceId

## Metric

### `dce mysql metric get-alerts-list`

- Summary: Metric_GetAlertsList
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/{cluster}/{namespace}/{name}/alerts`
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

## MysqlV3

### `dce mysql mysqlv3 create-mysql`

- Summary: MysqlV3_CreateMysql
- HTTP: `POST /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/mysql`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"required#choose workspace_id!"

### `dce mysql mysqlv3 create-mysql-backup`

- Summary: MysqlV3_CreateMysqlBackup
- HTTP: `POST /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/mysql/{cluster}/{namespace}/{name}/backup`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1#choose workspace_id!"
  - `--cluster` (path, required): @inject_tag: v:"update|required#RBAC error|input clusterName!"
  - `--namespace` (path, required): @inject_tag: v:"required#input namespace!"
  - `--name` (path, required): cluster's name

### `dce mysql mysqlv3 create-mysql-recover`

- Summary: MysqlV3_CreateMysqlRecover
- HTTP: `POST /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/mysql/{cluster}/{namespace}/{name}/recover`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1#choose workspace_id!"
  - `--cluster` (path, required): @inject_tag: v:"update|required#RBAC error|choose clusterName!"
  - `--namespace` (path, required): @inject_tag: v:"required#choose Namespace"
  - `--name` (path, required): name is source mysql cluster get config from source mysql cluster

### `dce mysql mysqlv3 delete-mysql`

- Summary: MysqlV3_DeleteMysql
- HTTP: `DELETE /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/mysql/{cluster}/{namespace}/{instanceType}/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1|get#choose workspace_id!RBAC error"
  - `--cluster` (path, required): @inject_tag: v:"delete|required#RBAC error|unkonwn clusterName!"
  - `--namespace` (path, required): @inject_tag: v:"required#unkonwn namespace!"
  - `--instance-type` (path, required, one of: UnKnown|SingleNode|MasterSlave|Mgr): instanceType
  - `--name` (path, required): @inject_tag: v:"regex:^[a-z][a-z0-9-]{0,38}[a-z0-9]$#unknown name!"

### `dce mysql mysqlv3 delete-mysql-backup`

- Summary: MysqlV3_DeleteMysqlBackup
- HTTP: `DELETE /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/mysql/{cluster}/{namespace}/{instanceType}/{name}/backup`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1|get#choose workspace_id!RBAC error"
  - `--cluster` (path, required): @inject_tag: v:"delete|required#RBAC error|unkonwn clusterName!"
  - `--namespace` (path, required): @inject_tag: v:"required#unkonwn namespace!"
  - `--instance-type` (path, required, one of: UnKnown|SingleNode|MasterSlave|Mgr): instanceType
  - `--name` (path, required): name

### `dce mysql mysqlv3 delete-mysqls`

- Summary: MysqlV3_DeleteMysqls
- HTTP: `POST /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/mysqls`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1|get#choose workspace_id!RBAC error"

### `dce mysql mysqlv3 delete-slowlog`

- Summary: 删除慢查询日志
- HTTP: `DELETE /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/mysql/{cluster}/{namespace}/{name}/{instanceType}/slowlog`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1|get#choose workspace_id!RBAC error"
  - `--cluster` (path, required): @inject_tag: v:"delete|required#RBAC error|unkonwn clusterName!"
  - `--namespace` (path, required): @inject_tag: v:"required#unkonwn namespace!"
  - `--name` (path, required): @inject_tag: v:"regex:^[a-z][a-z0-9-]{0,38}[a-z0-9]$#unknown name!"
  - `--instance-type` (path, required, one of: UnKnown|SingleNode|MasterSlave|Mgr): instanceType

### `dce mysql mysqlv3 get-all-visible-workspace-mysql-list`

- Summary: MysqlV3_GetAllVisibleWorkspaceMysqlList
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/mysqls`
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

### `dce mysql mysqlv3 get-minio-list`

- Summary: MysqlV3_GetMinioList
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/minios`
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

### `dce mysql mysqlv3 get-mysql`

- Summary: MysqlV3_GetMysql
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/mysql/{cluster}/{namespace}/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1|get#choose workspace_id!RBAC error"
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--instance-type` (query, default `UnKnown`, one of: UnKnown|SingleNode|MasterSlave|Mgr): instanceType

### `dce mysql mysqlv3 get-mysql-backup-job-list`

- Summary: MysqlV3_GetMysqlBackupJobList
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/mysql/{cluster}/{namespace}/{name}/backup/jobs`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1|get#choose workspace_id!RBAC error"
  - `--cluster` (path, required): cluster info
  - `--namespace` (path, required): namespace info
  - `--name` (path, required): name info
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--sort-dir` (query, default `ASC`, one of: ASC|DESC): sortDir
  - `--sort-by` (query): sortBy
  - `--search-key` (query): searchKey
  - `--backup-name` (query): job's backupname
- Output: list path `items`; pagination `offset`

### `dce mysql mysqlv3 get-mysql-backup-list`

- Summary: MysqlV3_GetMysqlBackupList
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/mysql/{cluster}/{namespace}/{name}/backups`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1|get#choose workspace_id!RBAC error"
  - `--cluster` (path, required): cluster info
  - `--namespace` (path, required): namespace info
  - `--name` (path, required): name info
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--sort-dir` (query, default `ASC`, one of: ASC|DESC): sortDir
  - `--sort-by` (query): sortBy
  - `--search-key` (query): searchKey
  - `--instance-type` (query, default `UnKnown`, one of: UnKnown|SingleNode|MasterSlave|Mgr): instanceType
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `kind`, `metadata.creationTimestamp`, `apiVersion`; pagination `offset`

### `dce mysql mysqlv3 get-mysql-backup-provider-list`

- Summary: MysqlV3_GetMysqlBackupProviderList
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/mysql/providers`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1#choose workspace_id!"

### `dce mysql mysqlv3 get-mysql-backup-secret`

- Summary: MysqlV3_GetMysqlBackupSecret
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/mysql/secret`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"get|min:1#RBAC error|choose workspace_id!"

### `dce mysql mysqlv3 get-mysql-confs`

- Summary: MysqlV3_GetMysqlConfs
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/mysql/{cluster}/{namespace}/{name}/confs`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1|get#choose workspace_id!RBAC error"
  - `--cluster` (path, required): @inject_tag: v:"required#choose clusterName!"
  - `--namespace` (path, required): @inject_tag: v:"required#choose Namespace"
  - `--name` (path, required): @inject_tag: v:"required#input name!"
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--sort-dir` (query, default `ASC`, one of: ASC|DESC): sortDir
  - `--sort-by` (query): sortBy
  - `--search-key` (query): searchKey
  - `--instance-type` (query, default `UnKnown`, one of: UnKnown|SingleNode|MasterSlave|Mgr): instanceType
- Output: list path `items`; columns `paramName`, `paramType`, `value`; pagination `offset`

### `dce mysql mysqlv3 get-mysql-grafana-addr`

- Summary: MysqlV3_GetMysqlGrafanaAddr
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/mysql/{cluster}/{namespace}/{name}/grafana`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--from` (query): from
  - `--to` (query): to
  - `--instance-type` (query, default `UnKnown`, one of: UnKnown|SingleNode|MasterSlave|Mgr): instanceType

### `dce mysql mysqlv3 get-mysql-list`

- Summary: MysqlV3_GetMysqlList
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/mysqls`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1|get#choose workspace_id!RBAC error"
  - `--page` (query, int32): common.PageInfoReq = 1;
  - `--page-size` (query, int32): pageSize
  - `--sort-dir` (query, default `ASC`, one of: ASC|DESC): sortDir
  - `--sort-by` (query): sortBy
  - `--search-key` (query): @inject_tag: v:"listSearchKey#invalid search key"
  - `--filter-cluster` (query): filterCluster
  - `--filter-namespace` (query): filterNamespace
  - `--filter-namespaces` (query): filterNamespaces
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `kind`, `spec.version`, `metadata.creationTimestamp`, `apiVersion`; pagination `offset`

### `dce mysql mysqlv3 get-mysql-node-list`

- Summary: MysqlV3_GetMysqlNodeList
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/mysql/{cluster}/{namespace}/{name}/nodes`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1|get#choose workspace_id!RBAC error"
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--sort-dir` (query, default `ASC`, one of: ASC|DESC): sortDir
  - `--sort-by` (query): sortBy
  - `--search-key` (query): searchKey
  - `--instance-type` (query, default `UnKnown`, one of: UnKnown|SingleNode|MasterSlave|Mgr): instanceType
- Output: list path `items`; columns `cpuLimit`, `cpuUsage`, `createTimestamp`, `healthStatus`, `ip`, `memoryLimit`; pagination `offset`

### `dce mysql mysqlv3 get-mysql-operator-version-list`

- Summary: MysqlV3_GetMysqlOperatorVersionList
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{cluster}/mysql-operator/versions`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
- Output: list path `items`; columns `namespace`, `cluster`, `version`

### `dce mysql mysqlv3 get-mysql-param`

- Summary: MysqlV3_GetMysqlParam
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/mysql-params/{cluster}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"required#choose workspace_id!"
  - `--cluster` (path, required): cluster

### `dce mysql mysqlv3 get-mysql-users`

- Summary: MysqlV3_GetMysqlUsers
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/mysql/{cluster}/{namespace}/{name}/users`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1|get#choose workspace_id!RBAC error"
  - `--cluster` (path, required): WHY check update?
  - `--namespace` (path, required): @inject_tag: v:"required#choose Namespace"
  - `--name` (path, required): @inject_tag: v:"required#input name!"
  - `--instance-type` (query, default `UnKnown`, one of: UnKnown|SingleNode|MasterSlave|Mgr): instanceType
- Output: list path `users`; columns `password`, `username`

### `dce mysql mysqlv3 get-pods-and-roles`

- Summary: MysqlV3_GetPodsAndRoles
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/{cluster}/{namespace}/{name}/{instanceType}/pods_and_roles`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"required#choose WorkspaceId"
  - `--cluster` (path, required): @inject_tag: v:"required#choose clusterName!"
  - `--namespace` (path, required): @inject_tag: v:"required#choose Namespace"
  - `--name` (path, required): @inject_tag: v:"required#choose Name"
  - `--instance-type` (path, required, one of: UnKnown|SingleNode|MasterSlave|Mgr): instanceType
- Output: list path `replica`; columns `podName`, `podStatus`

### `dce mysql mysqlv3 get-slowlog-conf`

- Summary: 获取慢查询相关的参数
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/{cluster}/{namespace}/{name}/{instanceType}/slowlog/conf`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1|get#choose workspace_id!RBAC error"
  - `--cluster` (path, required): @inject_tag: v:"required#choose clusterName!"
  - `--namespace` (path, required): @inject_tag: v:"required#choose Namespace"
  - `--name` (path, required): @inject_tag: v:"required#input name!"
  - `--instance-type` (path, required, one of: UnKnown|SingleNode|MasterSlave|Mgr): instanceType

### `dce mysql mysqlv3 get-slowlog-list`

- Summary: 获取慢查询日志列表
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/{cluster}/{namespace}/{name}/{podName}/{instanceType}/slowlog`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1|get#choose workspace_id!RBAC error"
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--pod-name` (path, required): podName
  - `--instance-type` (path, required, one of: UnKnown|SingleNode|MasterSlave|Mgr): instanceType
  - `--page` (query, int32): common.PageInfoReq = 1;
  - `--page-size` (query, int32): pageSize
  - `--sort-dir` (query, default `ASC`, one of: ASC|DESC): sortDir
  - `--sort-by` (query): sortBy
  - `--search-key` (query): searchKey
  - `--from-date` (query): fromDate
  - `--to-date` (query): toDate
- Output: list path `items`; columns `db`, `lockTime`, `queryTime`, `rowsExamined`, `rowsSent`, `sqlText`; pagination `offset`

### `dce mysql mysqlv3 get-slowlog-pod-list`

- Summary: MysqlV3_GetSlowlogPodList
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/{cluster}/{namespace}/{name}/{instanceType}/slowlog/pods`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--instance-type` (path, required, one of: UnKnown|SingleNode|MasterSlave|Mgr): instanceType
- Output: list path `items`; columns `nodeType`, `podName`, `slowLogCount`

### `dce mysql mysqlv3 get-topology`

- Summary: MysqlV3_GetTopology
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/{cluster}/{namespace}/{name}/{instanceType}/topology`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1|get#choose workspace_id!RBAC error"
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): @inject_tag: v:"required#input name!"
  - `--instance-type` (path, required, one of: UnKnown|SingleNode|MasterSlave|Mgr): instanceType
- Output: list path `edges`; columns `source`, `target`

### `dce mysql mysqlv3 set-mysql-backup-secret`

- Summary: MysqlV3_SetMysqlBackupSecret
- HTTP: `PUT /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/mysql/secret`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"update|min:1#RBAC error|choose workspace_id!"

### `dce mysql mysqlv3 switch-master`

- Summary: MysqlV3_SwitchMaster
- HTTP: `POST /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/{cluster}/{namespace}/{name}/{instanceType}/switch/master`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1|get#choose workspace_id!RBAC error"
  - `--cluster` (path, required): @inject_tag: v:"required#unkonwn cluster!"
  - `--namespace` (path, required): @inject_tag: v:"required#unkonwn namespace!"
  - `--name` (path, required): @inject_tag: v:"required#unkonwn instance name!"
  - `--instance-type` (path, required, one of: UnKnown|SingleNode|MasterSlave|Mgr): instanceType

### `dce mysql mysqlv3 update-mysql-backup-config`

- Summary: MysqlV3_UpdateMysqlBackupConfig
- HTTP: `PUT /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/mysql/{cluster}/{namespace}/{name}/backup/config`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1#choose workspace_id!"
  - `--cluster` (path, required): @inject_tag: v:"update|required#RBAC error|unknown backup_schedule!"
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name

### `dce mysql mysqlv3 update-mysql-conf`

- Summary: MysqlV3_UpdateMysqlConf
- HTTP: `PUT /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/mysql/{cluster}/{namespace}/{name}/conf`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1|get#choose workspace_id!RBAC error"
  - `--cluster` (path, required): @inject_tag: v:"update|required#RBAC error|choose clusterName!"
  - `--namespace` (path, required): @inject_tag: v:"required#choose Namespace"
  - `--name` (path, required): @inject_tag: v:"required#input name!"

### `dce mysql mysqlv3 update-mysql-params`

- Summary: MysqlV3_UpdateMysqlParams
- HTTP: `PUT /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/mysql/{cluster}/{namespace}/{name}/params`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"required#choose workspace_id!"
  - `--cluster` (path, required): WHY check update?
  - `--namespace` (path, required): @inject_tag: v:"required#choose Namespace"
  - `--name` (path, required): @inject_tag: v:"withFiledsMaxLen:%v-mysql-%v.mysql.%v,name,replicas,namespace,60|required|regex:^[a-z][a-z0-9-]{0,38}[a-z0-9]$#fields too long!|input name!|input name!"

### `dce mysql mysqlv3 update-slowlog-status`

- Summary: 更新慢日志状态（开启或关闭）
- HTTP: `PUT /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/{cluster}/{namespace}/{name}/{instanceType}/slowlog/toggle`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1|get#choose workspace_id!RBAC error"
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--instance-type` (path, required, one of: UnKnown|SingleNode|MasterSlave|Mgr): instanceType

## StorageConfig

### `dce mysql storageconfig create-storage-config`

- Summary: StorageConfig_CreateStorageConfig
- HTTP: `POST /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/storage-config`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"configUpdate|min:1#RBAC error|choose workspace_id!"

### `dce mysql storageconfig create-storage-config-bucket-check-job`

- Summary: StorageConfig_CreateStorageConfigBucketCheckJob
- HTTP: `POST /apis/mcamel.io/mysql/v1alpha3/storage-config/bucket/check-job`
- Auth: required
- Body: required
- Flags: none

### `dce mysql storageconfig delete-storage-config`

- Summary: StorageConfig_DeleteStorageConfig
- HTTP: `DELETE /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/storage-config/{cluster}/{namespace}/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"configDelete|min:1#RBAC error|choose workspace_id!"
  - `--cluster` (path, required): @inject_tag: v:"required#input cluster!"
  - `--namespace` (path, required): @inject_tag: v:"required#input namespace!"
  - `--name` (path, required): @inject_tag: v:"required#input name!"

### `dce mysql storageconfig get-storage-config`

- Summary: StorageConfig_GetStorageConfig
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/storage-config/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1#choose workspace_id!"
  - `--name` (path, required): @inject_tag: v:"required#input name!"
  - `--namespace` (query): @inject_tag: v:"required#input namespace!"
  - `--cluster` (query): @inject_tag: v:"required#input cluster!"

### `dce mysql storageconfig get-storage-config-consumers`

- Summary: StorageConfig_GetStorageConfigConsumers
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/storage-config/{name}/consumers`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"min:1#choose workspace_id!"
  - `--name` (path, required): @inject_tag: v:"required#input name!"
- Output: list path `consumers`; columns `name`, `namespace`, `type`, `cluster`

### `dce mysql storageconfig get-storage-config-list`

- Summary: StorageConfig_GetStorageConfigList
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/storage-configs`
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

### `dce mysql storageconfig get-storage-config-param`

- Summary: StorageConfig_GetStorageConfigParam
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/storage-config/param`
- Auth: required
- Body: none
- Flags: none

### `dce mysql storageconfig update-storage-config`

- Summary: StorageConfig_UpdateStorageConfig
- HTTP: `PUT /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/storage-config/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"configUpdate|min:1#RBAC error|choose workspace_id!"
  - `--name` (path, required): @inject_tag: v:"required#input name!"

## Template

### `dce mysql template create-template-config`

- Summary: Template_CreateTemplateConfig
- HTTP: `POST /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/template_config`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"configUpdate#RBAC error"

### `dce mysql template delete-template-config`

- Summary: Template_DeleteTemplateConfig
- HTTP: `DELETE /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/template_config/{name}/{version}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"configDelete#RBAC error"
  - `--name` (path, required): @inject_tag: v:"required#choose name!"
  - `--version` (path, required): @inject_tag: v:"required#choose version!"

### `dce mysql template get-template-config`

- Summary: Template_GetTemplateConfig
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/template_config/{name}`
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

### `dce mysql template get-template-config-list`

- Summary: Template_GetTemplateConfigList
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/template_config`
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

### `dce mysql template get-template-config-string`

- Summary: 模版 -> string
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/template_config/{name}/to_string`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--name` (path, required): @inject_tag: v:"required#choose name!"

### `dce mysql template get-template-config-versions`

- Summary: Template_GetTemplateConfigVersions
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/template_config/versions`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
- Output: list path `versions`

### `dce mysql template get-template-instance-type-list`

- Summary: Template_GetTemplateInstanceTypeList
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/template_instance_type`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
- Output: list path `type`

### `dce mysql template update-template-config`

- Summary: Template_UpdateTemplateConfig
- HTTP: `PUT /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/template_config`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"configUpdate#RBAC error"

### `dce mysql template update-template-config-to-item`

- Summary: string -> 模版 items
- HTTP: `PUT /apis/mcamel.io/mysql/v1alpha3/{workspaceId}/template_config/to_template`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): @inject_tag: v:"configUpdate#RBAC error"
- Output: list path `items`; columns `name`, `current`, `default`, `isNeedRestart`, `updateTimestamp`, `value`

## Version

### `dce mysql version get`

- Summary: Version_Get
- HTTP: `GET /apis/mcamel.io/mysql/v1alpha3/mysql/version`
- Auth: required
- Body: none
- Flags: none

### `dce mysql version healthz`

- Summary: Version_Healthz
- HTTP: `GET /healthz`
- Auth: required
- Body: none
- Flags: none

