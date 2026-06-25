# Module `ai-lab`

## Source

- Backend: `swagger`
- Repository: https://github.com/DaoCloud/daocloud-api-docs.git
- Pinned tag: `9fd0dfafa1400e6d98b14b85c9a27cd1c151f9bd`
- Files: `docs/openapi/baize/v0.111.2.json`
- Resolved SHA: `9fd0dfafa1400e6d98b14b85c9a27cd1c151f9bd`

## AnalysisManagement

### `dce ai-lab analysismanagement delete-analysis`

- Summary: 需要 Developer 权限：devloper-job-analysis.delete
- HTTP: `DELETE /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/analysis/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
- Output: list path `kubeVolumes`; columns `name`, `type`, `dataDirection`, `mountPath`, `readOnly`

### `dce ai-lab analysismanagement list-analysis`

- Summary: 额外支持的搜索、排序字段：type,owner
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/analysis`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (query): cluster
  - `--namespace` (query): namespace
  - `--queue-name` (query): queueName
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `namespace`, `status.phase`, `type`, `creationTimestamp`, `cluster`

### `dce ai-lab analysismanagement list-analysis2`

- Summary: 额外支持的搜索、排序字段：type,owner
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/analysis`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--queue-name` (query): queueName
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `namespace`, `status.phase`, `type`, `creationTimestamp`, `cluster`

## ClusterService

### `dce ai-lab clusterservice get-cluster-gpu-settings`

- Summary: 获取集群 GPU 配置
- HTTP: `GET /apis/baize.io/v1alpha1/clusters/{cluster}/settings/gpu-resources`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--workspace` (query, int32): Workspace ID
- Output: list path `items`; columns `type`, `alias`

### `dce ai-lab clusterservice list-cluster-namespaces`

- Summary: 获取集群命名空间
- HTTP: `GET /apis/baize.io/v1alpha1/clusters/{cluster}/namespaces`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--workspace` (query, int32): Workspace ID
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `cluster`, `clusterStatus`

### `dce ai-lab clusterservice list-cluster-namespaces2`

- Summary: 获取集群命名空间
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `cluster`, `clusterStatus`

### `dce ai-lab clusterservice list-clusters`

- Summary: List clusters
- HTTP: `GET /apis/baize.io/v1alpha1/clusters`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (query, int32): Workspace ID
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `clusterStatus`, `withAiSuite`, `withMetricsServer`

### `dce ai-lab clusterservice list-clusters2`

- Summary: 获取集群列表
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `clusterStatus`, `withAiSuite`, `withMetricsServer`

### `dce ai-lab clusterservice list-pv-cs`

- Summary: 获取 PVC 列表
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/pvcs`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `namespace`, `capacity`, `cluster`, `storageClass`

### `dce ai-lab clusterservice list-resource-affinities`

- Summary: 获取集群资源类型、名称列表
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/resource-affinities`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `type`

### `dce ai-lab clusterservice list-storage-classes`

- Summary: 获取存储类列表
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/storage-classes`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `allowReclaim`, `cluster`, `isDefault`, `provisioner`

## DatasetManagement

### `dce ai-lab datasetmanagement create-dataset`

- Summary: 需要 Developer 权限：devloper-data-management.create
- HTTP: `POST /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/datasets`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
- Output: list path `sharedStoWorkspaces`; columns `alias`, `workspaceId`

### `dce ai-lab datasetmanagement dataset-do-action`

- Summary: 需要 Developer 权限：devloper-data-management.update
- HTTP: `POST /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/datasets/{name}/actions`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
- Output: list path `sharedStoWorkspaces`; columns `alias`, `workspaceId`

### `dce ai-lab datasetmanagement delete-dataset`

- Summary: 需要 Developer 权限：devloper-data-management.delete
- HTTP: `DELETE /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/datasets/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
- Output: list path `sharedStoWorkspaces`; columns `alias`, `workspaceId`

### `dce ai-lab datasetmanagement get-dataset`

- Summary: 需要 Developer 权限：devloper-data-management.get
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/datasets/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
- Output: list path `sharedStoWorkspaces`; columns `alias`, `workspaceId`

### `dce ai-lab datasetmanagement get-dataset-conda-options`

- Summary: DatasetManagement_GetDatasetCondaOptions
- HTTP: `GET /apis/baize.io/v1alpha1/datasets/conda/options`
- Auth: required
- Body: none
- Flags: none
- Output: list path `pythonVersions`

