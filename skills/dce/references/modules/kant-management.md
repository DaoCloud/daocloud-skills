# Module `kant-management`

## Source

- Backend: `swagger`
- Repository: https://github.com/DaoCloud/daocloud-api-docs.git
- Pinned tag: `3c809f3428cd5c197b6b8ba636230275608b0a78`
- Files: `docs/openapi/kant/v0.21.0.json`
- Resolved SHA: `3c809f3428cd5c197b6b8ba636230275608b0a78`

## BatchNodes

### `dce kant-management batchnodes create`

- Summary: Create a batch node.
- HTTP: `POST /apis/batch.kant.io/v1alpha1/edgeunits/{edgeunit}/batch-nodes`
- Auth: required
- Body: required
- Flags:
  - `--edgeunit` (path, required): Edgeunit represents the name of the edgeunit.

### `dce kant-management batchnodes delete`

- Summary: Delete a batch node.
- HTTP: `DELETE /apis/batch.kant.io/v1alpha1/edgeunits/{edgeunit}/batch-nodes/{name}`
- Auth: required
- Body: none
- Flags:
  - `--edgeunit` (path, required): Edgeunit represents the name of the edgeunit.
  - `--name` (path, required): Name represents the name of BatchNode.
  - `--workspace-id` (query, int32): workspaceId ID of workspace

### `dce kant-management batchnodes download-cert`

- Summary: Download the cert of a batch node.
- HTTP: `GET /apis/batch.kant.io/v1alpha1/edgeunits/{edgeunit}/batch-nodes/{name}/cert`
- Auth: required
- Body: none
- Flags:
  - `--edgeunit` (path, required): Edgeunit represents the name of the edgeunit.
  - `--name` (path, required): Name represents the name of BatchNode.
  - `--workspace-id` (query, int32): workspaceId ID of workspace
- Output: list path `extensions`; columns `@type`

### `dce kant-management batchnodes get`

- Summary: Get a batch node by name.
- HTTP: `GET /apis/batch.kant.io/v1alpha1/edgeunits/{edgeunit}/batch-nodes/{name}`
- Auth: required
- Body: none
- Flags:
  - `--edgeunit` (path, required): Edgeunit represents the name of the edgeunit.
  - `--name` (path, required): Name represents the name of BatchNode.
  - `--workspace-id` (query, int32): workspaceId ID of workspace

### `dce kant-management batchnodes join-help`

- Summary: Join Help
- HTTP: `GET /apis/batch.kant.io/v1alpha1/edgeunits/{edgeunit}/batch-nodes/{name}/join-help`
- Auth: required
- Body: none
- Flags:
  - `--edgeunit` (path, required): Edgeunit represents the name of the edgeunit.
  - `--name` (path, required): Name represents the name of BatchNode.
  - `--workspace-id` (query, int32): workspaceId ID of workspace
- Output: list path `helpCommand`; columns `command`, `title`

### `dce kant-management batchnodes list`

- Summary: List batch nodes.
- HTTP: `GET /apis/batch.kant.io/v1alpha1/edgeunits/{edgeunit}/batch-nodes`
- Auth: required
- Body: none
- Flags:
  - `--edgeunit` (path, required): Edgeunit represents the name of the edgeunit.
  - `--name` (query): Name represents the name of BatchNode.
  - `--node-name-prefix` (query): NodeNamePrefix represents the prefix of the node name.
  - `--page` (query, int32): Page represents the page number.
  - `--page-size` (query, int32): PageSize represents the page size.
  - `--workspace-id` (query, int32): workspaceId ID of workspace
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `kind`, `apiVersion`; pagination `offset`

### `dce kant-management batchnodes update`

- Summary: Update a batch node.
- HTTP: `PUT /apis/batch.kant.io/v1alpha1/edgeunits/{edgeunit}/batch-nodes/{name}`
- Auth: required
- Body: required
- Flags:
  - `--edgeunit` (path, required): Edgeunit represents the name of the edgeunit.
  - `--name` (path, required): Name represents the name of BatchNode.

## ConfigMaps

### `dce kant-management configmaps create-config-map`

- Summary: CreateConfigMap creates a configMap under the namespaces of a specific
- HTTP: `POST /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/configmaps`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the secret belongs to.
  - `--namespace` (path, required): When the current namespace is named, the priority is higher than that in yaml

### `dce kant-management configmaps delete-config-map`

- Summary: DeleteConfigMap deletes a configMap under the namespaces of a specific
- HTTP: `DELETE /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/configmaps/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the configmap belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced ConfigMap.
  - `--name` (path, required): Name is the metadata.name of the referenced ConfigMap.

### `dce kant-management configmaps get-config-map`

- Summary: GetConfigMap gets a configMap under the namespaces of a specific cluster
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/configmaps/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the configmap belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced ConfigMap.
  - `--name` (path, required): name represents for the resource name

### `dce kant-management configmaps list-cluster-config-maps`

- Summary: ListClusterConfigMaps lists all configmaps in the specified cluster,
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/configmaps`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified configmap belongs to.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): Size per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the event list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the list order.
  - `--name` (query): name is used for query.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--only-metadata` (query): OnlyMetadata lists only metadata of configmaps, default false.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`, `immutable`; pagination `offset`

### `dce kant-management configmaps list-config-maps`

- Summary: ListConfigMaps lists configmaps in the specified cluster and namespace.
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/configmaps`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the configmap belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced ConfigMap.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): Size per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the list order.
  - `--name` (query): name is used for query.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--only-metadata` (query): OnlyMetadata lists only metadata of configmaps, default false.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`, `immutable`; pagination `offset`

### `dce kant-management configmaps update-config-map`

- Summary: UpdateConfigMap updates a configMap under the namespaces of a specific
- HTTP: `PUT /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/configmaps/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified configmap belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced ConfigMap.
  - `--name` (path, required): name represents for the resource name

## CustomResources

### `dce kant-management customresources create-custom-resource-by-json`

- Summary: CreateCustomResourceByJSON creates custom resource by JSON under the namespaces of a specific cluster
- HTTP: `POST /apis/core.kant.io/v1alpha1/clusters/{cluster}/gvr/{group}/{version}/{resource}/json`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the CustomResource belongs to.
  - `--group` (path, required): Group represents the resource group of CustomResource.
  - `--version` (path, required): Version represents the resource version of CustomResource.
  - `--resource` (path, required): Resource represents the resource name of CustomResource, which is plural.

### `dce kant-management customresources get-custom-resource-by-json`

- Summary: GetCustomResourceByJSON gets custom resource by JSON under the namespaces of a specific cluster
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/gvr/{group}/{version}/{resource}/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the CustomResource belongs to.
  - `--group` (path, required): Group represents the resource group of CustomResource.
  - `--version` (path, required): Version represents the resource version of CustomResource.
  - `--resource` (path, required): Resource represents the resource name of CustomResource, which is plural.
  - `--name` (path, required): Name represents the name of CustomResource.
  - `--namespace` (query): Namespace represents which namespace the CustomResource belongs to.

### `dce kant-management customresources get-gvr`

- Summary: GetGVR get gvr information under a specific cluster
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/gvr`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified customResourceDefinition belongs to.
  - `--name` (query): Name of the CustomResourceDefinition.
- Output: list path `version`

### `dce kant-management customresources update-custom-resource-by-json`

- Summary: UpdataCustomResourceByJSON updates custom resource by JSON under the namespaces of a specific cluster
- HTTP: `PUT /apis/core.kant.io/v1alpha1/clusters/{cluster}/gvr/{group}/{version}/{resource}/{name}/json`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the CustomResource belongs to.
  - `--group` (path, required): Group represents the resource group of CustomResource.
  - `--version` (path, required): Version represents the resource version of CustomResource.
  - `--resource` (path, required): Resource represents the resource name of CustomResource, which is plural.
  - `--name` (path, required): Name represents the name of CustomResource.

## DeploymentApp

### `dce kant-management deploymentapp create-deployment`

- Summary: CreateDeployment creates workload under the namespaces of a
- HTTP: `POST /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/deployments`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the deployment belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the deployment belongs to.

### `dce kant-management deploymentapp delete-deployment`

- Summary: DeleteDeployment deletes a deployment under the namespaces of a specific
- HTTP: `DELETE /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/deployments/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the deployment belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the deployment belongs to.
  - `--name` (path, required): Name represents the name of deployment

### `dce kant-management deploymentapp get-deployment`

- Summary: GetDeployment gets workload under the namespaces of a specific
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/deployment/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which namespace the workload belongs to.
  - `--namespace` (path, required): Cluster represents which namespace the workload belongs to.
  - `--name` (path, required): Name represents the name of workload to belongs to.
  - `--stable` (query): If stable is true, the v1 version under the corresponding package will be returned.

### `dce kant-management deploymentapp get-workload`

- Summary: GetWorkload gets a deployment under the namespaces of a specific cluster
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/workloads/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which namespace the workload belongs to.
  - `--namespace` (path, required): Cluster represents which namespace the workload belongs to.
  - `--name` (path, required): Name represents the name of workload to belongs to.

### `dce kant-management deploymentapp list-cluster-workloads`

- Summary: ListClusterWorkloads lists one cluster all namespace's deployments
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/workloads`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents the name of Workload to belongs to.
  - `--page` (query, int32): Page is current page.
  - `--page-size` (query, int32): Size is the data number shown per page.
  - `--name` (query): Name represents the name of workloads to search
  - `--phase` (query, default `WORKLOAD_STATE_UNSPECIFIED`, one of: WORKLOAD_STATE_UNSPECIFIED|Running|Deleting|Not_Ready|Stopped|Waiting): Phase represents the phase of workloads to search
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the data list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--gpu-type` (query): gpu_type is filter with pods resources, when value is * search all
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`, `revision`; pagination `offset`

### `dce kant-management deploymentapp list-replica-sets`

- Summary: ListReplicaSets lists replicasets in specified namespace of a cluster
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/replicasets`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents the name of replicaset belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the replicaset belongs to.
  - `--kind` (query, default `KIND_UNSPECIFIED`, one of: KIND_UNSPECIFIED|Deployment): Kind stands for what type of replicasets are needed.
  - `--kind-name` (query): The name of involvedObject.
  - `--name` (query): Name stands for replicaset name, used for fuzzy search.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): SortDir determines the data list order.
  - `--page` (query, int32): Page is current page.
  - `--page-size` (query, int32): PageSize is size of every page.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--gpu-type` (query): gpu_type is filter with pods resources, when value is * search all
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`; pagination `offset`

### `dce kant-management deploymentapp list-workloads`

- Summary: ListWorkloads lists deployment under the namespaces of a specific
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/workloads`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the deployment belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the deployment belongs to.
  - `--page` (query, int32): Page is current page.
  - `--page-size` (query, int32): Size is the data number shown per page.
  - `--name` (query): Name represents the name of workloads to search
  - `--phase` (query, default `WORKLOAD_STATE_UNSPECIFIED`, one of: WORKLOAD_STATE_UNSPECIFIED|Running|Deleting|Not_Ready|Stopped|Waiting): Phase represents the phase of workloads to search
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the data list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--gpu-type` (query): gpu_type is filter with pods resources, when value is * search all
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`, `revision`; pagination `offset`

### `dce kant-management deploymentapp pause-deployment`

- Summary: PauseDeployment pauses a deployment under the namespaces of a specific
- HTTP: `POST /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/deployments/{name}:pause`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the deployment belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the deployment belongs to.
  - `--name` (path, required): Name represents the name of deployment

### `dce kant-management deploymentapp restart-deployment`

- Summary: RestartDeployment restarts a deployment under the namespaces of a specific
- HTTP: `POST /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/deployments/{name}:restart`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the deployment belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the deployment belongs to.
  - `--name` (path, required): Name represents the name of deployment

### `dce kant-management deploymentapp resume-deployment`

- Summary: ResumeDeployment resumes a deployment under the namespaces of a specific
- HTTP: `POST /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/deployments/{name}:resume`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the deployment belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the deployment belongs to.
  - `--name` (path, required): Name represents the name of deployment

### `dce kant-management deploymentapp rollback-deployment`

- Summary: RollbackDeployment rollbacks a deployment under the namespaces of a
- HTTP: `POST /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/deployments/{name}:rollback`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the deployment belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the deployment belongs to.
  - `--name` (path, required): Name represents the name of deployment

### `dce kant-management deploymentapp start-deployment`

- Summary: StartDeployment starts a deployment under the namespace of a specific cluster
- HTTP: `POST /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/deployments/{name}:start`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the deployment belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the deployment belongs to.
  - `--name` (path, required): Name represents the name of deployment.

### `dce kant-management deploymentapp stop-deployment`

- Summary: StopDeployment starts a deployment under the namespace of a specific cluster
- HTTP: `POST /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/deployments/{name}:stop`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the deployment belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the deployment belongs to.
  - `--name` (path, required): Name represents the name of deployment.

### `dce kant-management deploymentapp update-deployment`

- Summary: UpdateDeployment updates workload under the namespaces of a
- HTTP: `PUT /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/deployments/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the deployment belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the deployment belongs to.
  - `--name` (path, required): Name represents the name of deployment

## DeviceModels

### `dce kant-management devicemodels batch-delete-device-models`

- Summary: Batch delete devicemodels
- HTTP: `DELETE /apis/v2/core.kant.io/v1beta1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/devicemodels`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (path, required): For cluster resources, choose one of two with edgeunit.
- Output: list path `taskResults`; columns `id`, `errmsg`, `status`

### `dce kant-management devicemodels batch-delete-device-models`

- Summary: Batch delete devicemodels
- HTTP: `DELETE /apis/core.kant.io/v1beta1/clusters/{cluster}/namespaces/devicemodels`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): For cluster resources, choose one of two with edgeunit.
- Output: list path `taskResults`; columns `id`, `errmsg`, `status`

