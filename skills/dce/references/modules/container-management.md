# Module `container-management`

## Source

- Backend: `swagger`
- Repository: https://github.com/DaoCloud/daocloud-api-docs.git
- Pinned tag: `4bc92dd4c0c1637b4257f69e26eb8dd6cdd269f3`
- Files: `docs/openapi/kpanda/v0.46.0.json`
- Resolved SHA: `4bc92dd4c0c1637b4257f69e26eb8dd6cdd269f3`

## Addon

### `dce container-management addon create-helm-release`

- Summary: CreateHelmRelease creates a Release.
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/helmreleases`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster represents which cluster the chart belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the helm release belongs to.

### `dce container-management addon create-helm-repo`

- Summary: CreateHelmRepo create a repo in cluster.
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/helmrepos`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster represents which cluster the repository belongs to.

### `dce container-management addon delete-helm-operation`

- Summary: DeleteHelmOperation delete a operation in cluster.
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/helmoperations/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents which cluster the repository belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the daemonSet belongs to.
  - `--name` (path, required): The name represents for the resource name.

### `dce container-management addon delete-helm-release`

- Summary: DeleteHelmRelease delete a release.
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/helmreleases/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the helmrelease belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the helmrelease belongs to.
  - `--name` (path, required): Name represents the name of helmrelease.

### `dce container-management addon delete-helm-repo`

- Summary: DeleteHelmRepo delete a repo in cluster.
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/helmrepos/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents which cluster the repository belongs to.
  - `--name` (path, required): The name represents for the resource name.

### `dce container-management addon get-helm-chart`

- Summary: GetHelmChartVersion get a chart version info from repository.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/helmrepos/{repo}/helmcharts/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents which cluster the chart belongs to.
  - `--repo` (path, required): The repo represents for the charts belongs to.
  - `--name` (path, required): The name represents for the resource name.
  - `--version` (query): The version represents for the resource version.

### `dce container-management addon get-helm-chart-display`

- Summary: GetHelmChartDisplay get a chart display info from repository.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/helmrepos/{repo}/helmcharts/{name}/display`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents which cluster the chart belongs to.
  - `--repo` (path, required): The repo represents for the charts belongs to.
  - `--name` (path, required): The name represents for the resource name.
  - `--version` (query): The version represents for the resource version.

### `dce container-management addon get-helm-chart-files`

- Summary: GetHelmChartFiles get a chart files from repository.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/helmrepos/{repo}/helmcharts/{name}/files`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents which cluster the chart belongs to.
  - `--repo` (path, required): The repo represents for the charts belongs to.
  - `--name` (path, required): The name represents for the resource name.
  - `--version` (query): The version represents for the resource version.

### `dce container-management addon get-helm-chart-manifest`

- Summary: GetHelmChartManifest get a chart manifests info from repository.
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/helmrepos/{repo}/helmcharts/{name}/manifests`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster represents which cluster the chart belongs to.
  - `--repo` (path, required): The repo represents for the charts belongs to.
  - `--name` (path, required): The name represents for the resource name.

### `dce container-management addon get-helm-chart-resources`

- Summary: GetHelmChartResources get the resources contained in charts.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/helmrepos/{repo}/helmcharts/{name}/resources`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents which cluster the chart belongs to.
  - `--repo` (path, required): The repo represents for the charts belongs to.
  - `--name` (path, required): The name represents for the resource name.
  - `--version` (query): The version represents for the resource version.
- Output: list path `resources`; columns `name`, `kind`, `image`

### `dce container-management addon get-helm-install-config`

- Summary: GetHelmInstallConfig create a Release.
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/helmrepos/{repo}/helmcharts/{name}:config`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster represents which cluster the chart belongs to.
  - `--repo` (path, required): The repo represents for the charts belongs to.
  - `--name` (path, required): Name represents the name of helmrelease

### `dce container-management addon get-helm-operation`

- Summary: GetHelmOperation get a operation in cluster.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/helmoperations/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents which cluster the repository belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the daemonSet belongs to.
  - `--name` (path, required): The name represents for the resource name.

### `dce container-management addon get-helm-operation-json`

- Summary: GetHelmOperationJSON get a operation json in cluster.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/helmoperations/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents which cluster the repository belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the daemonSet belongs to.
  - `--name` (path, required): The name represents for the resource name.

### `dce container-management addon get-helm-release`

- Summary: GetHelmRelease gets a release in cluster.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/helmreleases/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the helmrelease belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the helmrelease belongs to.
  - `--name` (path, required): Name of the helmrelease.

### `dce container-management addon get-helm-release-json`

- Summary: GetHelmReleaseJSON gets a release in cluster.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/helmreleases/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents which cluster the release belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the helmrelease belongs to.
  - `--name` (path, required): The name represents for the resource name.

### `dce container-management addon get-helm-repo`

- Summary: GetHelmRepo get a repo in cluster.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/helmrepos/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents which cluster the repository belongs to.
  - `--name` (path, required): The name represents for the resource name.

### `dce container-management addon get-helm-repo-json`

- Summary: GetHelmRepoJSON get a repo json in cluster.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/helmrepos/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents which cluster the repository belongs to.
  - `--name` (path, required): The name represents for the resource name.

### `dce container-management addon list-cluster-helm-operations`

- Summary: ListClusterHelmOperations list operation in cluster.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/helmoperations`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified operation belongs to.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the event list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the list order.
  - `--name` (query): name is used for query.
  - `--release-name` (query): Filter helm_operation by release_name,
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `status.phase`, `status.version`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management addon list-cluster-helm-releases`

- Summary: ListClusterHelmReleases list apps in cluster.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/helmreleases`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified operation belongs to.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the event list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the list order.
  - `--name` (query): name is used for query.
  - `--helm-chart-name` (query): the helm releases's chart name
  - `--helm-chart-repo` (query): the helm releases's chart repo name
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `spec.version`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management addon list-cluster-installed-helm-chart`

- Summary: ListClusterInstalledHelmChart list the charts which installed belong to repo
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/helmcharts/installed`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the chart belongs to.
  - `--repo-name` (query): repo_name represents which helm repo's name use to list installed helm chart

### `dce container-management addon list-helm-charts`

- Summary: ListCharts list chart from repositories.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/helmcharts`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the chart belongs to.
  - `--name` (query): Helm chart name.
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--category` (query, default `CATEGORY_UNSPECIFIED`, one of: CATEGORY_UNSPECIFIED|CATEGORY_OTHERS|CATEGORY_STORAGE|CATEGORY_NETWORKING|CATEGORY_MONITORING|CATEGORY_DATABASE|CATEGORY_DATASERVICE|CATEGORY_ECOAPP|CATEGORY_BIGDATA|CATEGORY_SECURITY|CATEGORY_IOTEDGE|CATEGORY_INFRA): Category is used for query.
  - `--repo` (query): The repo name which the charts belongs to.
  - `--required` (query): Required indicates whether to display the charts, which are required to install the cluster.
- Output: list path `data`; columns `metadata.name`, `created`, `removed`; pagination `offset`

### `dce container-management addon list-helm-operations`

- Summary: ListHelmOperations list operation in cluster.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/helmoperations`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents which cluster the repository belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced ConfigMap.
  - `--name` (query): Name is the user-specified identifier.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the repository list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the repository list order.
  - `--release-name` (query): Filter helm_operation by release_name,
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `status.phase`, `status.version`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management addon list-helm-release-resources`

- Summary: ListHelmReleaseResources lists resources related to the specified helm release.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/helmreleases/{helmrelease}/resources`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the helmrelease belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the helmrelease belongs to.
  - `--helmrelease` (path, required): Name of the helmrelease.
  - `--name` (query): Name is used to fuzzy search resources which belongs to this helmrelease by resource name.
  - `--kind` (query): Kind is used to filter resources which belongs to this helmrelease by resource kind.
  - `--phase` (query, default `RESOURCE_PHASE_UNSPECIFIED`, one of: RESOURCE_PHASE_UNSPECIFIED|InProgress|Failed|Current|Terminating|Unknown): Phase is used to filter resources which belongs to this helmrelease by resource phase.
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the resource list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): SortDir determines the list order.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
- Output: list path `items`; columns `name`, `namespace`, `phase`, `kind`, `apiVersion`; pagination `offset`

### `dce container-management addon list-helm-release-revisions`

- Summary: ListHelmReleaseRevisions lists revisions of the specified helm release.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/helmreleases/{helmrelease}/revisions`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the helmrelease belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the helmrelease belongs to.
  - `--helmrelease` (path, required): Name of the helmrelease.
- Output: list path `items`; columns `appVersion`, `chart`, `manifest`, `status`, `updated`, `version`

### `dce container-management addon list-helm-releases`

- Summary: ListHelmReleases lists apps in cluster.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/helmreleases`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents which cluster the releases belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced ConfigMap.
  - `--name` (query): Name is the user-specified identifier.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the release list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the release list order.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `spec.version`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management addon list-helm-repos`

- Summary: ListHelmRepos list repo in cluster.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/helmrepos`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents which cluster the repository belongs to.
  - `--name` (query): Name is the user-specified identifier.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the repository list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the repository list order.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--built-in` (query): builtin indicates whether to display the repos required to install the cluster.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `status.phase`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management addon refresh-helm-repo`

- Summary: RefreshHelmRepo updates a helm repo's index.
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/helmrepos/{name}:refresh`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents which cluster the helmrepo belongs to.
  - `--name` (path, required): The name represents for the resource name.

### `dce container-management addon rollback-helm-release`

- Summary: RollbackHelmRelease rollbacks a release.
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/helmreleases/{name}:rollback`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the helmrelease belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the helmrelease belongs to.
  - `--name` (path, required): Name represents the name of helmrelease.

### `dce container-management addon update-helm-release`

- Summary: UpdateHelmRelease updates a release.
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/helmreleases/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the helmrelease belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the helmrelease belongs to.
  - `--name` (path, required): Name represents the name of helmrelease.

### `dce container-management addon update-helm-repo`

- Summary: UpdateHelmRepo update repo
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/helmrepos/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster represents which cluster the repository belongs to.
  - `--name` (path, required): The name represents for the resource name.

### `dce container-management addon validate-helm-repo`

- Summary: ValidateHelmRepo verifies if a repo is connectable.
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/helmrepos/{name}/validate`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster of the repo
  - `--name` (path, required): Name of the repo

## Apiextensions

### `dce container-management apiextensions create-cluster-custom-resource`

- Summary: CreateClusterCustomResource creates a customResource of cluster scope to
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/gvr/{group}/{version}/{resource}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the CustomResource belongs to.
  - `--group` (path, required): Group represents the resource group of CustomResource.
  - `--version` (path, required): Version represents the resource version of CustomResource.
  - `--resource` (path, required): Resource represents the resource name of CustomResource, which is plural.

### `dce container-management apiextensions create-custom-resource`

- Summary: CreateCustomResource creates a customResource of namespaced scope to the
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/gvr/{group}/{version}/namespaces/{namespace}/{resource}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the CustomResource belongs to.
  - `--group` (path, required): Group represents the resource group of CustomResource.
  - `--version` (path, required): Version represents the resource version of CustomResource.
  - `--namespace` (path, required): Namespace represents which namespace the CustomResource belongs to.
  - `--resource` (path, required): Resource represents the resource name of CustomResource, which is plural.

### `dce container-management apiextensions create-custom-resource-definition`

- Summary: CreateCustomResourceDefinition creates a customResourceDefinition to the
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/customresourcedefinitions`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified customResourceDefinition belongs to.

### `dce container-management apiextensions create-resource`

- Summary: CreateResource creates a list of resources of a given yaml
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/resources`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the resources belong to.
  - `--namespace` (path, required): Namespace represents which namespace the resources belong to.
- Output: list path `data`

### `dce container-management apiextensions delete-cluster-custom-resource`

- Summary: DeleteClusterCustomResource deletes a customResource of cluster scope from
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/gvr/{group}/{version}/{resource}/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the CustomResource belongs to.
  - `--group` (path, required): Group represents the resource group of CustomResource.
  - `--version` (path, required): Version represents the resource version of CustomResource.
  - `--resource` (path, required): Resource represents the resource name of CustomResource, which is plural.
  - `--name` (path, required): Name represents the name of CustomResource.
  - `--deletion-propagation` (query, default `DELETION_PROPAGATION_UNSPECIFIED`, one of: DELETION_PROPAGATION_UNSPECIFIED|DELETION_PROPAGATION_ORPHAN|DELETION_PROPAGATION_BACKGROUND|DELETION_PROPAGATION_FOREGROUND): - DELETION_PROPAGATION_ORPHAN: Orphans the dependents.

### `dce container-management apiextensions delete-custom-resource`

- Summary: DeleteCustomResource deletes a customResource of namespaced scope from the
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/gvr/{group}/{version}/namespaces/{namespace}/{resource}/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the CustomResource belongs to.
  - `--group` (path, required): Group represents the resource group of CustomResource.
  - `--version` (path, required): Version represents the resource version of CustomResource.
  - `--namespace` (path, required): Namespace represents which namespace the CustomResource belongs to.
  - `--resource` (path, required): Resource represents the resource name of CustomResource, which is plural.
  - `--name` (path, required): Name represents the name of CustomResource.
  - `--deletion-propagation` (query, default `DELETION_PROPAGATION_UNSPECIFIED`, one of: DELETION_PROPAGATION_UNSPECIFIED|DELETION_PROPAGATION_ORPHAN|DELETION_PROPAGATION_BACKGROUND|DELETION_PROPAGATION_FOREGROUND): - DELETION_PROPAGATION_ORPHAN: Orphans the dependents.

### `dce container-management apiextensions delete-custom-resource-definition`

- Summary: DeleteCustomResourceDefinition deletes a customResourceDefinition from the
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/customresourcedefinitions/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified customResourceDefinition belongs to.
  - `--name` (path, required): Name is the metadata.name of the referenced customResourceDefinition.

### `dce container-management apiextensions get-cluster-custom-resource`

- Summary: GetClusterCustomResource gets a customResource of cluster scope
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/gvr/{group}/{version}/{resource}/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the CustomResource belongs to.
  - `--group` (path, required): Group represents the resource group of CustomResource.
  - `--version` (path, required): Version represents the resource version of CustomResource.
  - `--resource` (path, required): Resource represents the resource name of CustomResource, which is plural.
  - `--name` (path, required): Name represents the name of CustomResource.
  - `--show-detail` (query): ShowDetail is the presentation details, including metadata, spec, and status

### `dce container-management apiextensions get-cluster-custom-resource-json`

- Summary: GetClusterCustomResourceJSON gets a customResource json of cluster scope
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/gvr/{group}/{version}/{resource}/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the CustomResource belongs to.
  - `--group` (path, required): Group represents the resource group of CustomResource.
  - `--version` (path, required): Version represents the resource version of CustomResource.
  - `--resource` (path, required): Resource represents the resource name of CustomResource, which is plural.
  - `--name` (path, required): Name represents the name of CustomResource.

### `dce container-management apiextensions get-custom-resource`

- Summary: GetCustomResource gets a customResource of namespaced scope from
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/gvr/{group}/{version}/namespaces/{namespace}/{resource}/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the CustomResource belongs to.
  - `--group` (path, required): Group represents the resource group of CustomResource.
  - `--version` (path, required): Version represents the resource version of CustomResource.
  - `--namespace` (path, required): Namespace represents which namespace the CustomResource belongs to.
  - `--resource` (path, required): Resource represents the resource name of CustomResource, which is plural.
  - `--name` (path, required): Name represents the name of CustomResource.
  - `--show-detail` (query): ShowDetail is the presentation details, including metadata, spec, and status

### `dce container-management apiextensions get-custom-resource-definition`