### `dce ai-lab datasetmanagement get-dataset-sync-process`

- Summary: 需要 Developer 权限：devloper-data-management.get
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/datasets/{name}/sync-process`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name

### `dce ai-lab datasetmanagement get-related-instances`

- Summary: 额外支持的搜索、排序字段：datasets
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/datasets/{name}/related-instances`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `namespace`, `cluster`

### `dce ai-lab datasetmanagement list-dataset-events`

- Summary: 额外支持的搜索、排序字段：*
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/datasets/{name}/events`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `type`, `count`, `firstTimestamp`, `lastTimestamp`, `message`, `objKind`

### `dce ai-lab datasetmanagement list-datasets`

- Summary: List datasets in a workspace
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/datasets`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (query): cluster
  - `--namespace` (query): namespace
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `namespace`, `status.phase`, `creationTimestamp`, `cluster`, `description`
- Example:

```
dce ai-lab datasetmanagement list-datasets \
  --workspace <workspace-id> \
  --page.page 1 --page.page-size 20
```

### `dce ai-lab datasetmanagement list-datasets2`

- Summary: 额外支持的搜索、排序字段：type,uri,phase,share,sharedStoWorkspaces
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/datasets`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `namespace`, `status.phase`, `creationTimestamp`, `cluster`, `description`

### `dce ai-lab datasetmanagement update-dataset`

- Summary: 需要 Developer 权限：devloper-data-management.update
- HTTP: `PUT /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/datasets/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
- Output: list path `sharedStoWorkspaces`; columns `alias`, `workspaceId`

### `dce ai-lab datasetmanagement validate-data-source-secrets`

- Summary: DatasetManagement_ValidateDataSourceSecrets
- HTTP: `POST /apis/baize.io/v1alpha1/datasets/validate-secrets`
- Auth: required
- Body: required
- Flags: none

## DeviceService

### `dce ai-lab deviceservice list-devices-gp-us`

- Summary: List GPU devices
- HTTP: `GET /apis/baize.io/v1alpha1/devices/gpus`
- Auth: required
- Body: none
- Flags:
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `modelName`, `cluster`, `deviceUUID`, `nodeIP`, `nodeName`, `serialNumber`

## ImageService

### `dce ai-lab imageservice list-artifacts`

- Summary: ListArtifacts returns a list of tags of specified image
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/registries/{registry}/projects/{project}/repositories/{repository}/artifacts`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--registry` (path, required): Registry is registry name.
  - `--project` (path, required): Project is the project to request.
  - `--repository` (path, required): Repository is image name.
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `creationTimestamp`, `digest`, `imageSize`

### `dce ai-lab imageservice list-project-repositories`

- Summary: ListRepositories returns a list of image names of specified project
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/registries/{registry}/projects/{project}/repositories`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--registry` (path, required): Registry is registry name.
  - `--project` (path, required): Project is the project to request, "/" is a possible value.
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `updateTimestamp`

### `dce ai-lab imageservice list-projects`

- Summary: ListProjects returns a list of projects of specified registry
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/registries/{registry}/projects`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--registry` (path, required): Registry is registry name.
  - `--public` (query): Public is distinguish public projects and private projects.
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
  - `--only-bind` (query): if true only return bound data.
  - `--all` (query): if true return all projects.
- Output: list path `items`; columns `name`, `visible`

### `dce ai-lab imageservice list-registries`

- Summary: ListRegistries returns a list of registries
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/registries`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--global` (query): Global is to list all global registries.
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `type`, `host`, `scope`

## InferenceServingManagement

### `dce ai-lab inferenceservingmanagement create-inference-serving`

- Summary: 创建推理服务
- HTTP: `POST /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/inference-serving`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
- Output: list path `models`; columns `name`, `modelPath`, `version`

### `dce ai-lab inferenceservingmanagement delete-inference-serving`

- Summary: 删除推理服务
- HTTP: `DELETE /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/inference-serving/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
- Output: list path `models`; columns `name`, `modelPath`, `version`

### `dce ai-lab inferenceservingmanagement get-inference-serving`

- Summary: 获取推理服务
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/inference-serving/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
- Output: list path `models`; columns `name`, `modelPath`, `version`

### `dce ai-lab inferenceservingmanagement get-inference-serving-hpa`

- Summary: 需要 Developer 权限：developer-serving.get
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/inference-serving/{name}/hpa`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name