### `dce kant-management devicemodels create-device-model`

- Summary: CreateDevice creates a devicemodel of namespaced scope to the system by given device data
- HTTP: `POST /apis/v2/core.kant.io/v1beta1/clusters/{cluster}/namespaces/{namespace}/devicemodels`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the DeviceModel belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the DeviceModel belongs to.

### `dce kant-management devicemodels create-device-model`

- Summary: CreateDevice creates a devicemodel of namespaced scope to the system by given device data
- HTTP: `POST /apis/core.kant.io/v1beta1/clusters/{cluster}/namespaces/{namespace}/devicemodels`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the DeviceModel belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the DeviceModel belongs to.

### `dce kant-management devicemodels delete-device-model`

- Summary: DeleteDevice deletes a devicemodel of namespaced scope from the system by given devicemodel name
- HTTP: `DELETE /apis/core.kant.io/v1beta1/clusters/{cluster}/namespaces/{namespace}/devicemodels/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the DeviceModel belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the DeviceModel belongs to.
  - `--name` (path, required): Name represents the name of DeviceModel.
  - `--workspace-id` (query, int32): workspaceId ID of workspace

### `dce kant-management devicemodels delete-device-model`

- Summary: DeleteDevice deletes a devicemodel of namespaced scope from the system by given devicemodel name
- HTTP: `DELETE /apis/v2/core.kant.io/v1beta1/clusters/{cluster}/namespaces/{namespace}/devicemodels/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster.
  - `--namespace` (path, required): Namespace is the namespace of resource.
  - `--name` (path, required): Name is the name of resource.
  - `--workspace-id` (query, int32): WorkspaceId is the id of workspace.

### `dce kant-management devicemodels get-device-model`

- Summary: GetDevice gets a devicemodel of namespaced scope from the system
- HTTP: `GET /apis/v2/core.kant.io/v1beta1/clusters/{cluster}/namespaces/{namespace}/devicemodels/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster.
  - `--namespace` (path, required): Namespace is the namespace of resource.
  - `--name` (path, required): Name is the name of resource.
  - `--workspace-id` (query, int32): WorkspaceId is the id of workspace.

### `dce kant-management devicemodels get-device-model`

- Summary: GetDevice gets a devicemodel of namespaced scope from the system
- HTTP: `GET /apis/core.kant.io/v1beta1/clusters/{cluster}/namespaces/{namespace}/devicemodels/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the DeviceModel belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the DeviceModel belongs to.
  - `--name` (path, required): Name represents the name of DeviceModel.
  - `--workspace-id` (query, int32): workspaceId ID of workspace

### `dce kant-management devicemodels list-cluster-device-models`

- Summary: ListClusterDevice lists devicemodel of cluster scope
- HTTP: `GET /apis/core.kant.io/v1beta1/clusters/{cluster}/namespaces/devicemodels`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the DeviceModel belongs to.
  - `--page` (query, int32): Page is current page.
  - `--page-size` (query, int32): Size is the data number shown per page.
  - `--name` (query): name is used for query.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--workspace-id` (query, int32): workspaceId ID of workspace
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `kind`, `apiVersion`; pagination `offset`

### `dce kant-management devicemodels list-cluster-device-models`

- Summary: ListClusterDevice lists devicemodel of cluster scope
- HTTP: `GET /apis/v2/core.kant.io/v1beta1/clusters/{cluster}/namespaces/devicemodels`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the DeviceModel belongs to.
  - `--page` (query, int32): Page is current page.
  - `--page-size` (query, int32): Size is the data number shown per page.
  - `--name` (query): name is used for query.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--workspace-id` (query, int32): workspaceId ID of workspace
- Output: list path `items`; columns `name`, `namespace`, `createTimestamp`; pagination `offset`

### `dce kant-management devicemodels list-device-models`

- Summary: ListDevice lists devicemodel of namespaced scope from the system
- HTTP: `GET /apis/core.kant.io/v1beta1/clusters/{cluster}/namespaces/{namespace}/devicemodels`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the DeviceModel belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the DeviceModel belongs to.
  - `--page` (query, int32): Page is current page.
  - `--page-size` (query, int32): Size is the data number shown per page.
  - `--name` (query): name is used for query.
  - `--workspace-id` (query, int32): workspaceId ID of workspace
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `kind`, `apiVersion`; pagination `offset`

### `dce kant-management devicemodels list-device-models`

- Summary: ListDevice lists devicemodel of namespaced scope from the system
- HTTP: `GET /apis/v2/core.kant.io/v1beta1/clusters/{cluster}/namespaces/{namespace}/devicemodels`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the DeviceModel belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the DeviceModel belongs to.
  - `--page` (query, int32): Page is current page.
  - `--page-size` (query, int32): Size is the data number shown per page.
  - `--name` (query): name is used for query.
  - `--workspace-id` (query, int32): workspaceId ID of workspace
- Output: list path `items`; columns `name`, `namespace`, `createTimestamp`; pagination `offset`

### `dce kant-management devicemodels update-device-model`

- Summary: UpdateDevice updates a devicemodel of namespaced scope from the system by given device name
- HTTP: `PUT /apis/core.kant.io/v1beta1/clusters/{cluster}/namespaces/{namespace}/devicemodels/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the DeviceModel belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the DeviceModel belongs to.
  - `--name` (path, required): Name represents the name of DeviceModel.

### `dce kant-management devicemodels update-device-model`

- Summary: UpdateDevice updates a devicemodel of namespaced scope from the system by given device name
- HTTP: `PUT /apis/v2/core.kant.io/v1beta1/clusters/{cluster}/namespaces/{namespace}/devicemodels/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the DeviceModel belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the DeviceModel belongs to.
  - `--name` (path, required): Name represents the name of DeviceModel.

## DeviceModelsWithWorkspace

### `dce kant-management devicemodelswithworkspace batch-delete-device-models`

- Summary: Batch delete devicemodels
- HTTP: `DELETE /apis/v2/core.kant.io/v1beta1/workspaces/{workspaceId_1}/clusters/{cluster}/namespaces/devicemodels`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id_1` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (path, required): For cluster resources, choose one of two with edgeunit.
- Output: list path `taskResults`; columns `id`, `errmsg`, `status`

### `dce kant-management devicemodelswithworkspace create-device-model`

- Summary: CreateDevice creates a devicemodel of namespaced scope to the system by given device data
- HTTP: `POST /apis/v2/core.kant.io/v1beta1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/devicemodels`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (path, required): Cluster represents which cluster the DeviceModel belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the DeviceModel belongs to.

### `dce kant-management devicemodelswithworkspace delete-device-model`

- Summary: DeleteDevice deletes a devicemodel of namespaced scope from the system by given devicemodel name
- HTTP: `DELETE /apis/v2/core.kant.io/v1beta1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/devicemodels/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): WorkspaceId is the id of workspace.
  - `--cluster` (path, required): Cluster is the name of the cluster.
  - `--namespace` (path, required): Namespace is the namespace of resource.
  - `--name` (path, required): Name is the name of resource.

### `dce kant-management devicemodelswithworkspace get-device-model`

- Summary: GetDevice gets a devicemodel of namespaced scope from the system
- HTTP: `GET /apis/v2/core.kant.io/v1beta1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/devicemodels/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): WorkspaceId is the id of workspace.
  - `--cluster` (path, required): Cluster is the name of the cluster.
  - `--namespace` (path, required): Namespace is the namespace of resource.
  - `--name` (path, required): Name is the name of resource.

### `dce kant-management devicemodelswithworkspace list-cluster-device-models`

- Summary: ListClusterDevice lists devicemodel of cluster scope
- HTTP: `GET /apis/v2/core.kant.io/v1beta1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/devicemodels`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (path, required): Cluster represents which cluster the DeviceModel belongs to.
  - `--page` (query, int32): Page is current page.
  - `--page-size` (query, int32): Size is the data number shown per page.
  - `--name` (query): name is used for query.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
- Output: list path `items`; columns `name`, `namespace`, `createTimestamp`; pagination `offset`

### `dce kant-management devicemodelswithworkspace list-device-models`

- Summary: ListDevice lists devicemodel of namespaced scope from the system
- HTTP: `GET /apis/v2/core.kant.io/v1beta1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/devicemodels`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (path, required): Cluster represents which cluster the DeviceModel belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the DeviceModel belongs to.
  - `--page` (query, int32): Page is current page.
  - `--page-size` (query, int32): Size is the data number shown per page.
  - `--name` (query): name is used for query.
- Output: list path `items`; columns `name`, `namespace`, `createTimestamp`; pagination `offset`

### `dce kant-management devicemodelswithworkspace update-device-model`

- Summary: UpdateDevice updates a devicemodel of namespaced scope from the system by given device name
- HTTP: `PUT /apis/v2/core.kant.io/v1beta1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/devicemodels/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (path, required): Cluster represents which cluster the DeviceModel belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the DeviceModel belongs to.
  - `--name` (path, required): Name represents the name of DeviceModel.

## Devices

### `dce kant-management devices batch-delete-devices`

- Summary: Batch delete devices
- HTTP: `DELETE /apis/v2/core.kant.io/v1beta1/clusters/{cluster}/namespaces/devices`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): For cluster resources, choose one of two with edgeunit.
- Output: list path `taskResults`; columns `id`, `errmsg`, `status`

### `dce kant-management devices batch-delete-devices`

- Summary: Batch delete devices
- HTTP: `DELETE /apis/core.kant.io/v1beta1/clusters/{cluster}/namespaces/devices`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): For cluster resources, choose one of two with edgeunit.
- Output: list path `taskResults`; columns `id`, `errmsg`, `status`

### `dce kant-management devices bind-node`

- Summary: BindNode bind device to node
- HTTP: `PATCH /apis/v2/core.kant.io/v1beta1/clusters/{cluster}/namespaces/{namespace}/devices/{name}/bind-node`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the Device belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the Device belongs to.
  - `--name` (path, required): Name represents the name of Device.

### `dce kant-management devices bind-node`

- Summary: BindNode bind device to node
- HTTP: `PATCH /apis/core.kant.io/v1beta1/clusters/{cluster}/namespaces/{namespace}/devices/{name}/bind-node`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the Device belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the Device belongs to.
  - `--name` (path, required): Name represents the name of Device.

### `dce kant-management devices create-device`

- Summary: CreateDevice creates a device of namespaced scope to the system by given device data
- HTTP: `POST /apis/core.kant.io/v1beta1/clusters/{cluster}/namespaces/{namespace}/devices`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the Device belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the Device belongs to.

### `dce kant-management devices create-device`

- Summary: CreateDevice creates a device of namespaced scope to the system by given device data
- HTTP: `POST /apis/v2/core.kant.io/v1beta1/clusters/{cluster}/namespaces/{namespace}/devices`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the Device belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the Device belongs to.

### `dce kant-management devices delete-device`

- Summary: DeleteDevice deletes a device of namespaced scope from the system by given device name
- HTTP: `DELETE /apis/core.kant.io/v1beta1/clusters/{cluster}/namespaces/{namespace}/devices/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the Device belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the Device belongs to.
  - `--name` (path, required): Name represents the name of Device.
  - `--workspace-id` (query, int32): workspaceId ID of workspace

### `dce kant-management devices delete-device`

- Summary: DeleteDevice deletes a device of namespaced scope from the system by given device name
- HTTP: `DELETE /apis/v2/core.kant.io/v1beta1/clusters/{cluster}/namespaces/{namespace}/devices/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster.
  - `--namespace` (path, required): Namespace is the namespace of resource.
  - `--name` (path, required): Name is the name of resource.
  - `--workspace-id` (query, int32): WorkspaceId is the id of workspace.

### `dce kant-management devices get-device`

- Summary: GetDevice gets a device of namespaced scope from the system
- HTTP: `GET /apis/v2/core.kant.io/v1beta1/clusters/{cluster}/namespaces/{namespace}/devices/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster.
  - `--namespace` (path, required): Namespace is the namespace of resource.
  - `--name` (path, required): Name is the name of resource.
  - `--workspace-id` (query, int32): WorkspaceId is the id of workspace.

### `dce kant-management devices get-device`

- Summary: GetDevice gets a device of namespaced scope from the system
- HTTP: `GET /apis/core.kant.io/v1beta1/clusters/{cluster}/namespaces/{namespace}/devices/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the Device belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the Device belongs to.
  - `--name` (path, required): Name represents the name of Device.
  - `--workspace-id` (query, int32): workspaceId ID of workspace

### `dce kant-management devices list-cluster-devices`

- Summary: ListClusterDevice lists device of cluster scope
- HTTP: `GET /apis/v2/core.kant.io/v1beta1/clusters/{cluster}/namespaces/devices`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the Device belongs to.
  - `--page` (query, int32): Page is current page.
  - `--page-size` (query, int32): Size is the data number shown per page.
  - `--name` (query): name is used for query.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--workspace-id` (query, int32): workspaceId ID of workspace
- Output: list path `items`; columns `name`, `namespace`, `createTimestamp`; pagination `offset`

### `dce kant-management devices list-cluster-devices`

- Summary: ListClusterDevice lists device of cluster scope
- HTTP: `GET /apis/core.kant.io/v1beta1/clusters/{cluster}/namespaces/devices`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the Device belongs to.
  - `--page` (query, int32): Page is current page.
  - `--page-size` (query, int32): Size is the data number shown per page.
  - `--name` (query): name is used for query.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--workspace-id` (query, int32): workspaceId ID of workspace
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `kind`, `apiVersion`; pagination `offset`

### `dce kant-management devices list-devices`