- Summary: GetCustomResourceDefinition gets a customResourceDefinition from
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/customresourcedefinitions/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the CustomResourceDefinition belongs to.
  - `--name` (path, required): Name represents the name of CustomResourceDefinition.

### `dce container-management apiextensions get-custom-resource-definition-json`

- Summary: GetCustomResourceDefinitionJSON gets a customResourceDefinition json from
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/customresourcedefinitions/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the CustomResourceDefinition belongs to.
  - `--name` (path, required): Name represents the name of CustomResourceDefinition.

### `dce container-management apiextensions get-custom-resource-json`

- Summary: GetCustomResourceJSON gets a customResource of namespaced scope json from
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/gvr/{group}/{version}/namespaces/{namespace}/{resource}/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the CustomResource belongs to.
  - `--group` (path, required): Group represents the resource group of CustomResource.
  - `--version` (path, required): Version represents the resource version of CustomResource.
  - `--namespace` (path, required): Namespace represents which namespace the CustomResource belongs to.
  - `--resource` (path, required): Resource represents the resource name of CustomResource, which is plural.
  - `--name` (path, required): Name represents the name of CustomResource.

### `dce container-management apiextensions list-cluster-custom-resources`

- Summary: ListClusterCustomResources lists customResources of cluster scope
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/gvr/{group}/{version}/{resource}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the CustomResources belongs to.
  - `--group` (path, required): Group represents the resource group of CustomResources.
  - `--version` (path, required): Version represents the resource version of CustomResources.
  - `--resource` (path, required): Resource represents the resource name of CustomResources, which is plural.
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--name` (query): name is used for query.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the data list order.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--show-detail` (query): ShowDetail is the presentation details, including metadata, spec, and status
- Output: list path `items`; columns `name`, `namespace`, `kind`, `creationTimestamp`, `apiVersion`, `data`; pagination `offset`

### `dce container-management apiextensions list-custom-resource-definition-groups`

- Summary: ListCustomResourceDefinitionGroups lists all groups of customResourceDefinitions in the specified cluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/crd-groups`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster to request
- Output: list path `items`

### `dce container-management apiextensions list-custom-resource-definitions`

- Summary: ListCustomResourceDefinitions lists customResourceDefinitions in the specified cluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/customresourcedefinitions`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster cluster to be queried
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--name` (query): Name search the custom resource definitions fo name
  - `--status` (query): Status search the custom resource definitions fo status
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the data list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--group` (query): Group is to filter customResourceDefinitions by group.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management apiextensions list-custom-resources`

- Summary: ListCustomResources lists customResources of namespaced scope from the
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/gvr/{group}/{version}/namespaces/{namespace}/{resource}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the CustomResources belongs to.
  - `--group` (path, required): Group represents the resource group of CustomResources.
  - `--version` (path, required): Version represents the resource version of CustomResources.
  - `--namespace` (path, required): Namespace represents which namespace the CustomResources belongs to.
  - `--resource` (path, required): Resource represents the resource name of CustomResources, which is plural.
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--name` (query): name is used for query.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the data list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--show-detail` (query): ShowDetail is the presentation details, including metadata, spec, and status
  - `--owner-reference` (query): OwnerReference indicates that the query is based on the OwnerReference.
- Output: list path `items`; columns `name`, `namespace`, `kind`, `creationTimestamp`, `apiVersion`, `data`; pagination `offset`

### `dce container-management apiextensions patch-custom-resource`

- Summary: PatchCustomResource patches a customResource of cluster scope from
- HTTP: `PATCH /apis/kpanda.io/v1alpha1/clusters/{cluster}/gvr/{group}/{version}/namespaces/{namespace}/{resource}/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the CustomResource belongs to.
  - `--group` (path, required): Group represents the resource group of CustomResource.
  - `--version` (path, required): Version represents the resource version of CustomResource.
  - `--namespace` (path, required): Namespace represents which namespace the CustomResource belongs to.
  - `--resource` (path, required): Resource represents the resource name of CustomResource, which is plural.
  - `--name` (path, required): Name represents the name of CustomResource.

### `dce container-management apiextensions update-cluster-custom-resource`

- Summary: UpdateClusterCustomResource updates a customResource of cluster scope from
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/gvr/{group}/{version}/{resource}/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the CustomResource belongs to.
  - `--group` (path, required): Group represents the resource group of CustomResource.
  - `--version` (path, required): Version represents the resource version of CustomResource.
  - `--resource` (path, required): Resource represents the resource name of CustomResource, which is plural.
  - `--name` (path, required): Name represents the name of CustomResource.

### `dce container-management apiextensions update-cluster-custom-resource-status`

- Summary: UpdateClusterCustomResourceStatus updates the status of a customResource of cluster scope
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/gvr/{group}/{version}/{resource}/{name}/status`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the CustomResource belongs to.
  - `--group` (path, required): Group represents the resource group of CustomResource.
  - `--version` (path, required): Version represents the resource version of CustomResource.
  - `--resource` (path, required): Resource represents the resource name of CustomResource, which is plural.
  - `--name` (path, required): Name represents the name of CustomResource.

### `dce container-management apiextensions update-custom-resource`

- Summary: UpdateCustomResource updates a customResource of namespaced scope from the
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/gvr/{group}/{version}/namespaces/{namespace}/{resource}/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the CustomResource belongs to.
  - `--group` (path, required): Group represents the resource group of CustomResource.
  - `--version` (path, required): Version represents the resource version of CustomResource.
  - `--namespace` (path, required): Namespace represents which namespace the CustomResource belongs to.
  - `--resource` (path, required): Resource represents the resource name of CustomResource, which is plural.
  - `--name` (path, required): Name represents the name of CustomResource.

### `dce container-management apiextensions update-custom-resource-definition`

- Summary: UpdateCustomResourceDefinition updates a customResourceDefinition from the
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/customresourcedefinitions/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified customResourceDefinition belongs to.
  - `--name` (path, required): Name represents for the resource name.

### `dce container-management apiextensions update-custom-resource-status`

- Summary: UpdateCustomResourceStatus updates the status of a customResource
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/gvr/{group}/{version}/namespaces/{namespace}/{resource}/{name}/status`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the CustomResource belongs to.
  - `--group` (path, required): Group represents the resource group of CustomResource.
  - `--version` (path, required): Version represents the resource version of CustomResource.
  - `--namespace` (path, required): Namespace represents which namespace the CustomResource belongs to.
  - `--resource` (path, required): Resource represents the resource name of CustomResource, which is plural.
  - `--name` (path, required): Name represents the name of CustomResource.

## Apps

### `dce container-management apps create-workload-by-json`

- Summary: CreateWorkloadByJSON creates workload by JSON under the namespaces of a
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/{kind}/json`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the Workload belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the Workload belongs to.
  - `--kind` (path, required, one of: deployments|statefulsets|daemonsets|jobs|cronjobs|pods|replicasets): WorkloadKind the workload of kind

### `dce container-management apps delete-daemon-set`

- Summary: DeleteDaemonSet deletes a daemonSets under the namespaces of a specific
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/daemonsets/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which namespace the daemonSet belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the daemonSet belongs to.
  - `--name` (path, required): Name represents the name of daemonSet

### `dce container-management apps delete-deployment`

- Summary: DeleteDeployment deletes a deployment under the namespaces of a specific
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/deployments/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the deployment belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the deployment belongs to.
  - `--name` (path, required): Name represents the name of deployment

### `dce container-management apps delete-replica-set`

- Summary: DeleteReplicaSet deletes a replicaset in specified namespace of a cluster
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/replicasets/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the ReplicaSet belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced ReplicaSet.
  - `--name` (path, required): Name represents for the ReplicaSet name.

### `dce container-management apps delete-stateful-set`

- Summary: DeleteStatefulSet deletes a statefulSet under the namespaces of a specific
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/statefulsets/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the deployment belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the deployment belongs to.
  - `--name` (path, required): Name represents the name of deployment

### `dce container-management apps get-daemon-set`

- Summary: GetDaemonSet gets a daemonSets under the namespaces of a specific cluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/daemonsets/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which namespace the workload belongs to.
  - `--namespace` (path, required): Cluster represents which namespace the workload belongs to.
  - `--name` (path, required): Name represents the name of workload to belongs to.

### `dce container-management apps get-deployment`

- Summary: GetDeployment gets a deployment under the namespaces of a specific cluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/deployments/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which namespace the workload belongs to.
  - `--namespace` (path, required): Cluster represents which namespace the workload belongs to.
  - `--name` (path, required): Name represents the name of workload to belongs to.

### `dce container-management apps get-replica-set`

- Summary: GetReplicaSet gets replicaset detail in specified namespace of a cluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/replicasets/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified replicaSet belongs to.
  - `--namespace` (path, required): Namespace the specified replicaSet belongs to.
  - `--name` (path, required): Name of the specified replicaSet.

### `dce container-management apps get-replica-set-json`

- Summary: GetReplicaSetJSON gets replicaset yaml in specified namespace of a cluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/replicasets/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified replicaSet belongs to.
  - `--namespace` (path, required): Namespace the specified replicaSet belongs to.
  - `--name` (path, required): Name represents for the replicaSet name.

### `dce container-management apps get-stateful-set`

- Summary: GetStatefulSet gets a statefulSets under the namespaces of a specific
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/statefulsets/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which namespace the workload belongs to.
  - `--namespace` (path, required): Cluster represents which namespace the workload belongs to.
  - `--name` (path, required): Name represents the name of workload to belongs to.

### `dce container-management apps get-workload-json`

- Summary: GetWorkloadJSON gets workload by JSON under the namespaces of a specific
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/{kind}/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the Workload belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the Workload belongs to.
  - `--kind` (path, required, one of: deployments|statefulsets|daemonsets|jobs|cronjobs|pods|replicasets): WorkloadKind the workload of kind
  - `--name` (path, required): Name represents the name of Workload
  - `--stable` (query): If stable is true, the v1 version under the corresponding package will be returned.

### `dce container-management apps list-all-daemon-sets`

- Summary: List DaemonSets across all namespaces in a cluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/asl/daemonsets`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): Cluster represents which cluster the workloads belongs to.
  - `--namespace` (query): Cluster represents which namespace the workloads belongs to.
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--name` (query): Name represents the name of workloads to search
  - `--phase` (query, default `WORKLOAD_STATE_UNSPECIFIED`, one of: WORKLOAD_STATE_UNSPECIFIED|Running|Deleting|Not_Ready|Stopped|Waiting): Phase represents the phase of workloads to search
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the data list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--show-virtual-cluster` (query): ShowVirtualCluster is used to control whether to return data that belongs to a virtual cluster. Default false.
  - `--gpu-type` (query): gpu_type is filter with pods resources, when value is * search all
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`, `revision`; pagination `offset`

### `dce container-management apps list-all-deployments`

- Summary: List Deployments across all namespaces in a cluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/asl/deployments`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): Cluster represents which cluster the workloads belongs to.
  - `--namespace` (query): Cluster represents which namespace the workloads belongs to.
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--name` (query): Name represents the name of workloads to search
  - `--phase` (query, default `WORKLOAD_STATE_UNSPECIFIED`, one of: WORKLOAD_STATE_UNSPECIFIED|Running|Deleting|Not_Ready|Stopped|Waiting): Phase represents the phase of workloads to search
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the data list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--show-virtual-cluster` (query): ShowVirtualCluster is used to control whether to return data that belongs to a virtual cluster. Default false.
  - `--gpu-type` (query): gpu_type is filter with pods resources, when value is * search all
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`, `revision`; pagination `offset`

### `dce container-management apps list-all-stateful-sets`

- Summary: List StatefulSets across all namespaces in a cluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/asl/statefulsets`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): Cluster represents which cluster the workloads belongs to.
  - `--namespace` (query): Cluster represents which namespace the workloads belongs to.
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--name` (query): Name represents the name of workloads to search
  - `--phase` (query, default `WORKLOAD_STATE_UNSPECIFIED`, one of: WORKLOAD_STATE_UNSPECIFIED|Running|Deleting|Not_Ready|Stopped|Waiting): Phase represents the phase of workloads to search
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the data list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--show-virtual-cluster` (query): ShowVirtualCluster is used to control whether to return data that belongs to a virtual cluster. Default false.
  - `--gpu-type` (query): gpu_type is filter with pods resources, when value is * search all
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`, `revision`; pagination `offset`

### `dce container-management apps list-cluster-daemon-sets`

- Summary: ListClusterDaemonSets lists DaemonSet in one cluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/daemonsets`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents the name of Workload to belongs to.
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--name` (query): Name represents the name of workloads to search
  - `--phase` (query, default `WORKLOAD_STATE_UNSPECIFIED`, one of: WORKLOAD_STATE_UNSPECIFIED|Running|Deleting|Not_Ready|Stopped|Waiting): Phase represents the phase of workloads to search
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the data list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--gpu-type` (query): gpu_type is filter with pods resources, when value is * search all
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`, `revision`; pagination `offset`

### `dce container-management apps list-cluster-deployments`

- Summary: ListClusterDeployments lists one cluster all namespace's deployments
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/deployments`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents the name of Workload to belongs to.
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--name` (query): Name represents the name of workloads to search
  - `--phase` (query, default `WORKLOAD_STATE_UNSPECIFIED`, one of: WORKLOAD_STATE_UNSPECIFIED|Running|Deleting|Not_Ready|Stopped|Waiting): Phase represents the phase of workloads to search
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the data list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--gpu-type` (query): gpu_type is filter with pods resources, when value is * search all
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`, `revision`; pagination `offset`

### `dce container-management apps list-cluster-replica-sets`

- Summary: ListClusterReplicaSets lists replicasets of a cluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/replicasets`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified replicaset belongs to.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): PageSize is the data number per page.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the list order.
  - `--name` (query): Name is used for query.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--gpu-type` (query): gpu_type is filter with pods resources, when value is * search all
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management apps list-cluster-stateful-sets`

- Summary: ListClusterStatefulSets lists one cluster all namespace's statefulsets
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/statefulsets`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents the name of Workload to belongs to.
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--name` (query): Name represents the name of workloads to search
  - `--phase` (query, default `WORKLOAD_STATE_UNSPECIFIED`, one of: WORKLOAD_STATE_UNSPECIFIED|Running|Deleting|Not_Ready|Stopped|Waiting): Phase represents the phase of workloads to search
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the data list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--gpu-type` (query): gpu_type is filter with pods resources, when value is * search all
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`, `revision`; pagination `offset`

### `dce container-management apps list-config-maps-related-workloads`

- Summary: ListConfigMapsRelatedWorkloads list all workloads associated with this cm
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/configmaps/{configmap}/related`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--configmap` (path, required): configmap
- Output: list path `daemonsets`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`, `revision`

### `dce container-management apps list-controller-revisions`

- Summary: query like controllerrevisions?kind=STATEFULSET
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/controllerrevisions`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified controllerrevision belongs to.
  - `--namespace` (path, required): Namespace the specified controllerrevision belongs to.
  - `--kind` (query, default `KIND_UNSPECIFIED`, one of: KIND_UNSPECIFIED|StatefulSet|DaemonSet): Kind stands for what type of revisions are needed.
  - `--kind-name` (query): The name of involvedObject.
  - `--name` (query): Name stands for controllerrevision name, used for fuzzy search.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): SortDir determines the data list order.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`, `revision`; pagination `offset`

### `dce container-management apps list-daemon-sets`

- Summary: List DaemonSets in a namespace
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/daemonsets`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the deployment belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the deployment belongs to.
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--name` (query): Name represents the name of workloads to search
  - `--phase` (query, default `WORKLOAD_STATE_UNSPECIFIED`, one of: WORKLOAD_STATE_UNSPECIFIED|Running|Deleting|Not_Ready|Stopped|Waiting): Phase represents the phase of workloads to search
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the data list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--gpu-type` (query): gpu_type is filter with pods resources, when value is * search all
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`, `revision`; pagination `offset`

### `dce container-management apps list-deployments`

- Summary: List Deployments in a namespace
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/deployments`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the deployment belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the deployment belongs to.
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--name` (query): Name represents the name of workloads to search
  - `--phase` (query, default `WORKLOAD_STATE_UNSPECIFIED`, one of: WORKLOAD_STATE_UNSPECIFIED|Running|Deleting|Not_Ready|Stopped|Waiting): Phase represents the phase of workloads to search
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the data list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--gpu-type` (query): gpu_type is filter with pods resources, when value is * search all
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`, `revision`; pagination `offset`
- Example: `dce container-management apps list-deployments \ --cluster prod-cluster \ --namespace default`

### `dce container-management apps list-replica-sets`

- Summary: ListReplicaSets lists replicasets in specified namespace of a cluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/replicasets`
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
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): PageSize is size of every page.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--gpu-type` (query): gpu_type is filter with pods resources, when value is * search all
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management apps list-secrets-related-workloads`

