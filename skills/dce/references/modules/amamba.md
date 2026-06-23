# Module `amamba`

## Source

- Backend: `swagger`
- Repository: https://github.com/DaoCloud/daocloud-api-docs.git
- Pinned tag: `0bb0ec92f301b9c8a56deafebd4138e333f92cec`
- Files: `docs/openapi/amamba/v0.131.0.json`
- Resolved SHA: `0bb0ec92f301b9c8a56deafebd4138e333f92cec`

## Aggregation

### `dce amamba aggregation create-aggregation-resource`

- Summary: Create aggregation resources (override + propagation) for a kairship instance
- HTTP: `POST /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/kairship/{instance}/kairship_namespaces/{namespace}/aggregationresource`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--instance` (path, required): instance is the instance name of the application. is required and should same with `payload.instance`
  - `--namespace` (path, required): namespace is the namespace of the application. is required and should same with `payload.namespace`
- Output: list path `overridepolicies`
- Example: `dce amamba aggregation create-aggregation-resource --workspace-id <ws> --instance <i> --namespace <ns> --file agg.json`

## ApplicationService

### `dce amamba applicationservice attach-components`

- Summary: AttachComponents adds exist resource to application
- HTTP: `POST /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/applications/{name}/components:attach`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name

### `dce amamba applicationservice create-application`

- Summary: Create a new application
- HTTP: `POST /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/applications`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
- Example: `dce amamba applicationservice create-application --workspace-id <ws> --file app.yaml`

### `dce amamba applicationservice create-cloud-shell`

- Summary: ApplicationService_CreateCloudShell
- HTTP: `POST /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/applications/{application}/pods/{podName}/containers/{container}/cloudshell`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--application` (path, required): application
  - `--pod-name` (path, required): pod_name defines the name of the specified pod.
  - `--container` (path, required): container defines which container or init container to create cloud shell.

### `dce amamba applicationservice create-component`

- Summary: Add a component to an existing application
- HTTP: `POST /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/applications/{name}/components/{groupKind}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
  - `--group-kind` (path, required): groupKind
- Example: `dce amamba applicationservice create-component --workspace-id <ws> --application my-app --file component.yaml`

### `dce amamba applicationservice create-revision`

- Summary: ApplicationService_CreateRevision
- HTTP: `POST /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/applications/{applicationName}/revisions`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--application-name` (path, required): applicationName
- Output: list path `data`

### `dce amamba applicationservice delete-application`

- Summary: Delete an application
- HTTP: `DELETE /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/applications/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
- Example: `dce amamba applicationservice delete-application --workspace-id <ws> --name my-app`

### `dce amamba applicationservice delete-cloud-shell`

- Summary: ApplicationService_DeleteCloudShell
- HTTP: `DELETE /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/applications/{application}/pods/{podName}/containers/{container}/cloudshell`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--application` (path, required): application
  - `--pod-name` (path, required): pod_name defines the name of the specified pod.
  - `--container` (path, required): container defines which container or init container to create cloud shell.

### `dce amamba applicationservice delete-component`

- Summary: Remove a component from an application
- HTTP: `DELETE /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/applications/{name}/components/{groupKind}/{componentName}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
  - `--group-kind` (path, required): groupKind
  - `--component-name` (path, required): componentName
- Example: `dce amamba applicationservice delete-component --workspace-id <ws> --application my-app --name web`

### `dce amamba applicationservice delete-revision`

- Summary: ApplicationService_DeleteRevision
- HTTP: `DELETE /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/applications/{applicationName}/revisions/{revisionNumber}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--application-name` (path, required): applicationName
  - `--revision-number` (path, required): revisionNumber

### `dce amamba applicationservice detach-components`

- Summary: DetachComponents removes resource from application, but does not delete it
- HTTP: `POST /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/applications/{name}/components:detach`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name

### `dce amamba applicationservice get-application`

- Summary: Get an application's full details
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/applications/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
  - `--cluster` (query): cluster
  - `--namespace` (query): namespace
- Example: `dce amamba applicationservice get-application --workspace-id <ws> --name my-app`

### `dce amamba applicationservice get-application-templates`

- Summary: ApplicationService_GetApplicationTemplates
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/applications/{name}/templates`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
- Output: list path `data`

### `dce amamba applicationservice get-application-topology`

- Summary: Get the application topology graph (services, workloads, ingresses)
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/applications/{name}/topology`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
  - `--cluster` (query): cluster
  - `--namespace` (query): namespace
- Output: list path `edges`; columns `source`, `target`
- Example: `dce amamba applicationservice get-application-topology --workspace-id <ws> --name my-app`

### `dce amamba applicationservice get-application-yaml`

- Summary: Get the application as raw YAML
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/applications/{name}/yaml`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
  - `--cluster` (query): cluster
  - `--namespace` (query): namespace
- Example: `dce amamba applicationservice get-application-yaml --workspace-id <ws> --name my-app`

### `dce amamba applicationservice get-cloud-shell`

- Summary: ApplicationService_GetCloudShell
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/applications/{application}/pods/{podName}/containers/{container}/cloudshell`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--application` (path, required): application
  - `--pod-name` (path, required): pod_name defines the name of the specified pod.
  - `--container` (path, required): container defines which container or init container to create cloud shell.
  - `--cluster` (query): cluster specified the cluster name for cloudshell.
  - `--namespace` (query): namespace defines the namespace of the specified pod.
  - `--name` (query): name

### `dce amamba applicationservice get-component`

- Summary: Get a single component by name
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/applications/{name}/components/{groupKind}/{componentName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
  - `--group-kind` (path, required): groupKind
  - `--component-name` (path, required): componentName
  - `--cluster` (query): cluster
  - `--namespace` (query): namespace
- Example: `dce amamba applicationservice get-component --workspace-id <ws> --application my-app --name web`

### `dce amamba applicationservice get-pod-container-log`

- Summary: Stream logs from a workload container
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/applications/{name}/pods/{pod}/containers/{container}/log`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): Name of the application
  - `--pod` (path, required): Name of pod
  - `--container` (path, required): Name of the pod where the container is located
  - `--cluster` (query): Name of the cluster where the Pod is located
  - `--namespace` (query): Name of the namespace where the Pod is located
  - `--start-time` (query): Start time of get pod container log
  - `--end-time` (query): End time of get pod container log
  - `--page` (query, int32): Number of page.
  - `--page-size` (query, int32): Log number shown per page.
  - `--log-search` (query): for fuzzy query
- Output: list path `data`; columns `log`, `timeStamp`; pagination `offset`
- Example: `dce amamba workloads get-pod-container-log --workspace-id <ws> --cluster <c> --namespace <ns> --pod <pod> --container <c>`

### `dce amamba applicationservice get-revision`

- Summary: ApplicationService_GetRevision
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/applications/{applicationName}/revisions/{revisionNumber}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--application-name` (path, required): applicationName
  - `--revision-number` (path, required): revisionNumber
- Output: list path `data`

### `dce amamba applicationservice list-application-workloads`

- Summary: List workloads under an application
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/applications/{name}/workloads`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
  - `--cluster` (query): cluster
  - `--namespace` (query): namespace
  - `--fuzzy-name` (query): fuzzyName
  - `--metadata-only` (query): metadataOnly
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): PageSize per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|FIELD_NAME|CREATED_AT|CLUSTER|NAMESPACE): SortBy determines the cluster list order reference.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): OrderBy determines the cluster list order.
- Output: list path `items`; columns `data`, `state`; pagination `offset`
- Example: `dce amamba applicationservice list-application-workloads --workspace-id <ws> --name my-app`

### `dce amamba applicationservice list-applications`

- Summary: List applications in a workspace
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/applications`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): WorkspaceID restricts the cluster and namespace must be in the workspace.
  - `--cluster` (query): Cluster restricts the list to only those in the cluster.
  - `--namespace` (query): Namespace restricts the list to only those in the namespace.
  - `--fuzzy-name` (query): FuzzyName restricts the list to only those whose name match the fuzzy name.
  - `--metadata-only` (query): MetadataOnly restricts the result only return metadata.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): PageSize per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|FIELD_NAME|CREATED_AT|CLUSTER|NAMESPACE): SortBy determines the cluster list order reference.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): OrderBy determines the cluster list order.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `status.phase`; pagination `offset`
- Example:

```
dce amamba applicationservice list-applications --workspace-id <ws>
dce amamba applicationservice list-applications --workspace-id <ws> --name my-app -o json
```

### `dce amamba applicationservice list-component-events`

- Summary: ApplicationService_ListComponentEvents
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/applications/{name}/components/{componentName}/events`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): application name.
  - `--component-name` (path, required): componentName
  - `--cluster` (query): cluster
  - `--namespace` (query): namespace
  - `--event-type` (query, default `EVENT_TYPE_UNSPECIFIED`, one of: EVENT_TYPE_UNSPECIFIED|NORMAL|WARNING): - EVENT_TYPE_UNSPECIFIED: All events.
  - `--group-kind` (query): groupKind
  - `--fuzzy-name` (query): fuzzyName
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): PageSize per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|FIELD_NAME|CREATED_AT|CLUSTER|NAMESPACE): SortBy determines the cluster list order reference.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): OrderBy determines the cluster list order.
- Output: list path `items`; columns `type`, `firstTimestamp`, `lastTimestamp`, `message`, `reason`; pagination `offset`

### `dce amamba applicationservice list-component-events2`

- Summary: ApplicationService_ListComponentEvents2
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/applications/{name}/components/{groupKind}/{componentName}/events`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): application name.
  - `--group-kind` (path, required): groupKind
  - `--component-name` (path, required): componentName
  - `--cluster` (query): cluster
  - `--namespace` (query): namespace
  - `--event-type` (query, default `EVENT_TYPE_UNSPECIFIED`, one of: EVENT_TYPE_UNSPECIFIED|NORMAL|WARNING): - EVENT_TYPE_UNSPECIFIED: All events.
  - `--fuzzy-name` (query): fuzzyName
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): PageSize per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|FIELD_NAME|CREATED_AT|CLUSTER|NAMESPACE): SortBy determines the cluster list order reference.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): OrderBy determines the cluster list order.
- Output: list path `items`; columns `type`, `firstTimestamp`, `lastTimestamp`, `message`, `reason`; pagination `offset`

### `dce amamba applicationservice list-components`

- Summary: List components of an application
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/applications/{name}/components/{groupKind}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
  - `--group-kind` (path, required): groupKind
  - `--cluster` (query): cluster
  - `--namespace` (query): namespace
  - `--fuzzy-name` (query): fuzzyName
  - `--metadata-only` (query): metadataOnly
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): PageSize per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|FIELD_NAME|CREATED_AT|CLUSTER|NAMESPACE): SortBy determines the cluster list order reference.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): OrderBy determines the cluster list order.
- Output: list path `items`; columns `data`; pagination `offset`
- Example: `dce amamba applicationservice list-components --workspace-id <ws> --name my-app`

### `dce amamba applicationservice list-revisions`

- Summary: ApplicationService_ListRevisions
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/applications/{applicationName}/revisions`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): WorkspaceID restricts the cluster and namespace must be in the workspace.
  - `--cluster` (path, required): Cluster restricts the list to only those in the cluster.
  - `--namespace` (path, required): Namespace restricts the list to only those in the namespace.
  - `--application-name` (path, required): applicationName
  - `--metadata-only` (query): MetadataOnly restricts the result only return metadata.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): PageSize per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|FIELD_NAME|CREATED_AT|CLUSTER|NAMESPACE): SortBy determines the cluster list order reference.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): OrderBy determines the cluster list order.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `description`, `revisionNumber`; pagination `offset`

### `dce amamba applicationservice list-workload-pod-containers`

- Summary: List containers in a workload's pods
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/applications/{name}/components/{groupKind}/{componentName}/podcontainers`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): Name of the application
  - `--group-kind` (path, required): groupKind
  - `--component-name` (path, required): Name of the application component
  - `--cluster` (query): Name of the cluster where the Pod is located
  - `--namespace` (query): Name of the namespace where the Pod is located
- Output: list path `items`; columns `name`
- Example: `dce amamba workloads list-workload-pod-containers --workspace-id <ws> --cluster <c> --namespace <ns> --workload <name>`

### `dce amamba applicationservice pause-component`

- Summary: Pause a running component
- HTTP: `POST /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/applications/{name}/components/{groupKind}/{componentName}:pause`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
  - `--group-kind` (path, required): GroupKind specifies the resource group and kind
  - `--component-name` (path, required): componentName
- Example: `dce amamba applicationservice pause-component --workspace-id <ws> --application my-app --name web`

### `dce amamba applicationservice restart-component`

- Summary: Restart a component (rolling restart of pods)
- HTTP: `POST /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/applications/{name}/components/{groupKind}/{componentName}:restart`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
  - `--group-kind` (path, required): GroupKind specifies the resource group and kind
  - `--component-name` (path, required): componentName
- Example: `dce amamba applicationservice restart-component --workspace-id <ws> --application my-app --name web`

### `dce amamba applicationservice resume-component`

- Summary: Resume a paused component
- HTTP: `POST /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/applications/{name}/components/{groupKind}/{componentName}:resume`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
  - `--group-kind` (path, required): GroupKind specifies the resource group and kind
  - `--component-name` (path, required): componentName
- Example: `dce amamba applicationservice resume-component --workspace-id <ws> --application my-app --name web`

### `dce amamba applicationservice rollback-revision`

- Summary: ApplicationService_RollbackRevision
- HTTP: `POST /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/applications/{applicationName}/revisions/{revisionNumber}:rollback`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--application-name` (path, required): applicationName
  - `--revision-number` (path, required): revisionNumber
- Output: list path `created`

### `dce amamba applicationservice start-component`

- Summary: Resume a paused component
- HTTP: `POST /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/applications/{name}/components/{groupKind}/{componentName}:start`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
  - `--group-kind` (path, required): GroupKind specifies the resource group and kind
  - `--component-name` (path, required): componentName
- Example: `dce amamba applicationservice start-component --workspace-id <ws> --application my-app --name web`

### `dce amamba applicationservice stop-component`

- Summary: Pause a component (scale to 0)
- HTTP: `POST /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/applications/{name}/components/{groupKind}/{componentName}:stop`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
  - `--group-kind` (path, required): GroupKind specifies the resource group and kind
  - `--component-name` (path, required): componentName
- Example: `dce amamba applicationservice stop-component --workspace-id <ws> --application my-app --name web`

### `dce amamba applicationservice update-application`

- Summary: Update an existing application
- HTTP: `PUT /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/applications/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
- Example: `dce amamba applicationservice update-application --workspace-id <ws> --name my-app --file app.yaml`

### `dce amamba applicationservice update-application-info`

- Summary: ApplicationService_UpdateApplicationInfo
- HTTP: `POST /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/applications/{name}/info`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name

### `dce amamba applicationservice update-application-yaml`

- Summary: Update the application from raw YAML
- HTTP: `PUT /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/applications/{name}/yaml`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
- Example: `dce amamba applicationservice update-application-yaml --workspace-id <ws> --name my-app --file app.yaml`

### `dce amamba applicationservice update-component`