### `dce ai-lab inferenceservingmanagement list-inference-events`

- Summary: 额外支持的搜索、排序字段：*
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/inference-serving/{name}/events`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `type`, `count`, `firstTimestamp`, `lastTimestamp`, `message`, `objKind`

### `dce ai-lab inferenceservingmanagement list-inference-servings`

- Summary: List inference services in a workspace
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/inference-serving`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (query): cluster
  - `--namespace` (query): namespace
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `namespace`, `status.phase`, `creationTimestamp`, `authType`, `cluster`
- Example:

```
dce ai-lab inferenceservingmanagement list-inference-servings \
  --workspace <workspace-id> \
  --page.page 1 --page.page-size 20
```

### `dce ai-lab inferenceservingmanagement list-inference-servings2`

- Summary: 获取推理服务列表
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/inference-serving`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `namespace`, `status.phase`, `creationTimestamp`, `authType`, `cluster`

### `dce ai-lab inferenceservingmanagement update-inference-serving`

- Summary: 更新推理服务
- HTTP: `PUT /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/inference-serving/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
- Output: list path `models`; columns `name`, `modelPath`, `version`

## JobsManagement

### `dce ai-lab jobsmanagement create-job`

- Summary: 需要 Developer 权限：devloper-job-center.create
- HTTP: `POST /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/jobs`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace

### `dce ai-lab jobsmanagement delete-job`

- Summary: 需要 Developer 权限：devloper-job-center.delete
- HTTP: `DELETE /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/jobs/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name

### `dce ai-lab jobsmanagement do-job-action`

- Summary: 需要 Developer 权限：devloper-job-center.create
- HTTP: `POST /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/jobs/{name}/actions`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name

### `dce ai-lab jobsmanagement get-job`

- Summary: 需要 Developer 权限：devloper-job-center.get
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/jobs/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--type` (query, default `JOB_TYPE_UNSPECIFIED`, one of: JOB_TYPE_UNSPECIFIED|PYTORCH|TENSORFLOW|PADDLE|MPI|MXNET): - MPI: XGBOOST = 4;
  - `--delete-analysis` (query): 是否删除关联的任务分析工作负载

### `dce ai-lab jobsmanagement list-job-events`

- Summary: 额外支持的搜索、排序字段：*
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/jobs/{name}/events`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--type` (query, default `JOB_TYPE_UNSPECIFIED`, one of: JOB_TYPE_UNSPECIFIED|PYTORCH|TENSORFLOW|PADDLE|MPI|MXNET): - MPI: XGBOOST = 4;
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `type`, `count`, `firstTimestamp`, `lastTimestamp`, `message`, `objKind`

### `dce ai-lab jobsmanagement list-jobs`

- Summary: List training jobs in a workspace
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/jobs`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--type` (query, default `JOB_TYPE_UNSPECIFIED`, one of: JOB_TYPE_UNSPECIFIED|PYTORCH|TENSORFLOW|PADDLE|MPI|MXNET): 任务类型，如果为空，表示所有任务类型。
  - `--cluster` (query): cluster 表示查询所有集群的 Job。
  - `--namespace` (query): namespace 表示查询所有命名空间的 Job。
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `namespace`, `phase`, `type`, `creationTimestamp`, `cluster`
- Example:

```
dce ai-lab jobsmanagement list-jobs \
  --workspace <workspace-id> \
  --page.page 1 --page.page-size 20
```

### `dce ai-lab jobsmanagement list-jobs2`

- Summary: 额外支持的搜索、排序字段：trainingMode,runningDuration
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/jobs`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster 表示查询所有集群的 Job。
  - `--namespace` (path, required): namespace 表示查询所有命名空间的 Job。
  - `--type` (query, default `JOB_TYPE_UNSPECIFIED`, one of: JOB_TYPE_UNSPECIFIED|PYTORCH|TENSORFLOW|PADDLE|MPI|MXNET): 任务类型，如果为空，表示所有任务类型。
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `namespace`, `phase`, `type`, `creationTimestamp`, `cluster`

### `dce ai-lab jobsmanagement list-schedulers`

- Summary: 需要 Developer 权限：devloper-job-center.get
- HTTP: `PUT /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/jobs/{name}/schedulers`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
- Output: list path `items`; columns `name`, `alias`, `default`

## LabelingManagement

### `dce ai-lab labelingmanagement create-labeling-instance`

- Summary: 需要 Developer 权限：developer-labeling-instances.create
- HTTP: `POST /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/labeling-instances`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace

### `dce ai-lab labelingmanagement delete-labeling-instance`

- Summary: 需要 Developer 权限：developer-labeling-instances.delete
- HTTP: `DELETE /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/labeling-instances/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name