- Summary: ListSecretsRelatedWorkloads list all workloads associated with this secret
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/secrets/{secret}/related`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--secret` (path, required): secret
- Output: list path `daemonsets`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`, `revision`

### `dce container-management apps list-stateful-sets`

- Summary: List StatefulSets in a namespace
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/statefulsets`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the deployment belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the deployment belongs to.
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--name` (query): Name represents the name of workloads to search
  - `--phase` (query, default `WORKLOAD_STATE_UNSPECIFIED`, one of: WORKLOAD_STATE_UNSPECIFIED|Running|Deleting|Not_Ready|Stopped|Waiting): Phase represents the phase of workloads to search
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the data list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--gpu-type` (query): gpu_type is filter with pods resources, when value is * search all
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`, `revision`; pagination `offset`

### `dce container-management apps patch-daemon-set`

- Summary: PatchDaemonSet gets a daemonset under the namespaces of a specific cluster
- HTTP: `PATCH /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/daemonsets/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): The cluster which the deployment belongs to.
  - `--namespace` (path, required): The namespace which the deployment belongs to.
  - `--name` (path, required): The name of the deployment.

### `dce container-management apps patch-deployment`

- Summary: PatchDeployment patches a deployment under the namespaces of a
- HTTP: `PATCH /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/deployments/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): The cluster which the deployment belongs to.
  - `--namespace` (path, required): The namespace which the deployment belongs to.
  - `--name` (path, required): The name of the deployment.

### `dce container-management apps patch-stateful-set`

- Summary: PatchStatefulSet update a statefulSet under the namespaces of a specific
- HTTP: `PATCH /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/statefulsets/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): The cluster which the deployment belongs to.
  - `--namespace` (path, required): The namespace which the deployment belongs to.
  - `--name` (path, required): The name of the deployment.

### `dce container-management apps pause-deployment`

- Summary: PauseDeployment pauses a deployment under the namespaces of a specific
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/deployments/{name}:pause`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the deployment belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the deployment belongs to.
  - `--name` (path, required): Name represents the name of deployment

### `dce container-management apps restart-daemon-set`

- Summary: RestartDaemonSet restarts a daemonSets under the namespaces of a specific
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/daemonsets/{name}:restart`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified daemonset belongs to.
  - `--namespace` (path, required): Namespace the specified daemonset belongs to.
  - `--name` (path, required): Daemonset name.

### `dce container-management apps restart-deployment`

- Summary: RestartDeployment restarts a deployment under the namespaces of a specific
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/deployments/{name}:restart`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the deployment belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the deployment belongs to.
  - `--name` (path, required): Name represents the name of deployment

### `dce container-management apps restart-stateful-set`

- Summary: RestartStatefulSet restarts a statefulSet under the namespaces of a
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/statefulsets/{name}:restart`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified statefulset belongs to.
  - `--namespace` (path, required): Namespace the specified statefulset belongs to.
  - `--name` (path, required): StatefulSet name.

### `dce container-management apps resume-deployment`

- Summary: ResumeDeployment resumes a deployment under the namespaces of a specific
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/deployments/{name}:resume`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the deployment belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the deployment belongs to.
  - `--name` (path, required): Name represents the name of deployment

### `dce container-management apps rollback-daemon-set`

- Summary: RollbackDaemonSet rollbacks a daemonSets under the namespaces of a specific
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/daemonsets/{name}:rollback`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified daemonset belongs to.
  - `--namespace` (path, required): Namespace the specified daemonset belongs to.
  - `--name` (path, required): Daemonset name.

### `dce container-management apps rollback-deployment`

- Summary: RollbackDeployment rollbacks a deployment under the namespaces of a
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/deployments/{name}:rollback`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the deployment belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the deployment belongs to.
  - `--name` (path, required): Name represents the name of deployment

### `dce container-management apps rollback-stateful-set`

- Summary: RollbackStatefulSet rollbacks a statefulSet under the namespaces of a
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/statefulsets/{name}:rollback`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified statefulset belongs to.
  - `--namespace` (path, required): Namespace the specified statefulset belongs to.
  - `--name` (path, required): StatefulSet name.

### `dce container-management apps start-deployment`

- Summary: StartDeployment starts a deployment under the namespace of a specific cluster
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/deployments/{name}:start`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the deployment belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the deployment belongs to.
  - `--name` (path, required): Name represents the name of deployment.

### `dce container-management apps start-stateful-set`

- Summary: StartStatefulSet starts a statefulset under the namespace of a specific cluster
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/statefulsets/{name}:start`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the statefulset belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the statefulset belongs to.
  - `--name` (path, required): Name represents the name of statefulset.

### `dce container-management apps stop-deployment`

- Summary: StopDeployment starts a deployment under the namespace of a specific cluster
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/deployments/{name}:stop`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the deployment belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the deployment belongs to.
  - `--name` (path, required): Name represents the name of deployment.

### `dce container-management apps stop-stateful-set`

- Summary: StopStatefulSet starts a statefulset under the namespace of a specific cluster
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/statefulsets/{name}:stop`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the statefulset belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the statefulset belongs to.
  - `--name` (path, required): Name represents the name of statefulset.

### `dce container-management apps update-replica-set`

- Summary: UpdateReplicaSet updates a replicaset in specified namespace of a cluster
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/replicasets/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified replicaSet belongs to.
  - `--namespace` (path, required): Namespace the specified replicaSet belongs to.
  - `--name` (path, required): Name of the specified replicaSet.

### `dce container-management apps update-workload-by-json`

- Summary: UpdateWorkloadByJSON updates workload by JSON under the namespaces of a
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/{kind}/{name}/json`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the Workload belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the Workload belongs to.
  - `--kind` (path, required, one of: deployments|statefulsets|daemonsets|jobs|cronjobs|pods|replicasets): WorkloadKind the workload of kind
  - `--name` (path, required): Name represents the name of Workload

## Autoscaling

### `dce container-management autoscaling create-cluster-resource-override`

- Summary: CreateClusterResourceOverride creates a cro by given json.
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/clusterresourceoverride`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster defines the cluster name.

### `dce container-management autoscaling create-cron-horizontal-pod-autoscaler`

- Summary: CreateCronHorizontalPodAutoscaler creates a cron hpa by given json.
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/cronhorizontalpodautoscalers`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified hpa belongs to.
  - `--namespace` (path, required): When the current namespace is named, the priority is higher than that in yaml

### `dce container-management autoscaling create-horizontal-pod-autoscaler`

- Summary: CreateHorizontalPodAutoscaler creates a hpa by given json.
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/horizontalpodautoscalers`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified hpa belongs to.
  - `--namespace` (path, required): When the current namespace is named, the priority is higher than that in yaml

### `dce container-management autoscaling create-vertical-pod-autoscaler`

- Summary: CreateVerticalPodAutoscaler creates a vpa by given json.
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/verticalpodautoscalers`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified vpa belongs to.
  - `--namespace` (path, required): Namespace of the vpa.

### `dce container-management autoscaling delete-cluster-resource-override`

- Summary: DeleteClusterResourceOverride deletes a cro by name.
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/clusterresourceoverride/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster defines the cluster name.
  - `--name` (path, required): name defines the name of ClusterResourceOverride.

### `dce container-management autoscaling delete-cron-horizontal-pod-autoscaler`

- Summary: DeleteCronHorizontalPodAutoscaler deletes a cron hpa by given name.
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/cronhorizontalpodautoscalers/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the hpa belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced hpa.
  - `--name` (path, required): Name is the metadata.name of the referenced hpa.

### `dce container-management autoscaling delete-horizontal-pod-autoscaler`

- Summary: DeleteHorizontalPodAutoscaler deletes a hpa by given name.
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/horizontalpodautoscalers/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the hpa belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced hpa.
  - `--name` (path, required): Name is the metadata.name of the referenced hpa.

### `dce container-management autoscaling delete-vertical-pod-autoscaler`

- Summary: DeleteVerticalPodAutoscaler deletes a vpa by given name.
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/verticalpodautoscalers/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the vpa belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced vpa.
  - `--name` (path, required): Name is the metadata.name of the vpa.

### `dce container-management autoscaling get-cluster-resource-override`

- Summary: GetClusterResourceOverride gets a cro by name.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/clusterresourceoverride/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster defines the cluster name.
  - `--name` (path, required): name defines the name of ClusterResourceOverride.

### `dce container-management autoscaling get-cron-horizontal-pod-autoscaler-json`

- Summary: GetCronHorizontalPodAutoscalerJSON gets the cron hpa by namespace and name,
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/cronhorizontalpodautoscalers/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the pod belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced HorizontalPodAutoscaler.
  - `--name` (path, required): HorizontalPodAutoscaler name.
  - `--stable` (query): If stable is true, the v2 version under the corresponding package will be returned.

### `dce container-management autoscaling get-horizontal-pod-autoscaler-json`

- Summary: GetHorizontalPodAutoscalerJSON gets the hpa by namespace and name,
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/horizontalpodautoscalers/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the pod belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced HorizontalPodAutoscaler.
  - `--name` (path, required): HorizontalPodAutoscaler name.
  - `--stable` (query): If stable is true, the v2 version under the corresponding package will be returned.

### `dce container-management autoscaling get-vertical-pod-autoscaler-json`

- Summary: GetVerticalPodAutoscalerJSON gets a vpa by namespace and name, returning a string in JSON format.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/verticalpodautoscalers/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the vpa belongs to.
  - `--namespace` (path, required): Namespace of the vpa.
  - `--name` (path, required): Name of the vpa.
  - `--stable` (query): If stable is true, the v2 version under the corresponding package will be returned.

### `dce container-management autoscaling list-cron-horizontal-pod-autoscalers`

- Summary: ListCronHorizontalPodAutoscalers lists cron hpas in the specified cluster and namespace.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/cronhorizontalpodautoscalers`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the hpa belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced hpa.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--kind` (query, default `KIND_UNSPECIFIED`, one of: KIND_UNSPECIFIED|Deployment|StatefulSet|ReplicaSet): The kind of hpa targetRef.
  - `--name` (query): The workload name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management autoscaling list-custom-metric-summary`

- Summary: ListCustomMetricsSummary return the custom metrics for specified
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/custommetricsummary`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the custom metrics belongs to.
  - `--kind` (query, default `KIND_UNSPECIFIED`, one of: KIND_UNSPECIFIED|Pod|Service): The kind of hpa targetRef.
- Output: list path `items`

### `dce container-management autoscaling list-horizontal-pod-autoscalers`

- Summary: ListHorizontalPodAutoscalers lists hpas in the specified cluster and namespace.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/horizontalpodautoscalers`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the hpa belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced hpa.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--kind` (query, default `KIND_UNSPECIFIED`, one of: KIND_UNSPECIFIED|Deployment|StatefulSet|ReplicaSet): The kind of hpa targetRef.
  - `--name` (query): The workload name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `status.phase`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management autoscaling list-metric-values`

- Summary: ListMetricValueList returns a list of metrics values for a given
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/metricvalues`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the hpa belongs to.
  - `--namespace` (path, required): namespace
  - `--kind` (query, default `KIND_UNSPECIFIED`, one of: KIND_UNSPECIFIED|Pod|Service): The kind of metrics.
  - `--kind-name` (query): kindName
  - `--name` (query): The exact name of metric.
- Output: list path `items`; columns `metricName`, `timestamp`, `value`

### `dce container-management autoscaling list-vertical-pod-autoscalers`

- Summary: ListVerticalPodAutoscalers lists vpas in the specified cluster and namespace.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/verticalpodautoscalers`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the vpa belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced vpa.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--kind` (query, default `KIND_UNSPECIFIED`, one of: KIND_UNSPECIFIED|Deployment|StatefulSet|DaemonSet|ReplicaSet|Job|CronJob|ReplicationController): The kind of vpa targetRef.
  - `--kind-name` (query): The name of the targetRef.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management autoscaling update-cluster-resource-override`

- Summary: UpdateClusterResourceOverride updates a cro by given json.
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/clusterresourceoverride`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster defines the cluster name.

### `dce container-management autoscaling update-cron-horizontal-pod-autoscaler`

- Summary: UpdateCronHorizontalPodAutoscaler updates the specified cron hpa, the body must
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/cronhorizontalpodautoscalers/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified hpa belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced hpa.
  - `--name` (path, required): name represents for the resource name

### `dce container-management autoscaling update-horizontal-pod-autoscaler`

- Summary: UpdateHorizontalPodAutoscaler updates the specified hpa, the body must
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/horizontalpodautoscalers/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified hpa belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced hpa.
  - `--name` (path, required): name represents for the resource name

### `dce container-management autoscaling update-vertical-pod-autoscaler`

- Summary: UpdateVerticalPodAutoscaler updates the specified vpa, the body must
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/verticalpodautoscalers/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified vpa belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced vpa.
  - `--name` (path, required): Name represents for the resource name.

## Batch

### `dce container-management batch delete-cron-job`

- Summary: DeleteCronJob deletes a cronJob under the namespaces of a specific cluster
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/cronjobs/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the cronjob belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the cronjob belongs to.
  - `--name` (path, required): Cronjob name.

### `dce container-management batch delete-job`

- Summary: DeleteJob deletes a job under the namespaces of a specific cluster
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/jobs/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified job belongs to.
  - `--namespace` (path, required): Namespace the specified job belongs to.
  - `--name` (path, required): Name of the job.

### `dce container-management batch get-cron-job`

- Summary: GetCronJob gets a cronJob under the namespaces of a specific cluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/cronjobs/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the cronjob belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the cronjob belongs to.
  - `--name` (path, required): Cronjob name.
- Output: list path `images`

### `dce container-management batch get-job`

- Summary: GetJob gets a job under the namespaces of a specific cluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/jobs/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified job belongs to.
  - `--namespace` (path, required): Namespace the specified service belongs to.
  - `--name` (path, required): Name of the job.

### `dce container-management batch list-all-cron-jobs`

- Summary: ListAllCronJobs lists all clusters cronjob
- HTTP: `GET /apis/kpanda.io/v1alpha1/asl/cronjobs`
- Auth: required
- Body: none
- Flags:
  - `--clusters` (query): Cluster the specified job belongs to.
  - `--namespace` (query): Namespace the specified service belongs to.
  - `--job-state` (query, default `JOB_STATE_UNSPECIFIED`, one of: JOB_STATE_UNSPECIFIED|Waiting|Running|Completed|Deleting|Failed): Job_state represents the current state of a job.
  - `--cronjob-state` (query, default `CRONJOB_STATE_UNSPECIFIED`, one of: CRONJOB_STATE_UNSPECIFIED|Waiting_CronJob|Activated_CronJob|Stopped_CronJob|Deleting_CronJob): cronjob_state represents the current state of a cron job.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the list order.
  - `--name` (query): Name of the job.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--show-virtual-cluster` (query): ShowVirtualCluster is used to control whether to return data that belongs to a virtual cluster. Default false.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `status.phase`, `metadata.creationTimestamp`, `availed`, `executionTimestamp`; pagination `offset`