- Summary: Update a component's spec
- HTTP: `PUT /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/applications/{name}/components/{groupKind}/{componentName}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
  - `--group-kind` (path, required): groupKind
  - `--component-name` (path, required): componentName
- Example: `dce amamba applicationservice update-component --workspace-id <ws> --application my-app --name web --file component.yaml`

## Apps

### `dce amamba apps delete-deployment`

- Summary: Delete a kairship deployment
- HTTP: `DELETE /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/kairship/{instance}/kairship_namespaces/{namespace}/deployments/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--instance` (path, required): instance is the instance name of the application. is required and should same with `payload.instance`
  - `--namespace` (path, required): namespace is the namespace of the application. is required and should same with `payload.namespace`
  - `--name` (path, required): name is the name of the application. is required and should same with `payload.name`
  - `--payload.instance` (query): Instance represents which karmada instance the deployment belongs to.
  - `--payload.namespace` (query): Namespace represents which namespace the deployment belongs to.
  - `--payload.name` (query): Name represents the name of deployment
- Example: `dce amamba apps delete-deployment --workspace-id <ws> --instance <i> --namespace <ns> --name <name>`

### `dce amamba apps get-deployment-json`

- Summary: Apps_GetDeploymentJSON
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/kairship/{instance}/kairship_namespaces/{namespace}/deployments/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--instance` (path, required): instance is the instance name of the application. is required and should same with `payload.instance`
  - `--namespace` (path, required): namespace is the namespace of the application. is required and should same with `payload.namespace`
  - `--name` (path, required): name is the name of the application. is required and should same with `payload.name`
  - `--payload.instance` (query): Instance represents which instance the configmap belongs to.
  - `--payload.namespace` (query): Namespace is the metadata.namespace of the referenced Deployment.
  - `--payload.name` (query): name represents for the resource name

### `dce amamba apps list-deployments`

- Summary: ListDeployments lists deployments
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/kairship/{instance}/kairship_namespaces/{namespace}/deployments`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--instance` (path, required): instance is the instance name of the application. is required and should same with `payload.instance`
  - `--namespace` (path, required): namespace is the namespace of the application. is required and should same with `payload.namespace`
  - `--payload.instance` (query): Instance represents which karmada instance the deployment belongs to.
  - `--payload.namespace` (query): Namespace represents which namespace the deployment belongs to.
  - `--payload.page` (query, int32): Page is current page.
  - `--payload.page-size` (query, int32): Size is the data number shown per page.
  - `--payload.name` (query): Name represents the name of workloads to search
  - `--payload.phase` (query): Phase represents the phase of workloads to search
  - `--payload.sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--payload.sort-dir` (query, default `desc`, one of: desc|asc): SortDir determines the data list order.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`, `revision`

## Cluster

### `dce amamba cluster list-clusters-labels`

- Summary: Cluster_ListClustersLabels
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/kairship/{instance}/clusters-labels`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--instance` (path, required): instance is the instance name of the application. is required and should same with `payload.instance`
  - `--payload.instance` (query): karmada instance
- Output: list path `clusterLabels`; columns `cluster`

### `dce amamba cluster list-joined-clusters`

- Summary: ListJoinedCluster Get the list of clusters that have been added to karmada
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/kairship/{instance}/clusters`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--instance` (path, required): instance is the instance name of the application. is required and should same with `payload.instance`
  - `--payload.instance` (query): payload.instance
  - `--payload.page` (query, int32): Page requested.
  - `--payload.page-size` (query, int32): Size per page requested.
  - `--payload.role` (query): payload.role
  - `--payload.kubernetes-version` (query): KUBERNETESVERSION cluster k8s version use to support search sub cluster at
  - `--payload.phase` (query): Phases is used for filter.
  - `--payload.managed-by` (query): ManagedBy represents who manages the cluster
  - `--payload.sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the cluster list order reference.
  - `--payload.sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the cluster list order.
  - `--payload.name` (query): Name of cluster.
  - `--payload.region` (query): Region represents the region of the member cluster locate in.
  - `--payload.provider` (query): Provider represents the cloud provider name of the member cluster.
  - `--payload.zone` (query): Zone represents the zone of the member cluster locate in.
  - `--payload.label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter clusters.
  - `--payload.field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter the clusters.
  - `--payload.cluster-selector` (query): A cluster selector requirement is a selector that contains values, a key, and an operator
  - `--payload.all-cluster` (query): list all kpanda clusters
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `status.phase`, `spec.provider`, `spec.region`, `metadata.creationTimestamp`

## Core

### `dce amamba core create-control-plane-namespace`

- Summary: Core_CreateControlPlaneNamespace
- HTTP: `POST /apis/amamba.io/v1alpha1/workspaces/{workspaceId}/control-plane/namespaces`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId

### `dce amamba core create-namespace`

- Summary: Create a namespace in the specified workspace and cluster.
- HTTP: `POST /apis/amamba.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): Which workspace does it belong to
  - `--cluster` (path, required): Which cluster does it belong to

### `dce amamba core create-namespace-quota`

- Summary: Core_CreateNamespaceQuota
- HTTP: `POST /apis/amamba.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/quota`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): Which workspace does it belong to
  - `--cluster` (path, required): Which cluster does it belong to
  - `--namespace` (path, required): the name of the namespace.

### `dce amamba core delete-namespace`

- Summary: Delete a namespace in the specified workspace and cluster.
- HTTP: `DELETE /apis/amamba.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): Which workspace does it belong to
  - `--cluster` (path, required): Which cluster does it belong to
  - `--namespace` (path, required): the name of the namespace.

### `dce amamba core get-control-plane-namespace`

- Summary: Core_GetControlPlaneNamespace
- HTTP: `GET /apis/amamba.io/v1alpha1/workspaces/{workspaceId}/control-plane/namespaces`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId

### `dce amamba core get-namespace-quota`

- Summary: Core_GetNamespaceQuota
- HTTP: `GET /apis/amamba.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/quota`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): Which workspace does it belong to
  - `--cluster` (path, required): Which cluster does it belong to
  - `--namespace` (path, required): the name of the namespace.

### `dce amamba core get-secret`

- Summary: Get a single kairship secret by name
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/kairship/{instance}/kairship_namespaces/{namespace}/secrets/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--instance` (path, required): instance is the instance name of the application. is required and should same with `payload.instance`
  - `--namespace` (path, required): namespace is the namespace of the application. is required and should same with `payload.namespace`
  - `--name` (path, required): name
  - `--payload.instance` (query): Instance represents which karmada instance the secret belongs to.
  - `--payload.namespace` (query): Namespace is the metadata.namespace of the referenced secret.
  - `--payload.name` (query): Secret name.
- Example: `dce amamba core get-secret --workspace-id <ws> --instance <i> --namespace <ns> --name <name>`

### `dce amamba core get-workspace-quota`

- Summary: Core_GetWorkspaceQuota
- HTTP: `GET /apis/amamba.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/quota`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): Which workspace does it belong to
  - `--cluster` (path, required): Which cluster does it belong to

### `dce amamba core list-bound-clusters`

- Summary: List clusters that have been bound to the workspace.
- HTTP: `GET /apis/amamba.io/v1alpha1/workspaces/{workspaceId}/clusters`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): Which workspace does it belong to
  - `--owned` (query): Optional, if true, then only return the clusters that are owned by the user
  - `--status` (query, default `CLUSTER_STATUS_UNSPECIFIED`, one of: CLUSTER_STATUS_UNSPECIFIED|CLUSTER_STATUS_RUNNING|CLUSTER_STATUS_NOT_RUNNING|CLUSTER_STATUS_UNKNOWN): Optional, if not empty, then only return the clusters that have the given status
  - `--page` (query, int32): page
  - `--page-size` (query, int32): Optional, if page_size is -1 then return all the clusters
- Output: list path `items`; columns `name`, `aliasName`, `createdAt`, `kubeSystemId`, `status`; pagination `offset`

### `dce amamba core list-bound-namespaces`

- Summary: List a cluster's namespaces that have been bound to the workspace.
- HTTP: `GET /apis/amamba.io/v1alpha1/workspaces/{workspaceId}/namespaces`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): Which workspace does it belong to
  - `--cluster` (query): Which cluster does it belong to
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|FIELD_NAME|CREATED_AT|CLUSTER|NAMESPACE): SortBy determines the cluster list order reference.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): OrderBy determines the cluster list order.
  - `--name` (query): fuzzy search for namespace.
- Output: list path `items`; columns `name`, `creationTimestamp`, `cluster`, `workspaceId`; pagination `offset`

### `dce amamba core list-cluster-gpu-summary`

- Summary: Core_ListClusterGPUSummary
- HTTP: `GET /apis/amamba.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/gpusummary`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
- Output: list path `gpuSummary`; columns `node`

### `dce amamba core list-cluster-names`

- Summary: List all cluster names, no workspace scoped.
- HTTP: `GET /apis/amamba.io/v1alpha1/management/clusternames`
- Auth: required
- Body: none
- Flags: none
- Output: list path `items`

### `dce amamba core list-cluster-namespace-names`

- Summary: List all namespace names in a specified cluster, no workspace scoped.
- HTTP: `GET /apis/amamba.io/v1alpha1/management/clusters/{cluster}/namespacenames`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Which cluster does it belong to
- Output: list path `items`

### `dce amamba core list-config-maps`

- Summary: List configmaps in a kairship multi-cluster namespace
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/kairship/{instance}/kairship_namespaces/{namespace}/configmaps`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--instance` (path, required): instance is the instance name of the application. is required and should same with `payload.instance`
  - `--namespace` (path, required): namespace is the namespace of the application. is required and should same with `payload.namespace`
  - `--payload.instance` (query): Instance represents which karmada instance the configmap belongs to.
  - `--payload.namespace` (query): Namespace is the metadata.namespace of the referenced ConfigMap.
  - `--payload.page` (query, int32): Page requested.
  - `--payload.page-size` (query, int32): Size per page requested.
  - `--payload.sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the list order reference.
  - `--payload.sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the list order.
  - `--payload.name` (query): name is used for query.
  - `--payload.label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--payload.field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`, `immutable`
- Example: `dce amamba core list-config-maps --workspace-id <ws> --instance <i> --namespace <ns>`

### `dce amamba core list-deploy-targets`

- Summary: List available deploy targets (clusters) in a workspace
- HTTP: `GET /apis/amamba.io/v1alpha1/management/workspaces/{workspaceId}/deploytargets`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): Which workspace does the cluster/namespace belong to
  - `--cluster` (query): Optional, if cluster is not empty, then only return the deploy targets of the cluster
  - `--allow-empty` (query): Optional, default false, if true, then also return clusters with no namespace bound to the workspace
- Output: list path `items`; columns `aliasName`, `cluster`, `status`
- Example: `dce amamba mutilcloudapplication list-deploy-targets --workspace-id <ws>`

### `dce amamba core list-kairship-instance`

- Summary: List kairship multi-cluster instances
- HTTP: `GET /apis/amamba.io/v1alpha1/workspaces/{workspaceId}/kairship_instances`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
- Output: list path `items`
- Example: `dce amamba gitops list-kairship-instance --workspace-id <ws>`

### `dce amamba core list-kairship-instance-bound-namespaces`

- Summary: List namespaces bound to a kairship instance
- HTTP: `GET /apis/amamba.io/v1alpha1/workspaces/{workspaceId}/kairship_instances/namespaces`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--instance` (query): instance
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|FIELD_NAME|CREATED_AT|CLUSTER|NAMESPACE): SortBy determines the cluster list order reference.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): OrderBy determines the cluster list order.
  - `--name` (query): name
- Output: list path `items`; columns `namespace`, `createAt`, `instance`; pagination `offset`
- Example: `dce amamba gitops list-kairship-instance-bound-namespaces --workspace-id <ws> --instance <i>`

### `dce amamba core list-namespace-summary`

- Summary: Core_ListNamespaceSummary
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/kairship/{instance}/namespacesummary`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--instance` (path, required): instance is the instance name of the application. is required and should same with `payload.instance`
  - `--payload.instance` (query): Instance the namespace summary list belong to.
- Output: list path `data`; columns `name`, `instance`

### `dce amamba core list-platform-role-permissions-for-current-user`

- Summary: Core_ListPlatformRolePermissionsForCurrentUser
- HTTP: `GET /apis/amamba.io/v1alpha1/management/permissions`
- Auth: required
- Body: none
- Flags: none
- Output: list path `permissions`

### `dce amamba core list-role-permissions-by-workspace-for-current-user`

- Summary: Obtain the Perms of the current user Ctx needs to include JwtToken (GProduct sensitive)
- HTTP: `GET /apis/amamba.io/v1alpha1/management/workspaces/{workspaceId}/permissions`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
- Output: list path `permissions`

### `dce amamba core list-secrets`

- Summary: List secrets in a kairship multi-cluster namespace
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/kairship/{instance}/kairship_namespaces/{namespace}/secrets`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--instance` (path, required): instance is the instance name of the application. is required and should same with `payload.instance`
  - `--namespace` (path, required): namespace is the namespace of the application. is required and should same with `payload.namespace`
  - `--payload.instance` (query): Instance represents which karmada instance the secret belongs to.
  - `--payload.page` (query, int32): Page requested.
  - `--payload.page-size` (query, int32): Size per page requested.
  - `--payload.namespace` (query): Namespace is the metadata.namespace of the referenced secret.
  - `--payload.name` (query): The name use to search specific secret
  - `--payload.sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the list order reference.
  - `--payload.sort-dir` (query, default `desc`, one of: desc|asc): SortDir determines the list order.
  - `--payload.label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--payload.field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `type`, `metadata.creationTimestamp`, `immutable`
- Example: `dce amamba core list-secrets --workspace-id <ws> --instance <i> --namespace <ns>`

### `dce amamba core list-visible-workspaces`

- Summary: List the workspaces that have been bound to the account.
- HTTP: `GET /apis/amamba.io/v1alpha1/management/workspaces`
- Auth: required
- Body: none
- Flags:
  - `--name` (query): workspace name
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): PageSize per page requested.
- Output: list path `items`; columns `alias`, `workspaceId`; pagination `offset`

### `dce amamba core update-namespace`

- Summary: UpdateNamespace a namespace in the specified workspace and cluster.
- HTTP: `PUT /apis/amamba.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): Which workspace does it belong to
  - `--cluster` (path, required): Which cluster does it belong to
  - `--namespace` (path, required): the name of the namespace.

### `dce amamba core update-namespace-quota`

- Summary: Core_UpdateNamespaceQuota
- HTTP: `PUT /apis/amamba.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/quota`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): Which workspace does it belong to
  - `--cluster` (path, required): Which cluster does it belong to
  - `--namespace` (path, required): the name of the namespace.

## Credentials

### `dce amamba credentials create-credential`

- Summary: Create a credential (interactive prompts for the secret)
- HTTP: `POST /apis/credential.amamba.io/v1alpha1/workspaces/{workspaceId}/credentials`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): The workspace id of the credential.
- Example: `dce amamba credentials create-credential --workspace-id <ws> --name github-pat --type git --interactive`

### `dce amamba credentials delete-credential`

- Summary: Delete a credential
- HTTP: `DELETE /apis/credential.amamba.io/v1alpha1/workspaces/{workspaceId}/credentials/{credentialName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--credential-name` (path, required): credentialName
- Example: `dce amamba credentials delete-credential --workspace-id <ws> --name github-pat`

### `dce amamba credentials get-credential`

- Summary: Get a credential by name (secret value is not returned)
- HTTP: `GET /apis/credential.amamba.io/v1alpha1/workspaces/{workspaceId}/credentials/{credentialName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--credential-name` (path, required): credentialName
- Example: `dce amamba credentials get-credential --workspace-id <ws> --name github-pat`

### `dce amamba credentials list-credential`

- Summary: List credentials (Git, registry, Jenkins, etc.) in a workspace
- HTTP: `GET /apis/credential.amamba.io/v1alpha1/workspaces/{workspaceId}/credentials`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): PageSize is the data number shown per page.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|FIELD_NAME|CREATED_AT|CLUSTER|NAMESPACE): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): OrderBy determines the data list order.
  - `--name` (query): The filter of the credential, fuzzy search.
  - `--include-global` (query): The filter of the credential, include global credentials, such as gitlab, sonarqube, etc.