### `dce ai-lab labelingmanagement get-labeling-instance`

- Summary: 需要 Developer 权限：developer-labeling-instances.get
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/labeling-instances/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name

### `dce ai-lab labelingmanagement list-labeling-instance`

- Summary: 需要 Developer 权限：developer-labeling-instances.get
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/labeling-instances`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (query): cluster
  - `--namespace` (query): namespace
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `namespace`, `phase`, `type`, `creationTimestamp`, `cluster`

## MetricsService

### `dce ai-lab metricsservice get-admin-grafana-dashboard`

- Summary: 管理员概览面板
- HTTP: `GET /apis/baize.io/v1alpha1/grafana-dashboards/admin-overview`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): 可选，不选为全部集群
  - `--from` (query, int64): 起始时间
  - `--to` (query, int64): 结束时间，且作为单值指标的时间点

### `dce ai-lab metricsservice get-dev-grafana-dashboard`

- Summary: 开发者视角概览面板
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/grafana-dashboards/dev-overview`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (query): cluster
  - `--from` (query, int64): 起始时间
  - `--to` (query, int64): 结束时间，且作为单值指标的时间点

### `dce ai-lab metricsservice get-inference-service-grafana-dashboard`

- Summary: 推理服务详细指标面板
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/inference-serving/{inference}/service-grafana-dashboards`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--inference` (path, required): 推理服务名称
  - `--from` (query): 起始时间
  - `--to` (query): 结束时间，且作为单值指标的时间点

### `dce ai-lab metricsservice get-nvidia-gpu-grafana-dashboard`

- Summary: 需要 Operator 权限：devloper-overview.get
- HTTP: `GET /apis/baize.io/v1alpha1/grafana-dashboards/nvidia-gpu-overview`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): cluster
  - `--node` (query): node
  - `--gpu-index` (query): gpuIndex
  - `--from` (query): from
  - `--to` (query): to

### `dce ai-lab metricsservice get-workload-grafana-dashboard`

- Summary: 工作负载实例监控面板
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/grafana-dashboards`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--pod` (query): pod
  - `--container` (query): container
  - `--from` (query): 起始时间
  - `--to` (query): 结束时间，且作为单值指标的时间点

## ModelManagement

### `dce ai-lab modelmanagement create-model`

- Summary: 创建模型
- HTTP: `POST /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/models`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
- Output: list path `sharedToWorkspaces`; columns `alias`, `workspaceId`

### `dce ai-lab modelmanagement create-model-version`

- Summary: 创建模型版本
- HTTP: `POST /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/models/{name}/versions`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name

### `dce ai-lab modelmanagement delete-model`

- Summary: 删除模型
- HTTP: `DELETE /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/models/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
- Output: list path `sharedToWorkspaces`; columns `alias`, `workspaceId`

### `dce ai-lab modelmanagement delete-model-version`

- Summary: 删除模型版本
- HTTP: `DELETE /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/models/{name}/versions/{version}`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--version` (path, required): version

### `dce ai-lab modelmanagement get-model`

- Summary: 获取单个模型
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/models/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
- Output: list path `sharedToWorkspaces`; columns `alias`, `workspaceId`

### `dce ai-lab modelmanagement list-models`

- Summary: List models in a workspace
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/models`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (query): cluster
  - `--namespace` (query): namespace
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `namespace`, `status.phase`, `creationTimestamp`, `architecture`, `cluster`
- Example:

```
dce ai-lab modelmanagement list-models \
  --workspace <workspace-id> \
  --page.page 1 --page.page-size 20
```

### `dce ai-lab modelmanagement list-shared-models`

- Summary: List shared models available to a workspace
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/shared-models`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (query): cluster
  - `--namespace` (query): namespace
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `namespace`, `status.phase`, `creationTimestamp`, `architecture`, `cluster`

### `dce ai-lab modelmanagement update-model`