### `dce container-management batch list-all-jobs`

- Summary: ListAllJobs lists all cluster jobs
- HTTP: `GET /apis/kpanda.io/v1alpha1/asl/jobs`
- Auth: required
- Body: none
- Flags:
  - `--clusters` (query): Cluster the specified job belongs to.
  - `--namespace` (query): Namespace the specified service belongs to.
  - `--job-state` (query, default `JOB_STATE_UNSPECIFIED`, one of: JOB_STATE_UNSPECIFIED|Waiting|Running|Completed|Deleting|Failed): Job_state represents the current state of a job.
  - `--cronjob-state` (query, default `CRONJOB_STATE_UNSPECIFIED`, one of: CRONJOB_STATE_UNSPECIFIED|Waiting_CronJob|Activated_CronJob|Stopped_CronJob|Deleting_CronJob): cronjob_state represents the current state of a cron job.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the list order.
  - `--name` (query): Name of the job.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--show-virtual-cluster` (query): ShowVirtualCluster is used to control whether to return data that belongs to a virtual cluster. Default false.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `status.phase`, `metadata.creationTimestamp`, `executionTimestamp`; pagination `offset`

### `dce container-management batch list-cluster-cron-jobs`

- Summary: ListClusterCronJobs lists cluster cronJobs under the namespaces of a
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/cronjobs`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified job belongs to.
  - `--namespace` (path, required): Namespace the specified service belongs to.
  - `--job-state` (query, default `JOB_STATE_UNSPECIFIED`, one of: JOB_STATE_UNSPECIFIED|Waiting|Running|Completed|Deleting|Failed): Job_state represents the current state of a job.
  - `--cronjob-state` (query, default `CRONJOB_STATE_UNSPECIFIED`, one of: CRONJOB_STATE_UNSPECIFIED|Waiting_CronJob|Activated_CronJob|Stopped_CronJob|Deleting_CronJob): cronjob_state represents the current state of a cron job.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the list order.
  - `--name` (query): Name of the job.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--gpu-type` (query): gpu_type is filter with pods resources, when value is * search all
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `status.phase`, `metadata.creationTimestamp`, `availed`, `executionTimestamp`; pagination `offset`

### `dce container-management batch list-cluster-jobs`

- Summary: ListClusterJobs list cluster jobs under the namespaces of a specific
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/jobs`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified job belongs to.
  - `--namespace` (path, required): Namespace the specified service belongs to.
  - `--job-state` (query, default `JOB_STATE_UNSPECIFIED`, one of: JOB_STATE_UNSPECIFIED|Waiting|Running|Completed|Deleting|Failed): Job_state represents the current state of a job.
  - `--cronjob-state` (query, default `CRONJOB_STATE_UNSPECIFIED`, one of: CRONJOB_STATE_UNSPECIFIED|Waiting_CronJob|Activated_CronJob|Stopped_CronJob|Deleting_CronJob): cronjob_state represents the current state of a cron job.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the list order.
  - `--name` (query): Name of the job.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--gpu-type` (query): gpu_type is filter with pods resources, when value is * search all
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `status.phase`, `metadata.creationTimestamp`, `executionTimestamp`; pagination `offset`

### `dce container-management batch list-cron-jobs`

- Summary: List CronJobs in a namespace
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/cronjobs`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified job belongs to.
  - `--job-state` (query, default `JOB_STATE_UNSPECIFIED`, one of: JOB_STATE_UNSPECIFIED|Waiting|Running|Completed|Deleting|Failed): Job_state represents the current state of a job.
  - `--cronjob-state` (query, default `CRONJOB_STATE_UNSPECIFIED`, one of: CRONJOB_STATE_UNSPECIFIED|Waiting_CronJob|Activated_CronJob|Stopped_CronJob|Deleting_CronJob): cronjob_state represents the current state of a cron job.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the list order.
  - `--name` (query): Name of the job.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--gpu-type` (query): gpu_type is filter with pods resources, when value is * search all
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `status.phase`, `metadata.creationTimestamp`, `availed`, `executionTimestamp`; pagination `offset`

### `dce container-management batch list-jobs`

- Summary: List Jobs in a namespace
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/jobs`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified job belongs to.
  - `--job-state` (query, default `JOB_STATE_UNSPECIFIED`, one of: JOB_STATE_UNSPECIFIED|Waiting|Running|Completed|Deleting|Failed): Job_state represents the current state of a job.
  - `--cronjob-state` (query, default `CRONJOB_STATE_UNSPECIFIED`, one of: CRONJOB_STATE_UNSPECIFIED|Waiting_CronJob|Activated_CronJob|Stopped_CronJob|Deleting_CronJob): cronjob_state represents the current state of a cron job.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the list order.
  - `--name` (query): Name of the job.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--gpu-type` (query): gpu_type is filter with pods resources, when value is * search all
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `status.phase`, `metadata.creationTimestamp`, `executionTimestamp`; pagination `offset`

### `dce container-management batch list-jobs-by-cron-jobs-name`

- Summary: ListJobsByCronJobsName lists Jobs By CronJobs's Name under the namespaces
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/cronjobs/{cronjob}/jobs`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the cronjob belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the cronjob belongs to.
  - `--cronjob` (path, required): Cronjob name.
  - `--phase` (query): Represents the current state of a cron job.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the job list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the job list order.
  - `--name` (query): Cronjob name.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `status.phase`, `metadata.creationTimestamp`, `executionTimestamp`; pagination `offset`

### `dce container-management batch pause-cron-job`

- Summary: PauseCronJob pauses a cronjob under the namespaces of a specific
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/cronjobs/{name}:pause`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the cronjob belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the cronjob belongs to.
  - `--name` (path, required): Name represents the name of cronjob

### `dce container-management batch restart-job`

- Summary: RestartJob restarts a job under the namespaces of a specific
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/jobs/{name}:restart`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified job belongs to.
  - `--namespace` (path, required): Namespace the specified job belongs to.
  - `--name` (path, required): Name of the job.

### `dce container-management batch resume-cron-job`

- Summary: ResumeCronJob resumes a cronjob under the namespaces of a specific
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/cronjobs/{name}:resume`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the cronjob belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the cronjob belongs to.
  - `--name` (path, required): Name represents the name of cronjob

## CloudShell

### `dce container-management cloudshell create-cloud-shell`

- Summary: CreateCloudShell create a cloudshell in golobal cluster.
- HTTP: `POST /apis/kpanda.io/v1alpha1/cloudshells`
- Auth: required
- Body: required
- Flags: none

### `dce container-management cloudshell delete-cloud-shell`

- Summary: DeleteCloudShell delete a cloudshell in golobal cluster.
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/cloudshells/{name}`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): name specified the cloudshell name.

### `dce container-management cloudshell get-cloud-shell`

- Summary: GetCloudShell get a cloudshell in golobal cluster.
- HTTP: `GET /apis/kpanda.io/v1alpha1/cloudshells/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name specified the cloudshell name.

## Cluster

### `dce container-management cluster create-cluster`

- Summary: Register or create a cluster
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters`
- Auth: required
- Body: required
- Flags: none
- Example: `dce container-management cluster create-cluster --file cluster.json`

### `dce container-management cluster create-open-api-cluster-cert`

- Summary: CreateOpenAPIClusterCert creates openAPI cluster cert
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/clustercert`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): one of cluster or kubeSystemID has value

### `dce container-management cluster create-open-api-cluster-cert-by-kube-system-id`

- Summary: CreateOpenAPIClusterCertByKubeSystemID creates openAPI cluster cert by
- HTTP: `POST /apis/kpanda.io/v1alpha1/kubesystemid/{kubeSystemID}/clustercert`
- Auth: required
- Body: required
- Flags:
  - `--kube-system-id` (path, required): kubeSystemID is the cluster system ID.

### `dce container-management cluster delete-cluster`

- Summary: Remove a cluster from management
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{name}`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): Name is the user-specified identifier.

### `dce container-management cluster edit-cluster-labels`

- Summary: EditClusterLabels edits the specified cluster's labels
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{name}/labels`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): Name is the user-specified identifier.

### `dce container-management cluster get-cluster`

- Summary: Get cluster details
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): Name is the user-specified identifier.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--status` (query): Status represents the current state of cluster.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the list order.
  - `--exclude-metrics` (query): exclude_metrics
- Output: pagination `offset`
- Example: `dce container-management cluster get-cluster --name prod-cluster`

### `dce container-management cluster get-cluster-kube-config`

- Summary: Download kubeconfig for a cluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/kubeconfig`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
- Example: `dce container-management cluster get-cluster-kube-config --cluster prod-cluster -o raw > kubeconfig.yaml`

### `dce container-management cluster list-all-cluster-gpu`

- Summary: ListClusters lists kpanda cr resources
- HTTP: `GET /apis/kpanda.io/v1alpha1/gpus`
- Auth: required
- Body: none
- Flags: none
- Output: list path `items`; columns `uuid`, `modelName`, `memory`

### `dce container-management cluster list-cluster-preferred-resources`

- Summary: Cluster_ListClusterPreferredResources
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/preferredresources`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster belongs to.
  - `--namespaced` (query): namespaced indicates whether this resource is cluster or namespace scoped.
- Output: list path `resources`; columns `groupVersion`

### `dce container-management cluster list-cluster-summary`

- Summary: List cluster summary (lightweight)
- HTTP: `GET /apis/kpanda.io/v1alpha1/clustersummary`
- Auth: required
- Body: none
- Flags:
  - `--show-virtual-cluster` (query): ShowVirtualCluster is used to control whether returned data contains
  - `--filter-by-strategy` (query): FilterByStrategy is to list all the clusters without strategies if true, default false.
  - `--filter-by-snapshot` (query): FilterBySnapshot is to list all the clusters which has snapshot if true, default false.
  - `--show-shim-cluster` (query): ShowShimCluster is used to control whether returned clusters contain shim cluster, default false.
- Output: list path `clusterSummary`; columns `name`, `phase`, `kubeSystemID`

### `dce container-management cluster list-clusters`

- Summary: List all managed clusters
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters`
- Auth: required
- Body: none
- Flags:
  - `--name` (query): Name is the user-specified identifier.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--role` (query, default `CLUSTER_ROLE_UNSPECIFIED`, one of: CLUSTER_ROLE_UNSPECIFIED|CLUSTER_ROLE_MANAGER|CLUSTER_ROLE_GLOBAL_SERVICE|CLUSTER_ROLE_WORKER|CLUSTER_ROLE_THIRD_PARTY): role
  - `--kubernetes-version` (query): KUBERNETESVERSION cluster k8s version use to support search sub cluster at
  - `--phase` (query, default `CLUSTER_PHASE_UNSPECIFIED`, one of: CLUSTER_PHASE_UNSPECIFIED|Unknown|Creating|Running|Updating|Deleting|Failed|DeleteFailed): Phase is used for filter.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter clusters.
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter the clusters.
  - `--managed-by` (query): ManagedBy represents who manages the cluster
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the cluster list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the cluster list order.
  - `--show-virtual-cluster` (query): ShowVirtualCluster is used to control whether returned data contains
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by cluster name or cluster alias name.
  - `--exclude-metrics` (query): exclude_metrics
  - `--show-shim-cluster` (query): ShowShimCluster is used to control whether returned clusters contain shim cluster, default false.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `status.phase`, `spec.provider`, `spec.region`, `metadata.creationTimestamp`; pagination `offset`
- Example: `dce container-management cluster list-clusters dce container-management cluster list-clusters -o json | jq '.items[].name'`

### `dce container-management cluster update-clusters`

- Summary: Update cluster configuration
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{name}`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): Name is the user-specified identifier.

### `dce container-management cluster validate-cluster`

- Summary: ValidateCluster checks if residuals which affect integrating exist in a cluster
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{name}/validate`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): Name is the user-specified identifier.

### `dce container-management cluster validate-kube-config`

- Summary: Validate a kubeconfig before registration
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/validate`
- Auth: required
- Body: required
- Flags: none

## ClusterSetting

### `dce container-management clustersetting disable-plugin`

- Summary: Disable a plugin so that it can be shown by the frontend.
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/settings/plugins/{name}:disable`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): The cluster name of the clustersetting.
  - `--name` (path, required, one of: PLUGIN_NAME_UNSPECIFIED|HPA|Insight|GPU|METALLB|Spiderpool|CustomMetrics|CronHPA|VPA|Hwameistor|Flannel|KubeOvn|OLM|EgressGateway|Snapshot|DRA): The name of the plugin which needs to disable.

### `dce container-management clustersetting enable-plugin`

- Summary: Enable a plugin so that it can be shown by the frontend.
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/settings/plugins/{name}:enable`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): The cluster name of the clustersetting.
  - `--name` (path, required, one of: PLUGIN_NAME_UNSPECIFIED|HPA|Insight|GPU|METALLB|Spiderpool|CustomMetrics|CronHPA|VPA|Hwameistor|Flannel|KubeOvn|OLM|EgressGateway|Snapshot|DRA): The name of the plugin which needs to enable.

### `dce container-management clustersetting get-cluster-setting`

- Summary: Gets the setting under a given cluster.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/settings`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): The cluster name of the clustersetting.
- Output: list path `network`; columns `name`, `enabled`, `externalAddress`, `healthy`, `intelligentDetection`, `setting`

### `dce container-management clustersetting list-gpu-setting`

- Summary: ClusterSetting_ListGPUSetting
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/settings/gpu`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): The cluster name of the clustersetting.
  - `--available-enable` (query): if available_enable is true will return available gpu number
- Output: list path `items`; columns `type`, `alias`, `isDynamic`

### `dce container-management clustersetting list-plugins`

- Summary: Lists plugins under a given cluster.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/settings/plugins`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): The cluster name of the clustersetting.
- Output: list path `data`; columns `name`, `enabled`, `externalAddress`, `healthy`, `intelligentDetection`, `setting`

### `dce container-management clustersetting update-cluster-setting`

- Summary: UpdateClusterSetting will update the cluster setting and returns the settings
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/settings`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): one of cluster or kubeSystemID has value
- Output: list path `network`; columns `name`, `enabled`, `externalAddress`, `healthy`, `intelligentDetection`, `setting`

## Clusterlcm

### `dce container-management clusterlcm batch-add-node`

- Summary: Clusterlcm_BatchAddNode
- HTTP: `POST /apis/kpanda.io/v1alpha1/cluster-lcm/{cluster}/nodes`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster

### `dce container-management clusterlcm check-cluster`

- Summary: Clusterlcm_CheckCluster
- HTTP: `POST /apis/kpanda.io/v1alpha1/cluster-lcm/{name}:check`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): name

### `dce container-management clusterlcm create-cluster`

- Summary: Register or create a cluster
- HTTP: `POST /apis/kpanda.io/v1alpha1/cluster-lcm`
- Auth: required
- Body: required
- Flags: none
- Example: `dce container-management cluster create-cluster --file cluster.json`

### `dce container-management clusterlcm delete-clusterlcm-ops`

- Summary: Clusterlcm_DeleteClusterlcmOps
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/cluster-lcm/{cluster}/ops/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): The name of the manger cluster.
  - `--name` (path, required): The name of the cluster which needs to be create.

### `dce container-management clusterlcm get-clusterlcm-ops`

- Summary: Clusterlcm_GetClusterlcmOps
- HTTP: `GET /apis/kpanda.io/v1alpha1/cluster-lcm/{cluster}/ops/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): The name of the cluster.
  - `--name` (path, required): The name of the clusterclmOps.

### `dce container-management clusterlcm get-clusterlcm-ops-json`