- Summary: ListDevice lists device of namespaced scope from the system
- HTTP: `GET /apis/core.kant.io/v1beta1/clusters/{cluster}/namespaces/{namespace}/devices`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the Device belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the Device belongs to.
  - `--page` (query, int32): Page is current page.
  - `--page-size` (query, int32): Size is the data number shown per page.
  - `--name` (query): name is used for query.
  - `--model-name` (query): modelname is used for query.
  - `--workspace-id` (query, int32): workspaceId ID of workspace
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `kind`, `apiVersion`; pagination `offset`

### `dce kant-management devices list-devices`

- Summary: ListDevice lists device of namespaced scope from the system
- HTTP: `GET /apis/v2/core.kant.io/v1beta1/clusters/{cluster}/namespaces/{namespace}/devices`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the Device belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the Device belongs to.
  - `--page` (query, int32): Page is current page.
  - `--page-size` (query, int32): Size is the data number shown per page.
  - `--name` (query): name is used for query.
  - `--model-name` (query): modelname is used for query.
  - `--workspace-id` (query, int32): workspaceId ID of workspace
- Output: list path `items`; columns `name`, `namespace`, `createTimestamp`; pagination `offset`

### `dce kant-management devices patch-devices`

- Summary: Patch device
- HTTP: `PATCH /apis/core.kant.io/v1beta1/clusters/{cluster}/namespaces/{namespace}/devices/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name

### `dce kant-management devices patch-devices`

- Summary: Patch device
- HTTP: `PATCH /apis/v2/core.kant.io/v1beta1/clusters/{cluster}/namespaces/{namespace}/devices/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name

### `dce kant-management devices update-device`

- Summary: UpdateDevice updates a device of namespaced scope from the system by given device name
- HTTP: `PUT /apis/core.kant.io/v1beta1/clusters/{cluster}/namespaces/{namespace}/devices/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the Device belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the Device belongs to.
  - `--name` (path, required): Name represents the name of Device.

### `dce kant-management devices update-device`

- Summary: UpdateDevice updates a device of namespaced scope from the system by given device name
- HTTP: `PUT /apis/v2/core.kant.io/v1beta1/clusters/{cluster}/namespaces/{namespace}/devices/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the Device belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the Device belongs to.
  - `--name` (path, required): Name represents the name of Device.

## DevicesWithWorkspace

### `dce kant-management deviceswithworkspace batch-delete-devices`

- Summary: Batch delete devices
- HTTP: `DELETE /apis/v2/core.kant.io/v1beta1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/devices`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (path, required): For cluster resources, choose one of two with edgeunit.
- Output: list path `taskResults`; columns `id`, `errmsg`, `status`

### `dce kant-management deviceswithworkspace bind-node`

- Summary: BindNode bind device to node
- HTTP: `PATCH /apis/v2/core.kant.io/v1beta1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/devices/{name}/bind-node`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (path, required): Cluster represents which cluster the Device belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the Device belongs to.
  - `--name` (path, required): Name represents the name of Device.

### `dce kant-management deviceswithworkspace create-device`

- Summary: CreateDevice creates a device of namespaced scope to the system by given device data
- HTTP: `POST /apis/v2/core.kant.io/v1beta1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/devices`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (path, required): Cluster represents which cluster the Device belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the Device belongs to.

### `dce kant-management deviceswithworkspace delete-device`

- Summary: DeleteDevice deletes a device of namespaced scope from the system by given device name
- HTTP: `DELETE /apis/v2/core.kant.io/v1beta1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/devices/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): WorkspaceId is the id of workspace.
  - `--cluster` (path, required): Cluster is the name of the cluster.
  - `--namespace` (path, required): Namespace is the namespace of resource.
  - `--name` (path, required): Name is the name of resource.

### `dce kant-management deviceswithworkspace get-device`

- Summary: GetDevice gets a device of namespaced scope from the system
- HTTP: `GET /apis/v2/core.kant.io/v1beta1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/devices/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): WorkspaceId is the id of workspace.
  - `--cluster` (path, required): Cluster is the name of the cluster.
  - `--namespace` (path, required): Namespace is the namespace of resource.
  - `--name` (path, required): Name is the name of resource.

### `dce kant-management deviceswithworkspace list-cluster-devices`

- Summary: ListClusterDevice lists device of cluster scope
- HTTP: `GET /apis/v2/core.kant.io/v1beta1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/devices`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (path, required): Cluster represents which cluster the Device belongs to.
  - `--page` (query, int32): Page is current page.
  - `--page-size` (query, int32): Size is the data number shown per page.
  - `--name` (query): name is used for query.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
- Output: list path `items`; columns `name`, `namespace`, `createTimestamp`; pagination `offset`

### `dce kant-management deviceswithworkspace list-devices`

- Summary: ListDevice lists device of namespaced scope from the system
- HTTP: `GET /apis/v2/core.kant.io/v1beta1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/devices`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (path, required): Cluster represents which cluster the Device belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the Device belongs to.
  - `--page` (query, int32): Page is current page.
  - `--page-size` (query, int32): Size is the data number shown per page.
  - `--name` (query): name is used for query.
  - `--model-name` (query): modelname is used for query.
- Output: list path `items`; columns `name`, `namespace`, `createTimestamp`; pagination `offset`

### `dce kant-management deviceswithworkspace patch-devices`

- Summary: Patch device
- HTTP: `PATCH /apis/v2/core.kant.io/v1beta1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/devices/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name

### `dce kant-management deviceswithworkspace update-device`

- Summary: UpdateDevice updates a device of namespaced scope from the system by given device name
- HTTP: `PUT /apis/v2/core.kant.io/v1beta1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/devices/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (path, required): Cluster represents which cluster the Device belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the Device belongs to.
  - `--name` (path, required): Name represents the name of Device.

## EdgeApp

### `dce kant-management edgeapp create-edge-application`

- Summary: CreateEdgeApplication creates a edgeapplication under the namespaces of a specific cluster
- HTTP: `POST /apis/v2/batch.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/edgeapplications`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the deployment belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the deployment belongs to.

### `dce kant-management edgeapp create-edge-application`

- Summary: CreateEdgeApplication creates a edgeapplication under the namespaces of a specific cluster
- HTTP: `POST /apis/batch.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/edgeapplications`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the deployment belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the deployment belongs to.

### `dce kant-management edgeapp delete-edge-application`

- Summary: DeleteEdgeApplication deletes a edgeapplication under the namespaces of a specific cluster
- HTTP: `DELETE /apis/v2/batch.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the CustomResource belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the CustomResource belongs to.
  - `--name` (path, required): Name represents the name of CustomResource.
  - `--workspace-id` (query, int32): workspaceId ID of workspace

### `dce kant-management edgeapp delete-edge-application`

- Summary: DeleteEdgeApplication deletes a edgeapplication under the namespaces of a specific cluster
- HTTP: `DELETE /apis/batch.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the CustomResource belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the CustomResource belongs to.
  - `--name` (path, required): Name represents the name of CustomResource.

### `dce kant-management edgeapp delete-target-node-group`

- Summary: DeleteTargetNodeGroup deletes a target node group of a edgeapplication under the namespaces of a specific cluster
- HTTP: `DELETE /apis/batch.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}/targetnodegroups/{targetnodegroup}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the TargetNodeGroupInstance belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the TargetNodeGroupInstance belongs to.
  - `--name` (path, required): Name represents the name of edgeapplications.
  - `--targetnodegroup` (path, required): TargetNodeGroupName represents the name of TargetNodeGroupInstance.

### `dce kant-management edgeapp delete-target-node-group`

- Summary: DeleteTargetNodeGroup deletes a target node group of a edgeapplication under the namespaces of a specific cluster
- HTTP: `DELETE /apis/v2/batch.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}/targetnodegroups/{targetnodegroup}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the TargetNodeGroupInstance belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the TargetNodeGroupInstance belongs to.
  - `--name` (path, required): Name represents the name of edgeapplications.
  - `--targetnodegroup` (path, required): TargetNodeGroupName represents the name of TargetNodeGroupInstance.
  - `--workspace-id` (query, int32): workspaceId ID of workspace

### `dce kant-management edgeapp deploy-target-node-group`

- Summary: DeployTargetNodeGroup deploys a target node group of a edgeapplication under the namespaces of a specific cluster
- HTTP: `POST /apis/v2/batch.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}/targetnodegroups`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the TargetNodeGroupInstance belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the TargetNodeGroupInstance belongs to.
  - `--name` (path, required): Name represents the name of edgeapplications.

### `dce kant-management edgeapp deploy-target-node-group`

- Summary: DeployTargetNodeGroup deploys a target node group of a edgeapplication under the namespaces of a specific cluster
- HTTP: `POST /apis/batch.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}/targetnodegroups`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the TargetNodeGroupInstance belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the TargetNodeGroupInstance belongs to.
  - `--name` (path, required): Name represents the name of edgeapplications.

### `dce kant-management edgeapp get-edge-app-check-result`

- Summary: GetEdgeAppCheckResult verifies a edgeapplication container's image & env & command & args & resource under the
- HTTP: `POST /apis/v2/batch.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}/verify`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the TargetNodeGroupInstance belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the TargetNodeGroupInstance belongs to.
  - `--name` (path, required): Name represents the name of edgeapplications.

### `dce kant-management edgeapp get-edge-app-check-result`

- Summary: GetEdgeAppCheckResult verifies a edgeapplication container's image & env & command & args & resource under the
- HTTP: `POST /apis/batch.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}/verify`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the TargetNodeGroupInstance belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the TargetNodeGroupInstance belongs to.
  - `--name` (path, required): Name represents the name of edgeapplications.

### `dce kant-management edgeapp get-edge-app-override-features`

- Summary: GetEdgeAppOverrideFeatures gets the override features of a edgeapplication under a specific cluster
- HTTP: `GET /apis/v2/batch.kant.io/v1alpha1/clusters/{cluster}/edgeappoverridefeatures`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the TargetNodeGroupInstance belongs to.
  - `--workspace-id` (query, int32): workspaceId ID of workspace

### `dce kant-management edgeapp get-edge-app-override-features`

- Summary: GetEdgeAppOverrideFeatures gets the override features of a edgeapplication under a specific cluster
- HTTP: `GET /apis/batch.kant.io/v1alpha1/clusters/{cluster}/edgeappoverridefeatures`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the TargetNodeGroupInstance belongs to.

### `dce kant-management edgeapp get-edge-application`

- Summary: GetEdgeApplication gets a edgeapplication under the namespaces of a specific cluster
- HTTP: `GET /apis/v2/batch.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster.
  - `--namespace` (path, required): Namespace is the namespace of resource.
  - `--name` (path, required): Name is the name of resource.
  - `--workspace-id` (query, int32): WorkspaceId is the id of workspace.

### `dce kant-management edgeapp get-edge-application`

- Summary: GetEdgeApplication gets a edgeapplication under the namespaces of a specific cluster
- HTTP: `GET /apis/batch.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the CustomResource belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the CustomResource belongs to.
  - `--name` (path, required): Name represents the name of CustomResource.

### `dce kant-management edgeapp get-target-node-group`

- Summary: GetTargetNodeGroup gets a target node group of a edgeapplication under the namespaces of a specific cluster
- HTTP: `GET /apis/batch.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}/targetnodegroups/{targetnodegroup}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the TargetNodeGroupInstance belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the TargetNodeGroupInstance belongs to.
  - `--name` (path, required): Name represents the name of edgeapplications.
  - `--targetnodegroup` (path, required): TargetNodeGroupName represents the name of TargetNodeGroupInstance.

### `dce kant-management edgeapp get-target-node-group`

- Summary: GetTargetNodeGroup gets a target node group of a edgeapplication under the namespaces of a specific cluster
- HTTP: `GET /apis/v2/batch.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}/targetnodegroups/{targetnodegroup}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the TargetNodeGroupInstance belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the TargetNodeGroupInstance belongs to.
  - `--name` (path, required): Name represents the name of edgeapplications.
  - `--targetnodegroup` (path, required): TargetNodeGroupName represents the name of TargetNodeGroupInstance.
  - `--workspace-id` (query, int32): workspaceId ID of workspace

### `dce kant-management edgeapp list-cluster-edge-applications`

- Summary: ListClusterEdgeApplications lists all edgeapplications under the namespaces of a specific cluster
- HTTP: `GET /apis/batch.kant.io/v1alpha1/clusters/{cluster}/namespaces/edgeapplications`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the EdgeApplications belongs to.
  - `--namespace` (query): Namespace represents which namespace the EdgeApplications belongs to.
  - `--page` (query, int32): Page is current page.
  - `--page-size` (query, int32): Size is the data number shown per page.
  - `--name` (query): name is used for query.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the data list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `kind`, `apiVersion`; pagination `offset`

### `dce kant-management edgeapp list-cluster-edge-applications`