- Summary: 更新模型
- HTTP: `PUT /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/models/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
- Output: list path `sharedToWorkspaces`; columns `alias`, `workspaceId`

### `dce ai-lab modelmanagement update-model-version`

- Summary: 更新模型版本
- HTTP: `PUT /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/models/{name}/versions/{version}`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--version` (path, required): version

## NotebookService

### `dce ai-lab notebookservice create-notebook`

- Summary: 需要 Developer 权限：devloper-notebook.create
- HTTP: `POST /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/notebooks`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace

### `dce ai-lab notebookservice create-notebook-snapshot-task`

- Summary: 需要 Developer 权限：devloper-notebook.update
- HTTP: `POST /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/notebooks/{name}/snapshot`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name

### `dce ai-lab notebookservice delete-notebook`

- Summary: 需要 Developer 权限：devloper-notebook.delete
- HTTP: `DELETE /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/notebooks/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name

### `dce ai-lab notebookservice get-notebook`

- Summary: 需要 Developer 权限：devloper-notebook.get
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/notebooks/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--delete-analysis` (query): 是否删除关联的任务分析工作负载

### `dce ai-lab notebookservice get-notebook-connection-info`

- Summary: 需要 Developer 权限：devloper-notebook.get
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/notebooks/{name}/connections`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--delete-analysis` (query): 是否删除关联的任务分析工作负载

### `dce ai-lab notebookservice get-notebook-image-list`

- Summary: 需要 Operator 权限：operator-notebook.get
- HTTP: `GET /apis/baize.io/v1alpha1/notebook-images`
- Auth: required
- Body: none
- Flags:
  - `--type` (query, default `TYPE_UNSPECIFIED`, one of: TYPE_UNSPECIFIED|JUPYTER|CODE): 镜像类型，可以为空，空表示 Jupyter
- Output: list path `items`; columns `name`, `type`

### `dce ai-lab notebookservice list-notebook-events`

- Summary: 额外支持的搜索、排序字段：*
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/notebooks/{name}/events`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `type`, `count`, `firstTimestamp`, `lastTimestamp`, `message`, `objKind`

### `dce ai-lab notebookservice list-notebook-snapshot-tasks`

- Summary: 需要 Developer 权限：devloper-notebook.get
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/notebooks/{name}/snapshottasks`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `namespace`, `creationTimestamp`, `cluster`, `notebookName`, `status`

### `dce ai-lab notebookservice list-notebooks`

- Summary: List notebooks in a workspace
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/notebooks`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (query): cluster
  - `--namespace` (query): namespace
  - `--queue-name` (query): queueName
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `namespace`, `status.phase`, `type`, `creationTimestamp`, `cluster`
- Example:

```
dce ai-lab notebookservice list-notebooks \
  --workspace <workspace-id> \
  --page.page 1 --page.page-size 20
```

### `dce ai-lab notebookservice list-notebooks2`

- Summary: 额外支持的搜索、排序字段：type
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/notebooks`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--queue-name` (query): queueName
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `namespace`, `status.phase`, `type`, `creationTimestamp`, `cluster`

### `dce ai-lab notebookservice notebook-do-action`

- Summary: 需要 Developer 权限：devloper-notebook.update
- HTTP: `POST /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/notebooks/{name}/actions`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name

### `dce ai-lab notebookservice reset-notebook-image`

- Summary: 需要 Developer 权限：devloper-notebook.update
- HTTP: `POST /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/notebooks/{name}/image`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name

### `dce ai-lab notebookservice update-notebook`

- Summary: 需要 Developer 权限：devloper-notebook.update
- HTTP: `PUT /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/notebooks/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name

## PodsManagement

### `dce ai-lab podsmanagement get-pod-instance-list`

- Summary: 需要 Developer 权限：devloper-overview.get
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/resources/{name}/instances`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--type` (query, default `JOB_TYPE_UNSPECIFIED`, one of: JOB_TYPE_UNSPECIFIED|PYTORCH|TENSORFLOW|PADDLE|MXNET|MPI|NOTEBOOK|INFERENCE|DATASET): - PYTORCH: jobs
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `namespace`, `phase`, `creationTimestamp`, `cluster`, `containerReadyCount`

## QueueManagement

### `dce ai-lab queuemanagement check-queue`