- Summary: Clusterlcm_GetClusterlcmOpsJSON
- HTTP: `GET /apis/kpanda.io/v1alpha1/cluster-lcm/{cluster}/ops/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): The name of the cluster.
  - `--name` (path, required): The name of the clusterclmOps.

### `dce container-management clusterlcm get-clusterlcm-settings`

- Summary: Clusterlcm_GetClusterlcmSettings
- HTTP: `GET /apis/kpanda.io/v1alpha1/cluster-lcm/{cluster}/settings`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): The name of the cluster which needs to be create.
- Output: list path `preinstallAddons`; columns `repoUrl`

### `dce container-management clusterlcm get-pre-check-cluster-info`

- Summary: Clusterlcm_GetPreCheckClusterInfo
- HTTP: `POST /apis/kpanda.io/v1alpha1/cluster-lcm/{name}/precheck-infos`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): The name of the cluster which needs to be create.

### `dce container-management clusterlcm list-cluster-upgrade-histories`

- Summary: Clusterlcm_ListClusterUpgradeHistories
- HTTP: `GET /apis/kpanda.io/v1alpha1/cluster-lcm/{cluster}/upgrade-histories`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--target-cluster` (query): targetCluster
- Output: list path `upgradeHistories`; columns `phase`, `changeTime`, `kubeVersion`

### `dce container-management clusterlcm list-clusterlcm-ops`

- Summary: Clusterlcm_ListClusterlcmOps
- HTTP: `GET /apis/kpanda.io/v1alpha1/cluster-lcm/{cluster}/ops`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): The name of the cluster.
  - `--name` (query): The fuzzy-name of the clusterclmOps.
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): SortDir determines the order of the data.
  - `--target-cluster` (query): targetCluster
  - `--action` (query, default `ACTION_UNSPECIFIED`, one of: ACTION_UNSPECIFIED|CREATE_CLUSTER|UPGRADE_CLUSTER|RESET_CLUSTER|ADD_NODE|REMOVE_NODE): action
  - `--phase` (query, default `STATUS_UNSPECIFIED`, one of: STATUS_UNSPECIFIED|Running|Succeeded|Failed|Blocked): phase
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by cluster name or cluster alias name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `status.phase`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management clusterlcm list-kube-versions`

- Summary: Clusterlcm_ListKubeVersions
- HTTP: `GET /apis/kpanda.io/v1alpha1/cluster-lcm/{cluster}/available-kube-versions`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
- Output: list path `kubernetesVersions`

### `dce container-management clusterlcm list-runtime-versions`

- Summary: Clusterlcm_ListRuntimeVersions
- HTTP: `GET /apis/kpanda.io/v1alpha1/cluster-lcm/{cluster}/available-runtime-versions`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--kube-version` (query): kubeVersion
- Output: list path `containerdVersions`

### `dce container-management clusterlcm pre-check-cluster`

- Summary: Clusterlcm_PreCheckCluster
- HTTP: `POST /apis/kpanda.io/v1alpha1/cluster-lcm/{name}:precheck`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): The name of the cluster which needs to be create.

### `dce container-management clusterlcm remove-node`

- Summary: Clusterlcm_RemoveNode
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/cluster-lcm/{cluster}/nodes/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--name` (path, required): name

### `dce container-management clusterlcm reset-cluster`

- Summary: Clusterlcm_ResetCluster
- HTTP: `POST /apis/kpanda.io/v1alpha1/cluster-lcm/{name}:reset`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): name

### `dce container-management clusterlcm upgrade-cluster`

- Summary: Clusterlcm_UpgradeCluster
- HTTP: `POST /apis/kpanda.io/v1alpha1/cluster-lcm/{name}:upgrade`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): The name of the cluster which needs to upgrade.

## Core

### `dce container-management core batch-bind-node-to-namespace`

- Summary: BatchBindNodeToNamespace makes the specified node to exclusive.
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/nodes:batchBindNamespace`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster is the cluster for namespace and node.
- Output: list path `failedResults`; columns `error`, `nodeName`

### `dce container-management core compute-limit-range`

- Summary: ComputeLimitRange returns the final effective quota detail of multi limit range in specified namespace
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/limitranges:compute`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified LimitRange belongs to.
  - `--namespace` (path, required): Namespace the specified LimitRange belongs to.

### `dce container-management core compute-resource-quota`

- Summary: ComputeResourceQuota returns the final effective quota detail of multi quotas in specified namespace
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/resourcequotas:compute`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified resourceQuotas belongs to.
  - `--namespace` (path, required): Namespace the specified resourceQuotas belongs to.

### `dce container-management core cordon-node`

- Summary: CordonNode makes the specified node to unschedulable.
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/nodes/{node}/cordon`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified node belongs to.
  - `--node` (path, required): Node name.

### `dce container-management core create-config-map`

- Summary: CreateConfigMap creates a configMap under the namespaces of a specific
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/configmaps`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified configmap belongs to.
  - `--namespace` (path, required): When the current namespace is named, the priority is higher than that in yaml

### `dce container-management core create-limit-range`

- Summary: CreateLimitRange creates a limitrange in the specified cluster and namespace.
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/limitranges`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified limitRange belongs to.
  - `--namespace` (path, required): Namespace the specified limitRange belongs to.

### `dce container-management core create-namespace`

- Summary: CreateNamespace creates a namespace from the system by given namespace name
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster the specified namespace belongs to.

### `dce container-management core create-persistent-volume`

- Summary: CreatePersistentVolume creates a persistentvolume to the system by given persistentvolume data
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/persistentvolumes`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified persistentVolume belongs to.

### `dce container-management core create-persistent-volume-claim`

- Summary: CreatePersistentVolumeClaim create persistent volume claim
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/persistentvolumeclaims`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster represents the cluster of PVC to belongs to.
  - `--namespace` (path, required): namespace represents the namespace of PVC to belongs to.

### `dce container-management core create-resource-quota`

- Summary: CreateResourceQuota creates a resourceQuota to the system by given resourceQuota data
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/resourcequotas`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified resourceQuota belongs to.
  - `--namespace` (path, required): Namespace the specified resourceQuota belongs to.

### `dce container-management core create-secret`

- Summary: CreateSecret creates a secret under the namespaces of a specific cluster
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/secrets`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the secret belongs to.
  - `--namespace` (path, required): When the current namespace is named, the priority is higher than that in yaml

### `dce container-management core create-service`

- Summary: CreateService creates a service to the system by given service data
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/services`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified service belongs to.
  - `--namespace` (path, required): When the current namespace is named, the priority is higher than that in

### `dce container-management core create-service-account`

- Summary: CreateServiceAccount creates a sa from the system by given sa name
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/serviceaccounts`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents the cluster of ServiceAccount to belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced pod.

### `dce container-management core delete-config-map`

- Summary: DeleteConfigMap deletes a configMap under the namespaces of a specific
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/configmaps/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the configmap belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced ConfigMap.
  - `--name` (path, required): Name is the metadata.name of the referenced ConfigMap.

### `dce container-management core delete-limit-range`

- Summary: DeleteLimitRange deletes the limitrange by name.
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/limitranges/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the LimitRange belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced LimitRange.
  - `--name` (path, required): Name represents for the LimitRange name.

### `dce container-management core delete-namespace`

- Summary: DeleteNamespace deletes a namespace from the system by given namespace name
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified namespace belongs to.
  - `--name` (path, required): The name represents for the resource name.

### `dce container-management core delete-persistent-volume`

- Summary: DeletePersistentVolume deletes a persistentvolume from the system by given persistentvolume name
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/persistentvolumes/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the PersistentVolume belongs to.
  - `--name` (path, required): Name represents for the PersistentVolume name.

### `dce container-management core delete-persistent-volume-claim`

- Summary: DeletePersistentVolumeClaim delete the specified pvc
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/persistentvolumeclaims/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents the cluster of PVC to belongs to.
  - `--namespace` (path, required): namespace represents the namespace of PVC to belongs to.
  - `--name` (path, required): name represents the name of PVC to belongs to.

### `dce container-management core delete-pod`

- Summary: DeletePod deletes a pod under the namespaces of a specific cluster
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/pods/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the pod belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced pod.
  - `--name` (path, required): Pod name.

### `dce container-management core delete-secret`

- Summary: DeleteSecret deletes a secret under the namespaces of a specific cluster
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/secrets/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the secret belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced secret.
  - `--name` (path, required): Secret name.

### `dce container-management core delete-service`

- Summary: DeleteService deletes a service from the system by given service name
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/services/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the service belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced service.
  - `--name` (path, required): Name represents for the service name

### `dce container-management core delete-service-account`

- Summary: DeleteServiceAccount deletes a sa from the system by given sa name
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/serviceaccounts/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the ServiceAccount belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced pod.
  - `--name` (path, required): Name represents the name of StorageClass

### `dce container-management core disable-namespace-pod-security`

- Summary: DisableNamespacePodSecurity enables pod security policy of a namespace
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{name}/podsecurity:disable`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster of the namespace.
  - `--name` (path, required): Name represents for the resource name.

### `dce container-management core enable-namespace-pod-security`

- Summary: EnableNamespacePodSecurity enables pod security policy of a namespace
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{name}/podsecurity:enable`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster of the namespace.
  - `--name` (path, required): Name represents for the resource name.

### `dce container-management core get-config-map`

- Summary: GetConfigMap gets a configMap under the namespaces of a specific cluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/configmaps/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the configmap belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced ConfigMap.
  - `--name` (path, required): name represents for the resource name

### `dce container-management core get-config-map-json`

- Summary: GetConfigMapJSON gets a configMap json under the namespaces of a specific
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/configmaps/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the configmap belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced ConfigMap.
  - `--name` (path, required): name represents for the resource name

### `dce container-management core get-limit-range`

- Summary: GetLimitRange gets the limitrange by namespace and name.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/limitranges/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified limitRange belongs to.
  - `--namespace` (path, required): Namespace the specified limitRange belongs to.
  - `--name` (path, required): Name of the specified limitRange.

### `dce container-management core get-limit-range-json`

- Summary: GetLimitRangeJSON gets the limitrange by namespace and name, returns a string in JSON format.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/limitranges/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified limitRange belongs to.
  - `--namespace` (path, required): Namespace the specified limitRange belongs to.
  - `--name` (path, required): Name represents for the limitRange name.

### `dce container-management core get-namespace`

- Summary: GetNamespace gets a namespace from the system by given namespace
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the namespace belongs to.
  - `--name` (path, required): Node name.

### `dce container-management core get-namespace-json`

- Summary: GetNamespaceJSON gets a namespace json from the system by given namespace
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the namespace belongs to.
  - `--name` (path, required): Name represents for the requested namespace name.

### `dce container-management core get-node`

- Summary: GetNode gets a node from the system by given node name
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/nodes/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the node belongs to.
  - `--name` (path, required): Node name.
  - `--show-pods` (query): ShowPods is to control whether returned data contains
  - `--exclude-metrics` (query): exclude_metrics

### `dce container-management core get-node-gpu-stats`

- Summary: GetNodeGPUStats get node gpu stats
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/nodes/{node}/gpu-stats`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--node` (path, required): node

### `dce container-management core get-node-json`

- Summary: GetNodeJSON gets a node's json from the system by given node name
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/nodes/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified node belongs to.
  - `--name` (path, required): Name represents for the node name.

### `dce container-management core get-persistent-volume`

- Summary: GetPersistentVolume gets a persistentvolume from the system by given persistentvolume name
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/persistentvolumes/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified persistentVolume belongs to.
  - `--name` (path, required): Name of the specified persistentVolume.

### `dce container-management core get-persistent-volume-claim`

- Summary: GetPersistentVolumeClaim gets a pvc from the system by given pvc-name;
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/persistentvolumeclaims/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents the name of PVC belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the PVC belongs to.
  - `--name` (path, required): Name represents the name of PVC to search

### `dce container-management core get-persistent-volume-claim-json`

- Summary: GetPersistentVolumeClaimJSON get the specified pvc's JSON
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/persistentvolumeclaims/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents the name of PVC belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the PVC belongs to.
  - `--name` (path, required): Name represents the name of PVC to search

### `dce container-management core get-persistent-volume-json`

- Summary: GetPersistentVolumeJSON gets a persistentvolume json from the system by given persistentvolume name
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/persistentvolumes/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified persistentVolume belongs to.
  - `--name` (path, required): Name represents for the persistentVolume name.

### `dce container-management core get-pod`

- Summary: GetPods will get a pod under the namespaces of a specific cluster by pods
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/pods/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the pod belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced pod.
  - `--name` (path, required): Pod name.

### `dce container-management core get-resource-quota`

- Summary: GetResourceQuota gets a resourceQuota from the system by given resourceQuota name
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/resourcequotas/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified resourceQuota belongs to.
  - `--namespace` (path, required): Namespace the specified resourceQuota belongs to.
  - `--name` (path, required): Name of the specified resourceQuota.

### `dce container-management core get-resource-quota-json`

- Summary: GetResourceQuotaJSON gets a resourceQuota json from the system by given resourceQuota name
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/resourcequotas/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified resourceQuota belongs to.
  - `--namespace` (path, required): Namespace the specified resourceQuota belongs to.
  - `--name` (path, required): Name represents for the resourceQuota name.

### `dce container-management core get-secret`

- Summary: GetClusterSecret gets a secret under the namespaces of a specific cluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/secrets/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the secret belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced secret.
  - `--name` (path, required): Secret name.

### `dce container-management core get-secret-json`

- Summary: GetSecretJSON gets a secret json under the namespaces of a specific cluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/secrets/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the secret belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced secret.
  - `--name` (path, required): Secret name.

### `dce container-management core get-service`

- Summary: GetService gets a service from the system by given service name
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/services/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified service belongs to.
  - `--namespace` (path, required): Namespace the specified service belongs to.
  - `--name` (path, required): Name represents for the service name.

### `dce container-management core get-service-account`

- Summary: GetServiceAccount gets a sa from the system by given sa
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/serviceaccounts/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents the name of PVC to belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced ServiceAccount.
  - `--name` (path, required): name represents the name of ServiceAccount to belongs to.

### `dce container-management core get-service-json`

- Summary: GetServiceJSON gets a service json from the system by given service name
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/services/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified service belongs to.
  - `--namespace` (path, required): Namespace the specified service belongs to.
  - `--name` (path, required): Name represents for the service name.

### `dce container-management core list-all-pods`

- Summary: ListAllPods will list all pod by given cluster and namespace,
- HTTP: `GET /apis/kpanda.io/v1alpha1/asl/pods`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): Cluster represents the pods belongs to, it is a array
  - `--namespace` (query): Namespace is the metadata.namespace of the referenced pod.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--name` (query): Name is used for filter.
  - `--phase` (query, default `PHASE_UNSPECIFIED`, one of: PHASE_UNSPECIFIED|Unknown|Pending|Running|Succeeded|Failed): Phases is used for filter.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--gpu-type` (query): gpu_type is filter with pods resources, when value is * search all
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `status.phase`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management core list-cluster-config-maps`

- Summary: ListClusterConfigMaps lists all configmaps in the specified cluster,
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/configmaps`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified configmap belongs to.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the event list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the list order.
  - `--name` (query): name is used for query.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--only-metadata` (query): OnlyMetadata lists only metadata of configmaps, default false.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`, `immutable`; pagination `offset`

### `dce container-management core list-cluster-event-kinds`

- Summary: ListClusterEventKinds lists all involvedObject's kinds of events in the
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/events/kinds`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the events belongs to.
- Output: list path `data`

### `dce container-management core list-cluster-events`