- Output: list path `items`; pagination `offset`
- Example: `dce amamba credentials list-credential --workspace-id <ws>`

### `dce amamba credentials update-credential`

- Summary: Update a credential's metadata or rotate its secret
- HTTP: `PUT /apis/credential.amamba.io/v1alpha1/workspaces/{workspaceId}/credentials/{credentialName}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--credential-name` (path, required): credentialName
- Example: `dce amamba credentials update-credential --workspace-id <ws> --name github-pat --interactive`

## GatewayServer

### `dce amamba gatewayserver get-gateway`

- Summary: GatewayServer_GetGateway
- HTTP: `GET /apis/amamba.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/gateways`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace

### `dce amamba gatewayserver list-gateway-api`

- Summary: GatewayServer_ListGatewayAPI
- HTTP: `GET /apis/amamba.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/gateways/{gateway}/apis`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--gateway` (path, required): gateway
  - `--service` (query): service
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): PageSize per page requested.
- Output: list path `items`; columns `name`; pagination `offset`

## GitLab

### `dce amamba gitlab create-gitlab-branch`

- Summary: GitLab_CreateGitlabBranch
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/gitlab/{toolchainId}/projects/{projectId}/branches`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--toolchain-id` (path, required, int32): toolchainId
  - `--project-id` (path, required, int32): projectId

### `dce amamba gitlab create-gitlab-tag`

- Summary: GitLab_CreateGitlabTag
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/gitlab/{toolchainId}/projects/{projectId}/tags`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--toolchain-id` (path, required, int32): toolchainId
  - `--project-id` (path, required, int32): projectId

### `dce amamba gitlab get-gitlab-project-details`

- Summary: GitLab_GetGitlabProjectDetails
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/gitlab/{toolchainId}/projects/{projectId}/details`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--toolchain-id` (path, required, int32): toolchainId
  - `--project-id` (path, required, int32): projectId

### `dce amamba gitlab list-gitlab-all-branches-and-tags`

- Summary: List all branches and tags of a GitLab project in one call
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/gitlab/{toolchainId}/projects/{projectId}/refs`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--toolchain-id` (path, required, int32): toolchainId
  - `--project-id` (path, required, int32): projectId
- Output: list path `branches`; columns `name`, `default`, `diffUrl`, `mergeUrl`, `protected`, `webUrl`
- Example: `dce amamba gitlab list-gitlab-all-branches-and-tags --workspace-id <ws> --toolchain-id <id> --project-id <pid>`

### `dce amamba gitlab list-gitlab-project-branches`

- Summary: List branches of a GitLab project bound via a toolchain
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/gitlab/{toolchainId}/projects/{projectId}/branches`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--toolchain-id` (path, required, int32): toolchainId
  - `--project-id` (path, required, int32): projectId
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--name` (query): name
- Output: list path `items`; columns `name`, `default`, `diffUrl`, `mergeUrl`, `protected`, `webUrl`; pagination `offset`
- Example: `dce amamba gitlab list-gitlab-project-branches --workspace-id <ws> --toolchain-id <id> --project-id <pid>`

### `dce amamba gitlab list-gitlab-project-tags`

- Summary: List tags of a GitLab project bound via a toolchain
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/gitlab/{toolchainId}/projects/{projectId}/tags`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--toolchain-id` (path, required, int32): toolchainId
  - `--project-id` (path, required, int32): projectId
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--name` (query): name
- Output: list path `items`; columns `name`, `message`, `protected`, `webUrl`; pagination `offset`
- Example: `dce amamba gitlab list-gitlab-project-tags --workspace-id <ws> --toolchain-id <id> --project-id <pid>`

## GitOps

### `dce amamba gitops create-application`

- Summary: Create a new application
- HTTP: `POST /apis/gitops.amamba.io/v1alpha1/workspaces/{workspaceId}/applications`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
- Example: `dce amamba applicationservice create-application --workspace-id <ws> --file app.yaml`

### `dce amamba gitops create-repository`

- Summary: GitOps_CreateRepository
- HTTP: `POST /apis/gitops.amamba.io/v1alpha1/workspaces/{workspaceId}/repositories`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId

### `dce amamba gitops delete-application`

- Summary: Delete an application
- HTTP: `DELETE /apis/gitops.amamba.io/v1alpha1/workspaces/{workspaceId}/applications/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
- Example: `dce amamba applicationservice delete-application --workspace-id <ws> --name my-app`

### `dce amamba gitops delete-repository`

- Summary: GitOps_DeleteRepository
- HTTP: `DELETE /apis/gitops.amamba.io/v1alpha1/workspaces/{workspaceId}/repositories/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name

### `dce amamba gitops get-application`

- Summary: Get an application's full details
- HTTP: `GET /apis/gitops.amamba.io/v1alpha1/workspaces/{workspaceId}/applications/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
  - `--type` (query, default `UNSPECIFIED`, one of: UNSPECIFIED|NORMAL|HARD): type
  - `--namespace` (query): namespace
- Example: `dce amamba applicationservice get-application --workspace-id <ws> --name my-app`

### `dce amamba gitops get-application-dashboard-url`

- Summary: GitOps_GetApplicationDashboardURL
- HTTP: `GET /apis/gitops.amamba.io/v1alpha1/workspaces/{workspaceId}/applications/{name}/dashboard`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
  - `--view-type` (query, default `VIEW_TYPE_UNSPECIFIED`, one of: VIEW_TYPE_UNSPECIFIED|VIEW_TYPE_TREE|VIEW_TYPE_PODS|VIEW_TYPE_NETWORK|VIEW_TYPE_LIST): viewType
  - `--namespace` (query): namespace

### `dce amamba gitops get-application-json`

- Summary: GitOps_GetApplicationJSON
- HTTP: `GET /apis/gitops.amamba.io/v1alpha1/workspaces/{workspaceId}/applications/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
  - `--namespace` (query): namespace

### `dce amamba gitops get-application-revisions`

- Summary: GitOps_GetApplicationRevisions
- HTTP: `GET /apis/gitops.amamba.io/v1alpha1/workspaces/{workspaceId}/applications/{name}/revisions`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
  - `--revision` (query): revision
  - `--namespace` (query): namespace
- Output: list path `tags`

### `dce amamba gitops get-application-status`

- Summary: Get the runtime status of an application
- HTTP: `GET /apis/gitops.amamba.io/v1alpha1/workspaces/{workspaceId}/applications/status`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
- Example: `dce amamba applicationservice get-application-status --workspace-id <ws> --name my-app -o json`

### `dce amamba gitops get-git-ops-namespace`

- Summary: GitOps_GetGitOpsNamespace
- HTTP: `GET /apis/gitops.amamba.io/v1alpha1/workspaces/{workspaceId}/namespace`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId

### `dce amamba gitops get-helm-charts`

- Summary: Get a Helm chart by name
- HTTP: `GET /apis/gitops.amamba.io/v1alpha1/workspaces/{workspaceId}/helmcharts`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--repo` (query): the url of helm chart repo,like: https://release-ci.daocloud.io/chartrepo/demo
- Output: list path `items`; columns `name`
- Example: `dce amamba helm get-helm-charts --workspace-id <ws> --name my-chart`

### `dce amamba gitops get-managed-resources`

- Summary: GitOps_GetManagedResources
- HTTP: `GET /apis/gitops.amamba.io/v1alpha1/workspaces/{workspaceId}/applications/{name}/managed_resources`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
  - `--namespace` (query): namespace
  - `--resource-name` (query): resourceName
  - `--resource-namespace` (query): resourceNamespace
  - `--group` (query): group
  - `--version` (query): version
  - `--kind` (query): kind
- Output: list path `items`; columns `name`, `namespace`, `kind`, `group`, `hook`, `liveState`

### `dce amamba gitops list-application-events`

- Summary: List events for an application
- HTTP: `GET /apis/gitops.amamba.io/v1alpha1/workspaces/{workspaceId}/applications/{name}/events`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): PageSize per page requested.
  - `--namespace` (query): namespace
- Output: list path `items`; columns `type`, `firstTimestamp`, `lastTimestamp`, `message`, `reason`; pagination `offset`
- Example: `dce amamba applicationservice list-application-events --workspace-id <ws> --name my-app --page 1 --page-size 50`

### `dce amamba gitops list-applications`

- Summary: List applications in a workspace
- HTTP: `GET /apis/gitops.amamba.io/v1alpha1/workspaces/{workspaceId}/applications`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): PageSize per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|FIELD_NAME|CREATED_AT|CLUSTER|NAMESPACE): SortBy determines the cluster list order reference.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): OrderBy determines the cluster list order.
  - `--fuzzy-name` (query): fuzzyName
  - `--sync-status` (query, default `SYNC_STATUS_UNSPECIFIED`, one of: SYNC_STATUS_UNSPECIFIED|SYNC_STATUS_UNKNOWN|SYNC_STATUS_SYNCED|SYNC_STATUS_OUT_OF_SYNC): syncStatus
  - `--health-status` (query, default `HEALTH_STATUS_UNSPECIFIED`, one of: HEALTH_STATUS_UNSPECIFIED|HEALTH_STATUS_MISSING|HEALTH_STATUS_DEGRADED|HEALTH_STATUS_HEALTHY|HEALTH_STATUS_UNKNOWN|HEALTH_STATUS_SUSPENDED|HEALTH_STATUS_PROGRESSING): healthStatus
- Output: list path `items`; columns `createdAt`, `deletedAt`, `operationFinishedAt`, `operationStartedAt`; pagination `offset`
- Example:

```
dce amamba applicationservice list-applications --workspace-id <ws>
dce amamba applicationservice list-applications --workspace-id <ws> --name my-app -o json
```

### `dce amamba gitops list-git-ops-kairship-deploy-target`

- Summary: GitOps_ListGitOpsKairshipDeployTarget
- HTTP: `GET /apis/gitops.amamba.io/v1alpha1/workspaces/{workspaceId}/kairship_deploytargets`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
- Output: list path `items`; columns `instance`

### `dce amamba gitops list-git-references`

- Summary: GitOps_ListGitReferences
- HTTP: `GET /apis/gitops.amamba.io/v1alpha1/workspaces/{workspaceId}/gitreferences`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--url` (query): url
  - `--repo-name` (query): repoName
- Output: list path `branchs`

### `dce amamba gitops list-repositories`

- Summary: GitOps_ListRepositories
- HTTP: `GET /apis/gitops.amamba.io/v1alpha1/workspaces/{workspaceId}/repositories`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): PageSize per page requested.
  - `--sort-by` (query, default `ARGOCD_REPO_SORT_BY_UNSPECIFIED`, one of: ARGOCD_REPO_SORT_BY_UNSPECIFIED|ARGOCD_REPO_SORT_BY_NAME|ARGOCD_REPO_SORT_BY_REPO): SortBy determines the cluster list order reference.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): OrderBy determines the cluster list order.
  - `--fuzzy-name` (query): fuzzyName
- Output: list path `items`; columns `name`, `type`, `repo`, `workspaceId`; pagination `offset`

### `dce amamba gitops sync-application`

- Summary: Trigger a GitOps sync for an application
- HTTP: `POST /apis/gitops.amamba.io/v1alpha1/workspaces/{workspaceId}/applications/{name}:sync`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
- Example: `dce amamba gitops sync-application --workspace-id <ws> --name my-app`

### `dce amamba gitops terminate-application-sync`

- Summary: Terminate an in-flight GitOps sync
- HTTP: `DELETE /apis/gitops.amamba.io/v1alpha1/workspaces/{workspaceId}/applications/{name}:sync`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
- Example: `dce amamba gitops terminate-application-sync --workspace-id <ws> --name my-app`

### `dce amamba gitops update-application`

- Summary: Update an existing application
- HTTP: `PUT /apis/gitops.amamba.io/v1alpha1/workspaces/{workspaceId}/applications/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
- Example: `dce amamba applicationservice update-application --workspace-id <ws> --name my-app --file app.yaml`

### `dce amamba gitops update-application-json`

- Summary: GitOps_UpdateApplicationJSON
- HTTP: `PUT /apis/gitops.amamba.io/v1alpha1/workspaces/{workspaceId}/applications/{name}/json`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name

## GlobalBuildParameter

### `dce amamba globalbuildparameter create-global-build-parameter`

- Summary: Create a new global build parameter
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/global-build-parameters`
- Auth: required
- Body: required
- Flags: none
- Output: list path `choiceListText`
- Example: `dce amamba globalbuildparameter create-global-build-parameter --name REGISTRY --value docker.io`

### `dce amamba globalbuildparameter delete-global-build-parameter`

- Summary: Delete a global build parameter
- HTTP: `DELETE /apis/pipeline.amamba.io/v1alpha1/global-build-parameters/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name
- Example: `dce amamba globalbuildparameter delete-global-build-parameter --name REGISTRY`

### `dce amamba globalbuildparameter list-global-build-parameter`

- Summary: List global build parameters shared across pipelines
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/global-build-parameters`
- Auth: required
- Body: none
- Flags:
  - `--fuzzy-name` (query): fuzzyName
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): PageSize per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|FIELD_NAME|CREATED_AT|CLUSTER|NAMESPACE): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): OrderBy determines the data list order.
- Output: list path `items`; columns `name`; pagination `offset`
- Example: `dce amamba globalbuildparameter list-global-build-parameter`

### `dce amamba globalbuildparameter update-global-build-parameter`

- Summary: Update a global build parameter
- HTTP: `PUT /apis/pipeline.amamba.io/v1alpha1/global-build-parameters/{oldName}`
- Auth: required
- Body: required
- Flags:
  - `--old-name` (path, required): oldName
- Output: list path `choiceListText`
- Example: `dce amamba globalbuildparameter update-global-build-parameter --name REGISTRY --value registry.example.com`

## Helm

### `dce amamba helm get-helm-chart-files`

- Summary: Helm_GetHelmChartFiles
- HTTP: `GET /apis/application.amamba.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/helmrepos/{repo}/helmcharts/{name}/versions/{version}/files`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
  - `--repo` (path, required): repo
  - `--name` (path, required): name
  - `--version` (path, required): version

### `dce amamba helm get-helm-chart-resources`

- Summary: Helm_GetHelmChartResources
- HTTP: `GET /apis/application.amamba.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/helmrepos/{repo}/helmcharts/{name}/versions/{version}/resources`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
  - `--repo` (path, required): repo
  - `--name` (path, required): name
  - `--version` (path, required): version
- Output: list path `resources`; columns `name`, `kind`, `image`

### `dce amamba helm get-helm-chart-values`

- Summary: Helm_GetHelmChartValues
- HTTP: `GET /apis/application.amamba.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/helmrepos/{repo}/helmcharts/{name}/versions/{version}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster represents which cluster the chart belongs to.
  - `--repo` (path, required): The repo represents for the charts belongs to.
  - `--name` (path, required): The name represents for the resource name.
  - `--version` (path, required): The version represents for the resource version.

### `dce amamba helm get-helm-charts`