- Summary: ListClusterEdgeApplications lists all edgeapplications under the namespaces of a specific cluster
- HTTP: `GET /apis/v2/batch.kant.io/v1alpha1/clusters/{cluster}/namespaces/edgeapplications`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the EdgeApplications belongs to.
  - `--namespace` (query): Namespace represents which namespace the EdgeApplications belongs to.
  - `--page` (query, int32): Page is current page.
  - `--page-size` (query, int32): Size is the data number shown per page.
  - `--name` (query): name is used for query.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the data list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--workspace-id` (query, int32): workspaceId ID of workspace
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `kind`, `apiVersion`; pagination `offset`

### `dce kant-management edgeapp list-edge-app-unassociated-node-groups`

- Summary: ListEdgeAppUnassociatedNodeGroups lists all unassociated node groups of a edgeapplication under the namespaces of
- HTTP: `GET /apis/batch.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}/unassociatednodegroups`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the EdgeApplications belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the EdgeApplications belongs to.
  - `--name` (path, required): Name represents the name of edgeapplications.
  - `--page` (query, int32): Page is current page.
  - `--page-size` (query, int32): Size is the data number shown per page.
  - `--fuzzy-name` (query): fuzzyName is used for fuzzy query.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `kind`, `apiVersion`; pagination `offset`

### `dce kant-management edgeapp list-edge-app-unassociated-node-groups`

- Summary: ListEdgeAppUnassociatedNodeGroups lists all unassociated node groups of a edgeapplication under the namespaces of
- HTTP: `GET /apis/v2/batch.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}/unassociatednodegroups`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the EdgeApplications belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the EdgeApplications belongs to.
  - `--name` (path, required): Name represents the name of edgeapplications.
  - `--page` (query, int32): Page is current page.
  - `--page-size` (query, int32): Size is the data number shown per page.
  - `--fuzzy-name` (query): fuzzyName is used for fuzzy query.
  - `--workspace-id` (query, int32): workspaceId ID of workspace
- Output: list path `items`; columns `name`, `createTimestamp`; pagination `offset`

### `dce kant-management edgeapp list-edge-applications`

- Summary: ListEdgeApplications lists all edgeapplications under the namespaces of a specific cluster
- HTTP: `GET /apis/batch.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/edgeapplications`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the EdgeApplications belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the EdgeApplications belongs to.
  - `--page` (query, int32): Page is current page.
  - `--page-size` (query, int32): Size is the data number shown per page.
  - `--name` (query): name is used for query.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the data list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `kind`, `apiVersion`; pagination `offset`

### `dce kant-management edgeapp list-edge-applications`

- Summary: ListEdgeApplications lists all edgeapplications under the namespaces of a specific cluster
- HTTP: `GET /apis/v2/batch.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/edgeapplications`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the EdgeApplications belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the EdgeApplications belongs to.
  - `--page` (query, int32): Page is current page.
  - `--page-size` (query, int32): Size is the data number shown per page.
  - `--name` (query): name is used for query.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the data list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--workspace-id` (query, int32): workspaceId ID of workspace
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `kind`, `apiVersion`; pagination `offset`

### `dce kant-management edgeapp list-target-node-groups`

- Summary: ListTargetNodeGroups lists all target node groups of a edgeapplication under the namespaces of a specific cluster
- HTTP: `GET /apis/batch.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}/targetnodegroups`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the EdgeApplications belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the EdgeApplications belongs to.
  - `--name` (path, required): Name represents the name of edgeapplications.
  - `--page` (query, int32): Page is current page.
  - `--page-size` (query, int32): Size is the data number shown per page.
  - `--fuzzy-name` (query): fuzzyName is used for fuzzy query.
- Output: list path `items`; columns `deploymentName`, `nodeGroupName`, `replicas`, `status`; pagination `offset`

### `dce kant-management edgeapp list-target-node-groups`

- Summary: ListTargetNodeGroups lists all target node groups of a edgeapplication under the namespaces of a specific cluster
- HTTP: `GET /apis/v2/batch.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}/targetnodegroups`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the EdgeApplications belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the EdgeApplications belongs to.
  - `--name` (path, required): Name represents the name of edgeapplications.
  - `--page` (query, int32): Page is current page.
  - `--page-size` (query, int32): Size is the data number shown per page.
  - `--fuzzy-name` (query): fuzzyName is used for fuzzy query.
  - `--workspace-id` (query, int32): workspaceId ID of workspace
- Output: list path `items`; columns `deploymentName`, `nodeGroupName`, `replicas`, `status`; pagination `offset`

### `dce kant-management edgeapp update-edge-application`

- Summary: UpdateEdgeApplication updates a edgeapplication under the namespaces of a specific cluster
- HTTP: `PUT /apis/batch.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the CustomResource belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the CustomResource belongs to.
  - `--name` (path, required): Name represents the name of CustomResource.

### `dce kant-management edgeapp update-edge-application`

- Summary: UpdateEdgeApplication updates a edgeapplication under the namespaces of a specific cluster
- HTTP: `PUT /apis/v2/batch.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the CustomResource belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the CustomResource belongs to.
  - `--name` (path, required): Name represents the name of CustomResource.

### `dce kant-management edgeapp update-target-node-groups`

- Summary: UpdateTargetNodeGroups updates target node groups of a edgeapplication under the namespaces of a specific cluster
- HTTP: `PUT /apis/v2/batch.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}/targetnodegroups/{targetnodegroup}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the TargetNodeGroupInstance belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the TargetNodeGroupInstance belongs to.
  - `--name` (path, required): Name represents the name of edgeapplications.
  - `--targetnodegroup` (path, required): TargetNodeGroupName represents the name of TargetNodeGroupInstance.

### `dce kant-management edgeapp update-target-node-groups`

- Summary: UpdateTargetNodeGroups updates target node groups of a edgeapplication under the namespaces of a specific cluster
- HTTP: `PUT /apis/batch.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}/targetnodegroups/{targetnodegroup}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the TargetNodeGroupInstance belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the TargetNodeGroupInstance belongs to.
  - `--name` (path, required): Name represents the name of edgeapplications.
  - `--targetnodegroup` (path, required): TargetNodeGroupName represents the name of TargetNodeGroupInstance.

### `dce kant-management edgeapp verify-edge-application-image`

- Summary: verifyEdgeApplicationImage verifies a edgeapplication image under the namespaces of a specific cluster
- HTTP: `POST /apis/v2/batch.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}/verifyimage`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the TargetNodeGroupInstance belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the TargetNodeGroupInstance belongs to.
  - `--name` (path, required): Name represents the name of edgeapplications.
- Output: list path `defaultImages`

### `dce kant-management edgeapp verify-edge-application-image`

- Summary: verifyEdgeApplicationImage verifies a edgeapplication image under the namespaces of a specific cluster
- HTTP: `POST /apis/batch.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}/verifyimage`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the TargetNodeGroupInstance belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the TargetNodeGroupInstance belongs to.
  - `--name` (path, required): Name represents the name of edgeapplications.
- Output: list path `defaultImages`

## EdgeAppWithWorkspace

### `dce kant-management edgeappwithworkspace create-edge-application`

- Summary: CreateEdgeApplication creates a edgeapplication under the namespaces of a specific cluster
- HTTP: `POST /apis/v2/batch.kant.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/edgeapplications`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (path, required): Cluster represents which cluster the deployment belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the deployment belongs to.

### `dce kant-management edgeappwithworkspace delete-edge-application`

- Summary: DeleteEdgeApplication deletes a edgeapplication under the namespaces of a specific cluster
- HTTP: `DELETE /apis/v2/batch.kant.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (path, required): Cluster represents which cluster the CustomResource belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the CustomResource belongs to.
  - `--name` (path, required): Name represents the name of CustomResource.

### `dce kant-management edgeappwithworkspace delete-target-node-group`

- Summary: DeleteTargetNodeGroup deletes a target node group of a edgeapplication under the namespaces of a specific cluster
- HTTP: `DELETE /apis/v2/batch.kant.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}/targetnodegroups/{targetnodegroup}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (path, required): Cluster represents which cluster the TargetNodeGroupInstance belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the TargetNodeGroupInstance belongs to.
  - `--name` (path, required): Name represents the name of edgeapplications.
  - `--targetnodegroup` (path, required): TargetNodeGroupName represents the name of TargetNodeGroupInstance.

### `dce kant-management edgeappwithworkspace deploy-target-node-group`

- Summary: DeployTargetNodeGroup deploys a target node group of a edgeapplication under the namespaces of a specific cluster
- HTTP: `POST /apis/v2/batch.kant.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}/targetnodegroups`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (path, required): Cluster represents which cluster the TargetNodeGroupInstance belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the TargetNodeGroupInstance belongs to.
  - `--name` (path, required): Name represents the name of edgeapplications.

### `dce kant-management edgeappwithworkspace get-edge-app-check-result`

- Summary: GetEdgeAppCheckResult verifies a edgeapplication container's image & env & command & args & resource under the
- HTTP: `POST /apis/v2/batch.kant.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}/verify`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (path, required): Cluster represents which cluster the TargetNodeGroupInstance belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the TargetNodeGroupInstance belongs to.
  - `--name` (path, required): Name represents the name of edgeapplications.

### `dce kant-management edgeappwithworkspace get-edge-app-override-features`

- Summary: GetEdgeAppOverrideFeatures gets the override features of a edgeapplication under a specific cluster
- HTTP: `GET /apis/v2/batch.kant.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/edgeappoverridefeatures`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (path, required): Cluster represents which cluster the TargetNodeGroupInstance belongs to.

### `dce kant-management edgeappwithworkspace get-edge-application`

- Summary: GetEdgeApplication gets a edgeapplication under the namespaces of a specific cluster
- HTTP: `GET /apis/v2/batch.kant.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): WorkspaceId is the id of workspace.
  - `--cluster` (path, required): Cluster is the name of the cluster.
  - `--namespace` (path, required): Namespace is the namespace of resource.
  - `--name` (path, required): Name is the name of resource.

### `dce kant-management edgeappwithworkspace get-target-node-group`

- Summary: GetTargetNodeGroup gets a target node group of a edgeapplication under the namespaces of a specific cluster
- HTTP: `GET /apis/v2/batch.kant.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}/targetnodegroups/{targetnodegroup}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (path, required): Cluster represents which cluster the TargetNodeGroupInstance belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the TargetNodeGroupInstance belongs to.
  - `--name` (path, required): Name represents the name of edgeapplications.
  - `--targetnodegroup` (path, required): TargetNodeGroupName represents the name of TargetNodeGroupInstance.

### `dce kant-management edgeappwithworkspace list-cluster-edge-applications`

- Summary: ListClusterEdgeApplications lists all edgeapplications under the namespaces of a specific cluster
- HTTP: `GET /apis/v2/batch.kant.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/edgeapplications`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (path, required): Cluster represents which cluster the EdgeApplications belongs to.
  - `--namespace` (query): Namespace represents which namespace the EdgeApplications belongs to.
  - `--page` (query, int32): Page is current page.
  - `--page-size` (query, int32): Size is the data number shown per page.
  - `--name` (query): name is used for query.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the data list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `kind`, `apiVersion`; pagination `offset`

### `dce kant-management edgeappwithworkspace list-edge-app-unassociated-node-groups`

- Summary: ListEdgeAppUnassociatedNodeGroups lists all unassociated node groups of a edgeapplication under the namespaces of
- HTTP: `GET /apis/v2/batch.kant.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}/unassociatednodegroups`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (path, required): Cluster represents which cluster the EdgeApplications belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the EdgeApplications belongs to.
  - `--name` (path, required): Name represents the name of edgeapplications.
  - `--page` (query, int32): Page is current page.
  - `--page-size` (query, int32): Size is the data number shown per page.
  - `--fuzzy-name` (query): fuzzyName is used for fuzzy query.
- Output: list path `items`; columns `name`, `createTimestamp`; pagination `offset`

### `dce kant-management edgeappwithworkspace list-edge-applications`

- Summary: ListEdgeApplications lists all edgeapplications under the namespaces of a specific cluster
- HTTP: `GET /apis/v2/batch.kant.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/edgeapplications`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (path, required): Cluster represents which cluster the EdgeApplications belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the EdgeApplications belongs to.
  - `--page` (query, int32): Page is current page.
  - `--page-size` (query, int32): Size is the data number shown per page.
  - `--name` (query): name is used for query.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the data list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `kind`, `apiVersion`; pagination `offset`

### `dce kant-management edgeappwithworkspace list-target-node-groups`

- Summary: ListTargetNodeGroups lists all target node groups of a edgeapplication under the namespaces of a specific cluster
- HTTP: `GET /apis/v2/batch.kant.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}/targetnodegroups`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (path, required): Cluster represents which cluster the EdgeApplications belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the EdgeApplications belongs to.
  - `--name` (path, required): Name represents the name of edgeapplications.
  - `--page` (query, int32): Page is current page.
  - `--page-size` (query, int32): Size is the data number shown per page.
  - `--fuzzy-name` (query): fuzzyName is used for fuzzy query.
- Output: list path `items`; columns `deploymentName`, `nodeGroupName`, `replicas`, `status`; pagination `offset`

### `dce kant-management edgeappwithworkspace update-edge-application`

- Summary: UpdateEdgeApplication updates a edgeapplication under the namespaces of a specific cluster
- HTTP: `PUT /apis/v2/batch.kant.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (path, required): Cluster represents which cluster the CustomResource belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the CustomResource belongs to.
  - `--name` (path, required): Name represents the name of CustomResource.

### `dce kant-management edgeappwithworkspace update-target-node-groups`

- Summary: UpdateTargetNodeGroups updates target node groups of a edgeapplication under the namespaces of a specific cluster
- HTTP: `PUT /apis/v2/batch.kant.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}/targetnodegroups/{targetnodegroup}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (path, required): Cluster represents which cluster the TargetNodeGroupInstance belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the TargetNodeGroupInstance belongs to.
  - `--name` (path, required): Name represents the name of edgeapplications.
  - `--targetnodegroup` (path, required): TargetNodeGroupName represents the name of TargetNodeGroupInstance.

### `dce kant-management edgeappwithworkspace verify-edge-application-image`

- Summary: verifyEdgeApplicationImage verifies a edgeapplication image under the namespaces of a specific cluster
- HTTP: `POST /apis/v2/batch.kant.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/edgeapplications/{name}/verifyimage`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (path, required): Cluster represents which cluster the TargetNodeGroupInstance belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the TargetNodeGroupInstance belongs to.
  - `--name` (path, required): Name represents the name of edgeapplications.
- Output: list path `defaultImages`

## EdgeUnits

### `dce kant-management edgeunits create-edge-unit`

- Summary: EdgeUnits_CreateEdgeUnit
- HTTP: `POST /apis/v2/core.kant.io/v1beta1/edgeunits`
- Auth: required
- Body: required
- Flags: none

### `dce kant-management edgeunits create-edge-unit`