- Summary: ListClusterEvents lists all events in the specified cluster,
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/events`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the events belongs to.
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the data list order.
  - `--type` (query): Type is used for query, showing events of specified type.
  - `--kind` (query): Kind is used for query, showing events of specified involvedObject kind,
  - `--name` (query): Name is used for query, showing events of specified involvedObject name,
- Output: list path `items`; columns `type`, `firstTimestamp`, `lastTimestamp`, `message`, `reason`; pagination `offset`

### `dce container-management core list-cluster-gpu-summary`

- Summary: ListClusterGPUSummary lists gpu summary of all nodes of the specified cluster.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/gpusummary`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster defines the cluster name.
- Output: list path `summary`; columns `node`

### `dce container-management core list-cluster-limit-ranges`

- Summary: ListClusterLimitRanges lists all limitranges in the specified cluster.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/limitranges`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified LimitRange belongs to.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the LimitRange list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the LimitRange list order.
  - `--name` (query): Name is used for fuzzy search.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter.
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by cluster name or cluster alias name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management core list-cluster-namespace-summary`

- Summary: ListClusterNamespaceSummary gets a list of namespace simple information
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespacesummary`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the namespace summary list belong to.
  - `--phase` (query, default `NAMESPACE_PHASE_UNSPECIFIED`, one of: NAMESPACE_PHASE_UNSPECIFIED|Active|Terminating): Phases is used for filter.
- Output: list path `data`; columns `name`, `phase`, `cluster`

### `dce container-management core list-cluster-namespaces`

- Summary: List all namespaces across a cluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the namespace list belong to.
  - `--workspace-id` (query, int32): workspace_id the specified namespace belongs to.
  - `--workspace-alias` (query): workspace_alias the specified namespace belongs to.
  - `--name` (query): Name is to filter namespaces by namespace name
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the job list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the job list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by cluster name or cluster alias name.
  - `--phase` (query, default `NAMESPACE_PHASE_UNSPECIFIED`, one of: NAMESPACE_PHASE_UNSPECIFIED|Active|Terminating): Phases is used for filter.
  - `--exclude-system` (query): ExcludeSystem determines to exclude system namespaces, defaults to False.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `status.phase`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management core list-cluster-node-summary`

- Summary: ListClusterNodeSummary lists the node summary in specified cluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/nodesummary`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
- Output: list path `data`; columns `name`, `phase`, `creationTimestamp`, `uid`, `podCIDR`, `unschedulable`

### `dce container-management core list-cluster-persistent-volume-claims`

- Summary: ListPersistentVolumeClaims gets the pvcs from the system
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/persistentvolumeclaims`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents the name of PVC to belongs to.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--name` (query): Name is used for filter.
  - `--phase` (query): Phase is used for filter.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--access-mode` (query, default `PERSISTENT_VOLUME_ACCESS_MODE_UNSPECIFIED`, one of: PERSISTENT_VOLUME_ACCESS_MODE_UNSPECIFIED|ReadWriteOnce|ReadOnlyMany|ReadWriteMany|ReadWriteOncePod): AccessMode is used searching PVC by accessMode.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `status.phase`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management core list-cluster-pods`

- Summary: ListClusterPods will list all pod by given cluster and regardless of
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/pods`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the pod belongs to.
  - `--namespace` (query): Namespace is the metadata.namespace of the referenced pod.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--name` (query): Name is used for filter.
  - `--phase` (query, default `PHASE_UNSPECIFIED`, one of: PHASE_UNSPECIFIED|Unknown|Pending|Running|Succeeded|Failed): Phases is used for filter.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--status` (query, default `FILTER_POD_STATUS_UNSPECIFIED`, one of: FILTER_POD_STATUS_UNSPECIFIED|FILTER_POD_STATUS_RUNNING|FILTER_POD_STATUS_ERROR|FILTER_POD_STATUS_COMPLETED|FILTER_POD_STATUS_WAITING): status is filter with pod status ,the status is composite state
  - `--exclude-metrics` (query): exclude_metrics
  - `--gpu-type` (query): gpu_type is filter with pods resources, when value is * search all
  - `--pod-ip` (query): pod_ip is used for filter.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `status.phase`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management core list-cluster-secrets`

- Summary: ListClusterSecrets lists a secret in a specific cluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/secrets`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the secret belongs to.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--name` (query): The name use to search specific secret
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--type` (query): Type is used to filter secrets by type.
  - `--only-metadata` (query): OnlyMetadata lists only metadata of secrets, default false.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `type`, `metadata.creationTimestamp`, `immutable`; pagination `offset`

### `dce container-management core list-cluster-services`

- Summary: ListClusterServices lists all services in the specified cluster, regardless
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/services`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified service belongs to.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the service list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the service list order.
  - `--name` (query): Name is used for query.
  - `--type` (query): Type is a array used for frontend filter.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--ports` (query): Ports is used to filter by port.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management core list-cluster-sriov-allocated-resources`

- Summary: Core_ListClusterSriovAllocatedResources
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/sriovnodesresources`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
- Output: list path `allocatedResources`; columns `resourceName`, `value`

### `dce container-management core list-config-maps`

- Summary: ListConfigMaps lists configmaps in the specified cluster and namespace.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/configmaps`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the configmap belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced ConfigMap.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the list order.
  - `--name` (query): name is used for query.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--only-metadata` (query): OnlyMetadata lists only metadata of configmaps, default false.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`, `immutable`; pagination `offset`

### `dce container-management core list-containers-by-pod`

- Summary: ListContainersByPod lists containers under the namespaces of a specific
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/pods/{name}/containers`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents the name of pod belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the pod belongs to.
  - `--name` (path, required): Name represents the name of pod to search
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the data list order.
- Output: list path `items`; columns `name`, `phase`, `image`, `ready`, `restartCount`, `started`; pagination `offset`

### `dce container-management core list-events`

- Summary: ListEvents lists events under the namespaces of a specific cluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/events`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents the name of deployment belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the deployment belongs to.
  - `--kind` (query, default `KIND_UNSPECIFIED`, one of: KIND_UNSPECIFIED|Deployment|StatefulSet|DaemonSet|Pod|Service|Ingress|Job|CronJob|HorizontalPodAutoscaler|ReplicaSet|CronHPA|PersistentVolumeClaim|GroupVersionResource): Kind represents what type of event is needed.
  - `--kind-name` (query): The name of involvedObject.
  - `--name` (query): Name stands for event name, used for fuzzy search.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the event list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the event list order.
  - `--type` (query): Type is used for query, showing events of specified type.
  - `--group` (query): resource group,used when the kind type is GroupVersionResource.
  - `--version` (query): resource version,used when the kind type is GroupVersionResource.
  - `--resource` (query): resource name,used when the kind type is GroupVersionResource.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
- Output: list path `items`; columns `type`, `firstTimestamp`, `lastTimestamp`, `message`, `reason`; pagination `offset`

### `dce container-management core list-limit-ranges`

- Summary: ListLimitRanges lists all limitranges in the specified cluster and namespace.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/limitranges`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the LimitRanges belongs to.
  - `--namespace` (path, required): Namespace the LimitRanges belongs to.
  - `--name` (query): Name stands for LimitRange name, used for fuzzy search.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the LimitRange list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the LimitRange list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter.
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by cluster name or cluster alias name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management core list-namespaces`

- Summary: List namespaces in a cluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/asl/namespaces`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): Clusters is to filter namespaces by cluster names
  - `--workspace-id` (query, int32): workspace_id the specified namespace belongs to.
  - `--workspace-alias` (query): workspace_alias the specified namespace belongs to.
  - `--name` (query): Name is to filter namespaces by namespace name
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the job list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the job list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--only-unassign` (query): Only_unassign is used to distinguish workspaces that are not assigned.
  - `--exclude-system` (query): ExcludeSystem determines to exclude system namespaces, defaults to False.
  - `--show-virtual-cluster` (query): ShowVirtualCluster is used to control whether to return data that belongs to a virtual cluster. Default false.
  - `--include-resource-quota` (query): IncludeQuota used to control whether return namespace resource quota, default false.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `status.phase`, `metadata.creationTimestamp`; pagination `offset`
- Example: `dce container-management core list-namespaces --cluster prod-cluster`

### `dce container-management core list-node-gpu`

- Summary: listNodeGPU gets all the gpu info with cluster node
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/nodes/{node}/gpus`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--node` (path, required): node
- Output: list path `items`; columns `name`, `uid`, `gpuMode`

### `dce container-management core list-nodes`

- Summary: ListNodes lists the node in specified cluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/nodes`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the node belongs to.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
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

### `dce container-management core list-persistent-volume-claims`

- Summary: List PersistentVolumeClaims in a namespace
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/persistentvolumeclaims`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents the name of PVC to belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the PVC belongs to.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--name` (query): Name is used for fuzzy search by name.
  - `--phase` (query): Phases is used for fuzzy search by phase.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--access-mode` (query, default `PERSISTENT_VOLUME_ACCESS_MODE_UNSPECIFIED`, one of: PERSISTENT_VOLUME_ACCESS_MODE_UNSPECIFIED|ReadWriteOnce|ReadOnlyMany|ReadWriteMany|ReadWriteOncePod): - PERSISTENT_VOLUME_ACCESS_MODE_UNSPECIFIED: This is only a meaningless placeholder, to avoid zero not return.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `status.phase`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management core list-persistent-volumes`

- Summary: List PersistentVolumes in a cluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/persistentvolumes`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the PersistentVolumes belongs to.
  - `--name` (query): Name stands for PersistentVolume name, used for fuzzy search.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the PersistentVolume list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the PersistentVolume list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter.
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by cluster name or cluster alias name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `status.phase`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management core list-pods`

- Summary: ListPods will list all pod by given cluster and namespace
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/pods`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the pod belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced pod.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
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

### `dce container-management core list-pods-by-node`

- Summary: ListPodsByNode lists pods info by given node in a specific
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/nodes/{node}/pods`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the node belongs to.
  - `--node` (path, required): Node represents which node the pod belongs to.
  - `--name` (query): Name is to filter pods by pod name
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the job list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the job list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--status` (query, default `FILTER_POD_STATUS_UNSPECIFIED`, one of: FILTER_POD_STATUS_UNSPECIFIED|FILTER_POD_STATUS_RUNNING|FILTER_POD_STATUS_ERROR|FILTER_POD_STATUS_COMPLETED|FILTER_POD_STATUS_WAITING): status is filter with pod status ,the status is composite state
  - `--gpu-type` (query): gpu_type is filter with pods resources, when value is * search all
  - `--pod-ip` (query): pod_ip is used for filter.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `status.phase`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management core list-resource-quotas`

- Summary: ListResourceQuotas lists quotas in specified namespace
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/resourcequotas`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the ResourceQuotas belongs to.
  - `--namespace` (path, required): Namespace the ResourceQuotas belongs to.
  - `--name` (query): Name stands for ResourceQuota name, used for name fuzzy search.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the ResourceQuota list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the ResourceQuota list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter.
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by cluster name or cluster alias name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management core list-secrets`

- Summary: ListSecrets lists a secret under the namespaces of a specific cluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/secrets`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the secret belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced secret.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--name` (query): The name use to search specific secret
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--type` (query): Type is used to filter secrets by type.
  - `--only-metadata` (query): OnlyMetadata lists only metadata of secrets, default false.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `type`, `metadata.creationTimestamp`, `immutable`; pagination `offset`

### `dce container-management core list-service-accounts`

- Summary: ListNamespaces gets all the namespaces across clusters
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/serviceaccounts`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents the name of sa to belongs to.
  - `--namesapce` (query): Namespace is the current namespace.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--name` (query): Name is used for filter.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management core list-services`

- Summary: ListServices lists services in the specified cluster and namespace
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/services`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified service belongs to.
  - `--namespace` (path, required): Namespace the specified service belongs to.
  - `--kind` (query, default `KIND_UNSPECIFIED`, one of: KIND_UNSPECIFIED|Deployment|StatefulSet|DaemonSet): The kind of service.
  - `--kind-name` (query): Name of kind.
  - `--name` (query): Name stands for service name, used for fuzzy search.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the service list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the service list order.
  - `--type` (query): Type is a array used for frontend filter.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--ports` (query): Ports is used to filter by port.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management core patch-config-map`

- Summary: PatchConfigMap patchs a configMap under the namespaces of a specific
- HTTP: `PATCH /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/configmaps/{name}/json`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the configmap belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced ConfigMap.
  - `--name` (path, required): The name represents for the resource name

### `dce container-management core patch-namespace`

- Summary: PatchNamespace patches a namespace from the system by given namespace name
- HTTP: `PATCH /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified namespace belongs to.
  - `--name` (path, required): The name represents for the resource name.

### `dce container-management core patch-secret`

- Summary: PatchSecret patchs a Secret under the namespaces of a specific cluster
- HTTP: `PATCH /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/secrets/{name}/json`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the secret belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced secret.
  - `--name` (path, required): The name represents for the resource name

### `dce container-management core patch-service`

- Summary: PatchService patches a service from the system by given service name
- HTTP: `PATCH /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/services/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified service belongs to.
  - `--namespace` (path, required): Namespace the specified service belongs to.
  - `--name` (path, required): The name represents for the resource name.

### `dce container-management core put-node-labels`

- Summary: PutNodeLabels puts the specified node's labels
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/nodes/{node}/labels`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the node belongs to.
  - `--node` (path, required): Node name.

### `dce container-management core put-node-taints`

- Summary: PutNodeTaints puts a node's taints in a specific cluster
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/nodes/{node}/taints`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): // Cluster the specified node belongs to.
  - `--node` (path, required): Node name.
- Output: list path `taints`; columns `effect`, `key`, `value`

### `dce container-management core scale-persistent-volume-claim`

- Summary: ScalePersistentVolumeClaim post scale the persistent volume claim capacity
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/persistentvolumeclaims/{name}:scale`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster represents the cluster of PVC belongs to.
  - `--namespace` (path, required): namespace represents the namespace of PVC belongs to.
  - `--name` (path, required): name represents the name of PVC belongs to.

### `dce container-management core un-cordon-node`

- Summary: UnCordonNode makes the specified node to schedulable.
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/nodes/{node}/uncordon`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified node belongs to.
  - `--node` (path, required): Node name.

### `dce container-management core unbind-node-to-namespace`

- Summary: UnbindNodeToNamespace makes the specified node to shared.
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/nodes/{name}:unbindNamespace`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster is the cluster for namespace and node.
  - `--name` (path, required): Name is the node name for node which needs to

### `dce container-management core update-config-map`

- Summary: UpdateConfigMap updates a configMap under the namespaces of a specific
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/configmaps/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified configmap belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced ConfigMap.
  - `--name` (path, required): name represents for the resource name

### `dce container-management core update-limit-range`

- Summary: UpdateLimitRange updates the specified limitrange, the body must be a JSON
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/limitranges/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified limitRange belongs to.
  - `--namespace` (path, required): Namespace the specified limitRange belongs to.
  - `--name` (path, required): Name of the specified limitRange.

### `dce container-management core update-namespace`

- Summary: UpdateNamespace updates a namespace from the system by given namespace name
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified namespace belongs to.
  - `--name` (path, required): The name represents for the resource name.

### `dce container-management core update-node`

- Summary: UpdateNode updates a node from the system by given node name
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/nodes/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified node belongs to.
  - `--name` (path, required): The name represents for the node name.

### `dce container-management core update-node-annotations`

- Summary: UpdateNodeAnnotations edits annotations of specified node.
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/nodes/{node}/annotations`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified node belongs to.
  - `--node` (path, required): Node name.

### `dce container-management core update-node-gpu-mode`

- Summary: UpdateNodeGPUMode updates single the gpu mode with cluster node
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/nodes/{node}/gpu-mode`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster
  - `--node` (path, required): node

### `dce container-management core update-persistent-volume`

- Summary: UpdatePersistentVolume updates a persistentvolume from the system by given persistentvolume name
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/persistentvolumes/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified persistentVolume belongs to.
  - `--name` (path, required): Name of the specified persistentVolume.