- Summary: 需要 Developer 权限：devloper-queues.get
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/queues/{name}/capacites`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--name` (path, required): name
  - `--type` (query, default `QUEUE_TYPE_UNSPECIFIED`, one of: QUEUE_TYPE_UNSPECIFIED|KUEUE): 队列类型
  - `--namespace` (query): namespace

### `dce ai-lab queuemanagement create-local-queue`

- Summary: 需要 Developer 权限：devloper-queues.create
- HTTP: `POST /apis/baize.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/localqueues`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace

### `dce ai-lab queuemanagement create-queue`

- Summary: 需要 Operator 权限：operator-queues.create
- HTTP: `POST /apis/baize.io/v1alpha1/clusters/{cluster}/queues`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster
- Output: list path `resources`; columns `name`, `borrowingLimit`, `value`

### `dce ai-lab queuemanagement delete-queue`

- Summary: 需要 Operator 权限：operator-queues.delete
- HTTP: `DELETE /apis/baize.io/v1alpha1/clusters/{cluster}/queues/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster
  - `--name` (path, required): name
- Output: list path `resources`; columns `name`, `borrowingLimit`, `value`

### `dce ai-lab queuemanagement get-queue`

- Summary: 需要 Operator 权限：operator-queues.get
- HTTP: `GET /apis/baize.io/v1alpha1/clusters/{cluster}/queues/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--name` (path, required): name
  - `--type` (query, default `QUEUE_TYPE_UNSPECIFIED`, one of: QUEUE_TYPE_UNSPECIFIED|KUEUE): 队列类型
- Output: list path `resources`; columns `name`, `borrowingLimit`, `value`

### `dce ai-lab queuemanagement get-queue-by-json`

- Summary: 需要 Operator 权限：operator-queues.get
- HTTP: `GET /apis/baize.io/v1alpha1/clusters/{cluster}/queues/{name}/json`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--name` (path, required): name
  - `--type` (query, default `QUEUE_TYPE_UNSPECIFIED`, one of: QUEUE_TYPE_UNSPECIFIED|KUEUE): 队列类型

### `dce ai-lab queuemanagement list-queue-workloads`

- Summary: 额外支持的搜索、排序字段：queueName,priorityClassName
- HTTP: `GET /apis/baize.io/v1alpha1/clusters/{cluster}/queues/{queueName}/workloads`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--queue-name` (path, required): queueName
  - `--namespace` (query): namespace
  - `--type` (query, default `QUEUE_TYPE_UNSPECIFIED`, one of: QUEUE_TYPE_UNSPECIFIED|KUEUE): type
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `namespace`, `phase`, `creationTimestamp`, `cluster`, `preemptionPolicy`

### `dce ai-lab queuemanagement list-queues`

- Summary: List queues
- HTTP: `GET /apis/baize.io/v1alpha1/queues`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): cluster
  - `--type` (query, default `QUEUE_TYPE_UNSPECIFIED`, one of: QUEUE_TYPE_UNSPECIFIED|KUEUE): type
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
  - `--workspace` (query, int32): Workspace ID
- Output: list path `items`; columns `name`, `status.phase`, `type`, `cluster`, `description`, `strategy`

### `dce ai-lab queuemanagement list-queues2`

- Summary: 额外支持的搜索、排序字段：workspace
- HTTP: `GET /apis/baize.io/v1alpha1/workspace/{workspace}/queues`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
  - `--cluster` (query): cluster
  - `--type` (query, default `QUEUE_TYPE_UNSPECIFIED`, one of: QUEUE_TYPE_UNSPECIFIED|KUEUE): type
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `status.phase`, `type`, `cluster`, `description`, `strategy`

### `dce ai-lab queuemanagement update-queue`

- Summary: 需要 Operator 权限：operator-queues.update
- HTTP: `PUT /apis/baize.io/v1alpha1/clusters/{cluster}/queues/{name}`
- Auth: required
- Body: required
- Flags:
  - `--cluster` (path, required): cluster
  - `--name` (path, required): name
- Output: list path `resources`; columns `name`, `borrowingLimit`, `value`

## WorkspaceService

### `dce ai-lab workspaceservice list-workspaces`

- Summary: List workspaces
- HTTP: `GET /apis/baize.io/v1alpha1/workspaces`
- Auth: required
- Body: none
- Flags:
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, default `1`, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, default `20`, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
  - `--cluster` (query): cluster
- Output: list path `items`; columns `alias`, `workspaceId`