- Summary: EdgeUnits_CreateEdgeUnit
- HTTP: `POST /apis/core.kant.io/v1beta1/edgeunits`
- Auth: required
- Body: required
- Flags: none

### `dce kant-management edgeunits delete-edge-unit`

- Summary: EdgeUnits_DeleteEdgeUnit
- HTTP: `DELETE /apis/core.kant.io/v1beta1/edgeunits/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name of edgeunit

### `dce kant-management edgeunits delete-edge-unit`

- Summary: EdgeUnits_DeleteEdgeUnit
- HTTP: `DELETE /apis/v2/core.kant.io/v1beta1/edgeunits/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name of edgeunit
  - `--workspace-id` (query, int32): workspaceId ID of workspace

### `dce kant-management edgeunits get-addons`

- Summary: EdgeUnits_GetAddons
- HTTP: `GET /apis/v2/core.kant.io/v1beta1/edgeunits/{name}/addons`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name
  - `--workspace-id` (query, int32): workspaceId ID of workspace

### `dce kant-management edgeunits get-addons`

- Summary: EdgeUnits_GetAddons
- HTTP: `GET /apis/core.kant.io/v1beta1/edgeunits/{name}/addons`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name

### `dce kant-management edgeunits get-components-repository`

- Summary: EdgeUnits_GetComponentsRepository
- HTTP: `GET /apis/v2/core.kant.io/v1beta1/edgeunits/{name}/components-repository`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name of edgeunit
  - `--workspace-id` (query, int32): workspaceId ID of workspace

### `dce kant-management edgeunits get-components-repository`

- Summary: EdgeUnits_GetComponentsRepository
- HTTP: `GET /apis/core.kant.io/v1beta1/edgeunits/{name}/components-repository`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name of edgeunit

### `dce kant-management edgeunits get-edge-unit`

- Summary: EdgeUnits_GetEdgeUnit
- HTTP: `GET /apis/v2/core.kant.io/v1beta1/edgeunits/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name of edgeunit
  - `--workspace-id` (query, int32): workspaceId ID of workspace

### `dce kant-management edgeunits get-edge-unit`

- Summary: EdgeUnits_GetEdgeUnit
- HTTP: `GET /apis/core.kant.io/v1beta1/edgeunits/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name of edgeunit

### `dce kant-management edgeunits list-cloud-core-host-i-ps`

- Summary: EdgeUnits_ListCloudCoreHostIPs
- HTTP: `GET /apis/v2/core.kant.io/v1beta1/edgeunits/{name}/cloudcorehostips`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name
  - `--workspace-id` (query, int32): workspaceId ID of workspace
- Output: list path `hostIps`

### `dce kant-management edgeunits list-cloud-core-host-i-ps`

- Summary: EdgeUnits_ListCloudCoreHostIPs
- HTTP: `GET /apis/core.kant.io/v1beta1/edgeunits/{name}/cloudcorehostips`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name
- Output: list path `hostIps`

### `dce kant-management edgeunits list-edge-unit`

- Summary: EdgeUnits_ListEdgeUnit
- HTTP: `GET /apis/core.kant.io/v1beta1/edgeunits`
- Auth: required
- Body: none
- Flags:
  - `--page` (query, int32): represents the page number. If the value is -1, returns all
  - `--page-size` (query, int32): represents the page size
  - `--search` (query): search condition for list
  - `--cluster` (query): cluster name
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `status.phase`; pagination `offset`

### `dce kant-management edgeunits list-edge-unit`

- Summary: EdgeUnits_ListEdgeUnit
- HTTP: `GET /apis/v2/core.kant.io/v1beta1/edgeunits`
- Auth: required
- Body: none
- Flags:
  - `--page` (query, int32): represents the page number. If the value is -1, returns all
  - `--page-size` (query, int32): represents the page size
  - `--search` (query): search condition for list
  - `--cluster` (query): cluster name
  - `--workspace-id` (query, int32): workspaceId ID of workspace
- Output: list path `items`; columns `name`, `status.phase`, `createTimestamp`; pagination `offset`

### `dce kant-management edgeunits list-edge-unit-resource-policies`

- Summary: EdgeUnits_ListEdgeUnitResourcePolicies
- HTTP: `GET /apis/core.kant.io/v1beta1/edgeunit-resource-policies`
- Auth: required
- Body: none
- Flags: none
- Output: list path `items`; columns `name`, `descEN`, `descZH`, `version`

### `dce kant-management edgeunits list-edge-unit-resource-policies`

- Summary: EdgeUnits_ListEdgeUnitResourcePolicies
- HTTP: `GET /apis/v2/core.kant.io/v1beta1/edgeunit-resource-policies`
- Auth: required
- Body: none
- Flags: none
- Output: list path `items`; columns `name`, `descEN`, `descZH`, `version`

### `dce kant-management edgeunits update-edge-unit`

- Summary: EdgeUnits_UpdateEdgeUnit
- HTTP: `PUT /apis/v2/core.kant.io/v1beta1/edgeunits/{name}`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): Name is the name of EdgeUnit.

### `dce kant-management edgeunits update-edge-unit`

- Summary: EdgeUnits_UpdateEdgeUnit
- HTTP: `PUT /apis/core.kant.io/v1beta1/edgeunits/{name}`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): name of edgeunit

## EdgeUnitsWithWorkspace

### `dce kant-management edgeunitswithworkspace create-edge-unit`

- Summary: EdgeUnitsWithWorkspace_CreateEdgeUnit
- HTTP: `POST /apis/v2/core.kant.io/v1beta1/workspaces/{workspaceId}/edgeunits`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace

### `dce kant-management edgeunitswithworkspace delete-edge-unit`

- Summary: EdgeUnitsWithWorkspace_DeleteEdgeUnit
- HTTP: `DELETE /apis/v2/core.kant.io/v1beta1/workspaces/{workspaceId}/edgeunits/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--name` (path, required): name of edgeunit

### `dce kant-management edgeunitswithworkspace get-addons`

- Summary: EdgeUnitsWithWorkspace_GetAddons
- HTTP: `GET /apis/v2/core.kant.io/v1beta1/workspaces/{workspaceId}/edgeunits/{name}/addons`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--name` (path, required): name

### `dce kant-management edgeunitswithworkspace get-components-repository`

- Summary: EdgeUnitsWithWorkspace_GetComponentsRepository
- HTTP: `GET /apis/v2/core.kant.io/v1beta1/workspaces/{workspaceId}/edgeunits/{name}/components-repository`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--name` (path, required): name of edgeunit

### `dce kant-management edgeunitswithworkspace get-edge-unit`

- Summary: EdgeUnitsWithWorkspace_GetEdgeUnit
- HTTP: `GET /apis/v2/core.kant.io/v1beta1/workspaces/{workspaceId}/edgeunits/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--name` (path, required): name of edgeunit

### `dce kant-management edgeunitswithworkspace list-cloud-core-host-i-ps`

- Summary: EdgeUnitsWithWorkspace_ListCloudCoreHostIPs
- HTTP: `GET /apis/v2/core.kant.io/v1beta1/workspaces/{workspaceId}/edgeunits/{name}/cloudcorehostips`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--name` (path, required): name
- Output: list path `hostIps`

### `dce kant-management edgeunitswithworkspace list-edge-unit`

- Summary: EdgeUnitsWithWorkspace_ListEdgeUnit
- HTTP: `GET /apis/v2/core.kant.io/v1beta1/workspaces/{workspaceId}/edgeunits`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--page` (query, int32): represents the page number. If the value is -1, returns all
  - `--page-size` (query, int32): represents the page size
  - `--search` (query): search condition for list
  - `--cluster` (query): cluster name
- Output: list path `items`; columns `name`, `status.phase`, `createTimestamp`; pagination `offset`

### `dce kant-management edgeunitswithworkspace update-edge-unit`

- Summary: EdgeUnitsWithWorkspace_UpdateEdgeUnit
- HTTP: `PUT /apis/v2/core.kant.io/v1beta1/workspaces/{workspaceId}/edgeunits/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--name` (path, required): Name is the name of EdgeUnit.

## Events

### `dce kant-management events list-events`

- Summary: ListEvents lists events under the namespaces of a specific cluster
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/events`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents the name of deployment belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the deployment belongs to.
  - `--kind` (query, default `KIND_UNSPECIFIED`, one of: KIND_UNSPECIFIED|Deployment|StatefulSet|DaemonSet|Pod|Service|Ingress|Job|CronJob|HorizontalPodAutoscaler|ReplicaSet|CronHPA|PersistentVolumeClaim|GroupVersionResource): Kind represents what type of event is needed.
  - `--kind-name` (query): The name of involvedObject.
  - `--name` (query): Name stands for event name, used for fuzzy search.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): Size per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the event list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the event list order.
  - `--type` (query): Type is used for query, showing events of specified type.
  - `--group` (query): resource group,used when the kind type is GroupVersionResource.
  - `--version` (query): resource version,used when the kind type is GroupVersionResource.
  - `--resource` (query): resource name,used when the kind type is GroupVersionResource.
- Output: list path `items`; columns `type`, `firstTimestamp`, `lastTimestamp`, `message`, `reason`; pagination `offset`

## Image

### `dce kant-management image detect-kangaroo`

- Summary: DetectKangaroo returns whether the kangaroo is installed.
- HTTP: `GET /apis/core.kant.io/v1beta1/registries/kangaroo`
- Auth: required
- Body: none
- Flags: none

### `dce kant-management image list-artifacts`

- Summary: ListArtifacts returns a list of tags of specified image
- HTTP: `GET /apis/core.kant.io/v1beta1/registries/{registry}/repositories/{repository}/artifacts`
- Auth: required
- Body: none
- Flags:
  - `--registry` (path, required): Registry is registry name.
  - `--repository` (path, required): Repository is image name.
  - `--cluster` (query): Cluster is the current cluster.
  - `--namespace` (query): Namespace is the current namespace.
  - `--project` (query): Project is the project to request.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): Size per page.
  - `--public` (query): Public is distinguish public images and private images.
  - `--fuzzy-tag-name` (query): FuzzyTagName is used to fuzzy search by tag name.
- Output: list path `items`; columns `digest`, `imageSize`, `pushTime`; pagination `offset`

### `dce kant-management image list-projects`

- Summary: ListProjects returns a list of projects of specified registry
- HTTP: `GET /apis/core.kant.io/v1beta1/registries/{registry}/projects`
- Auth: required
- Body: none
- Flags:
  - `--registry` (path, required): Registry is registry name.
  - `--cluster` (query): Cluster is the current cluster.
  - `--namespace` (query): Namespace is the current namespace.
  - `--public` (query): Public is distinguish public projects and private projects.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): Size per page.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by project name.
- Output: list path `items`; pagination `offset`

### `dce kant-management image list-registries`

- Summary: ListRegistries returns a list of registries
- HTTP: `GET /apis/core.kant.io/v1beta1/registries`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): Cluster is the current cluster.
  - `--namespace` (query): Namespace is the current namespace.
  - `--global` (query): Global is to list all global registries.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): Size per page.
  - `--public` (query): Public is distinguish public images and private images.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by registry name.
- Output: list path `items`; columns `name`, `alias`, `host`; pagination `offset`

### `dce kant-management image list-repositories`

- Summary: ListRepositories returns a list of image names of specified project
- HTTP: `GET /apis/core.kant.io/v1beta1/registries/{registry}/repositories`
- Auth: required
- Body: none
- Flags:
  - `--registry` (path, required): Registry is registry name.
  - `--cluster` (query): Cluster is the current cluster.
  - `--namespace` (query): Namespace is the current namespace.
  - `--project` (query): Project is the project to request, "/" is a possible value.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): Size per page.
  - `--public` (query): Public is distinguish public images and private images.
  - `--show-artifacts` (query): ShowArtifacts is to list artifacts of per image, default false.
- Output: list path `items`; columns `name`; pagination `offset`

## ImagePrePullJobs

### `dce kant-management imageprepulljobs batch-delete`

- Summary: BatchDelete delete multiple ImagePrePullJob
- HTTP: `DELETE /apis/v2/batch.kant.io/v1alpha2/clusters/{cluster}/imageprepulljobs`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): For cluster resources, choose one of two with edgeunit.
- Output: list path `taskResults`; columns `id`, `errmsg`, `status`

### `dce kant-management imageprepulljobs batch-delete`

- Summary: ImagePrePullJobs_BatchDelete
- HTTP: `DELETE /apis/batch.kant.io/v1alpha1/edgeunits/{edgeunit}/imageprepulljobs`
- Auth: required
- Body: required
- Flags:
  - `--edgeunit` (path, required): For edgeunit resources, choose one of two with cluster.
- Output: list path `taskResults`; columns `id`, `errmsg`, `status`

### `dce kant-management imageprepulljobs create`

- Summary: Create a new ImagePrePullJob
- HTTP: `POST /apis/batch.kant.io/v1alpha1/edgeunits/{edgeunit}/imageprepulljobs`
- Auth: required
- Body: required
- Flags:
  - `--edgeunit` (path, required): Edgeunit is name of edgeunit

### `dce kant-management imageprepulljobs create`

- Summary: Create a new ImagePrePullJob
- HTTP: `POST /apis/v2/batch.kant.io/v1alpha2/clusters/{cluster}/imageprepulljobs`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster.

### `dce kant-management imageprepulljobs delete`

- Summary: Delete a ImagePrePullJob with edgeunit and name
- HTTP: `DELETE /apis/batch.kant.io/v1alpha1/edgeunits/{edgeunit}/imageprepulljobs/{name}`
- Auth: required
- Body: none
- Flags:
  - `--edgeunit` (path, required): Edgeunit is name of edgeunit
  - `--name` (path, required): Name is ImagePrePullJob name
  - `--workspace-id` (query, int32): Worksapce ID path variable

### `dce kant-management imageprepulljobs delete`

- Summary: Delete a ImagePrePullJob with edgeunit and name
- HTTP: `DELETE /apis/v2/batch.kant.io/v1alpha2/clusters/{cluster}/imageprepulljobs/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster.
  - `--name` (path, required): Name is the name of resource.
  - `--workspace-id` (query, int32): WorkspaceId is the id of workspace.