- Summary: Get a Helm chart by name
- HTTP: `GET /apis/application.amamba.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/helmrepos/{repo}/helmcharts/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
  - `--repo` (path, required): repo
  - `--name` (path, required): name
- Example: `dce amamba helm get-helm-charts --workspace-id <ws> --name my-chart`

### `dce amamba helm get-helm-install-config`

- Summary: Get the install config of a deployed Helm release
- HTTP: `GET /apis/application.amamba.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/helmrepos/{repo}/helmcharts/{name}/config`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster represents which cluster the chart belongs to.
  - `--repo` (path, required): The repo represents for the charts belongs to.
  - `--name` (path, required): Name represents the name of helmrelease
  - `--version` (query): Version is an int which represents the version of the chart.
- Example: `dce amamba helm get-helm-install-config --workspace-id <ws> --release my-release`

### `dce amamba helm get-helm-release`

- Summary: Get a Helm release by name
- HTTP: `GET /apis/application.amamba.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/helmreleases/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): Name is the user-specified identifier.
- Example: `dce amamba helm get-helm-release --workspace-id <ws> --name my-release`

### `dce amamba helm list-cluster-helm-release`

- Summary: Helm_ListClusterHelmRelease
- HTTP: `GET /apis/application.amamba.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/helmreleases`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
  - `--name` (query): Name is the user-specified identifier.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): PageSize per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|FIELD_NAME|CREATED_AT|CLUSTER|NAMESPACE): SortBy determines the cluster list order reference.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): OrderBy determines the cluster list order.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `spec.version`, `metadata.creationTimestamp`; pagination `offset`

### `dce amamba helm list-helm-charts`

- Summary: List Helm charts available in a workspace
- HTTP: `GET /apis/application.amamba.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/helmcharts`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
  - `--repo` (query): repo
  - `--category` (query, default `UNSPECIFIED`, one of: UNSPECIFIED|OTHERS|STORAGE|NETWORKING|MONITORING|DATABASE|DATA_SERVICE|ECO_APP|BIGDATA|SECURITY|IOT_EDGE|INFRA): category
  - `--name` (query): name
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): pageSize
- Output: list path `items`; columns `metadata.name`, `removed`; pagination `offset`
- Example: `dce amamba helm list-helm-charts --workspace-id <ws>`

### `dce amamba helm list-helm-release`

- Summary: List Helm releases deployed in the workspace
- HTTP: `GET /apis/application.amamba.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/helmreleases`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (query): Name is the user-specified identifier.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): PageSize per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|FIELD_NAME|CREATED_AT|CLUSTER|NAMESPACE): SortBy determines the cluster list order reference.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): OrderBy determines the cluster list order.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `spec.version`, `metadata.creationTimestamp`; pagination `offset`
- Example: `dce amamba helm list-helm-release --workspace-id <ws>`

### `dce amamba helm list-helm-repo`

- Summary: List configured Helm chart repositories
- HTTP: `GET /apis/application.amamba.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/helmrepos`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `status.phase`, `metadata.creationTimestamp`
- Example: `dce amamba helm list-helm-repo --workspace-id <ws>`

### `dce amamba helm rendering-helm-chart-manifests`

- Summary: Render a Helm chart's manifests locally (dry-run)
- HTTP: `POST /apis/application.amamba.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/helmrepos/{repo}/helmcharts/{name}/versions/{version}/manifests`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster represents which cluster the chart belongs to.
  - `--repo` (path, required): The repo represents for the charts belongs to.
  - `--name` (path, required): The name represents for the resource name.
  - `--version` (path, required): The version represents for the resource version.
- Example: `dce amamba helm rendering-helm-chart-manifests --workspace-id <ws> --name my-chart --version 1.2.3`

## Image

### `dce amamba image get-image-info`

- Summary: Get details about a specific image (tag, digest, size, etc.)
- HTTP: `GET /apis/application.amamba.io/v1alpha1/workspaces/{workspaceId}/imageinfo/{image}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--image` (path, required): image
- Example: `dce amamba image get-image-info --workspace-id <ws> --image nginx:1.25`

### `dce amamba image list-artifacts`

- Summary: ListArtifacts returns a list of tags of specified image
- HTTP: `GET /apis/application.amamba.io/v1alpha1/workspaces/{workspaceId}/registries/{registry}/projects/{project}/repositories/{repository}/artifacts`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--registry` (path, required): Registry is registry name.
  - `--project` (path, required): Project is the project to request.
  - `--repository` (path, required): Repository is image name.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): Size per page.
  - `--fuzzy-name` (query): fuzzyName
- Output: list path `items`; columns `digest`, `imageSize`, `pushTime`; pagination `offset`

### `dce amamba image list-registries`

- Summary: ListRegistries returns a list of registries
- HTTP: `GET /apis/application.amamba.io/v1alpha1/workspaces/{workspaceId}/registries`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--global` (query): Global is to list all global registries.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): Size per page.
  - `--fuzzy-name` (query): fuzzyName
- Output: list path `items`; columns `name`, `type`, `alias`, `host`; pagination `offset`

### `dce amamba image list-repositories`

- Summary: ListRepositories returns a list of image names of specified project
- HTTP: `GET /apis/application.amamba.io/v1alpha1/workspaces/{workspaceId}/registries/{registry}/projects/{project}/repositories`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--registry` (path, required): Registry is registry name.
  - `--project` (path, required): Project is the project to request, "/" is a possible value.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): Size per page.
  - `--show-artifacts` (query): ShowArtifacts is to list artifacts of per image, default false.
- Output: list path `items`; columns `name`, `public`, `pullCount`, `tagCount`, `updateTime`; pagination `offset`

## JFrogService

### `dce amamba jfrogservice list-files`

- Summary: JFrogService_ListFiles
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/jfrog/{toolchainId}/storage/files`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--toolchain-id` (path, required, int32): toolchainId
  - `--path` (query): path
- Output: list path `items`; columns `name`, `folder`

## Jira

### `dce amamba jira list-jira-project-issues`

- Summary: List issues of a Jira project bound via a toolchain
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/jira/{jiraId}/projects/{projectId}/issues`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--jira-id` (path, required, int32): jiraId
  - `--project-id` (path, required, int32): projectId
  - `--fuzzy-key` (query): fuzzyKey
  - `--type` (query): type filter used to eliminate issue
  - `--creator` (query): creator used to filter the issues created by this person
  - `--assignee` (query): assignee of issue
  - `--priority` (query): priority of issue
  - `--status` (query): status of issue
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): PageSize per page requested.
  - `--sort-by` (query, default `JIRA_ISSUE_SORT_BY_UNSPECIFIED`, one of: JIRA_ISSUE_SORT_BY_UNSPECIFIED|JIRA_ISSUE_SORT_BY_TYPE|JIRA_ISSUE_SORT_BY_STATUS|JIRA_ISSUE_SORT_BY_PRIORITY|JIRA_ISSUE_SORT_BY_CREATOR|JIRA_ISSUE_SORT_BY_ASSIGNEE|JIRA_ISSUE_SORT_BY_UPDATED): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): OrderBy determines the data list order.
- Output: list path `items`; columns `id`, `assignee`, `creator`, `expand`, `key`, `reporter`; pagination `offset`
- Example: `dce amamba jira list-jira-project-issues --workspace-id <ws> --jira-id <id> --project-id <pid>`

### `dce amamba jira list-jira-projects-search-keywords`

- Summary: List Jira search keywords (assignees, labels) for a project
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/jira/{jiraId}/projects/{projectId}/keywords`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--jira-id` (path, required, int32): jiraId
  - `--project-id` (path, required, int32): projectId
- Output: list path `assignees`; columns `key`, `value`
- Example: `dce amamba jira list-jira-projects-search-keywords --workspace-id <ws> --jira-id <id> --project-id <pid>`

### `dce amamba jira list-workspace-bind-jira-project-list`

- Summary: Jira_ListWorkspaceBindJiraProjectList
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/jira/all_projects`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
- Output: list path `items`; columns `projectId`, `projectName`, `resourceStatus`, `toolchainId`, `toolchainName`

## Management

### `dce amamba management list-jenkins-node-labels`

- Summary: ListJenkinsNodeLabels is same as ListPodTemplates but only return the field label.
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/management/node_labels`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (query): workspaceId
- Output: list path `items`; columns `label`

### `dce amamba management list-pod-templates`

- Summary: List Jenkins agent pod templates (compute resources available to pipelines)
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/management/agents`
- Auth: required
- Body: none
- Flags: none
- Output: list path `agents`; columns `name`, `namespace`, `label`
- Example: `dce amamba management list-pod-templates`

### `dce amamba management restart`

- Summary: Restart restarts the jenkins server deployment.
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/management/restart`
- Auth: required
- Body: none
- Flags: none

## MutilCloudApplication

### `dce amamba mutilcloudapplication list-mutil-cloud-deploy-target`

- Summary: List multi-cloud deploy targets
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/mutil-cloud-deploytargets`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
- Output: list path `items`; columns `cluster`
- Example: `dce amamba mutilcloudapplication list-mutil-cloud-deploy-target --workspace-id <ws>`

## OAMService

### `dce amamba oamservice add-oam-component`

- Summary: OAMService_AddOAMComponent
- HTTP: `POST /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/oam/{name}/components`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): application name

### `dce amamba oamservice batch-update-oam-traits`

- Summary: batch update traits.
- HTTP: `PUT /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/oam/{name}/components/{componentName}/traits`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): application name
  - `--component-name` (path, required): componentName

### `dce amamba oamservice create-oam-application`

- Summary: OAMService_CreateOAMApplication
- HTTP: `POST /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/oam`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId

### `dce amamba oamservice delete-oam-application`

- Summary: OAMService_DeleteOAMApplication
- HTTP: `DELETE /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/oam/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name

### `dce amamba oamservice delete-oam-component`

- Summary: OAMService_DeleteOAMComponent
- HTTP: `DELETE /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/oam/{name}/components/{componentName}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): application name
  - `--component-name` (path, required): componentName

### `dce amamba oamservice delete-oam-trait`

- Summary: OAMService_DeleteOAMTrait
- HTTP: `DELETE /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/oam/{name}/components/{componentName}/traits/{traitType}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): application name
  - `--component-name` (path, required): componentName
  - `--trait-type` (path, required): traitType

### `dce amamba oamservice get-component-properties`

- Summary: get component properties schema json.
- HTTP: `GET /apis/application.amamba.io/v1alpha2/management/components_definition/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name

### `dce amamba oamservice get-oam-application`

- Summary: OAMService_GetOAMApplication
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/oam/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name

### `dce amamba oamservice get-oam-application-json`

- Summary: OAMService_GetOAMApplicationJSON
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/oam/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name

### `dce amamba oamservice get-trait-properties`

- Summary: get trait properties json schema.
- HTTP: `GET /apis/application.amamba.io/v1alpha2/management/traits_definition/{traitType}`
- Auth: required
- Body: none
- Flags:
  - `--trait-type` (path, required): traitType

### `dce amamba oamservice list-application-revisions`

- Summary: List revisions of an application (for rollback)
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/oam/{name}/revisions`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): application name
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): PageSize per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|FIELD_NAME|CREATED_AT|CLUSTER|NAMESPACE): SortBy determines the cluster list order reference.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): OrderBy determines the cluster list order.
- Output: list path `items`; columns `createdAt`, `revisionHash`; pagination `offset`
- Example: `dce amamba applicationservice list-application-revisions --workspace-id <ws> --name my-app`

### `dce amamba oamservice list-component-definitions`

- Summary: list system buildin components.
- HTTP: `GET /apis/application.amamba.io/v1alpha2/management/components_definition`
- Auth: required
- Body: none
- Flags:
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): PageSize per page requested.
- Output: list path `items`; columns `name`, `properties`, `uiSchema`; pagination `offset`

### `dce amamba oamservice list-oam-applications`

- Summary: OAMService_ListOAMApplications
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/oam`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--fuzzy-name` (query): fuzzyName
  - `--status` (query, default `OAM_APPLICATION_PHASE_UNSPECIFIED`, one of: OAM_APPLICATION_PHASE_UNSPECIFIED|OAM_APPLICATION_PHASE_STARTING|OAM_APPLICATION_PHASE_RENDERING|OAM_APPLICATION_PHASE_POLICY_GENERATING|OAM_APPLICATION_PHASE_RUNNING_WORKFLOW|OAM_APPLICATION_PHASE_WORKFLOW_SUSPENDING|OAM_APPLICATION_PHASE_WORKFLOW_TERMINATED|OAM_APPLICATION_PHASE_WORKFLOW_FAILED|OAM_APPLICATION_PHASE_RUNNING|OAM_APPLICATION_PHASE_UNHEALTHY|OAM_APPLICATION_PHASE_DELETING): - OAM_APPLICATION_PHASE_STARTING: ApplicationStarting means the app is preparing for reconcile
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): PageSize per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|FIELD_NAME|CREATED_AT|CLUSTER|NAMESPACE): SortBy determines the cluster list order reference.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): OrderBy determines the cluster list order.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`; pagination `offset`

### `dce amamba oamservice list-trait-definitions`

- Summary: list system buildin traits.
- HTTP: `GET /apis/application.amamba.io/v1alpha2/management/traits_definition`
- Auth: required
- Body: none
- Flags:
  - `--component-type` (query): componentType
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): PageSize per page requested.
- Output: list path `items`; columns `name`, `properties`, `uiSchema`; pagination `offset`

### `dce amamba oamservice rollback-application-revision`

- Summary: Roll back an application to a previous revision
- HTTP: `POST /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/oam/{name}/revisions/{revisionHash}:rollback`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
  - `--revision-hash` (path, required): revisionHash
- Example: `dce amamba applicationservice rollback-application-revision --workspace-id <ws> --name my-app --revision-id <rev>`

### `dce amamba oamservice update-oam-application`

- Summary: update app alias and description.
- HTTP: `PUT /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/oam/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name

### `dce amamba oamservice update-oam-application-json`

- Summary: OAMService_UpdateOAMApplicationJSON
- HTTP: `PUT /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/oam/{name}/json`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name

### `dce amamba oamservice update-oam-component`

- Summary: OAMService_UpdateOAMComponent
- HTTP: `PUT /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/oam/{name}/components/{componentName}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): application name
  - `--component-name` (path, required): componentName

## OLMService

### `dce amamba olmservice create-cluster-resource`

- Summary: OLMService_CreateClusterResource
- HTTP: `POST /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/operators/{operator}/resources`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
  - `--operator` (path, required): operator

### `dce amamba olmservice create-resource`

- Summary: OLMService_CreateResource
- HTTP: `POST /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/operators/{operator}/resources`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--operator` (path, required): operator

### `dce amamba olmservice delete-cluster-resource`

- Summary: OLMService_DeleteClusterResource
- HTTP: `DELETE /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/operators/{operator}/resources/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
  - `--operator` (path, required): operator
  - `--name` (path, required): name

### `dce amamba olmservice delete-resource`

- Summary: OLMService_DeleteResource
- HTTP: `DELETE /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/operators/{operator}/resources/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--operator` (path, required): operator
  - `--name` (path, required): name

### `dce amamba olmservice get-resource-json`