### `dce container-management core update-persistent-volume-claim`

- Summary: UpdatePersistentVolumeClaim update the persistent volume claim
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/persistentvolumeclaims/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster represents the cluster of PVC to belongs to.
  - `--namespace` (path, required): namespace represents the namespace of PVC to belongs to.
  - `--name` (path, required): name represents the name of PVC to belongs to.

### `dce container-management core update-persistent-volume-claim-annotations`

- Summary: UpdatePersistentVolumeClaimAnnotations puts the specified pvc's annotations
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/persistentvolumeclaims/{name}/annotations`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster represents the cluster of PVC to belongs to.
  - `--namespace` (path, required): namespace represents the namespace of PVC to belongs to.
  - `--name` (path, required): name represents the name of PVC to belongs to.

### `dce container-management core update-persistent-volume-claim-labels`

- Summary: UpdatePersistentVolumeClaimLabels puts the specified pvc's labels
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/persistentvolumeclaims/{name}/labels`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster represents the name of PVC belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the PVC belongs to.
  - `--name` (path, required): Name represents the name of PVC to search

### `dce container-management core update-resource-quota`

- Summary: UpdateResourceQuota updates a resourceQuota from the system by given resourceQuota name
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/resourcequotas/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified resourceQuota belongs to.
  - `--namespace` (path, required): Namespace the specified resourceQuota belongs to.
  - `--name` (path, required): Name of the specified resourceQuota.

### `dce container-management core update-secret`

- Summary: UpdateSecret updates secret under the namespaces of a specific cluster
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/secrets/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the secret belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced secret.
  - `--name` (path, required): Secret name.

### `dce container-management core update-service`

- Summary: UpdateService updates a service from the system by given service name
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/services/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified service belongs to.
  - `--namespace` (path, required): Namespace the specified service belongs to.
  - `--name` (path, required): Name represents for the service name

### `dce container-management core update-service-account`

- Summary: UpdateServiceAccount updates a sa from the system by given sa name
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/serviceaccounts/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster represents the cluster of ServiceAccount to belongs to.
  - `--name` (path, required): name represents the name of ServiceAccount to belongs to.

## Devices

### `dce container-management devices get-dashboard-url`

- Summary: Devices_GetDashboardURL
- HTTP: `GET /apis/kpanda.io/v1alpha1/grafana-dashboards/gpu-overview`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): cluster
  - `--node` (query): node
  - `--vendor` (query): vendor
  - `--gpu-index` (query, int32): gpuIndex
  - `--from` (query, int64): from
  - `--to` (query, int64): to

### `dce container-management devices list-gpu-devices`

- Summary: Devices_ListGPUDevices
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/gpu-devices`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the node belongs to.
  - `--search-node-name` (query): searchNodeName
  - `--search-gpu-model` (query): searchGPUModel
  - `--search-vendor` (query): searchVendor
  - `--search-device-uuid` (query): searchDeviceUUID
  - `--search-gpuid` (query): searchGPUID
- Output: list path `items`; columns `modelName`, `cluster`, `coreUtilization`, `deviceUUID`, `frameBufferMemoryUtilization`, `nodeName`

## EtcdBackupRestore

### `dce container-management etcdbackuprestore create-etcd-backup-strategy`

- Summary: CreateEtcdBackupStrategy creates a etcd backup strategy.
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/etcdbackuprestore/strategies`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified etcd backup strategy belongs to.

### `dce container-management etcdbackuprestore delete-etcd-backup-strategy`

- Summary: DeleteEtcdBackupStrategy delete a etcd backup strategy in cluster.
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/etcdbackuprestore/strategies/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the etcd backup strategy belongs to.
  - `--name` (path, required): Name represents the name of etcd backup strategy

### `dce container-management etcdbackuprestore delete-etcd-snapshot`

- Summary: DeleteEtcdBackup delete a etcd backup.
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/etcdbackuprestore/strategies/{strategy}/snapshots/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the etcd backup strategy belongs to.
  - `--strategy` (path, required): strategy represents the name of etcd backup strategy.
  - `--name` (path, required): Name represents the name of etcd snapshot.

### `dce container-management etcdbackuprestore execute-etcd-backup-strategy`

- Summary: ExecuteEtcdBackupStrategy executes a etcd backup strategy under the cluster
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/etcdbackuprestore/strategies/{name}:execute`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the etcd backup strategy belongs to.
  - `--name` (path, required): Name represents the name of etcd backup strategy.

### `dce container-management etcdbackuprestore get-etcd-backup-strategy`

- Summary: GetEtcdBackupStrategy get a etcd backup strategy in cluster.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/etcdbackuprestore/strategies/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified etcd backup strategy belongs to.
  - `--name` (path, required): Name represents for the etcd backup strategy name.

### `dce container-management etcdbackuprestore get-etcd-backup-strategy-json`

- Summary: GetEtcdBackupStrategyJSON get a etcd backup strategy json in cluster.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/etcdbackuprestore/strategies/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster the specified etcd backup strategy belongs to.
  - `--name` (path, required): Name represents for the etcd backup strategy name.

### `dce container-management etcdbackuprestore list-etcd-backup-clusters`

- Summary: ListEtcdBackupClusters list clusters with/without etcd backup strategies.
- HTTP: `GET /apis/kpanda.io/v1alpha1/etcdbackuprestore/clusters`
- Auth: required
- Body: none
- Flags: none
- Output: list path `items`; columns `name`, `phase`, `hasBackup`, `kubeSystemID`

### `dce container-management etcdbackuprestore list-etcd-backup-strategies`

- Summary: ListEtcdBackupStrategies list etcd backup strategies.
- HTTP: `GET /apis/kpanda.io/v1alpha1/etcdbackuprestore/strategies`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): cluster represents which cluster the repository belongs to.
  - `--name` (query): Name is the user-specified identifier.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the repository list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the repository list order.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `status.phase`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management etcdbackuprestore list-etcd-snapshots`

- Summary: ListEtcdSnapshots list etcd backup snapshots .
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/etcdbackuprestore/strategies/{strategy}/snapshots`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the etcd backup strategy belongs to.
  - `--strategy` (path, required): strategy represents the name of etcd backup strategy.
- Output: list path `items`; columns `name`, `externalUrl`, `key`, `lastModified`, `size`

### `dce container-management etcdbackuprestore pause-etcd-backup-strategy`

- Summary: PauseEtcdBackupStrategy pauses a etcd backup strategy under the cluster
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/etcdbackuprestore/strategies/{name}:pause`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the etcd backup strategy belongs to.
  - `--name` (path, required): Name represents the name of etcd backup strategy

### `dce container-management etcdbackuprestore resume-etcd-backup-strategy`

- Summary: ResumeEtcdBackupStrategy resumes a etcd backup strategy under the cluster
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/etcdbackuprestore/strategies/{name}:resume`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the etcd backup strategy belongs to.
  - `--name` (path, required): Name represents the name of etcd backup strategy

### `dce container-management etcdbackuprestore update-etcd-backup-strategy`

- Summary: UpdateEtcdBackupStrategy updates tcd backup strategy under the cluster
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/etcdbackuprestore/strategies/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster the specified etcd backup strategy belongs to.
  - `--name` (path, required): The name for EtcdBackupStrategy.

### `dce container-management etcdbackuprestore verify-etcd-connection`

- Summary: VerifyEtcdConnection verifies the etcd connection.
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/etcdbackuprestore/etcd:verify`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the etcd snapstore belongs to.

### `dce container-management etcdbackuprestore verify-snap-store-config`

- Summary: VerifySnapStore verifies the SnapStore config.
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/etcdbackuprestore/snapstores:verify`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the etcd snapstore belongs to.

## Image

### `dce container-management image detect-kangaroo`

- Summary: DetectKangaroo returns whether the kangaroo is installed.
- HTTP: `GET /apis/kpanda.io/v1alpha1/registries/kangaroo`
- Auth: required
- Body: none
- Flags: none

### `dce container-management image list-artifacts`

- Summary: ListArtifacts returns a list of tags of specified image
- HTTP: `GET /apis/kpanda.io/v1alpha1/registries/{registry}/repositories/{repository}/artifacts`
- Auth: required
- Body: none
- Flags:
  - `--registry` (path, required): Registry is registry name.
  - `--repository` (path, required): Repository is image name.
  - `--cluster` (query): Cluster is the current cluster.
  - `--namespace` (query): Namespace is the current namespace.
  - `--project` (query): Project is the project to request.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page.
  - `--public` (query): Public is distinguish public images and private images.
  - `--fuzzy-tag-name` (query): FuzzyTagName is used to fuzzy search by tag name.
- Output: list path `items`; columns `digest`, `imageSize`, `pushTime`; pagination `offset`

### `dce container-management image list-projects`

- Summary: ListProjects returns a list of projects of specified registry
- HTTP: `GET /apis/kpanda.io/v1alpha1/registries/{registry}/projects`
- Auth: required
- Body: none
- Flags:
  - `--registry` (path, required): Registry is registry name.
  - `--cluster` (query): Cluster is the current cluster.
  - `--namespace` (query): Namespace is the current namespace.
  - `--public` (query): Public is distinguish public projects and private projects.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by project name.
- Output: list path `items`; pagination `offset`

### `dce container-management image list-registries`

- Summary: ListRegistries returns a list of registries
- HTTP: `GET /apis/kpanda.io/v1alpha1/registries`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): Cluster is the current cluster.
  - `--namespace` (query): Namespace is the current namespace.
  - `--global` (query): Global is to list all global registries.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page.
  - `--public` (query): Public is distinguish public images and private images.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by registry name.
- Output: list path `items`; columns `name`, `alias`, `host`; pagination `offset`

### `dce container-management image list-repositories`

- Summary: ListRepositories returns a list of image names of specified project
- HTTP: `GET /apis/kpanda.io/v1alpha1/registries/{registry}/repositories`
- Auth: required
- Body: none
- Flags:
  - `--registry` (path, required): Registry is registry name.
  - `--cluster` (query): Cluster is the current cluster.
  - `--namespace` (query): Namespace is the current namespace.
  - `--project` (query): Project is the project to request, "/" is a possible value.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page.
  - `--public` (query): Public is distinguish public images and private images.
  - `--show-artifacts` (query): ShowArtifacts is to list artifacts of per image, default false.
- Output: list path `items`; columns `name`; pagination `offset`

## Networking

### `dce container-management networking create-ingress`

- Summary: Create an Ingress
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/ingresses`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster, return all the ingress of the cluster
  - `--namespace` (path, required): Namespace specified the namespace of ingress.

### `dce container-management networking create-network-policy`

- Summary: CreateNetworkPolicy creates a networkpolicy in the specified cluster and namespace.
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/networkpolicies`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster to request.
  - `--namespace` (path, required): Namespace specified the namespace of networkpolicy.

### `dce container-management networking delete-ingress`

- Summary: Delete an Ingress
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/ingresses/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster, return all the ingress of the cluster
  - `--namespace` (path, required): Namespace specified the namespace of ingress.
  - `--name` (path, required): Name is the name of ingress.

### `dce container-management networking delete-network-policy`

- Summary: DeleteNetworkPolicy deletes the networkpolicy by name.
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/networkpolicies/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster to request.
  - `--namespace` (path, required): Namespace specified the namespace of networkpolicy.
  - `--name` (path, required): Name is the name of networkpolicy.

### `dce container-management networking get-ingress`

- Summary: Get Ingress details
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/ingresses/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster, return all the ingress of the cluster
  - `--namespace` (path, required): Namespace specified the namespace of ingress.
  - `--name` (path, required): Name is the name of the ingress.

### `dce container-management networking get-ingress-json`

- Summary: GetIngressJSON gets the ingress by namespace and name, returns a string in JSON
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/ingresses/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster, return all the ingress of the cluster
  - `--namespace` (path, required): Namespace specified the namespace of ingress.
  - `--name` (path, required): Name is the name of the ingress.
  - `--stable` (query): If stable is true, the v1 version under the corresponding package will be returned.

### `dce container-management networking get-network-policy`

- Summary: GetNetworkPolicy gets the networkpolicy by namespace and name.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/networkpolicies/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster to request.
  - `--namespace` (path, required): Namespace specifies the namespace of networkpolicy.
  - `--name` (path, required): Name is the name of the networkpolicy.

### `dce container-management networking get-network-policy-json`

- Summary: GetNetworkPolicyJSON gets the networkpolicy by namespace and name, returns a string in JSON
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/networkpolicies/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster to request.
  - `--namespace` (path, required): Namespace specified the namespace of networkpolicy.
  - `--name` (path, required): Name is the name of the networkpolicy.
  - `--stable` (query): If stable is true, the v1 version under the corresponding package will be returned.

### `dce container-management networking list-cluster-ingresses`

- Summary: ListClusterIngresses lists all ingresses in the specified cluster.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/ingresses`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster, must be specified,
  - `--page` (query, default `1`, int32): Page is the number of pages at the beginning.
  - `--page-size` (query, default `20`, int32): Size is the number of every page displayed.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy defines sort field, please see message kpanda.io.api.types.SortBy.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy defines the type of sort, default type asc, can also specify desc.
  - `--name` (query): Name is the name of the ingress.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management networking list-cluster-network-policies`

- Summary: ListClusterNetworkPolicies lists all networkpolicies in the specified cluster.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/networkpolicies`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster, must be specified,
  - `--page` (query, default `1`, int32): Page is current page number.
  - `--page-size` (query, default `20`, int32): Size is the number of every page displayed.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy defines sort field, please see message kpanda.io.api.types.SortBy.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy defines the type of sort, default type asc, can also specify desc.
  - `--name` (query): Name is the name of the networkpolicy.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter.
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management networking list-ingress-class-summary`

- Summary: ListIngressClassSummary gets a list of ingressClass simple information
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/ingressclasssummary`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster is the ingressClass belongs to.
  - `--namespace` (query): Namespace is the IngressClass to retrieve for a specific namespace scoped.
- Output: list path `items`; columns `name`, `kind`, `isDefaultClass`

### `dce container-management networking list-ingresses`

- Summary: List Ingresses in a namespace
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/ingresses`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster, return all the ingress of the cluster
  - `--namespace` (path, required): Namespace specified the namespace of ingress.
  - `--page` (query, default `1`, int32): Page is the number of pages at the beginning.
  - `--page-size` (query, default `20`, int32): Size is the number of every page displayed.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy defines sort field, please see message kpanda.io.api.types.SortBy.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy defines the type of sort, default type asc, can also specify desc.
  - `--name` (query): Name is the name of the ingress.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management networking list-metallb-ip-address-pools`

- Summary: ListMetallbIPPool lists all metallb in the specified cluster and namespace.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/metallb/ippools`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster, return all the ingress of the cluster
  - `--page` (query, default `1`, int32): Page is the number of pages at the beginning.
  - `--page-size` (query, default `20`, int32): Size is the number of every page displayed.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy defines sort field, please see message kpanda.io.api.types.SortBy.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy defines the type of sort, default type asc, can also specify desc.
  - `--name` (query): Name is the name of the ingress.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management networking list-network-policies`

- Summary: ListNetworkPolicies lists all networkpolicies in the specified cluster and namespace.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/networkpolicies`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster, return all the networkpolicies of the cluster
  - `--namespace` (path, required): Namespace of networkpolicy list.
  - `--page` (query, default `1`, int32): Page is current page number.
  - `--page-size` (query, default `20`, int32): Size is the number of every page displayed.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy defines sort field, please see message kpanda.io.api.types.SortBy.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy defines the type of sort, default type asc, can also specify desc.
  - `--name` (query): Name is the name of the networkpolicy.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management networking patch-ingress`