### `dce kant-management imageprepulljobs get`

- Summary: Get a ImagePrePullJob with edgeunit and name
- HTTP: `GET /apis/batch.kant.io/v1alpha1/edgeunits/{edgeunit}/imageprepulljobs/{name}`
- Auth: required
- Body: none
- Flags:
  - `--edgeunit` (path, required): Edgeunit is name of edgeunit
  - `--name` (path, required): Name is ImagePrePullJob name
  - `--workspace-id` (query, int32): Worksapce ID path variable

### `dce kant-management imageprepulljobs get`

- Summary: Get a ImagePrePullJob with edgeunit and name
- HTTP: `GET /apis/v2/batch.kant.io/v1alpha2/clusters/{cluster}/imageprepulljobs/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster.
  - `--name` (path, required): Name is the name of resource.
  - `--workspace-id` (query, int32): WorkspaceId is the id of workspace.

### `dce kant-management imageprepulljobs list`

- Summary: Page the collection of ImagePrePullJob with condition
- HTTP: `GET /apis/v2/batch.kant.io/v1alpha2/clusters/{cluster}/imageprepulljobs`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster.
  - `--page` (query, int32): represents the page number. If the value is -1, returns all.
  - `--page-size` (query, int32): represents the page size.
  - `--search` (query): Search is list fuzzy search criteria.
  - `--workspace-id` (query, int32): Worksapce ID path variable.
- Output: list path `items`; columns `name`, `status.phase`, `createTimestamp`; pagination `offset`

### `dce kant-management imageprepulljobs list`

- Summary: Page the collection of ImagePrePullJob with condition
- HTTP: `GET /apis/batch.kant.io/v1alpha1/edgeunits/{edgeunit}/imageprepulljobs`
- Auth: required
- Body: none
- Flags:
  - `--edgeunit` (path, required): Edgeunit is name of edgeunit
  - `--page` (query, int32): represents the page number. If the value is -1, returns all
  - `--page-size` (query, int32): represents the page size
  - `--search` (query): Search is list fuzzy search criteria
  - `--workspace-id` (query, int32): Worksapce ID path variable
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `kind`, `apiVersion`; pagination `offset`

## ImagePrePullJobsWithWorkspace

### `dce kant-management imageprepulljobswithworkspace batch-delete`

- Summary: BatchDelete delete multiple ImagePrePullJob
- HTTP: `DELETE /apis/v2/batch.kant.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/imageprepulljobs`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (path, required): For cluster resources, choose one of two with edgeunit.
- Output: list path `taskResults`; columns `id`, `errmsg`, `status`

### `dce kant-management imageprepulljobswithworkspace create`

- Summary: Create a new ImagePrePullJob
- HTTP: `POST /apis/v2/batch.kant.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/imageprepulljobs`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): WorkspaceId is the id of workspace.
  - `--cluster` (path, required): Cluster is the name of the cluster.

### `dce kant-management imageprepulljobswithworkspace delete`

- Summary: Delete a ImagePrePullJob with edgeunit and name
- HTTP: `DELETE /apis/v2/batch.kant.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/imageprepulljobs/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): WorkspaceId is the id of workspace.
  - `--cluster` (path, required): Cluster is the name of the cluster.
  - `--name` (path, required): Name is the name of resource.

### `dce kant-management imageprepulljobswithworkspace get`

- Summary: Get a ImagePrePullJob with edgeunit and name
- HTTP: `GET /apis/v2/batch.kant.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/imageprepulljobs/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): WorkspaceId is the id of workspace.
  - `--cluster` (path, required): Cluster is the name of the cluster.
  - `--name` (path, required): Name is the name of resource.

### `dce kant-management imageprepulljobswithworkspace list`

- Summary: Page the collection of ImagePrePullJob with condition
- HTTP: `GET /apis/v2/batch.kant.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/imageprepulljobs`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): Worksapce ID path variable.
  - `--cluster` (path, required): Cluster is the name of the cluster.
  - `--page` (query, int32): represents the page number. If the value is -1, returns all.
  - `--page-size` (query, int32): represents the page size.
  - `--search` (query): Search is list fuzzy search criteria.
- Output: list path `items`; columns `name`, `status.phase`, `createTimestamp`; pagination `offset`

## Images

### `dce kant-management images detect-kangaroo`

- Summary: DetectKangaroo returns whether the kangaroo is installed.
- HTTP: `GET /apis/v2/core.kant.io/v1alpha1/registries/kangaroo`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (query, int32): workspaceId ID of workspace

### `dce kant-management images list-artifacts`

- Summary: ListArtifacts returns a list of tags of specified image
- HTTP: `GET /apis/v2/core.kant.io/v1alpha1/registries/{registry}/repositories/{repository}/artifacts`
- Auth: required
- Body: none
- Flags:
  - `--registry` (path, required): Registry is registry name.
  - `--repository` (path, required): Repository is image name.
  - `--cluster` (query): Cluster is the current cluster.
  - `--namespace` (query): Namespace is the current namespace.
  - `--project` (query): Project is the project to request.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): Size per page.
  - `--public` (query): Public is distinguish public images and private images.
  - `--fuzzy-tag-name` (query): FuzzyTagName is used to fuzzy search by tag name.
  - `--workspace-id` (query, int32): workspaceId ID of workspace
- Output: list path `items`; columns `digest`, `imageSize`, `pushTime`; pagination `offset`

### `dce kant-management images list-projects`

- Summary: ListProjects returns a list of projects of specified registry
- HTTP: `GET /apis/v2/core.kant.io/v1alpha1/registries/{registry}/projects`
- Auth: required
- Body: none
- Flags:
  - `--registry` (path, required): Registry is registry name.
  - `--cluster` (query): Cluster is the current cluster.
  - `--namespace` (query): Namespace is the current namespace.
  - `--public` (query): Public is distinguish public projects and private projects.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): Size per page.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by project name.
  - `--workspace-id` (query, int32): workspaceId ID of workspace
- Output: list path `items`; pagination `offset`

### `dce kant-management images list-registries`

- Summary: ListRegistries returns a list of registries
- HTTP: `GET /apis/v2/core.kant.io/v1alpha1/registries`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): Cluster is the current cluster.
  - `--namespace` (query): Namespace is the current namespace.
  - `--global` (query): Global is to list all global registries.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): Size per page.
  - `--public` (query): Public is distinguish public images and private images.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by registry name.
  - `--workspace-id` (query, int32): workspaceId ID of workspace
- Output: list path `items`; columns `name`, `alias`, `host`; pagination `offset`

### `dce kant-management images list-repositories`

- Summary: ListRepositories returns a list of image names of specified project
- HTTP: `GET /apis/v2/core.kant.io/v1alpha1/registries/{registry}/repositories`
- Auth: required
- Body: none
- Flags:
  - `--registry` (path, required): Registry is registry name.
  - `--cluster` (query): Cluster is the current cluster.
  - `--namespace` (query): Namespace is the current namespace.
  - `--project` (query): Project is the project to request, "/" is a possible value.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): Size per page.
  - `--public` (query): Public is distinguish public images and private images.
  - `--show-artifacts` (query): ShowArtifacts is to list artifacts of per image, default false.
  - `--workspace-id` (query, int32): workspaceId ID of workspace
- Output: list path `items`; columns `name`; pagination `offset`

## ImagesWithWorkspace

### `dce kant-management imageswithworkspace detect-kangaroo`

- Summary: DetectKangaroo returns whether the kangaroo is installed.
- HTTP: `GET /apis/v2/core.kant.io/v1alpha1/workspaces/{workspaceId}/registries/kangaroo`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace

### `dce kant-management imageswithworkspace list-artifacts`

- Summary: ListArtifacts returns a list of tags of specified image
- HTTP: `GET /apis/v2/core.kant.io/v1alpha1/workspaces/{workspaceId}/registries/{registry}/repositories/{repository}/artifacts`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--registry` (path, required): Registry is registry name.
  - `--repository` (path, required): Repository is image name.
  - `--cluster` (query): Cluster is the current cluster.
  - `--namespace` (query): Namespace is the current namespace.
  - `--project` (query): Project is the project to request.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): Size per page.
  - `--public` (query): Public is distinguish public images and private images.
  - `--fuzzy-tag-name` (query): FuzzyTagName is used to fuzzy search by tag name.
- Output: list path `items`; columns `digest`, `imageSize`, `pushTime`; pagination `offset`

### `dce kant-management imageswithworkspace list-projects`

- Summary: ListProjects returns a list of projects of specified registry
- HTTP: `GET /apis/v2/core.kant.io/v1alpha1/workspaces/{workspaceId}/registries/{registry}/projects`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--registry` (path, required): Registry is registry name.
  - `--cluster` (query): Cluster is the current cluster.
  - `--namespace` (query): Namespace is the current namespace.
  - `--public` (query): Public is distinguish public projects and private projects.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): Size per page.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by project name.
- Output: list path `items`; pagination `offset`

### `dce kant-management imageswithworkspace list-registries`

- Summary: ListRegistries returns a list of registries
- HTTP: `GET /apis/v2/core.kant.io/v1alpha1/workspaces/{workspaceId}/registries`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (query): Cluster is the current cluster.
  - `--namespace` (query): Namespace is the current namespace.
  - `--global` (query): Global is to list all global registries.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): Size per page.
  - `--public` (query): Public is distinguish public images and private images.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by registry name.
- Output: list path `items`; columns `name`, `alias`, `host`; pagination `offset`

### `dce kant-management imageswithworkspace list-repositories`

- Summary: ListRepositories returns a list of image names of specified project
- HTTP: `GET /apis/v2/core.kant.io/v1alpha1/workspaces/{workspaceId}/registries/{registry}/repositories`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--registry` (path, required): Registry is registry name.
  - `--cluster` (query): Cluster is the current cluster.
  - `--namespace` (query): Namespace is the current namespace.
  - `--project` (query): Project is the project to request, "/" is a possible value.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): Size per page.
  - `--public` (query): Public is distinguish public images and private images.
  - `--show-artifacts` (query): ShowArtifacts is to list artifacts of per image, default false.
- Output: list path `items`; columns `name`; pagination `offset`

## InternalResource

### `dce kant-management internalresource create-workload-by-json`

- Summary: CreateWorkloadByJSON creates workload by JSON under the namespaces of a
- HTTP: `POST /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/{kind}/json`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the Workload belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the Workload belongs to.
  - `--kind` (path, required, one of: deployments|statefulsets|daemonsets|jobs|cronjobs|pods|replicasets|secrets|configmaps): WorkloadKind the workload of kind

### `dce kant-management internalresource get-workload-json`

- Summary: GetWorkloadJSON gets workload by JSON under the namespaces of a specific
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/{kind}/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the Workload belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the Workload belongs to.
  - `--kind` (path, required, one of: deployments|statefulsets|daemonsets|jobs|cronjobs|pods|replicasets|secrets|configmaps): WorkloadKind the workload of kind
  - `--name` (path, required): Name represents the name of Workload
  - `--stable` (query): If stable is true, the v1 version under the corresponding package will be returned.

### `dce kant-management internalresource update-workload-by-json`

- Summary: UpdateWorkloadByJSON updates workload by JSON under the namespaces of a
- HTTP: `PUT /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/{kind}/{name}/json`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the Workload belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the Workload belongs to.
  - `--kind` (path, required, one of: deployments|statefulsets|daemonsets|jobs|cronjobs|pods|replicasets|secrets|configmaps): WorkloadKind the workload of kind
  - `--name` (path, required): Name represents the name of Workload

## Metrics

### `dce kant-management metrics query-public-range-usages`

- Summary: Query public metrics of a resource
- HTTP: `POST /apis/core.kant.io/v1alpha1/clusters/{cluster}/publicmetricrange`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Name of the cluster where the workload is located
- Output: list path `data`; columns `errorMessage`, `status`

## NodeGroups

### `dce kant-management nodegroups batch-delete-node-groups`

- Summary: Batch delete nodegroups
- HTTP: `DELETE /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/nodegroups`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): For cluster resources, choose one of two with edgeunit.
- Output: list path `taskResults`; columns `id`, `errmsg`, `status`

### `dce kant-management nodegroups batch-delete-node-groups`

- Summary: Batch delete nodegroups
- HTTP: `DELETE /apis/v2/batch.kant.io/v1alpha1/clusters/{cluster}/namespaces/nodegroups`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): For cluster resources, choose one of two with edgeunit.
- Output: list path `taskResults`; columns `id`, `errmsg`, `status`

### `dce kant-management nodegroups create-node-group`

- Summary: CreateNodeGroup creates a nodegroup by given nodegroup data
- HTTP: `POST /apis/v2/batch.kant.io/v1alpha1/clusters/{cluster}/nodegroups`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster.

### `dce kant-management nodegroups create-node-group`

- Summary: CreateNodeGroup creates a nodegroup by given nodegroup data
- HTTP: `POST /apis/core.kant.io/v1alpha1/clusters/{cluster}/nodegroups`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents the name of the cluster.

### `dce kant-management nodegroups delete-node-group`

- Summary: DeleteNodeGroup deletes a nodegroup by given nodegroup name
- HTTP: `DELETE /apis/core.kant.io/v1alpha1/clusters/{cluster}/nodegroups/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the NodeGroup belongs to.
  - `--name` (path, required): Name represents the name of NodeGroup

### `dce kant-management nodegroups delete-node-group`

- Summary: DeleteNodeGroup deletes a nodegroup by given nodegroup name
- HTTP: `DELETE /apis/v2/batch.kant.io/v1alpha1/clusters/{cluster}/nodegroups/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster.
  - `--name` (path, required): Name is the name of resource.
  - `--workspace-id` (query, int32): WorkspaceId is the id of workspace.