- Summary: OLMService_GetResourceJSON
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/operators/{operator}/resources/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--operator` (path, required): operator
  - `--name` (path, required): name
  - `--payload.cluster` (query): Cluster represents which cluster the CustomResource belongs to.
  - `--payload.group` (query): Group represents the resource group of CustomResource.
  - `--payload.version` (query): Version represents the resource version of CustomResource.
  - `--payload.namespace` (query): Namespace represents which namespace the CustomResource belongs to.
  - `--payload.resource` (query): Resource represents the resource name of CustomResource, which is plural.
  - `--payload.name` (query): Name represents the name of CustomResource.

### `dce amamba olmservice list-collection-resources`

- Summary: OLMService_ListCollectionResources
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/operators/{operator}/collectionresources`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster is the cluster of the operator. is required and should same with `payload.cluster`
  - `--namespace` (path, required): namespace is the namespace of the operator resource. is required and should same with `payload.namespace`
  - `--operator` (path, required): operator
  - `--payload.cluster` (query): payload.cluster
  - `--payload.namespace` (query): payload.namespace
  - `--payload.name` (query): payload.name
  - `--payload.group` (query): payload.group
  - `--payload.version` (query): payload.version
  - `--payload.resource` (query): payload.resource
  - `--payload.csv-name` (query): payload.csvName
  - `--payload.csv-namespace` (query): payload.csvNamespace
  - `--payload.sort-dir` (query, default `DESC`, one of: DESC|ASC): - DESC: Desc stands for descending order.
  - `--payload.sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|FIELD_NAME|CREATED_AT|CLUSTER|NAMESPACE): - SORT_BY_UNSPECIFIED: Unspecified is default, no sorting.
- Output: list path `items`

### `dce amamba olmservice list-events`

- Summary: OLMService_ListEvents
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/operators/{operator}/events`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster is the cluster of the operator. is required and should same with `payload.cluster`
  - `--namespace` (path, required): namespace is the namespace of the operator resource. is required and should same with `payload.namespace`
  - `--operator` (path, required): operator
  - `--payload.cluster` (query): cluster represents the name of deployment belongs to.
  - `--payload.namespace` (query): Namespace represents which namespace the deployment belongs to.
  - `--payload.kind` (query, default `KIND_UNSPECIFIED`, one of: KIND_UNSPECIFIED|Deployment|StatefulSet|DaemonSet|Pod|Service|Ingress|Job|CronJob|HorizontalPodAutoscaler|ReplicaSet|CronHPA|PersistentVolumeClaim|GroupVersionResource): Kind represents what type of event is needed.
  - `--payload.kind-name` (query): The name of involvedObject.
  - `--payload.name` (query): Name stands for event name, used for fuzzy search.
  - `--payload.page` (query, int32): Page requested.
  - `--payload.page-size` (query, int32): Size per page requested.
  - `--payload.sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|FIELD_NAME|CREATED_AT|CLUSTER|NAMESPACE): SortBy determines the event list order reference.
  - `--payload.sort-dir` (query, default `DESC`, one of: DESC|ASC): OrderBy determines the event list order.
  - `--payload.type` (query): Type is used for query, showing events of specified type.
  - `--payload.group` (query): resource group,used when the kind type is GroupVersionResource.
  - `--payload.version` (query): resource version,used when the kind type is GroupVersionResource.
  - `--payload.resource` (query): resource name,used when the kind type is GroupVersionResource.
- Output: list path `items`; columns `type`, `lastTimestamp`, `message`, `reason`

### `dce amamba olmservice list-resources`

- Summary: OLMService_ListResources
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/operators/{operator}/resources`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster is the cluster of the operator. is required and should same with `payload.cluster`
  - `--namespace` (path, required): namespace is the namespace of the operator resource. is required and should same with `payload.namespace`
  - `--operator` (path, required): operator
  - `--payload.cluster` (query): Cluster represents which cluster the CustomResources belongs to.
  - `--payload.group` (query): Group represents the resource group of CustomResources.
  - `--payload.version` (query): Version represents the resource version of CustomResources.
  - `--payload.namespace` (query): Namespace represents which namespace the CustomResources belongs to.
  - `--payload.resource` (query): Resource represents the resource name of CustomResources, which is plural.
  - `--payload.page` (query, int32): Page is current page.
  - `--payload.page-size` (query, int32): Size is the data number shown per page.
  - `--payload.name` (query): name is used for query.
  - `--payload.label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--payload.field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--payload.fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--payload.show-detail` (query): ShowDetail is the presentation details, including metadata, spec, and status
  - `--payload.csv-name` (query): list cr created by crd in csv
  - `--payload.csv-namespace` (query): payload.csvNamespace
  - `--payload.sort-dir` (query, default `DESC`, one of: DESC|ASC): - DESC: Desc stands for descending order.
  - `--payload.sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|FIELD_NAME|CREATED_AT|CLUSTER|NAMESPACE): - SORT_BY_UNSPECIFIED: Unspecified is default, no sorting.
- Output: list path `items`; columns `name`, `namespace`, `kind`, `creationTimestamp`, `apiVersion`, `data`

### `dce amamba olmservice update-cluster-resource`

- Summary: OLMService_UpdateClusterResource
- HTTP: `PUT /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/operators/{operator}/resources/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
  - `--operator` (path, required): operator
  - `--name` (path, required): name

### `dce amamba olmservice update-resource`

- Summary: OLMService_UpdateResource
- HTTP: `PUT /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/operators/{operator}/resources/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--operator` (path, required): operator
  - `--name` (path, required): name

## Pipelines

### `dce amamba pipelines cancel-pipeline-run`

- Summary: Cancel an in-progress pipeline run
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/runs/{runId}:cancel`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline will be created.
  - `--name` (path, required): The name of the pipeline.
  - `--run-id` (path, required, int64): The id of the build.
- Output: list path `parameters`; columns `name`, `type`, `defaultValue`, `description`, `value`
- Example: `dce amamba pipelines cancel-pipeline-run --workspace-id <ws> --pipeline my-pipeline --run 42`

### `dce amamba pipelines create-global-template`

- Summary: Pipelines_CreateGlobalTemplate
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/templates`
- Auth: required
- Body: required
- Flags: none
- Output: list path `parameters`; columns `name`, `type`, `defaultValue`, `description`, `displayName`

### `dce amamba pipelines create-group`

- Summary: Pipelines_CreateGroup
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/groups`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId

### `dce amamba pipelines create-pipeline`

- Summary: Create a new pipeline (Jenkins-based)
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline will be created.
- Output: list path `parameters`; columns `name`, `type`, `defaultValue`, `description`, `redact`
- Example: `dce amamba pipelines create-pipeline --workspace-id <ws> --name my-pipeline --file pipeline.yaml`

### `dce amamba pipelines create-pipeline-volume`

- Summary: Create a persistent volume for pipeline workspaces
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/volumes`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline will be created.
  - `--name` (path, required): The name of the pipeline.
- Example: `dce amamba pipelines create-pipeline-volume --workspace-id <ws> --name cache --size 10Gi`

### `dce amamba pipelines create-run-access-token`

- Summary: Pipelines_CreateRunAccessToken
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/runs/{runId}/access_token`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline created.
  - `--name` (path, required): The name of the pipeline.
  - `--run-id` (path, required, int64): runId

### `dce amamba pipelines create-template`

- Summary: Create a new application template
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/templates`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
- Output: list path `parameters`; columns `name`, `type`, `defaultValue`, `description`, `displayName`
- Example: `dce amamba management create-template --workspace-id <ws> --name my-template --file template.yaml`

### `dce amamba pipelines delete-global-template`

- Summary: Pipelines_DeleteGlobalTemplate
- HTTP: `DELETE /apis/pipeline.amamba.io/v1alpha1/templates/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name

### `dce amamba pipelines delete-group`

- Summary: Pipelines_DeleteGroup
- HTTP: `DELETE /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/groups/{id}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--id` (path, required, int32): id

### `dce amamba pipelines delete-pipeline`

- Summary: Delete a pipeline
- HTTP: `DELETE /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline created.
  - `--name` (path, required): The name of the pipeline.
- Example: `dce amamba pipelines delete-pipeline --workspace-id <ws> --name my-pipeline`

### `dce amamba pipelines delete-pipeline-volume`

- Summary: Pipelines_DeletePipelineVolume
- HTTP: `DELETE /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/volumes/{claimName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline will be created.
  - `--name` (path, required): The name of the pipeline.
  - `--claim-name` (path, required): DEPRECATED: Name of the PVC. If it was empty, the system will find the generated one.

### `dce amamba pipelines delete-template`

- Summary: Delete a template
- HTTP: `DELETE /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/templates/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
- Example: `dce amamba management delete-template --workspace-id <ws> --name my-template`

### `dce amamba pipelines disable-template`

- Summary: Disable a template
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/templates/{name}:disable`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): name
- Example: `dce amamba management disable-template --workspace-id <ws> --name my-template`

### `dce amamba pipelines enable-template`

- Summary: Enable a template for use in the workspace
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/templates/{name}:enable`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): name
- Example: `dce amamba management enable-template --workspace-id <ws> --name my-template`

### `dce amamba pipelines get-branches`

- Summary: Pipelines_GetBranches
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/branches`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline created.
  - `--name` (path, required): The name of the pipeline.
- Output: list path `branches`; columns `branchName`, `commit`, `disabled`, `lastMessage`, `state`, `updatedAt`

### `dce amamba pipelines get-build-parameter`

- Summary: Get a build parameter by name
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/parameters`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline created.
  - `--name` (path, required): The name of the pipeline.
- Output: list path `parameters`; columns `name`, `type`, `defaultValue`, `description`, `redact`
- Example: `dce amamba globalbuildparameter get-build-parameter --name REGISTRY`

### `dce amamba pipelines get-code-analyze-result`

- Summary: Pipelines_GetCodeAnalyzeResult
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/code_analyze_result`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name

### `dce amamba pipelines get-git-parameter-value`

- Summary: Pipelines_GetGITParameterValue
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/git-parameter/{parameterName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
  - `--parameter-name` (path, required): parameterName
- Output: list path `items`; columns `name`, `value`

### `dce amamba pipelines get-global-template`

- Summary: Pipelines_GetGlobalTemplate
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/templates/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name
  - `--raw` (query): raw specifies whether return the original spec instead of parsed json only
- Output: list path `parameters`; columns `name`, `type`, `defaultValue`, `description`, `displayName`

### `dce amamba pipelines get-jenkins-json`

- Summary: Pipelines_GetJenkinsJSON
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/jenkinsjson`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline will be created.
  - `--name` (path, required): The name of the pipeline.

### `dce amamba pipelines get-junit-report`

- Summary: Pipelines_GetJunitReport
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/runs/{runId}/junit_report`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
  - `--run-id` (path, required, int64): runId
  - `--result` (query, default `JUNIT_RESULT_UNSPECIFIED`, one of: JUNIT_RESULT_UNSPECIFIED|JUNIT_RESULT_PASSED|JUNIT_RESULT_SKIPPED|JUNIT_RESULT_FAILED|JUNIT_RESULT_FIXED|JUNIT_RESULT_REGRESSION|JUNIT_RESULT_EXISTING_FAILED): result
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `name`, `duration`; pagination `offset`

### `dce amamba pipelines get-junit-report-summary`

- Summary: Pipelines_GetJunitReportSummary
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/runs/{runId}/junit_summary`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
  - `--run-id` (path, required, int64): runId

### `dce amamba pipelines get-pipeline`

- Summary: Get a pipeline's configuration
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline created.
  - `--name` (path, required): The name of the pipeline.
- Output: list path `parameters`; columns `name`, `type`, `defaultValue`, `description`, `redact`
- Example: `dce amamba pipelines get-pipeline --workspace-id <ws> --name my-pipeline`

### `dce amamba pipelines get-pipeline-artifacts`

- Summary: List artifacts produced by a pipeline run
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/runs/{runId}/artifacts`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
  - `--run-id` (path, required, int64): runId
- Output: list path `artifacts`; columns `name`, `id`, `class`, `downloadable`, `path`, `size`
- Example: `dce amamba pipelines get-pipeline-artifacts --workspace-id <ws> --pipeline my-pipeline --run 42`

### `dce amamba pipelines get-pipeline-artifacts-download-token`

- Summary: Pipelines_GetPipelineArtifactsDownloadToken
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{pipeline}/token`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--pipeline` (path, required): pipeline

### `dce amamba pipelines get-pipeline-run`

- Summary: Get a single pipeline run's metadata
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/runs/{runId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline will be created.
  - `--name` (path, required): The name of the pipeline.
  - `--run-id` (path, required, int64): The id of the build.
- Output: list path `parameters`; columns `name`, `type`, `defaultValue`, `description`, `value`
- Example: `dce amamba pipelines get-pipeline-run --workspace-id <ws> --pipeline my-pipeline --run 42`

### `dce amamba pipelines get-pipeline-run-log`

- Summary: Get a pipeline run's full log
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/runs/{runId}/log`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline created.
  - `--name` (path, required): The name of the pipeline.
  - `--run-id` (path, required, int64): The id of pipeline run
  - `--start` (query): start
- Example: `dce amamba pipelines get-pipeline-run-log --workspace-id <ws> --pipeline my-pipeline --run 42`

### `dce amamba pipelines get-pipeline-run-nodes`

- Summary: Pipelines_GetPipelineRunNodes
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/runs/{runId}/nodes`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline created.
  - `--name` (path, required): The name of the pipeline.
  - `--run-id` (path, required, int64): The id of pipeline run
- Output: list path `nodes`; columns `type`, `id`, `displayName`, `durationInMillis`, `firstParent`, `restartable`

### `dce amamba pipelines get-pipeline-run-parameters`

- Summary: Get the parameters used by a pipeline run
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/runs/{runId}/parameters`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
  - `--run-id` (path, required, int64): runId
- Output: list path `items`; columns `name`, `type`, `defaultValue`, `description`, `value`
- Example: `dce amamba pipelines get-pipeline-run-parameters --workspace-id <ws> --pipeline my-pipeline --run 42`

### `dce amamba pipelines get-pipeline-run-step-log`

- Summary: Get a single step's log from a pipeline run
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/runs/{runId}/nodes/{nodeId}/steps/{stepId}/log`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline created.
  - `--name` (path, required): The name of the pipeline.
  - `--run-id` (path, required, int64): The id of pipeline run
  - `--node-id` (path, required, int64): The node of pipeline run
  - `--step-id` (path, required, int64): The step of pipeline run
  - `--start` (query): The start location of log
- Example: `dce amamba pipelines get-pipeline-run-step-log --workspace-id <ws> --pipeline my-pipeline --run 42 --step build`

### `dce amamba pipelines get-pipeline-run-steps`

- Summary: Pipelines_GetPipelineRunSteps
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/runs/{runId}/nodes/{nodeId}/steps`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline created.
  - `--name` (path, required): The name of the pipeline.
  - `--run-id` (path, required, int64): The id of pipeline run
  - `--node-id` (path, required, int64): The node of pipeline run
- Output: list path `steps`; columns `type`, `id`, `displayDescription`, `displayName`, `durationInMillis`, `result`

### `dce amamba pipelines get-pipeline-volume`

