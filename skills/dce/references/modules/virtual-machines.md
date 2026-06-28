# Module `virtual-machines`

## Source

- Backend: `swagger`
- Repository: https://github.com/DaoCloud/daocloud-api-docs.git
- Pinned tag: `74a87ca82821c5c9ca1b07d1cf8bf037185d1408`
- Files: `docs/openapi/virtnest/v0.20.0.json`
- Resolved SHA: `74a87ca82821c5c9ca1b07d1cf8bf037185d1408`

## Cluster

### `dce virtual-machines cluster is-vm-monitor-ready`

- Summary: Cluster_IsVMMonitorReady
- HTTP: `GET /apis/virtnest.io/v1alpha1/clusters/{cluster}/vm-monitor/ready`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster

### `dce virtual-machines cluster list-cluster-namespaces`

- Summary: Cluster_ListClusterNamespaces
- HTTP: `GET /apis/virtnest.io/v1alpha1/clusters/{cluster}/namespaces`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
- Output: list path `items`

### `dce virtual-machines cluster list-clusters`

- Summary: Cluster_ListClusters
- HTTP: `GET /apis/virtnest.io/v1alpha1/clusters`
- Auth: required
- Body: none
- Flags:
  - `--search` (query): search
- Output: list path `items`; columns `name`, `isInsightAgentReady`, `isKubevirtInstalled`, `status`

## FeatureGate

### `dce virtual-machines featuregate list-feature-gates`

- Summary: FeatureGate_ListFeatureGates
- HTTP: `GET /apis/virtnest.io/v1alpha1/feature-gate`
- Auth: required
- Body: none
- Flags: none
- Output: list path `items`; columns `id`, `description`, `enabled`

## Image

### `dce virtual-machines image check-secret`

- Summary: Image_CheckSecret
- HTTP: `GET /apis/virtnest.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/secrets/{name}/check`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name

### `dce virtual-machines image list-projects`

- Summary: Image_ListProjects
- HTTP: `GET /apis/virtnest.io/v1alpha1/projects`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): Cluster is the current cluster.
  - `--namespace` (query): Namespace is the current namespace.
  - `--registry` (query): Registry is registry name.
  - `--public` (query): Public is distinguish public projects and private projects.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): Size per page.
- Output: list path `items`; pagination `offset`

### `dce virtual-machines image list-registries`

- Summary: Image_ListRegistries
- HTTP: `GET /apis/virtnest.io/v1alpha1/registries`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): Cluster is the current cluster.
  - `--namespace` (query): Namespace is the current namespace.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): Size per page.
  - `--public` (query): Public is distinguish public images and private images.
- Output: list path `items`; columns `name`, `alias`, `host`; pagination `offset`

### `dce virtual-machines image list-repositories`

- Summary: Image_ListRepositories
- HTTP: `GET /apis/virtnest.io/v1alpha1/repositories`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): Cluster is the current cluster.
  - `--namespace` (query): Namespace is the current namespace.
  - `--registry` (query): Registry is registry name.
  - `--project` (query): Project is the project to request, "/" is a possible value.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): Size per page.
  - `--public` (query): Public is distinguish public images and private images.
  - `--show-artifacts` (query): ShowArtifacts is to list artifacts of per image, default false.
- Output: list path `items`; columns `name`; pagination `offset`

### `dce virtual-machines image list-secrets`

- Summary: Image_ListSecrets
- HTTP: `GET /apis/virtnest.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/secrets`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
- Output: list path `items`; columns `name`, `namespace`, `type`, `uid`, `cluster`

## Role

### `dce virtual-machines role get-user-roles`

- Summary: Role_GetUserRoles
- HTTP: `GET /apis/virtnest.io/v1alpha1/roles`
- Auth: required
- Body: none
- Flags: none
- Output: list path `platformRoles`

## VM

### `dce virtual-machines vm add-disk-volume-to-vm`

- Summary: VM_AddDiskVolumeToVM
- HTTP: `POST /apis/virtnest.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/vms/{name}/disk-volume`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name

### `dce virtual-machines vm clone-vm`