### `dce kant-management nodegroups filter-nodes-by-node-group`

- Summary: FilterNodesByNodeGroup filter nodes by nodegroup
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/nodegroupnodes`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the node belongs to.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): Size per page requested.
  - `--phase` (query): Phase represents the current phase of node.
  - `--node-ip` (query): nodeIp represents node's ip address
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the job list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the job list order.
  - `--name` (query): Name is to filter nodes by node name
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--role` (query, default `NODE_ROLE_UNSPECIFIED`, one of: NODE_ROLE_UNSPECIFIED|CONTROL_PLANE|WORKER): Role is used for filter by node role.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--exclude-metrics` (query): exclude_metrics
  - `--node-group-name` (query): name represents the name of the NodeGroup.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`; pagination `offset`

### `dce kant-management nodegroups filter-nodes-by-node-group`

- Summary: FilterNodesByNodeGroup filter nodes by nodegroup
- HTTP: `GET /apis/v2/batch.kant.io/v1alpha1/clusters/{cluster}/nodegroupnodes`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the node belongs to.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): Size per page requested.
  - `--phase` (query): Phase represents the current phase of node.
  - `--node-ip` (query): nodeIp represents node's ip address
  - `--name` (query): Name is to filter nodes by node name
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--role` (query, default `NODE_ROLE_UNSPECIFIED`, one of: NODE_ROLE_UNSPECIFIED|CONTROL_PLANE|WORKER): Role is used for filter by node role.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--exclude-metrics` (query): exclude_metrics
  - `--node-group-name` (query): name represents the name of the NodeGroup.
  - `--workspace-id` (query, int32): workspaceId ID of workspace
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`; pagination `offset`

### `dce kant-management nodegroups get-node-group`

- Summary: GetNodeGroup gets a nodegroup by given nodegroup name
- HTTP: `GET /apis/v2/batch.kant.io/v1alpha1/clusters/{cluster}/nodegroups/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster.
  - `--name` (path, required): Name is the name of resource.
  - `--workspace-id` (query, int32): WorkspaceId is the id of workspace.

### `dce kant-management nodegroups get-node-group`

- Summary: GetNodeGroup gets a nodegroup by given nodegroup name
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/nodegroups/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the NodeGroup belongs to.
  - `--name` (path, required): Name represents the name of NodeGroup

### `dce kant-management nodegroups list-node-groups`

- Summary: ListNodeGroups lists nodegroups from the system
- HTTP: `GET /apis/v2/batch.kant.io/v1alpha1/clusters/{cluster}/nodegroups`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--name` (query): name
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--workspace-id` (query, int32): workspaceId ID of workspace
- Output: list path `items`; columns `name`, `createTimestamp`; pagination `offset`

### `dce kant-management nodegroups list-node-groups`

- Summary: ListNodeGroups lists nodegroups from the system
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/nodegroups`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--name` (query): name
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `kind`, `apiVersion`; pagination `offset`

### `dce kant-management nodegroups update-node-group`

- Summary: UpdateNodeGroup updates a nodegroup by given nodegroup name
- HTTP: `PUT /apis/v2/batch.kant.io/v1alpha1/clusters/{cluster}/nodegroups/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster.
  - `--name` (path, required): Name is the name of NodeGroup.

### `dce kant-management nodegroups update-node-group`

- Summary: UpdateNodeGroup updates a nodegroup by given nodegroup name
- HTTP: `PUT /apis/core.kant.io/v1alpha1/clusters/{cluster}/nodegroups/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents the name of the cluster.
  - `--name` (path, required): name represents the name of the NodeGroup.

## NodeGroupsWithWorkspace

### `dce kant-management nodegroupswithworkspace batch-delete-node-groups`

- Summary: Batch delete nodegroups
- HTTP: `DELETE /apis/v2/batch.kant.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/nodegroups`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (path, required): For cluster resources, choose one of two with edgeunit.
- Output: list path `taskResults`; columns `id`, `errmsg`, `status`

### `dce kant-management nodegroupswithworkspace create-node-group`

- Summary: CreateNodeGroup creates a nodegroup by given nodegroup data
- HTTP: `POST /apis/v2/batch.kant.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/nodegroups`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): WorkspaceId is the id of workspace.
  - `--cluster` (path, required): Cluster is the name of the cluster.

### `dce kant-management nodegroupswithworkspace delete-node-group`

- Summary: DeleteNodeGroup deletes a nodegroup by given nodegroup name
- HTTP: `DELETE /apis/v2/batch.kant.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/nodegroups/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): WorkspaceId is the id of workspace.
  - `--cluster` (path, required): Cluster is the name of the cluster.
  - `--name` (path, required): Name is the name of resource.

### `dce kant-management nodegroupswithworkspace filter-nodes-by-node-group`

- Summary: FilterNodesByNodeGroup filter nodes by nodegroup
- HTTP: `GET /apis/v2/batch.kant.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/nodegroupnodes`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (path, required): Cluster represents which cluster the node belongs to.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): Size per page requested.
  - `--phase` (query): Phase represents the current phase of node.
  - `--node-ip` (query): nodeIp represents node's ip address
  - `--name` (query): Name is to filter nodes by node name
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--role` (query, default `NODE_ROLE_UNSPECIFIED`, one of: NODE_ROLE_UNSPECIFIED|CONTROL_PLANE|WORKER): Role is used for filter by node role.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--exclude-metrics` (query): exclude_metrics
  - `--node-group-name` (query): name represents the name of the NodeGroup.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`; pagination `offset`

### `dce kant-management nodegroupswithworkspace get-node-group`

- Summary: GetNodeGroup gets a nodegroup by given nodegroup name
- HTTP: `GET /apis/v2/batch.kant.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/nodegroups/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): WorkspaceId is the id of workspace.
  - `--cluster` (path, required): Cluster is the name of the cluster.
  - `--name` (path, required): Name is the name of resource.

### `dce kant-management nodegroupswithworkspace list-node-groups`

- Summary: ListNodeGroups lists nodegroups from the system
- HTTP: `GET /apis/v2/batch.kant.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/nodegroups`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (path, required): cluster
  - `--name` (query): name
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `name`, `createTimestamp`; pagination `offset`

### `dce kant-management nodegroupswithworkspace update-node-group`

- Summary: UpdateNodeGroup updates a nodegroup by given nodegroup name
- HTTP: `PUT /apis/v2/batch.kant.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/nodegroups/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): WorkspaceId is the id of workspace.
  - `--cluster` (path, required): Cluster is the name of the cluster.
  - `--name` (path, required): Name is the name of NodeGroup.

## NodeUpgradeJobs

### `dce kant-management nodeupgradejobs batch-delete`

- Summary: BatchDelete delete multiple NodeUpgradeJob
- HTTP: `DELETE /apis/v2/batch.kant.io/v1alpha2/clusters/{cluster}/nodeupgradejobs`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): For cluster resources, choose one of two with edgeunit.
- Output: list path `taskResults`; columns `id`, `errmsg`, `status`

### `dce kant-management nodeupgradejobs create`

- Summary: Create a new NodeUpgradeJob
- HTTP: `POST /apis/batch.kant.io/v1alpha1/edgeunits/{edgeunit}/nodeupgradejobs`
- Auth: required
- Body: required
- Flags:
  - `--edgeunit` (path, required): Edgeunit is name of edgeunit

### `dce kant-management nodeupgradejobs create`

- Summary: Create a new NodeUpgradeJob
- HTTP: `POST /apis/v2/batch.kant.io/v1alpha2/clusters/{cluster}/nodeupgradejobs`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster.

### `dce kant-management nodeupgradejobs delete`

- Summary: Delete a NodeUpgradeJob with edgeunit and name
- HTTP: `DELETE /apis/batch.kant.io/v1alpha1/edgeunits/{edgeunit}/nodeupgradejobs/{name}`
- Auth: required
- Body: none
- Flags:
  - `--edgeunit` (path, required): Edgeunit is name of edgeunit
  - `--name` (path, required): Name is NodeUpgradeJob name

### `dce kant-management nodeupgradejobs delete`

- Summary: Delete a NodeUpgradeJob with edgeunit and name
- HTTP: `DELETE /apis/v2/batch.kant.io/v1alpha2/clusters/{cluster}/nodeupgradejobs/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster.
  - `--name` (path, required): Name is the name of resource.
  - `--workspace-id` (query, int32): WorkspaceId is the id of workspace.

### `dce kant-management nodeupgradejobs get`

- Summary: Get a NodeUpgradeJob with edgeunit and name
- HTTP: `GET /apis/v2/batch.kant.io/v1alpha2/clusters/{cluster}/nodeupgradejobs/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster.
  - `--name` (path, required): Name is the name of resource.
  - `--workspace-id` (query, int32): WorkspaceId is the id of workspace.

### `dce kant-management nodeupgradejobs get`

- Summary: Get a NodeUpgradeJob with edgeunit and name
- HTTP: `GET /apis/batch.kant.io/v1alpha1/edgeunits/{edgeunit}/nodeupgradejobs/{name}`
- Auth: required
- Body: none
- Flags:
  - `--edgeunit` (path, required): Edgeunit is name of edgeunit
  - `--name` (path, required): Name is NodeUpgradeJob name

### `dce kant-management nodeupgradejobs list`

- Summary: Page the collection of NodeUpgradeJob with condition
- HTTP: `GET /apis/batch.kant.io/v1alpha1/edgeunits/{edgeunit}/nodeupgradejobs`
- Auth: required
- Body: none
- Flags:
  - `--edgeunit` (path, required): Edgeunit is name of edgeunit
  - `--page` (query, int32): represents the page number. If the value is -1, returns all
  - `--page-size` (query, int32): represents the page size
  - `--search` (query): Search is list fuzzy search criteria
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `kind`, `spec.version`, `apiVersion`; pagination `offset`

### `dce kant-management nodeupgradejobs list`

- Summary: Page the collection of NodeUpgradeJob with condition
- HTTP: `GET /apis/v2/batch.kant.io/v1alpha2/clusters/{cluster}/nodeupgradejobs`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster.
  - `--page` (query, int32): represents the page number. If the value is -1, returns all.
  - `--page-size` (query, int32): represents the page size.
  - `--search` (query): Search is list fuzzy search criteria.
  - `--workspace-id` (query, int32): Worksapce ID path variable.
- Output: list path `items`; columns `name`, `status.phase`, `spec.version`, `createTimestamp`; pagination `offset`

## NodeUpgradeJobsWithWorkspace

### `dce kant-management nodeupgradejobswithworkspace batch-delete`

- Summary: BatchDelete delete multiple NodeUpgradeJob
- HTTP: `DELETE /apis/v2/batch.kant.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/nodeupgradejobs`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId ID of workspace
  - `--cluster` (path, required): For cluster resources, choose one of two with edgeunit.
- Output: list path `taskResults`; columns `id`, `errmsg`, `status`

### `dce kant-management nodeupgradejobswithworkspace create`

- Summary: Create a new NodeUpgradeJob
- HTTP: `POST /apis/v2/batch.kant.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/nodeupgradejobs`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): WorkspaceId is the id of workspace.
  - `--cluster` (path, required): Cluster is the name of the cluster.

### `dce kant-management nodeupgradejobswithworkspace delete`

- Summary: Delete a NodeUpgradeJob with edgeunit and name
- HTTP: `DELETE /apis/v2/batch.kant.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/nodeupgradejobs/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): WorkspaceId is the id of workspace.
  - `--cluster` (path, required): Cluster is the name of the cluster.
  - `--name` (path, required): Name is the name of resource.

### `dce kant-management nodeupgradejobswithworkspace get`

- Summary: Get a NodeUpgradeJob with edgeunit and name
- HTTP: `GET /apis/v2/batch.kant.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/nodeupgradejobs/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): WorkspaceId is the id of workspace.
  - `--cluster` (path, required): Cluster is the name of the cluster.
  - `--name` (path, required): Name is the name of resource.

### `dce kant-management nodeupgradejobswithworkspace list`

- Summary: Page the collection of NodeUpgradeJob with condition
- HTTP: `GET /apis/v2/batch.kant.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/nodeupgradejobs`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): Worksapce ID path variable.
  - `--cluster` (path, required): Cluster is the name of the cluster.
  - `--page` (query, int32): represents the page number. If the value is -1, returns all.
  - `--page-size` (query, int32): represents the page size.
  - `--search` (query): Search is list fuzzy search criteria.
- Output: list path `items`; columns `name`, `status.phase`, `spec.version`, `createTimestamp`; pagination `offset`

## Nodes

### `dce kant-management nodes cordon-node`

- Summary: CordonNode cordon a edge node.
- HTTP: `PATCH /apis/core.kant.io/v1alpha1/clusters/{cluster}/nodes/{name}/cordon`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--name` (path, required): name

### `dce kant-management nodes delete-node`

- Summary: DeleteNode delete a edge node.
- HTTP: `DELETE /apis/core.kant.io/v1alpha1/clusters/{cluster}/nodes/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--name` (path, required): name

### `dce kant-management nodes get-first-control-plane-node-ip`

- Summary: GetFirstControlPlaneNodeIP returns a IP address of the first got control-plane node
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/nodes/first-controlplane/address`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster

### `dce kant-management nodes get-node`

- Summary: GetNode returns a edge node.
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/nodes/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the node belongs to.
  - `--name` (path, required): Node name.
  - `--show-pods` (query): ShowPods is to control whether returned data contains
  - `--exclude-metrics` (query): exclude_metrics

### `dce kant-management nodes get-node-json`

- Summary: GetNodeJSON gets a node's json from the system by given node name
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/nodes/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified node belongs to.
  - `--name` (path, required): Name represents for the node name.

### `dce kant-management nodes list-node`