- Summary: Pipelines_GetPipelineVolume
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/volumes/{claimName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline will be created.
  - `--name` (path, required): The name of the pipeline.
  - `--claim-name` (path, required): DEPRECATED: Name of the PVC. If it was empty, the system will find the generated one.

### `dce amamba pipelines get-scanlog-of-multi-branch-pipeline`

- Summary: Pipelines_GetScanlogOfMultiBranchPipeline
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/scanlog`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline created.
  - `--name` (path, required): The name of the pipeline.

### `dce amamba pipelines get-template`

- Summary: Get a template's definition
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/templates/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
  - `--raw` (query): raw specifies whether return the original spec instead of parsed json only
- Output: list path `parameters`; columns `name`, `type`, `defaultValue`, `description`, `displayName`
- Example: `dce amamba management get-template --workspace-id <ws> --name my-template`

### `dce amamba pipelines jenkinsfile-to-json`

- Summary: Pipelines_JenkinsfileToJSON
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}:toJson`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name

### `dce amamba pipelines json-to-jenkinsfile`

- Summary: Pipelines_JSONToJenkinsfile
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}:toJenkinsfile`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name

### `dce amamba pipelines list-approval-permission-users`

- Summary: Pipelines_ListApprovalPermissionUsers
- HTTP: `GET /apis/amamba.io/v1alpha1/workspaces/{workspaceId}/approvalusers`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
- Output: list path `items`; columns `name`, `type`

### `dce amamba pipelines list-git-references`

- Summary: Pipelines_ListGitReferences
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/gitreferences`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--repo.toolchain-id` (query, int32): repo.toolchainId
  - `--repo.url` (query): repo.url
  - `--repo.credential-id` (query): repo.credentialId
  - `--repo.resource-id` (query, int32): repo.resourceId
- Output: list path `branchs`

### `dce amamba pipelines list-global-templates`

- Summary: List globally-shared application templates
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/templates`
- Auth: required
- Body: none
- Flags:
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): PageSize per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|FIELD_NAME|CREATED_AT|CLUSTER|NAMESPACE): SortBy determines the cluster list order reference.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): SortDir determines the cluster list order.
  - `--type` (query, default `TEMPLATE_TYPE_UNSPECIFIED`, one of: TEMPLATE_TYPE_UNSPECIFIED|TEMPLATE_TYPE_BUILTIN|TEMPLATE_TYPE_CUSTOM): Type filters the type of response templates.
  - `--metadata-only` (query): MetadataOnly indicates whether to return parameter definitions and jenkinsfile.
  - `--fuzzy-name` (query): template name
  - `--enabled` (query): enabled
- Output: list path `items`; columns `name`, `type`, `createdAt`, `description`, `enabled`, `global`; pagination `offset`
- Example: `dce amamba management list-global-templates`

### `dce amamba pipelines list-groups`

- Summary: Pipelines_ListGroups
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/groups`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--fuzzy-name` (query): fuzzyName
- Output: list path `items`; columns `name`, `id`, `workspaceId`

### `dce amamba pipelines list-pipeline-runs`

- Summary: List historical pipeline runs
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/runs`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline created in.
  - `--name` (path, required): The name of the pipeline.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): PageSize per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|CREATED_AT|PIPELINE_RUN_ID|START_AT): SortBy determines the cluster list order reference.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): OrderBy determines the cluster list order.
  - `--search-run-id` (query, int64): search is used to accurately query the id of the pipeline running record.
  - `--state` (query, default `STATUS_UNSPECIFIED`, one of: STATUS_UNSPECIFIED|QUEUE|RUNNING|SUCCESS|FAILED|CANCELED|ERROR|NOT_BUILT|PAUSED|SKIPPED|UNKNOWN|UNSTABLE): filter by state
  - `--trigger-type` (query, default `TYPE_UNSPECIFIED`, one of: TYPE_UNSPECIFIED|MANUAL|SCHEDULE|SCMCHANGE|WEBHOOK|BRANCH_INDEX): filter by trigger type
  - `--started-by` (query): filter by run started_by
  - `--description` (query): filter by description keyword
  - `--start-time-from` (query, date-time): filter by start time range
  - `--start-time-to` (query, date-time): startTimeTo
- Output: list path `items`; columns `name`, `createdAt`, `description`, `duration`, `runId`, `startAt`; pagination `offset`
- Example: `dce amamba pipelines list-pipeline-runs --workspace-id <ws> --pipeline my-pipeline`

### `dce amamba pipelines list-pipeline-volumes`

- Summary: List pipeline workspace volumes (PVCs)
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/volumes`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline will be created.
  - `--name` (path, required): The name of the pipeline.
- Output: list path `items`; columns `name`, `status.phase`, `allowVolumeExpansion`, `claimName`, `workspaceId`
- Example: `dce amamba pipelines list-pipeline-volumes --workspace-id <ws>`

### `dce amamba pipelines list-pipelines`

- Summary: List Jenkins pipelines in a workspace
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline created.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): PageSize per page requested.
  - `--sort-by` (query, default `PIPELINE_SORT_BY_UNSPECIFIED`, one of: PIPELINE_SORT_BY_UNSPECIFIED|PIPELINE_FIELD_NAME|PIPELINE_CREATED_AT|PIPELINE_LAST_RUN_TIME): SortBy determines the pipeline list order reference.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): OrderBy determines the cluster list order.
  - `--search-name` (query): search is used to obfuscate the names in the query pipeline.
  - `--search-build-type` (query, default `PIPELINE_TYPE_UNSPECIFIED`, one of: PIPELINE_TYPE_UNSPECIFIED|PIPELINE_TYPE_CUSTOM|PIPELINE_TYPE_SCM|PIPELINE_TYPE_TEMPLATE|PIPELINE_TYPE_MULTI_BRANCH): Search the build type in the query pipeline.
  - `--group.id` (query, int32): If not fill it, query data without grouping.
  - `--weather` (query): - PIPELINE_WEATHER_SUNNY: No recent builds failed.
  - `--last-run-state` (query, default `STATUS_UNSPECIFIED`, one of: STATUS_UNSPECIFIED|QUEUE|RUNNING|SUCCESS|FAILED|CANCELED|ERROR|NOT_BUILT|PAUSED|SKIPPED|UNKNOWN|UNSTABLE): - CANCELED: CANCELED indicates the run is aborted by user.
  - `--disabled` (query): disabled
- Output: list path `items`; columns `name`, `type`, `createdAt`, `description`, `disabled`, `isRelease`; pagination `offset`
- Example:

```
dce amamba pipelines list-pipelines --workspace-id <ws>
dce amamba pipelines list-pipelines --workspace-id <ws> --name build- -o json
```

### `dce amamba pipelines list-templates`

- Summary: List application templates available in a workspace
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/templates`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): PageSize per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|FIELD_NAME|CREATED_AT|CLUSTER|NAMESPACE): SortBy determines the cluster list order reference.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): SortDir determines the cluster list order.
  - `--type` (query, default `TEMPLATE_TYPE_UNSPECIFIED`, one of: TEMPLATE_TYPE_UNSPECIFIED|TEMPLATE_TYPE_BUILTIN|TEMPLATE_TYPE_CUSTOM): Type filters the type of response templates.
  - `--metadata-only` (query): MetadataOnly indicates whether to return parameter definitions and jenkinsfile.
  - `--fuzzy-name` (query): template name
  - `--global` (query): global
- Output: list path `items`; columns `name`, `type`, `createdAt`, `description`, `enabled`, `global`; pagination `offset`
- Example: `dce amamba management list-templates --workspace-id <ws>`

### `dce amamba pipelines patch-pipeline-parameters`

- Summary: Update parameters of a pipeline run mid-flight
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/parameters`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
- Output: list path `parameters`; columns `name`, `type`, `defaultValue`, `description`, `redact`
- Example: `dce amamba pipelines patch-pipeline-parameters --workspace-id <ws> --pipeline my-pipeline --run 42 --file params.json`

### `dce amamba pipelines replay-pipeline-run`

- Summary: Replay a pipeline run from scratch
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/runs/{runId}:replay`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline will be created.
  - `--name` (path, required): The name of the pipeline.
  - `--run-id` (path, required, int64): The id of the build.
- Output: list path `parameters`; columns `name`, `type`, `defaultValue`, `description`, `value`
- Example: `dce amamba pipelines replay-pipeline-run --workspace-id <ws> --pipeline my-pipeline --run 42`

### `dce amamba pipelines replicate-pipeline`

- Summary: Copy a pipeline (optionally into another workspace)
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines:replicate`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline will be created.
- Output: list path `parameters`; columns `name`, `type`, `defaultValue`, `description`, `redact`
- Example: `dce amamba pipelines replicate-pipeline --workspace-id <ws> --name src --new-name dst`

### `dce amamba pipelines restart-pipeline-run-node`

- Summary: Restart a single node (stage) in a pipeline run
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/runs/{runId}/nodes/{nodeId}:restart`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline created.
  - `--name` (path, required): The name of the pipeline.
  - `--run-id` (path, required, int64): runId
  - `--node-id` (path, required, int64): The node of pipeline run, the node type must be STAGE
- Example: `dce amamba pipelines restart-pipeline-run-node --workspace-id <ws> --pipeline my-pipeline --run 42 --node stage-1`

### `dce amamba pipelines scan-multi-branch-pipeline`

- Summary: Pipelines_ScanMultiBranchPipeline
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/scan`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline created.
  - `--name` (path, required): The name of the pipeline.

### `dce amamba pipelines submit-input-to-abort`

- Summary: Pipelines_SubmitInputToAbort
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/runs/{runId}/nodes/{nodeId}/steps/{stepId}:abort`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline created.
  - `--name` (path, required): The name of the pipeline.
  - `--run-id` (path, required, int64): The id of pipeline run
  - `--node-id` (path, required, int64): The node of pipeline run
  - `--step-id` (path, required, int64): The step of pipeline run

### `dce amamba pipelines submit-input-to-proceed`

- Summary: Pipelines_SubmitInputToProceed
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/runs/{runId}/nodes/{nodeId}/steps/{stepId}:process`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline created.
  - `--name` (path, required): The name of the pipeline.
  - `--run-id` (path, required, int64): The id of pipeline run
  - `--node-id` (path, required, int64): The node of pipeline run
  - `--step-id` (path, required, int64): The step of pipeline run

### `dce amamba pipelines sync-pipeline`

- Summary: Force a pipeline sync from the underlying Jenkins
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}:sync`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline is created.
  - `--name` (path, required): The name of the pipeline.
- Example: `dce amamba pipelines sync-pipeline --workspace-id <ws> --name my-pipeline`

### `dce amamba pipelines toggle-pipeline`

- Summary: Enable or disable a pipeline
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}:toggle`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline created.
  - `--name` (path, required): The name of the pipeline.
- Example: `dce amamba pipelines toggle-pipeline --workspace-id <ws> --name my-pipeline --enabled true`

### `dce amamba pipelines update-global-template`

- Summary: Pipelines_UpdateGlobalTemplate
- HTTP: `PUT /apis/pipeline.amamba.io/v1alpha1/templates/{name}`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): name
- Output: list path `parameters`; columns `name`, `type`, `defaultValue`, `description`, `displayName`

### `dce amamba pipelines update-jenkins-json`

- Summary: Pipelines_UpdateJenkinsJSON
- HTTP: `PUT /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/jenkinsjson`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline will be created.
  - `--name` (path, required): The name of the pipeline.

### `dce amamba pipelines update-pipeline`

- Summary: Update a pipeline's configuration
- HTTP: `PUT /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline will be created.
  - `--name` (path, required): The name of the pipeline.
- Output: list path `parameters`; columns `name`, `type`, `defaultValue`, `description`, `redact`
- Example: `dce amamba pipelines update-pipeline --workspace-id <ws> --name my-pipeline --file pipeline.yaml`

### `dce amamba pipelines update-pipeline-jenkinsfile`

- Summary: Pipelines_UpdatePipelineJenkinsfile
- HTTP: `PUT /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/jenkinsfile`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline will be created.
  - `--name` (path, required): The name of the pipeline.
- Output: list path `parameters`; columns `name`, `type`, `defaultValue`, `description`, `redact`

### `dce amamba pipelines update-pipeline-name`

- Summary: Rename a pipeline
- HTTP: `PUT /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/name`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline will be created.
  - `--name` (path, required): The name of the pipeline.
- Output: list path `parameters`; columns `name`, `type`, `defaultValue`, `description`, `redact`
- Example: `dce amamba pipelines update-pipeline-name --workspace-id <ws> --name old-name --new-name new-name`

### `dce amamba pipelines update-pipeline-volume`

- Summary: Pipelines_UpdatePipelineVolume
- HTTP: `PUT /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/pipelines/{name}/volumes/{claimName}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): The scope where the pipeline will be created.
  - `--name` (path, required): The name of the pipeline.
  - `--claim-name` (path, required): DEPRECATED: Name of PVC, If it was empty, the system will find the generated one.

### `dce amamba pipelines update-template`

- Summary: Update a template
- HTTP: `PUT /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/templates/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
- Output: list path `parameters`; columns `name`, `type`, `defaultValue`, `description`, `displayName`
- Example: `dce amamba management update-template --workspace-id <ws> --name my-template --file template.yaml`

## PluginService

### `dce amamba pluginservice create-pipeline-plugin`

- Summary: PluginService_CreatePipelinePlugin
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/plugins`
- Auth: required
- Body: required
- Flags: none

### `dce amamba pluginservice delete-pipeline-plugin`

- Summary: PluginService_DeletePipelinePlugin
- HTTP: `DELETE /apis/pipeline.amamba.io/v1alpha1/plugins/{name}/versions/{version}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name
  - `--version` (path, required): version

### `dce amamba pluginservice disable-pipeline-plugin`

- Summary: PluginService_DisablePipelinePlugin
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/plugins/{name}/versions/{version}/disable`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): name
  - `--version` (path, required): version

### `dce amamba pluginservice enable-pipeline-plugin`

- Summary: PluginService_EnablePipelinePlugin
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/plugins/{name}/versions/{version}/enable`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): name
  - `--version` (path, required): version

### `dce amamba pluginservice get-pipeline-plugin`

- Summary: PluginService_GetPipelinePlugin
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/plugins/{name}/versions/{version}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name
  - `--version` (path, required): version

### `dce amamba pluginservice get-workspace-pipeline-plugin`

- Summary: PluginService_GetWorkspacePipelinePlugin
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/plugins/{name}/versions/{version}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
  - `--version` (path, required): version

### `dce amamba pluginservice list-pipeline-plugin`

- Summary: PluginService_ListPipelinePlugin
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/plugins`
- Auth: required
- Body: none
- Flags:
  - `--fuzzy-name` (query): fuzzyName
  - `--version` (query): version
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--only-metadata` (query): onlyMetadata
  - `--show-hidden` (query): showHidden
  - `--source` (query, default `PluginSource_UNSPECIFIED`, one of: PluginSource_UNSPECIFIED|PluginSource_BUILTIN|PluginSource_CUSTOM): source
  - `--category` (query, default `PluginCategory_UNSPECIFIED`, one of: PluginCategory_UNSPECIFIED|PluginCategory_Others|PluginCategory_Build|PluginCategory_Test|PluginCategory_Security|PluginCategory_Release|PluginCategory_Deploy|PluginCategory_Command|PluginCategory_General|PluginCategory_Repository|PluginCategory_Quality): category
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|FIELD_NAME|CREATED_AT|CLUSTER|NAMESPACE): - SORT_BY_UNSPECIFIED: Unspecified is default, no sorting.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): - DESC: Desc stands for descending order.
  - `--status` (query, default `PluginStatus_UNSPECIFIED`, one of: PluginStatus_UNSPECIFIED|PluginStatus_Enable|PluginStatus_Disable): status
- Output: list path `items`; columns `metadata.name`, `kind`, `apiVersion`, `raw`; pagination `offset`

### `dce amamba pluginservice list-workspace-pipeline-plugin`

- Summary: PluginService_ListWorkspacePipelinePlugin
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/plugins`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--fuzzy-name` (query): fuzzyName
  - `--version` (query): version
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
  - `--only-metadata` (query): onlyMetadata
  - `--show-hidden` (query): showHidden
  - `--source` (query, default `PluginSource_UNSPECIFIED`, one of: PluginSource_UNSPECIFIED|PluginSource_BUILTIN|PluginSource_CUSTOM): source
  - `--category` (query, default `PluginCategory_UNSPECIFIED`, one of: PluginCategory_UNSPECIFIED|PluginCategory_Others|PluginCategory_Build|PluginCategory_Test|PluginCategory_Security|PluginCategory_Release|PluginCategory_Deploy|PluginCategory_Command|PluginCategory_General|PluginCategory_Repository|PluginCategory_Quality): category
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|FIELD_NAME|CREATED_AT|CLUSTER|NAMESPACE): - SORT_BY_UNSPECIFIED: Unspecified is default, no sorting.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): - DESC: Desc stands for descending order.
  - `--status` (query, default `PluginStatus_UNSPECIFIED`, one of: PluginStatus_UNSPECIFIED|PluginStatus_Enable|PluginStatus_Disable): status
- Output: list path `items`; columns `metadata.name`, `kind`, `apiVersion`, `raw`; pagination `offset`

### `dce amamba pluginservice update-pipeline-plugin`

- Summary: PluginService_UpdatePipelinePlugin
- HTTP: `PUT /apis/pipeline.amamba.io/v1alpha1/plugins/{name}/versions/{version}`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): name
  - `--version` (path, required): version

## Policy

### `dce amamba policy get-override-policy`

- Summary: Get a single override policy
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/kairship/{instance}/kairship_namespaces/{namespace}/overridepolicies/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--instance` (path, required): instance is the instance name of the application. is required and should same with `payload.instance`
  - `--namespace` (path, required): namespace is the namespace of the application. is required and should same with `payload.namespace`
  - `--name` (path, required): name
  - `--payload.instance` (query): Instance represents which instance the override belongs to.
  - `--payload.namespace` (query): Namespace is the metadata.namespace of the referenced OverridePolicy.
  - `--payload.name` (query): name represents for the resource name