- Summary: PatchIngress patches the specified ingress, the body must be a JSON string.
- HTTP: `PATCH /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/ingresses/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster, return all the ingress of the cluster
  - `--namespace` (path, required): Namespace specified the namespace of ingress.
  - `--name` (path, required): The name represents for the resource name.

### `dce container-management networking update-ingress`

- Summary: UpdateIngress updates the specified ingress, the body must be a JSON
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/ingresses/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster, return all the ingress of the cluster
  - `--namespace` (path, required): Namespace specified the namespace of ingress.
  - `--name` (path, required): Name is the name of ingress.

### `dce container-management networking update-network-policy`

- Summary: UpdateNetworkPolicy updates the specified networkpolicy, the body must be a JSON
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/networkpolicies/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster to request.
  - `--namespace` (path, required): Namespace specified the namespace of networkpolicy.
  - `--name` (path, required): Name is the name of networkpolicy.

### `dce container-management networking validate-metallb-shared-ip-port-conflict`

- Summary: ValidateMetallbSharedIPPortConflict checks whether the service port of
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/metallb/check-serviceports`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster is the name of the cluster, return all the ingress of the cluster

## RBAC

### `dce container-management rbac create-cluster-role`

- Summary: CreateClusterRole creates a ClusterRole
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/clusterroles/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the clusterrole belongs to.
  - `--name` (path, required): the name of role.
- Output: list path `rules`

### `dce container-management rbac create-cluster-role-binding`

- Summary: CreateClusterRoleBinding creates a cluster roleBinding batch
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/clusterrolebindings`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the clusterRoleBinding belongs to.
- Output: list path `subjects`; columns `name`, `namespace`, `kind`, `APIGroup`

### `dce container-management rbac create-role`

- Summary: CreateRole creates a Role
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/roles`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the role belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the role belongs to.
- Output: list path `rules`

### `dce container-management rbac create-role-binding`

- Summary: CreateRoleBinding creates a RoleBinding
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/rolebindings`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the roleBinding belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the roleBinding belongs to.
- Output: list path `subjects`; columns `name`, `namespace`, `kind`, `APIGroup`

### `dce container-management rbac delete-cluster-role`

- Summary: DeleteClusterRole deletes a ClusterRole
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/clusterroles/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the clusterrole belongs to.
  - `--name` (path, required): Name represents the name of the clusterrole to delete.

### `dce container-management rbac delete-cluster-role-binding`

- Summary: DeleteClusterRoleBinding deletes a cluster RoleBinding
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/clusterrolebindings/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the roleBinding belongs to.
  - `--name` (path, required): Name represents the name of the clusterrolebinding to delete.

### `dce container-management rbac delete-role`

- Summary: DeleteRole deletes the roles created by the frontend.
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/roles/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the role belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the role belongs to.
  - `--name` (path, required): Name represents the name of the role to delete.

### `dce container-management rbac delete-role-binding`

- Summary: ListRoleBindings lists the clusterrolebidings created by the frontend.
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/rolebindings/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the roleBinding belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the roleBinding belongs to.
  - `--name` (path, required): Name represents the name of the rolebinding to delete.

### `dce container-management rbac get-cluster-role`

- Summary: GetClusterRole gets a ClusterRole
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/clusterroles/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the clusterrole belongs to.
  - `--name` (path, required): Name represents the name of the clusterrole to delete.
- Output: list path `rules`

### `dce container-management rbac get-role`

- Summary: GetRole gets a Role
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/roles/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the role belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the role belongs to.
  - `--name` (path, required): Name represents the name of the role to delete.
- Output: list path `rules`

### `dce container-management rbac list-admin-cluster-summary`

- Summary: ListAdminClusterSummary List cluster summary by adminCluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/admincluster`
- Auth: required
- Body: none
- Flags:
  - `--user` (query): user is the cluster's user
  - `--user-group` (query): userGroup is the cluster user's belong group
- Output: list path `clusters`

### `dce container-management rbac list-all-user-role-summary`

- Summary: ListAllUserRoleSummary lists user role summary
- HTTP: `GET /apis/kpanda.io/v1alpha1/rolesummary`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): Cluster represents which cluster the roleBinding belongs to.
  - `--namespace` (query): Namespace represents which namespace the roleBinding belongs to.

### `dce container-management rbac list-cluster-role-bindings`

- Summary: List ClusterRoleBindings
- HTTP: `GET /apis/kpanda.io/v1alpha1/asl/clusterrolebindings`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): Cluster represents which cluster the roleBinding belongs to.
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--name` (query): Name represents the name of the user
  - `--role-ref` (query): RoleRef is the role of the user, it should be the same as when it is created.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the data list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management rbac list-cluster-roles`

- Summary: List ClusterRoles
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/clusterroles`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the role belongs to.
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--name` (query): Name represents the name of the user
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the data list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management rbac list-groups`

- Summary: ListGroups lists the groups in the system.
- HTTP: `GET /apis/kpanda.io/v1alpha1/asl/groups`
- Auth: required
- Body: none
- Flags:
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--name` (query): Name is used for fuzzy search.
- Output: list path `items`; columns `name`, `id`; pagination `offset`

### `dce container-management rbac list-role-bindings`

- Summary: List RoleBindings in a namespace
- HTTP: `GET /apis/kpanda.io/v1alpha1/asl/rolebindings`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): Cluster represents which cluster the roleBinding belongs to.
  - `--namespace` (query): Namespace represents which namespace the roleBinding belongs to.
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--name` (query): Name represents the name of the user
  - `--role-ref` (query): RoleRef is the role of the user, it should be the same as when it is created.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the data list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management rbac list-roles`

- Summary: ListRoles lists the roles created by frontend.
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/roles`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the role belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the role belongs to.
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--name` (query): Name represents the name of the user
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the data list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the data list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management rbac list-users`

- Summary: ListUsers lists the users in the system.
- HTTP: `GET /apis/kpanda.io/v1alpha1/asl/users`
- Auth: required
- Body: none
- Flags:
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--name` (query): Name is used for fuzzy search.
- Output: list path `items`; columns `name`, `id`; pagination `offset`

### `dce container-management rbac update-cluster-role`

- Summary: UpdateClusterRole updates a ClusterRole
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/clusterroles/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the clusterrole belongs to.
  - `--name` (path, required): Name represents the name of the clusterrole to delete.

### `dce container-management rbac update-role`

- Summary: UpdateRole updates a Role
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/roles/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the role belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the role belongs to.
  - `--name` (path, required): Name represents the name of the role to delete.

## Registry

### `dce container-management registry list-image-tags`

- Summary: Registry_ListImageTags
- HTTP: `GET /apis/kpanda.io/v1alpha1/registry/tags`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): Cluster presents the cluster of dockeconfig belongs to.
  - `--namespace` (query): Namespace presents the namespace of dockeconfig belongs to.
  - `--secret` (query): Secret is the name of dockeconfig.
  - `--image` (query): Image is the name of repository which needs verify.
  - `--registry-host` (query): The registry host which the repository belongs to.
- Output: list path `data`

### `dce container-management registry verify-image`

- Summary: Registry_VerifyImage
- HTTP: `GET /apis/kpanda.io/v1alpha1/registry/verifyImage`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): Cluster presents the cluster of dockeconfig belongs to.
  - `--namespace` (query): Namespace presents the namespace of dockeconfig belongs to.
  - `--secret` (query): Secret is the name of dockeconfig.
  - `--image` (query): Image is the name of repository which needs to list tags.
  - `--registry-host` (query): The registry host which the repository belongs to.

### `dce container-management registry verify-registry`

- Summary: Registry_VerifyRegistry
- HTTP: `POST /apis/kpanda.io/v1alpha1/registry/verify`
- Auth: required
- Body: required
- Flags: none

## SettingService

### `dce container-management settingservice gpu-setting`

- Summary: SettingService_GPUSetting
- HTTP: `GET /apis/kpanda.io/v1alpha1/settings/gpu`
- Auth: required
- Body: none
- Flags: none
- Output: list path `gpuSetting`; columns `type`, `alias`, `isDynamic`

## Storage

### `dce container-management storage create-storage-class`

- Summary: CreateStorageClass
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/storageclasses`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Cluster represents the cluster of StorageClass to belongs to.

### `dce container-management storage create-volume-snapshot`

- Summary: CreateVolumeSnapshot create volume snapshot in single cluster
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/volumesnapshots`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster represents the cluster of VolumeSnapshot to belongs to.
  - `--namespace` (path, required): namespace represents the namespace of VolumeSnapshot to belongs to.

### `dce container-management storage delete-storage-class`

- Summary: DeleteStorageClass
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/storageclasses/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the StorageClass belongs to.
  - `--name` (path, required): Name represents the name of StorageClass

### `dce container-management storage delete-volume-snapshot`

- Summary: DeleteVolumeSnapshot delete volume snapshot in single cluster
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/volumesnapshots/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents the cluster of VolumeSnapshot to belongs to.
  - `--namespace` (path, required): namespace represents the namespace of VolumeSnapshot to belongs to.
  - `--name` (path, required): name represents the name of VolumeSnapshot to belongs to.

### `dce container-management storage get-storage-class`

- Summary: GetStorageClass get StorageClass in single cluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/storageclasses/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents the name of PVC to belongs to.
  - `--name` (path, required): name represents the name of StorageClass to belongs to.
- Output: list path `mountOptions`

### `dce container-management storage get-storage-class-json`

- Summary: GetStorageClassJSON get StorageClass json in single cluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/storageclasses/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents the name of PVC to belongs to.
  - `--name` (path, required): name represents the name of StorageClass to belongs to.

### `dce container-management storage get-volume-snapshot-json`

- Summary: GetVolumeSnapshotJSON list StorageClass in single cluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/volumesnapshots/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents the name of VolumeSnapshots belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the VolumeSnapshots belongs to.
  - `--name` (path, required): Name represents the name of VolumeSnapshots to search

### `dce container-management storage list-accessible-storage-classes`

- Summary: ListAccessibleStorageClasses lists all storageclasses in accessible clusters
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/accessiblestorageclasses`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents the name of PVC to belongs to.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--provisioner` (query): Provisioner is used for fuzzy search by provisioner.
  - `--reclaim-policy` (query): ReclaimPolicy is used for fuzzy search by reclaimPolicy.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`, `allowVolumeExpansion`, `provisioner`, `reclaimPolicy`; pagination `offset`

### `dce container-management storage list-cluster-volume-snapshots`

- Summary: ListClusterVolumeSnapshots will list all VolumeSnapshot by given cluster and regardless of
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/volumesnapshots`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents the name of VolumeSnapshot to belongs to.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--name` (query): Name is used for filter.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management storage list-storage-classes`

- Summary: ListStorageClass list StorageClass in single cluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/storageclasses`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents the name of PVC to belongs to.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--name` (query): Name is used for filter.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
  - `--provisioner` (query): Provisioner is used for fuzzy search by provisioner.
  - `--reclaim-policy` (query): ReclaimPolicy is used for fuzzy search by reclaimPolicy.
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`, `allowVolumeExpansion`, `provisioner`, `reclaimPolicy`; pagination `offset`

### `dce container-management storage list-volume-snapshots`

- Summary: ListVolumeSnapshots list volume snapshot in single cluster
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/volumesnapshots`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster represents the name of VolumeSnapshot to belongs to.
  - `--namespace` (path, required): Namespace represents which namespace the VolumeSnapshot belongs to.
  - `--page` (query, default `1`, int32): Page requested.
  - `--page-size` (query, default `20`, int32): Size per page requested.
  - `--name` (query): Name is used for filter.
  - `--sort-by` (query, default `SORT_BY_UNSPECIFIED`, one of: SORT_BY_UNSPECIFIED|field_name|state|workspace|cluster|namespace|created_at): SortBy determines the list order reference.
  - `--sort-dir` (query, default `desc`, one of: desc|asc): OrderBy determines the list order.
  - `--label-selector` (query): LabelSelector is the format after labels.FormatLabels used to filter
  - `--field-selector` (query): FieldSelector is the format after labels.FormatLabels used to filter
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `metadata.creationTimestamp`; pagination `offset`

### `dce container-management storage update-storage-class`

- Summary: UpdateStorageClass update storage class
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/storageclasses/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster represents the cluster of StorageClass to belongs to.
  - `--name` (path, required): name represents the name of StorageClass to belongs to.

### `dce container-management storage update-volume-snapshot`

- Summary: UpdateVolumeSnapshot update volume snapshot
- HTTP: `PUT /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/volumesnapshots/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster represents the cluster of Volume snapshot to belongs to.
  - `--namespace` (path, required): namespace represents the namespace of volume snapshot to belongs to.
  - `--name` (path, required): name represents the name of volume snapshot to belongs to.

## Workspace

### `dce container-management workspace bind-cluster-to-workspace`

- Summary: Workspace_BindClusterToWorkspace
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}:bind`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster

### `dce container-management workspace bind-resource-to-workspace`

- Summary: Workspace_BindResourceToWorkspace
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{name}:bind`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster
  - `--name` (path, required): name

### `dce container-management workspace get-workspace-resource-quota-allocatable`

- Summary: Workspace_GetWorkspaceResourceQuotaAllocatable
- HTTP: `GET /apis/kpanda.io/v1alpha1/workspaces/{workspaceId}/workspacesharedresourcequota`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--workspace-alias` (query): workspaceAlias
  - `--cluster` (query): cluster

### `dce container-management workspace list-global-roles-for-current-user`

- Summary: Workspace_ListGlobalRolesForCurrentUser
- HTTP: `GET /apis/kpanda.io/v1alpha1/globalroles`
- Auth: required
- Body: none
- Flags: none
- Output: list path `roles`

### `dce container-management workspace list-workspaces`

- Summary: Workspace_ListWorkspaces
- HTTP: `GET /apis/kpanda.io/v1alpha1/workspaces`
- Auth: required
- Body: none
- Flags: none
- Output: list path `workspaces`; columns `id`, `alias`

### `dce container-management workspace un-bind-cluster-from-workspace`

- Summary: Workspace_UnBindClusterFromWorkspace
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}:unbind`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster

### `dce container-management workspace unbind-resource-from-workspace`

- Summary: Workspace_UnbindResourceFromWorkspace
- HTTP: `DELETE /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{name}:unbind`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster
  - `--name` (path, required): name

## insight

### `dce container-management insight get-pod-container-log`

- Summary: GetPodContainerLog gets pod contianer log
- HTTP: `GET /apis/kpanda.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/pods/{name}/log`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Name of the cluster where the Pod is located
  - `--namespace` (path, required): Name of the namespace where the Pod is located
  - `--name` (path, required): Name of pod
  - `--workload` (query): workload refers to the name of a workload
  - `--container` (query): Name of the pod where the container is located
  - `--start-time` (query): Start time of get pod container log
  - `--end-time` (query): End time of get pod container log
  - `--page` (query, default `1`, int32): Number of page.
  - `--page-size` (query, default `20`, int32): Log number shown per page.
  - `--log-search` (query): for fuzzy query
- Output: list path `data`; columns `log`, `timeStamp`; pagination `offset`

### `dce container-management insight query-cluster-metrics`

- Summary: insight_QueryClusterMetrics
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/metric`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): The name of the cluster
- Output: list path `data`; columns `errorMessage`, `status`

### `dce container-management insight query-cluster-metrics-range`

- Summary: insight_QueryClusterMetricsRange
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/metricrange`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): the name of the cluster
- Output: list path `data`; columns `errorMessage`, `status`

### `dce container-management insight query-public-range-usage`

- Summary: insight_QueryPublicRangeUsage
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/publicmetricrange`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Name of the cluster where the workload is located
- Output: list path `data`; columns `errorMessage`, `status`

### `dce container-management insight query-public-usage`

- Summary: insight_QueryPublicUsage
- HTTP: `POST /apis/kpanda.io/v1alpha1/clusters/{cluster}/publicmetric`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): Name of the cluster where the workload is located
- Output: list path `data`; columns `errorMessage`, `status`