- Summary: ListNode returns all edge nodes in the cluster.
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/nodes`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the node belongs to.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): Size per page requested.
  - `--phase` (query): Phase represents the current phase of node.
  - `--node-ip` (query): nodeIp represents node's ip address
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the job list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the job list order.
  - `--name` (query): Name is to filter nodes by node name
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--role` (query, default `NODE_ROLE_UNSPECIFIED`, one of: NODE_ROLE_UNSPECIFIED|CONTROL_PLANE|WORKER): Role is used for filter by node role.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--exclude-metrics` (query): exclude_metrics
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`; pagination `offset`

### `dce kant-management nodes un-cordon-node`

- Summary: UnCordonNode uncordon a edge node.
- HTTP: `PATCH /apis/core.kant.io/v1alpha1/clusters/{cluster}/nodes/{name}/uncordon`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--name` (path, required): name

### `dce kant-management nodes update-node`

- Summary: updateNode update a edge node.
- HTTP: `PUT /apis/core.kant.io/v1alpha1/clusters/{cluster}/nodes/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified node belongs to.
  - `--name` (path, required): The name represents for the node name.

## Pods

### `dce kant-management pods delete-pod`

- Summary: DeletePod deletes a pod under the namespaces of a specific cluster
- HTTP: `DELETE /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/pods/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the pod belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced pod.
  - `--name` (path, required): Pod name.

### `dce kant-management pods get-pod`

- Summary: GetPods will get a pod under the namespaces of a specific cluster by pods
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/pods/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the pod belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced pod.
  - `--name` (path, required): Pod name.

### `dce kant-management pods list-pods`

- Summary: ListPods will list all pod by given cluster and namespace
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/pods`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the pod belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced pod.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): Size per page requested.
  - `--kind` (query, default `KIND_UNSPECIFIED`, one of: KIND_UNSPECIFIED|Deployment|StatefulSet|DaemonSet|Service|Job|CronJob|ReplicaSet|NetworkPolicy): The kind of pod.
  - `--kind-name` (query): Name of kind.
  - `--name` (query): Name stands for pod name, used for fuzzy search.
  - `--phase` (query, default `PHASE_UNSPECIFIED`, one of: PHASE_UNSPECIFIED|Unknown|Pending|Running|Succeeded|Failed): Phases is used for filter.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--status` (query, default `FILTER_POD_STATUS_UNSPECIFIED`, one of: FILTER_POD_STATUS_UNSPECIFIED|FILTER_POD_STATUS_RUNNING|FILTER_POD_STATUS_ERROR|FILTER_POD_STATUS_COMPLETED|FILTER_POD_STATUS_WAITING): status is filter with pod status ,the status is composite state
  - `--gpu-type` (query): gpu_type is filter with pods resources, when value is * search all
  - `--pod-ip` (query): pod_ip is used for filter.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `status.phase`, `metadata.creationTimestamp`; pagination `offset`

## RuleEndpoints

### `dce kant-management ruleendpoints batch-delete-msg-rule-endpoints`

- Summary: RuleEndpoints_BatchDeleteMsgRuleEndpoints
- HTTP: `DELETE /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/ruleendpoints`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): For cluster resources, choose one of two with edgeunit.
- Output: list path `taskResults`; columns `id`, `errmsg`, `status`

### `dce kant-management ruleendpoints create-msg-rule-endpoints`

- Summary: RuleEndpoints_CreateMsgRuleEndpoints
- HTTP: `POST /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/ruleendpoints`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents the name of the cluster.
  - `--namespace` (path, required): Namespace represents which namespace the ruleEndpoint belongs to.

### `dce kant-management ruleendpoints delete-msg-rule-endpoints`

- Summary: RuleEndpoints_DeleteMsgRuleEndpoints
- HTTP: `DELETE /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/ruleendpoints/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the ruleEndpoint belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the ruleEndpoint belongs to.
  - `--name` (path, required): Name represents the name of ruleEndpoint

### `dce kant-management ruleendpoints list-all-msg-rule-endpoints`

- Summary: RuleEndpoints_ListAllMsgRuleEndpoints
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/ruleendpoints`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (query): namespace
  - `--name` (query): name
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `kind`, `apiVersion`; pagination `offset`

### `dce kant-management ruleendpoints list-msg-rule-endpoints`

- Summary: RuleEndpoints_ListMsgRuleEndpoints
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/ruleendpoints`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (query): name
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `kind`, `apiVersion`; pagination `offset`

## Rules

### `dce kant-management rules batch-delete-msg-rules`

- Summary: Rules_BatchDeleteMsgRules
- HTTP: `DELETE /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/rules`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): For cluster resources, choose one of two with edgeunit.
- Output: list path `taskResults`; columns `id`, `errmsg`, `status`

### `dce kant-management rules create-msg-rules`

- Summary: Rules_CreateMsgRules
- HTTP: `POST /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/rules`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents the name of the cluster.
  - `--namespace` (path, required): Namespace represents which namespace the Rule belongs to.

### `dce kant-management rules delete-msg-rules`

- Summary: Rules_DeleteMsgRules
- HTTP: `DELETE /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/rules/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the Rule belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the Rule belongs to.
  - `--name` (path, required): Name represents the name of Rule

### `dce kant-management rules get-msg-rules`

- Summary: Rules_GetMsgRules
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/rules/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the Rule belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the Rule belongs to.
  - `--name` (path, required): Name represents the name of Rule

### `dce kant-management rules list-all-msg-rules`

- Summary: Rules_ListAllMsgRules
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/rules`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (query): namespace
  - `--name` (query): name
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `kind`, `apiVersion`; pagination `offset`

### `dce kant-management rules list-msg-rules`

- Summary: Rules_ListMsgRules
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/rules`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (query): name
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `kind`, `apiVersion`; pagination `offset`

## Secrets

### `dce kant-management secrets create-secret`

- Summary: CreateSecret creates a secret under the namespaces of a specific cluster
- HTTP: `POST /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/secrets`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the secret belongs to.
  - `--namespace` (path, required): When the current namespace is named, the priority is higher than that in yaml

### `dce kant-management secrets delete-secret`

- Summary: DeleteSecret deletes a secret under the namespaces of a specific cluster
- HTTP: `DELETE /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/secrets/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the secret belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced secret.
  - `--name` (path, required): Secret name.

### `dce kant-management secrets get-secret`

- Summary: GetClusterSecret gets a secret under the namespaces of a specific cluster
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/secrets/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the secret belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced secret.
  - `--name` (path, required): Secret name.

### `dce kant-management secrets list-cluster-secrets`

- Summary: ListClusterSecrets lists a secret in a specific cluster
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/secrets`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the secret belongs to.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): Size per page requested.
  - `--name` (query): The name use to search specific secret
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--type` (query): Type is used to filter secrets by type.
  - `--only-metadata` (query): OnlyMetadata lists only metadata of secrets, default false.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `type`, `metadata.creationTimestamp`, `immutable`; pagination `offset`

### `dce kant-management secrets list-secrets`

- Summary: ListSecrets lists a secret under the namespaces of a specific cluster
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/secrets`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the secret belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced secret.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): Size per page requested.
  - `--name` (query): The name use to search specific secret
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--type` (query): Type is used to filter secrets by type.
  - `--only-metadata` (query): OnlyMetadata lists only metadata of secrets, default false.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `type`, `metadata.creationTimestamp`, `immutable`; pagination `offset`

### `dce kant-management secrets update-secret`

- Summary: UpdateSecret updates secret under the namespaces of a specific cluster
- HTTP: `PUT /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/secrets/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the secret belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced secret.
  - `--name` (path, required): Secret name.

## Services

### `dce kant-management services create-service`

- Summary: CreateService creates a service to the system by given service data
- HTTP: `POST /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/services`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified service belongs to.
  - `--namespace` (path, required): When the current namespace is named, the priority is higher than that in

### `dce kant-management services delete-service`

- Summary: DeleteService deletes a service from the system by given service name
- HTTP: `DELETE /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/services/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the service belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced service.
  - `--name` (path, required): Name represents for the service name

### `dce kant-management services get-service`

- Summary: GetService gets a service from the system by given service name
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/services/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified service belongs to.
  - `--namespace` (path, required): Namespace the specified service belongs to.
  - `--name` (path, required): Name represents for the service name.

### `dce kant-management services get-service-json`

- Summary: GetServiceJSON gets a service json from the system by given service name
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/services/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified service belongs to.
  - `--namespace` (path, required): Namespace the specified service belongs to.
  - `--name` (path, required): Name represents for the service name.

### `dce kant-management services list-cluster-services`

- Summary: ListClusterServices lists all services in the specified cluster, regardless
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/services`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified service belongs to.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): Size per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the service list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the service list order.
  - `--name` (query): Name is used for query.
  - `--type` (query): Type is a array used for frontend filter.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--ports` (query): Ports is used to filter by port.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`; pagination `offset`

### `dce kant-management services list-services`

- Summary: ListServices lists services in the specified cluster and namespace
- HTTP: `GET /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/services`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified service belongs to.
  - `--namespace` (path, required): Namespace the specified service belongs to.
  - `--kind` (query, default `KIND_UNSPECIFIED`, one of: KIND_UNSPECIFIED|Deployment|StatefulSet|DaemonSet): The kind of service.
  - `--kind-name` (query): Name of kind.
  - `--name` (query): Name stands for service name, used for fuzzy search.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): Size per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the service list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the service list order.
  - `--type` (query): Type is a array used for frontend filter.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--ports` (query): Ports is used to filter by port.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`; pagination `offset`

### `dce kant-management services patch-service`

- Summary: PatchService patches a service from the system by given service name
- HTTP: `PATCH /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/services/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified service belongs to.
  - `--namespace` (path, required): Namespace the specified service belongs to.
  - `--name` (path, required): The name represents for the resource name.

### `dce kant-management services update-service`

- Summary: UpdateService updates a service from the system by given service name
- HTTP: `PUT /apis/core.kant.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/services/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified service belongs to.
  - `--namespace` (path, required): Namespace the specified service belongs to.
  - `--name` (path, required): Name represents for the service name

## SingleJoinConfigs

### `dce kant-management singlejoinconfigs create`

- Summary: Create SingleJoinConfigs.
- HTTP: `POST /apis/batch.kant.io/v1alpha1/edgeunits/{edgeunit}/join-config`
- Auth: required
- Body: required
- Flags:
  - `--edgeunit` (path, required): Edgeunit represents the name of the edgeunit.

### `dce kant-management singlejoinconfigs delete`

- Summary: Delete SingleJoinConfigs.
- HTTP: `DELETE /apis/batch.kant.io/v1alpha1/edgeunits/{edgeunit}/join-config/{name}`
- Auth: required
- Body: none
- Flags:
  - `--edgeunit` (path, required): Edgeunit represents the name of the edgeunit.
  - `--name` (path, required): Name represents the name of SingleJoinConfig.
  - `--node-name` (query): nodeName

### `dce kant-management singlejoinconfigs get`

- Summary: Get SingleJoinConfigs by name.
- HTTP: `GET /apis/batch.kant.io/v1alpha1/edgeunits/{edgeunit}/join-config/{name}`
- Auth: required
- Body: none
- Flags:
  - `--edgeunit` (path, required): Edgeunit represents the name of the edgeunit.
  - `--name` (path, required): Name represents the name of SingleJoinConfig.
  - `--node-name` (query): nodeName

### `dce kant-management singlejoinconfigs join-help`

- Summary: Join Help
- HTTP: `GET /apis/batch.kant.io/v1alpha1/edgeunits/{edgeunit}/join-config/{name}/guid`
- Auth: required
- Body: none
- Flags:
  - `--edgeunit` (path, required): Edgeunit represents the name of the edgeunit.
  - `--name` (path, required): Name represents the name of SingleJoinConfig.
  - `--node-name` (query): nodeName

### `dce kant-management singlejoinconfigs list`

- Summary: List SingleJoinConfigs.
- HTTP: `GET /apis/batch.kant.io/v1alpha1/edgeunits/{edgeunit}/join-config`
- Auth: required
- Body: none
- Flags:
  - `--edgeunit` (path, required): Edgeunit represents the name of the edgeunit.
  - `--name` (query): Name represents the name of SingleJoinConfig.
  - `--page` (query, int32): Page represents the page number.
  - `--page-size` (query, int32): PageSize represents the page size.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `kind`, `apiVersion`; pagination `offset`

### `dce kant-management singlejoinconfigs update`

- Summary: Update SingleJoinConfigs.
- HTTP: `PUT /apis/batch.kant.io/v1alpha1/edgeunits/{edgeunit}/join-config/{name}`
- Auth: required
- Body: required
- Flags:
  - `--edgeunit` (path, required): Edgeunit represents the name of the edgeunit.
  - `--name` (path, required): Name represents the name of SingleJoinConfig.

## Workspaces

### `dce kant-management workspaces list-visible-workspaces`

- Summary: Returns workspaces that visible for the current user
- HTTP: `GET /apis/core.kant.io/v1alpha1/workspaces`
- Auth: required
- Body: none
- Flags: none
- Output: list path `items`; columns `id`, `alias`

### `dce kant-management workspaces list-visitor-clusters`

- Summary: Returns cluster names that visible for the current user
- HTTP: `GET /apis/core.kant.io/v1alpha1/workspaces/clusters`
- Auth: required
- Body: none
- Flags: none
- Output: list path `clusterInfos`; columns `name`, `edgeUnitInstalled`

### `dce kant-management workspaces list-visitor-namespaces`

- Summary: Returns cluster namespaces that visible for the current user
- HTTP: `GET /apis/core.kant.io/v1alpha1/workspaces/clusters/{cluster}/namespaces`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster path variable of cluster name
  - `--workspace-id` (query, int32): workspaceId ID of workspace
- Output: list path `namespaces`