- Example: `dce amamba gitops get-override-policy --workspace-id <ws> --instance <i> --namespace <ns> --name <name>`

### `dce amamba policy get-propagation-policy`

- Summary: Get a single propagation policy
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/kairship/{instance}/kairship_namespaces/{namespace}/propagationpolicies/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--instance` (path, required): instance is the instance name of the application. is required and should same with `payload.instance`
  - `--namespace` (path, required): namespace is the namespace of the application. is required and should same with `payload.namespace`
  - `--name` (path, required): name
  - `--payload.instance` (query): Instance represents which instance the propagation belongs to.
  - `--payload.namespace` (query): Namespace is the metadata.namespace of the referenced PropagationPolicy.
  - `--payload.name` (query): name represents for the resource name
- Example: `dce amamba gitops get-propagation-policy --workspace-id <ws> --instance <i> --namespace <ns> --name <name>`

### `dce amamba policy list-override-policies`

- Summary: List GitOps override policies for a kairship instance
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/kairship/{instance}/kairship_namespaces/{namespace}/overridepolicies`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--instance` (path, required): instance is the instance name of the application. is required and should same with `payload.instance`
  - `--namespace` (path, required): namespace is the namespace of the application. is required and should same with `payload.namespace`
  - `--payload.instance` (query): karmada instance
  - `--payload.namespace` (query): Namespace is the metadata.namespace of the referenced pod.
  - `--payload.page` (query, int32): Page requested.
  - `--payload.page-size` (query, int32): Size per page requested.
  - `--payload.kind` (query): The kind of service.
  - `--payload.kind-name` (query): Name of kind.
  - `--payload.name` (query): Name stands for service name, used for fuzzy search.
  - `--payload.sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--payload.sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the data list order.
  - `--payload.api-version` (query): payload.apiVersion
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`
- Example: `dce amamba gitops list-override-policies --workspace-id <ws> --instance <i> --namespace <ns>`

### `dce amamba policy list-propagation-policies`

- Summary: List GitOps propagation policies for a kairship instance
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/kairship/{instance}/kairship_namespaces/{namespace}/propagationpolicies`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--instance` (path, required): instance is the instance name of the application. is required and should same with `payload.instance`
  - `--namespace` (path, required): namespace is the namespace of the application. is required and should same with `payload.namespace`
  - `--payload.instance` (query): karmada instance
  - `--payload.namespace` (query): Namespace is the metadata.namespace of the referenced pod.
  - `--payload.page` (query, int32): Page requested.
  - `--payload.page-size` (query, int32): Size per page requested.
  - `--payload.kind` (query): The kind of service.
  - `--payload.kind-name` (query): Name of kind.
  - `--payload.name` (query): Name stands for service name, used for fuzzy search.
  - `--payload.sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--payload.sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the data list order.
  - `--payload.api-version` (query): payload.apiVersion
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`
- Example: `dce amamba gitops list-propagation-policies --workspace-id <ws> --instance <i> --namespace <ns>`

## Release

### `dce amamba release list-release-stats`

- Summary: Release_ListReleaseStats
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/releasestats`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--pipeline-id` (query): Filter by pipeline name
  - `--started-by` (query): Filter by started user
  - `--application` (query): Filter by application name
  - `--cluster-filter` (query): Filter by cluster name
  - `--namespace-filter` (query): Filter by namespace name
  - `--start` (query, int64): Filter by started_at, should >= start
  - `--end` (query, int64): Filter by started_at, should <= end
  - `--search` (query): Filter by if application name, pipeline name or image contains `search`
  - `--page` (query, int32): Page requested. default is 1.
  - `--page-size` (query, int32): PageSize per page requested. default is 10.
  - `--sort-by` (query, default `RELEASE_SORT_BY_UNSPECIFIED`, one of: RELEASE_SORT_BY_UNSPECIFIED|RELEASE_FIELD_NAME|RELEASE_CREATED_AT|RELEASE_STARTED_AT): SortBy determines the release stats list order reference.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): OrderBy determines the release stats order.
- Output: list path `items`; columns `namespace`, `abortedBy`, `application`, `cluster`, `image`, `pipelineId`; pagination `offset`

## Rollouts

### `dce amamba rollouts abort-rollout`

- Summary: Abort an in-progress rollout
- HTTP: `POST /apis/rollout.amamba.io/v1alpha1/workspaces/{workspaceId}/rollouts/{name}:abort`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): Workspace is a virtual space to scope clusters and namespaces which current user can access.
  - `--name` (path, required): Name for resource Rollout, must be unique within a combination of cluster and namespace.
- Example: `dce amamba rollouts abort-rollout --workspace-id <ws> --name my-rollout`

### `dce amamba rollouts create-rollout`

- Summary: Create a new rollout (canary / blue-green)
- HTTP: `POST /apis/rollout.amamba.io/v1alpha1/workspaces/{workspaceId}/rollouts`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): Workspace is a virtual space to scope clusters and namespaces which current user can access.
- Example: `dce amamba rollouts create-rollout --workspace-id <ws> --name my-rollout --file rollout.yaml`

### `dce amamba rollouts delete-rollout`

- Summary: Delete a rollout
- HTTP: `DELETE /apis/rollout.amamba.io/v1alpha1/workspaces/{workspaceId}/rollouts/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): Workspace is a virtual space to scope clusters and namespaces which current user can access.
  - `--name` (path, required): Name for resource Rollout, must be unique within a combination of cluster and namespace.
- Example: `dce amamba rollouts delete-rollout --workspace-id <ws> --name my-rollout`

### `dce amamba rollouts get-rollout`

- Summary: Get a rollout's spec and current wave
- HTTP: `GET /apis/rollout.amamba.io/v1alpha1/workspaces/{workspaceId}/rollouts/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): Workspace is a virtual space to scope clusters and namespaces which current user can access.
  - `--name` (path, required): Name for resource Rollout, must be unique within a combination of cluster and namespace.
  - `--cluster` (query): Name of cluster in which the namespace lives, declared when created from kpanda api.
  - `--namespace` (query): Name of namespace in which the resource Rollout lives.
- Example: `dce amamba rollouts get-rollout --workspace-id <ws> --name my-rollout`

### `dce amamba rollouts get-rollout-info`

- Summary: Get rollout runtime info (waves, canary status)
- HTTP: `GET /apis/rollout.amamba.io/v1alpha1/workspaces/{workspaceId}/rolloutinfo/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): Workspace is a virtual space to scope clusters and namespaces which current user can access.
  - `--name` (path, required): Name for resource Rollout, must be unique within a combination of cluster and namespace.
  - `--cluster` (query): cluster
  - `--namespace` (query): namespace
- Output: list path `analysisRuns`; columns `name`, `error`, `failed`, `inconclusive`, `revision`, `status`
- Example: `dce amamba rollouts get-rollout-info --workspace-id <ws> --name my-rollout`

### `dce amamba rollouts get-rollout-json`

- Summary: Rollouts_GetRolloutJSON
- HTTP: `GET /apis/rollout.amamba.io/v1alpha1/workspaces/{workspaceId}/rollouts/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
  - `--cluster` (query): cluster
  - `--namespace` (query): namespace

### `dce amamba rollouts get-workload-json`

- Summary: Rollouts_GetWorkloadJSON
- HTTP: `GET /apis/rollout.amamba.io/v1alpha1/workspaces/{workspaceId}/workloads/{workloadName}/json`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): The workspace bind to the following cluster and namespace.
  - `--workload-name` (path, required): workload name
  - `--cluster` (query): The cluster which the namespace belongs to.
  - `--namespace` (query): The namespace where the secret lives in.
  - `--workload-type` (query, default `WORKLOAD_TYPE_UNSPECIFIED`, one of: WORKLOAD_TYPE_UNSPECIFIED|WORKLOAD_TYPE_DEPLOYMENT|WORKLOAD_TYPE_STATEFUL_SET|WORKLOAD_TYPE_DAEMON_SET|WORKLOAD_TYPE_JOB|WORKLOAD_TYPE_CRONJOB): workloadType

### `dce amamba rollouts list-ingress-names`

- Summary: List ingress names available for a rollout in a cluster/namespace
- HTTP: `GET /apis/rollout.amamba.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/ingressnames`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): PageSize per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|FIELD_NAME|CREATED_AT|CLUSTER|NAMESPACE): SortBy determines the cluster list order reference.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): OrderBy determines the cluster list order.
  - `--fuzzy-name` (query): fuzzyName
- Output: list path `items`; pagination `offset`
- Example: `dce amamba rollouts list-ingress-names --workspace-id <ws> --cluster <c> --namespace <ns>`

### `dce amamba rollouts list-rollout-containers`

- Summary: List containers involved in a rollout
- HTTP: `GET /apis/rollout.amamba.io/v1alpha1/workspaces/{workspaceId}/rollouts/{name}/containters`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name
  - `--cluster` (query): cluster
  - `--namespace` (query): namespace
- Output: list path `items`; columns `name`, `image`
- Example: `dce amamba rollouts list-rollout-containers --workspace-id <ws> --name my-rollout`

### `dce amamba rollouts list-rollouts`

- Summary: List progressive-delivery rollouts
- HTTP: `GET /apis/rollout.amamba.io/v1alpha1/workspaces/{workspaceId}/rollouts`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): Workspace is a virtual space to scope clusters and namespaces which current user can access.
  - `--cluster` (query): Name of cluster in which the namespace lives, declared when created from kpanda api.
  - `--namespace` (query): Name of namespace in which the resource Rollout lives.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): PageSize per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|FIELD_NAME|CREATED_AT|CLUSTER|NAMESPACE): SortBy determines the cluster list order reference.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): OrderBy determines the cluster list order.
  - `--fuzzy-name` (query): fuzzyName
  - `--rollout-phase` (query, default `ROLLOUT_PHASE_UNSPECIFIED`, one of: ROLLOUT_PHASE_UNSPECIFIED|ROLLOUT_PHASE_HEALTHY|ROLLOUT_PHASE_DEGRADED|ROLLOUT_PHASE_PROCESSING|ROLLOUT_PHASE_PAUSED|ROLLOUT_PHASE_SCALEDDOWN): rolloutPhase
- Output: list path `items`; columns `name`, `status.phase`, `createdAt`, `replicas`, `workspaceId`; pagination `offset`
- Example: `dce amamba rollouts list-rollouts --workspace-id <ws>`

### `dce amamba rollouts list-services`

- Summary: Rollouts_ListServices
- HTTP: `GET /apis/rollout.amamba.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/services`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): The workspace bind to the following cluster and namespace.
  - `--cluster` (path, required): The cluster which the namespace belongs to.
  - `--namespace` (path, required): The namespace where the secret lives in.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--only-metadata` (query): OnlyMetadata lists only metadata of configmaps, default false.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): PageSize per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|FIELD_NAME|CREATED_AT|CLUSTER|NAMESPACE): SortBy determines the cluster list order reference.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): OrderBy determines the cluster list order.
  - `--label-selector` (query): labelSelector
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`; pagination `offset`

### `dce amamba rollouts promote-rollout`

- Summary: Promote the next wave of a rollout
- HTTP: `POST /apis/rollout.amamba.io/v1alpha1/workspaces/{workspaceId}/rollouts/{name}:promote`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): Workspace is a virtual space to scope clusters and namespaces which current user can access.
  - `--name` (path, required): Name for resource Rollout, must be unique within a combination of cluster and namespace.
- Example: `dce amamba rollouts promote-rollout --workspace-id <ws> --name my-rollout`

### `dce amamba rollouts undo-rollout`

- Summary: Roll back a rollout to its previous revision
- HTTP: `POST /apis/rollout.amamba.io/v1alpha1/workspaces/{workspaceId}/rollouts/{name}/revisions/{revision}:undo`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): Workspace is a virtual space to scope clusters and namespaces which current user can access.
  - `--name` (path, required): Name for resource Rollout, must be unique within a combination of cluster and namespace.
  - `--revision` (path, required, int64): The revision to rollback to. Default to 0 (last revision).
- Example: `dce amamba rollouts undo-rollout --workspace-id <ws> --name my-rollout`

### `dce amamba rollouts update-rollout`

- Summary: Update a rollout's spec
- HTTP: `PUT /apis/rollout.amamba.io/v1alpha1/workspaces/{workspaceId}/rollouts/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): Workspace is a virtual space to scope clusters and namespaces which current user can access.
  - `--name` (path, required): Name for resource Rollout, must be unique within a combination of cluster and namespace.
- Example: `dce amamba rollouts update-rollout --workspace-id <ws> --name my-rollout --file rollout.yaml`

### `dce amamba rollouts update-rollout-json`

- Summary: Rollouts_UpdateRolloutJSON
- HTTP: `PUT /apis/rollout.amamba.io/v1alpha1/workspaces/{workspaceId}/rollouts/{name}/json`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--name` (path, required): name

### `dce amamba rollouts upgrade-rollout`

- Summary: Trigger a new rollout upgrade with a new image
- HTTP: `POST /apis/rollout.amamba.io/v1alpha1/workspaces/{workspaceId}/rollouts/{name}:upgrade`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): Workspace is a virtual space to scope clusters and namespaces which current user can access.
  - `--name` (path, required): Name for resource Rollout, must be unique within a combination of cluster and namespace.
- Example: `dce amamba rollouts upgrade-rollout --workspace-id <ws> --name my-rollout --image my-app:v2`

## Sonarqube

### `dce amamba sonarqube list-binded-sonarqube`

- Summary: Sonarqube_ListBindedSonarqube
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/sonarqube/all_projects`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
- Output: list path `items`; columns `address`, `createdAt`, `nameInJenkins`, `resourceStatus`, `toolchainId`, `toolchainName`

## SummaryService

### `dce amamba summaryservice check-port-occupancy`

- Summary: SummaryService_CheckPortOccupancy
- HTTP: `POST /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/summary/services:check-port`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster

### `dce amamba summaryservice get-namespaced-resource`

- Summary: GetNamespacedResource gets the resource with specified `GroupKind` in target cluster/namespace
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/resources/{groupKind}/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--group-kind` (path, required): GroupKind specifies the resource group and kind
  - `--name` (path, required): name

### `dce amamba summaryservice list-cluster-api-groups`

- Summary: SummaryService_ListClusterAPIGroups
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/apis`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
- Output: list path `items`; columns `name`