- Summary: VM_CloneVM
- HTTP: `POST /apis/virtnest.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/vms/{name}/clone`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name

### `dce virtual-machines vm cold-migration`

- Summary: VM_ColdMigration
- HTTP: `POST /apis/virtnest.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/vms/{name}/cold-migration`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name

### `dce virtual-machines vm create-custom-resource`

- Summary: VM_CreateCustomResource
- HTTP: `POST /apis/virtnest.io/v1alpha1/clusters/{cluster}/custom-resource`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster

### `dce virtual-machines vm create-vm`

- Summary: VM_CreateVM
- HTTP: `POST /apis/virtnest.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/vm`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace

### `dce virtual-machines vm create-vm-snapshot`

- Summary: VM_CreateVMSnapshot
- HTTP: `POST /apis/virtnest.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/vms/{name}/snapshot`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name

### `dce virtual-machines vm create-vm-with-vm-template`

- Summary: VM_CreateVMWithVMTemplate
- HTTP: `POST /apis/virtnest.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/vm-with-vmtemplate/{vmtemplateName}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--vmtemplate-name` (path, required): vmtemplateName

### `dce virtual-machines vm delete-vm`

- Summary: VM_DeleteVM
- HTTP: `DELETE /apis/virtnest.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/vms/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name

### `dce virtual-machines vm delete-vm-restore`

- Summary: VM_DeleteVMRestore
- HTTP: `DELETE /apis/virtnest.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/vms/{name}/restores/{restoreName}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--restore-name` (path, required): restoreName

### `dce virtual-machines vm delete-vm-snapshot`

- Summary: VM_DeleteVMSnapshot
- HTTP: `DELETE /apis/virtnest.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/vms/{name}/snapshots/{snapshotName}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--snapshot-name` (path, required): snapshotName

### `dce virtual-machines vm expand-vm-disk-capacity`

- Summary: VM_ExpandVMDiskCapacity
- HTTP: `PUT /apis/virtnest.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/vms/{name}/disk-volume/{diskName}/expand-capacity`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--disk-name` (path, required): diskName

### `dce virtual-machines vm get-custom-resource`

- Summary: VM_GetCustomResource
- HTTP: `GET /apis/virtnest.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/vms/{name}/custom-resource`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name

### `dce virtual-machines vm get-vm`

- Summary: VM_GetVM
- HTTP: `GET /apis/virtnest.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/vms/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
- Output: list path `allowedOperation`

### `dce virtual-machines vm get-vm-disk-count`

- Summary: VM_GetVMDiskCount
- HTTP: `GET /apis/virtnest.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/vm-disk-count`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace

### `dce virtual-machines vm get-vm-network-count`

- Summary: VM_GetVMNetworkCount
- HTTP: `GET /apis/virtnest.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/vm-network-count`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace

### `dce virtual-machines vm get-vm-status-count`

- Summary: VM_GetVMStatusCount
- HTTP: `GET /apis/virtnest.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/vm-status-count`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace

### `dce virtual-machines vm list-cluster-event-kinds`

- Summary: VM_ListClusterEventKinds
- HTTP: `GET /apis/virtnest.io/v1alpha1/clusters/{cluster}/events/kinds`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
- Output: list path `resources`; columns `kind`, `group`, `version`

### `dce virtual-machines vm list-cluster-nodes`

- Summary: VM_ListClusterNodes
- HTTP: `GET /apis/virtnest.io/v1alpha1/clusters/{cluster}/nodes`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
- Output: list path `items`; columns `name`, `phase`

### `dce virtual-machines vm list-cluster-snapshots`

- Summary: VM_ListClusterSnapshots
- HTTP: `GET /apis/virtnest.io/v1alpha1/clusters/{cluster}/snapshots`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--page-size` (query, int32): pageSize
  - `--page` (query, int32): page
  - `--search` (query): search
  - `--sort-by` (query, default `created_at`, one of: created_at|field_name): sortBy
  - `--sort-dir` (query, default `desc`, one of: desc|asc): sortDir
  - `--namespace` (query): namespace
- Output: list path `items`; columns `name`, `namespace`, `createdAt`, `description`, `restoreTime`, `status`; pagination `offset`

### `dce virtual-machines vm list-cluster-storage-classes`

- Summary: VM_ListClusterStorageClasses
- HTTP: `GET /apis/virtnest.io/v1alpha1/clusters/{cluster}/storageclasses`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
- Output: list path `items`; columns `name`

### `dce virtual-machines vm list-cluster-v-ms`

- Summary: VM_ListClusterVMs
- HTTP: `GET /apis/virtnest.io/v1alpha1/clusters/{cluster}/vms`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--page-size` (query, int32): pageSize
  - `--page` (query, int32): page
  - `--search` (query): search
  - `--sort-by` (query, default `created_at`, one of: created_at|field_name): sortBy
  - `--sort-dir` (query, default `desc`, one of: desc|asc): sortDir
  - `--namespace` (query): namespace
  - `--ip` (query): 支持ipv4地址，可以为空
  - `--os-family` (query): osFamily
  - `--status` (query, default `all`, one of: all|running|processing|error|poweroff|migrating): status
- Output: list path `items`; columns `name`, `namespace`, `cpu`, `createdAt`, `memory`, `migNodeSelector`; pagination `offset`

### `dce virtual-machines vm list-network-interfaces`

- Summary: VM_ListNetworkInterfaces
- HTTP: `GET /apis/virtnest.io/v1alpha1/clusters/{cluster}/network-interfaces`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
- Output: list path `interfaces`; columns `networkInterface`

### `dce virtual-machines vm list-system-images`

- Summary: VM_ListSystemImages
- HTTP: `GET /apis/virtnest.io/v1alpha1/clusters/{cluster}/system-images`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
- Output: list path `items`; columns `osFamily`

### `dce virtual-machines vm list-vm-events`

- Summary: VM_ListVMEvents
- HTTP: `GET /apis/virtnest.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/vms/events`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--page-size` (query, int32): pageSize
  - `--page` (query, int32): page
  - `--name` (query): name
  - `--level` (query, default `UNSPECIFIED`, one of: UNSPECIFIED|Normal|Warning): - UNSPECIFIED: This is only a meaningless placeholder, to avoid zero not return.
  - `--resource.group` (query): resource.group
  - `--resource.version` (query): resource.version
  - `--resource.kind` (query): resource.kind
- Output: list path `items`; columns `name`, `component`, `detail`, `level`, `time`; pagination `offset`

### `dce virtual-machines vm list-vm-networks`

- Summary: VM_ListVMNetworks
- HTTP: `GET /apis/virtnest.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/vms/{name}/networks`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
- Output: list path `items`; columns `name`, `type`, `ip`

### `dce virtual-machines vm list-vm-restores`

- Summary: VM_ListVMRestores
- HTTP: `GET /apis/virtnest.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/vms/{name}/snapshots/{snapshotName}/restores`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--snapshot-name` (path, required): snapshotName
  - `--page-size` (query, int32): pageSize
  - `--page` (query, int32): page
- Output: list path `items`; columns `name`, `complete`, `createdAt`, `description`, `lastRestore`, `restoreTime`; pagination `offset`

### `dce virtual-machines vm list-vm-snapshots`

- Summary: VM_ListVMSnapshots
- HTTP: `GET /apis/virtnest.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/vms/{name}/snapshots`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--page-size` (query, int32): pageSize
  - `--page` (query, int32): page
  - `--search` (query): search
- Output: list path `items`; columns `name`, `namespace`, `createdAt`, `description`, `restoreTime`, `status`; pagination `offset`

### `dce virtual-machines vm list-vm-storages`

- Summary: VM_ListVMStorages
- HTTP: `GET /apis/virtnest.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/vms/{name}/storages`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--page-size` (query, int32): pageSize
  - `--page` (query, int32): page
  - `--search` (query): search
- Output: list path `items`; columns `name`, `type`, `allowExpand`, `capacity`, `hotpluggable`, `pvAccessMode`; pagination `offset`

### `dce virtual-machines vm live-migrate-status`

- Summary: VM_LiveMigrateStatus
- HTTP: `GET /apis/virtnest.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/vms/{name}/live-migration/{migrationName}/status`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--migration-name` (path, required): migrationName