### `dce amamba summaryservice list-ingress-class-summary`

- Summary: ListIngressClasses lists instances of `ingressclass` in target cluster
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/summary/ingressclasses`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
  - `--namespace` (query): namespace
  - `--scope` (query, default `SCOPE_CLUSTER`, one of: SCOPE_CLUSTER|SCOPE_NAMESPACE): scope
- Output: list path `items`; columns `name`, `kind`, `isDefaultClass`

### `dce amamba summaryservice list-metallb-ip-pools`

- Summary: ListMetallbIPPools lists instances of `ipaddresspools.metallb.io` in metallb-system
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/summary/metallbippools`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`

### `dce amamba summaryservice list-nacos-registries`

- Summary: SummaryService_ListNacosRegistries
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/nacos`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): PageSize per page requested.
- Output: list path `items`; columns `name`, `namespace`, `certificationEnabled`, `cluster`, `workspaceId`; pagination `offset`

### `dce amamba summaryservice list-nacos-registry-namespaces`

- Summary: SummaryService_ListNacosRegistryNamespaces
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/nacos/{nacosName}/namespaces`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
  - `--nacos-name` (path, required): nacosName
  - `--nacos-namespace` (query): the nacos belong to which cluster
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): PageSize per page requested.
- Output: list path `items`; columns `name`, `id`; pagination `offset`

### `dce amamba summaryservice list-namespace-summary`

- Summary: ListNamespaceSummary lists basic namespace information in target cluster,
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/summary/namespaces`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
  - `--phase` (query): phase
- Output: list path `data`; columns `name`, `phase`, `cluster`

### `dce amamba summaryservice list-namespaced-resources`

- Summary: ListNamespacedResources lists resources with specified `GroupKind` in target cluster/namespace
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/resources/{groupKind}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--group-kind` (path, required): GroupKind indicates the group and kind of the resource in a
  - `--label-selector` (query): Selector (label query) to filter on, supports '=', '==', and '!='.(e.g. key1=value1,key2=value2). Matching
  - `--field-selector` (query): A selector to restrict the list of returned objects by their fields.
  - `--metadata-only` (query): metadata_only indicates whether to return only metadata of the resources.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): PageSize per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|FIELD_NAME|CREATED_AT|CLUSTER|NAMESPACE): SortBy determines the resources list order reference.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): OrderBy determines the resources list order.
- Output: list path `items`; columns `data`; pagination `offset`

### `dce amamba summaryservice list-node-summary`

- Summary: ListNodeSummary lists basic node information in target cluster
- HTTP: `GET /apis/application.amamba.io/v1alpha2/workspaces/{workspaceId}/clusters/{cluster}/summary/nodes`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--cluster` (path, required): cluster
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`

## Toolchain

### `dce amamba toolchain admin-bind-toolchain-resources`

- Summary: Toolchain_AdminBindToolchainResources
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/toolchains/{toolchainId}/resources/{resourceId}:bind`
- Auth: required
- Body: required
- Flags:
  - `--toolchain-id` (path, required, int32): toolchainId
  - `--resource-id` (path, required, int32): resourceId

### `dce amamba toolchain admin-create-toolchain-instance`

- Summary: Toolchain_AdminCreateToolchainInstance
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/toolchains`
- Auth: required
- Body: required
- Flags: none

### `dce amamba toolchain admin-delete-instance`

- Summary: Toolchain_AdminDeleteInstance
- HTTP: `DELETE /apis/pipeline.amamba.io/v1alpha1/toolchains/{toolchainId}`
- Auth: required
- Body: required
- Flags:
  - `--toolchain-id` (path, required, int32): toolchainId

### `dce amamba toolchain admin-delete-toolchain-resource`

- Summary: Toolchain_AdminDeleteToolchainResource
- HTTP: `DELETE /apis/pipeline.amamba.io/v1alpha1/toolchains/{toolchainId}/resources/{resourceId}`
- Auth: required
- Body: required
- Flags:
  - `--toolchain-id` (path, required, int32): toolchainId
  - `--resource-id` (path, required, int32): resourceId

### `dce amamba toolchain admin-get-instance`

- Summary: Toolchain_AdminGetInstance
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/toolchains/{toolchainId}`
- Auth: required
- Body: none
- Flags:
  - `--toolchain-id` (path, required, int32): toolchainId
  - `--workspace-id` (query): If it is an administrator operation, it does not need to be filled in.
  - `--type` (query, default `INSTANCE_TYPE_UNSPECIFIED`, one of: INSTANCE_TYPE_UNSPECIFIED|INSTANCE_TYPE_JIRA|INSTANCE_TYPE_GITLAB|INSTANCE_TYPE_JENKINS|INSTANCE_TYPE_SONARQUBE|INSTANCE_TYPE_TESTLINK|INSTANCE_TYPE_NEXUS|INSTANCE_TYPE_JFROG): type

### `dce amamba toolchain admin-list-instances`

- Summary: Toolchain_AdminListInstances
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/toolchains`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (query): If it is an administrator operation, it does not need to be filled in.
  - `--fuzzy-name` (query): fuzzyName
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): PageSize per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|FIELD_NAME|CREATED_AT|CLUSTER|NAMESPACE): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): OrderBy determines the data list order.
  - `--types` (query): types that need to be queried,if empty all types,
- Output: list path `items`; columns `name`, `type`, `id`, `address`, `config`, `connectStatus`; pagination `offset`

### `dce amamba toolchain admin-list-toolchain-resources`

- Summary: Toolchain_AdminListToolchainResources
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/toolchains/{toolchainId}/resources`
- Auth: required
- Body: none
- Flags:
  - `--toolchain-id` (path, required, int32): toolchainId
  - `--workspace-id` (query): workspaceId
  - `--fuzzy-name` (query): used for fuzzy query based on project name.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): PageSize per page requested.
  - `--type` (query, default `RESOURCE_TYPE_UNSPECIFIED`, one of: RESOURCE_TYPE_UNSPECIFIED|RESOURCE_TYPE_JIRA_PROJECT|RESOURCE_TYPE_GITLAB_PROJECT|RESOURCE_TYPE_SONARQUBE|RESOURCE_TYPE_TESTLINK_PROJECT|RESOURCE_TYPE_NEXUS_REPOSITORY): type
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|FIELD_NAME|CREATED_AT|CLUSTER|NAMESPACE): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): OrderBy determines the data list order.
- Output: list path `items`; columns `name`, `type`, `id`, `resourceStatus`, `toolchainId`, `workspaceId`; pagination `offset`

### `dce amamba toolchain admin-sync-toolchain-resources`

- Summary: Toolchain_AdminSyncToolchainResources
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/toolchains/{toolchainId}:sync`
- Auth: required
- Body: required
- Flags:
  - `--toolchain-id` (path, required, int32): toolchainId

### `dce amamba toolchain admin-unbind-toolchain-resources`

- Summary: Toolchain_AdminUnbindToolchainResources
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/toolchains/{toolchainId}/resources/{resourceId}:unbind`
- Auth: required
- Body: required
- Flags:
  - `--toolchain-id` (path, required, int32): toolchainId
  - `--resource-id` (path, required, int32): resourceId

### `dce amamba toolchain admin-update-toolchain-instance`

- Summary: only support update toolchain instance credential
- HTTP: `PUT /apis/pipeline.amamba.io/v1alpha1/toolchains/{toolchainId}`
- Auth: required
- Body: required
- Flags:
  - `--toolchain-id` (path, required, int32): toolchainId

### `dce amamba toolchain bind-toolchain-resources`

- Summary: Bind a toolchain resource (Jenkins / SonarQube / JFrog) to a workspace
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/toolchains/{toolchainId}/resources/{resourceId}:bind`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--toolchain-id` (path, required, int32): toolchainId
  - `--resource-id` (path, required, int32): resourceId
- Example: `dce amamba toolchain bind-toolchain-resources --workspace-id <ws> --resource <id>`

### `dce amamba toolchain create-toolchain-instance`

- Summary: Toolchain_CreateToolchainInstance
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/toolchains`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId

### `dce amamba toolchain delete-instance`

- Summary: Toolchain_DeleteInstance
- HTTP: `DELETE /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/toolchains/{toolchainId}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): If it is an administrator operation, it does not need to be filled in.
  - `--toolchain-id` (path, required, int32): toolchainId

### `dce amamba toolchain delete-toolchain-resource`

- Summary: Toolchain_DeleteToolchainResource
- HTTP: `DELETE /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/toolchains/{toolchainId}/resources/{resourceId}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--toolchain-id` (path, required, int32): toolchainId
  - `--resource-id` (path, required, int32): resourceId

### `dce amamba toolchain get-instance`

- Summary: Toolchain_GetInstance
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/toolchains/{toolchainId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): If it is an administrator operation, it does not need to be filled in.
  - `--toolchain-id` (path, required, int32): toolchainId
  - `--type` (query, default `INSTANCE_TYPE_UNSPECIFIED`, one of: INSTANCE_TYPE_UNSPECIFIED|INSTANCE_TYPE_JIRA|INSTANCE_TYPE_GITLAB|INSTANCE_TYPE_JENKINS|INSTANCE_TYPE_SONARQUBE|INSTANCE_TYPE_TESTLINK|INSTANCE_TYPE_NEXUS|INSTANCE_TYPE_JFROG): type

### `dce amamba toolchain list-instances`

- Summary: Toolchain_ListInstances
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/toolchains`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): If it is an administrator operation, it does not need to be filled in.
  - `--fuzzy-name` (query): fuzzyName
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): PageSize per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|FIELD_NAME|CREATED_AT|CLUSTER|NAMESPACE): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): OrderBy determines the data list order.
  - `--types` (query): types that need to be queried,if empty all types,
- Output: list path `items`; columns `name`, `type`, `id`, `address`, `config`, `connectStatus`; pagination `offset`

### `dce amamba toolchain list-sonarqube-bind-workspace`

- Summary: Toolchain_ListSonarqubeBindWorkspace
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/toolchains/{toolchainId}/sonarqube_bind_workspace`
- Auth: required
- Body: none
- Flags:
  - `--toolchain-id` (path, required, int32): toolchain id
  - `--fuzzy-name` (query): fuzzyName
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): PageSize per page requested.
- Output: list path `items`; columns `address`, `createdAt`, `nameInJenkins`, `resourceStatus`, `toolchainId`, `toolchainName`; pagination `offset`

### `dce amamba toolchain list-toolchain-resources`

- Summary: List toolchain resources bound to a workspace (Jenkins, SonarQube, etc.)
- HTTP: `GET /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/toolchains/{toolchainId}/resources`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--toolchain-id` (path, required, int32): toolchainId
  - `--fuzzy-name` (query): used for fuzzy query based on project name.
  - `--page` (query, int32): Page requested.
  - `--page-size` (query, int32): PageSize per page requested.
  - `--type` (query, default `RESOURCE_TYPE_UNSPECIFIED`, one of: RESOURCE_TYPE_UNSPECIFIED|RESOURCE_TYPE_JIRA_PROJECT|RESOURCE_TYPE_GITLAB_PROJECT|RESOURCE_TYPE_SONARQUBE|RESOURCE_TYPE_TESTLINK_PROJECT|RESOURCE_TYPE_NEXUS_REPOSITORY): type
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|FIELD_NAME|CREATED_AT|CLUSTER|NAMESPACE): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): OrderBy determines the data list order.
- Output: list path `items`; columns `name`, `type`, `id`, `resourceStatus`, `toolchainId`, `workspaceId`; pagination `offset`
- Example: `dce amamba toolchain list-toolchain-resources --workspace-id <ws>`

### `dce amamba toolchain sync-toolchain-resources`

- Summary: Force re-sync of toolchain resources in a workspace
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/toolchains/{toolchainId}:sync`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): If it is an administrator operation, it does not need to be filled in.
  - `--toolchain-id` (path, required, int32): toolchainId
- Example: `dce amamba toolchain sync-toolchain-resources --workspace-id <ws>`

### `dce amamba toolchain unbind-toolchain-resources`

- Summary: Unbind a toolchain resource from a workspace
- HTTP: `POST /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/toolchains/{toolchainId}/resources/{resourceId}:unbind`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--toolchain-id` (path, required, int32): toolchainId
  - `--resource-id` (path, required, int32): resourceId
- Example: `dce amamba toolchain unbind-toolchain-resources --workspace-id <ws> --resource <id>`

### `dce amamba toolchain update-toolchain-instance`

- Summary: only support update toolchain instance credential
- HTTP: `PUT /apis/pipeline.amamba.io/v1alpha1/workspaces/{workspaceId}/toolchains/{toolchainId}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): workspaceId
  - `--toolchain-id` (path, required, int32): toolchainId

## Workloads

### `dce amamba workloads create-app-by-helm`

- Summary: CreateAppByHelm create workload given an image name
- HTTP: `POST /apis/application.amamba.io/v1alpha1/workspaces/{workspaceId}/helmreleases`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): target workspace id

### `dce amamba workloads create-app-by-image`

- Summary: CreateAppByImage create workload given an image name
- HTTP: `POST /apis/application.amamba.io/v1alpha1/workspaces/{workspaceId}/create_workload_by_image`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): Workspace ID
- Output: list path `previews`

### `dce amamba workloads create-app-from-git`

- Summary: Workloads_CreateAppFromGit
- HTTP: `POST /apis/application.amamba.io/v1alpha1/workspaces/{workspaceId}/create_workload_by_git`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): Workspace ID
- Output: list path `previews`

### `dce amamba workloads create-app-from-jar`

- Summary: Workloads_CreateAppFromJar
- HTTP: `POST /apis/application.amamba.io/v1alpha1/workspaces/{workspaceId}/create_workload_by_jar`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): Workspace ID
- Output: list path `previews`

### `dce amamba workloads list-workloads`

- Summary: List workloads across namespaces (deprecated; prefer list-application-workloads)
- HTTP: `GET /apis/application.amamba.io/v1alpha1/workspaces/{workspaceId}/workloads`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required): The scope where the workload created.
  - `--cluster` (query): The cluster which the namespace belongs to.
  - `--namespace` (query): The namespace which the workload is deployed at.
  - `--name` (query): name
  - `--app-group` (query): appGroup
  - `--workload-type` (query, default `WORKLOAD_TYPE_UNSPECIFIED`, one of: WORKLOAD_TYPE_UNSPECIFIED|WORKLOAD_TYPE_DEPLOYMENT|WORKLOAD_TYPE_STATEFUL_SET|WORKLOAD_TYPE_DAEMON_SET|WORKLOAD_TYPE_JOB|WORKLOAD_TYPE_CRONJOB): workloadType
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): PageSize per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|FIELD_NAME|CREATED_AT|CLUSTER|NAMESPACE): SortBy determines the cluster list order reference.
  - `--sort-dir` (query, default `DESC`, one of: DESC|ASC): OrderBy determines the cluster list order.
- Output: list path `items`; columns `name`, `appGroup`, `createBy`, `createdAt`, `status`, `workloadType`; pagination `offset`
- Example: `dce amamba workloads list-workloads --workspace-id <ws> --cluster <c> --namespace <ns>`

### `dce amamba workloads update-workload-replicas`

- Summary: Scale a workload to N replicas
- HTTP: `PUT /apis/application.amamba.io/v1alpha1/workspaces/{workspaceId}/workloads/{workloadName}/replicas`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required): The workspace bind to the following cluster and namespace.
  - `--workload-name` (path, required): workload name
- Example: `dce amamba workloads update-workload-replicas --workspace-id <ws> --workload-name <name> --replicas 3`