### `dce virtual-machines vm live-migrate-vm`

- Summary: VM_LiveMigrateVM
- HTTP: `POST /apis/virtnest.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/vms/{name}/live-migration`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name

### `dce virtual-machines vm remove-vm-disk-volume`

- Summary: VM_RemoveVMDiskVolume
- HTTP: `DELETE /apis/virtnest.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/vms/{name}/disk-volume/{diskName}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--disk-name` (path, required): diskName

### `dce virtual-machines vm restore-vm-snapshot`

- Summary: VM_RestoreVMSnapshot
- HTTP: `POST /apis/virtnest.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/vms/{name}/restore`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name

### `dce virtual-machines vm update-custom-resource`

- Summary: VM_UpdateCustomResource
- HTTP: `PUT /apis/virtnest.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/vms/{name}/custom-resource`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name

### `dce virtual-machines vm update-vm`

- Summary: VM_UpdateVM
- HTTP: `PUT /apis/virtnest.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/vms/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name

### `dce virtual-machines vm update-vm-running-status`

- Summary: VM_UpdateVMRunningStatus
- HTTP: `PUT /apis/virtnest.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/vms/{name}/running-status`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name

### `dce virtual-machines vm update-vm-snapshot`

- Summary: VM_UpdateVMSnapshot
- HTTP: `PUT /apis/virtnest.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/vms/{name}/snapshots/{snapshotName}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--snapshot-name` (path, required): snapshotName

## VMTemplate

### `dce virtual-machines vmtemplate create-vm-template-by-vm`

- Summary: rpc UpdateVMTemplate(UpdateVMTemplateRequest) returns (UpdateVMTemplateResponse) {
- HTTP: `POST /apis/virtnest.io/v1alpha1/vmtemplate-by-vm`
- Auth: required
- Body: required
- Flags: none

### `dce virtual-machines vmtemplate delete-vm-template`

- Summary: rpc CreateVMTemplate(CreateVMTemplateRequest) returns (CreateVMTemplateResponse) {
- HTTP: `DELETE /apis/virtnest.io/v1alpha1/vmtemplates/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name

### `dce virtual-machines vmtemplate get-custom-resource`

- Summary: VMTemplate_GetCustomResource
- HTTP: `GET /apis/virtnest.io/v1alpha1/vmtemplates/{name}/custom-resource`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name

### `dce virtual-machines vmtemplate get-vm-template`

- Summary: VMTemplate_GetVMTemplate
- HTTP: `GET /apis/virtnest.io/v1alpha1/vmtemplates/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name
- Output: list path `gpus`; columns `type`, `count`, `deviceName`

### `dce virtual-machines vmtemplate get-vm-template-count`

- Summary: VMTemplate_GetVMTemplateCount
- HTTP: `GET /apis/virtnest.io/v1alpha1/vm-template-count`
- Auth: required
- Body: none
- Flags: none

### `dce virtual-machines vmtemplate list-vm-templates`

- Summary: VMTemplate_ListVMTemplates
- HTTP: `GET /apis/virtnest.io/v1alpha1/vmtemplates`
- Auth: required
- Body: none
- Flags:
  - `--page-size` (query, int32): pageSize
  - `--page` (query, int32): page
  - `--search` (query): search
  - `--sort-by` (query, default `UNSPECIFIED`, one of: UNSPECIFIED|created_at|field_name): - UNSPECIFIED: Unspecified is default, no sorting.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): sortDir
- Output: list path `items`; columns `name`, `type`, `cpu`, `createdAt`, `memory`, `osFamily`; pagination `offset`

### `dce virtual-machines vmtemplate update-custom-resource`

- Summary: VMTemplate_UpdateCustomResource
- HTTP: `PUT /apis/virtnest.io/v1alpha1/vmtemplates/{name}/custom-resource`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): name

