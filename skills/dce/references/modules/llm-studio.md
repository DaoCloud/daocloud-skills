# Module `llm-studio`

## Source

- Backend: `swagger`
- Repository: https://github.com/DaoCloud/daocloud-api-docs.git
- Pinned tag: `658460973f77ce60f15c45f9afefbb5d70ee9e21`
- Files: `docs/openapi/hydra/v0.16.0.json`
- Resolved SHA: `658460973f77ce60f15c45f9afefbb5d70ee9e21`

## AIGuardrailsService

### `dce llm-studio aiguardrailsservice export-ai-audit-log`

- Summary: 当前 API 模式：Any
- HTTP: `GET /apis/admin.hydra.io/v1alpha1/ai-guardrails-logs/export`
- Auth: required
- Body: none
- Flags:
  - `--start-time` (query, date-time): startTime
  - `--end-time` (query, date-time): endTime
  - `--cluster-name` (query): clusterName
  - `--operation` (query, default `PLUGIN_ACTION_UNSPECIFIED`, one of: PLUGIN_ACTION_UNSPECIFIED|PLUGIN_ACTION_BLOCK|PLUGIN_ACTION_LOG|PLUGIN_ACTION_REPLACE_RANDOM|PLUGIN_ACTION_REPLACE_MASK): operation
  - `--plugin-id` (query, default `GUARDRAILS_PLUGIN_UNSPECIFIED`, one of: GUARDRAILS_PLUGIN_UNSPECIFIED|GUARDRAILS_PLUGIN_CONTAINS|GUARDRAILS_PLUGIN_REGEX|GUARDRAILS_PLUGIN_JSON_SCHEMA|GUARDRAILS_PLUGIN_JWT|GUARDRAILS_PLUGIN_MODEL_WHITELIST): pluginId
  - `--level` (query, default `GUARDRAILS_LEVEL_UNSPECIFIED`, one of: GUARDRAILS_LEVEL_UNSPECIFIED|GUARDRAILS_LEVEL_HIGH|GUARDRAILS_LEVEL_MEDIUM|GUARDRAILS_LEVEL_LOW): level
  - `--export-type` (query, default `EXPORT_TYPE_UNSPECIFIED`, one of: EXPORT_TYPE_UNSPECIFIED|EXPORT_TYPE_CSV|EXPORT_TYPE_EXCEL): exportType
  - `--route-name` (query): routeName
- Output: list path `extensions`; columns `@type`

### `dce llm-studio aiguardrailsservice get-ai-guardrails-config`

- Summary: 当前 API 模式：Any
- HTTP: `GET /apis/admin.hydra.io/v1alpha1/ai-guardrails/{cluster}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster

### `dce llm-studio aiguardrailsservice list-ai-guardrails-config`

- Summary: 当前 API 模式：Any
- HTTP: `GET /apis/admin.hydra.io/v1alpha1/ai-guardrails`
- Auth: required
- Body: none
- Flags:
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
  - `--cluster` (query): cluster
- Output: list path `items`; columns `blockStrategy`, `cluster`, `creationTime`, `denyMessage`, `updateTime`

### `dce llm-studio aiguardrailsservice query-ai-audit-log`

- Summary: 当前 API 模式：Any
- HTTP: `GET /apis/admin.hydra.io/v1alpha1/ai-guardrails-logs`
- Auth: required
- Body: none
- Flags:
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
  - `--start-time` (query, date-time): startTime
  - `--end-time` (query, date-time): endTime
  - `--cluster-name` (query): clusterName
  - `--operation` (query, default `PLUGIN_ACTION_UNSPECIFIED`, one of: PLUGIN_ACTION_UNSPECIFIED|PLUGIN_ACTION_BLOCK|PLUGIN_ACTION_LOG|PLUGIN_ACTION_REPLACE_RANDOM|PLUGIN_ACTION_REPLACE_MASK): operation
  - `--plugin-id` (query, default `GUARDRAILS_PLUGIN_UNSPECIFIED`, one of: GUARDRAILS_PLUGIN_UNSPECIFIED|GUARDRAILS_PLUGIN_CONTAINS|GUARDRAILS_PLUGIN_REGEX|GUARDRAILS_PLUGIN_JSON_SCHEMA|GUARDRAILS_PLUGIN_JWT|GUARDRAILS_PLUGIN_MODEL_WHITELIST): pluginId
  - `--level` (query, default `GUARDRAILS_LEVEL_UNSPECIFIED`, one of: GUARDRAILS_LEVEL_UNSPECIFIED|GUARDRAILS_LEVEL_HIGH|GUARDRAILS_LEVEL_MEDIUM|GUARDRAILS_LEVEL_LOW): level
  - `--route-name` (query): routeName
- Output: list path `items`; columns `clusterName`, `denyMessage`, `duration`, `functionArgs`, `functionName`, `level`

### `dce llm-studio aiguardrailsservice update-ai-guardrails-config`

- Summary: 当前 API 模式：Any
- HTTP: `PUT /apis/admin.hydra.io/v1alpha1/ai-guardrails`
- Auth: required
- Body: required
- Flags: none

## APIKeyManagement

### `dce llm-studio apikeymanagement check-api-key-creation`

- Summary: 校验是否可以创建 API Key
- HTTP: `POST /apis/hydra.io/v1alpha1/apikeys/check-creation`
- Auth: required
- Body: required
- Flags: none

### `dce llm-studio apikeymanagement create-api-key`

- Summary: 当前 API 模式：CSP
- HTTP: `POST /apis/hydra.io/v1alpha1/apikeys`
- Auth: required
- Body: required
- Flags: none
- Output: list path `allowModels`

### `dce llm-studio apikeymanagement delete-api-key`

- Summary: 当前 API 模式：CSP
- HTTP: `DELETE /apis/hydra.io/v1alpha1/apikeys/{id}`
- Auth: required
- Body: required
- Flags:
  - `--id` (path, required): id
- Output: list path `allowModels`

### `dce llm-studio apikeymanagement get-api-key-usage-statistics`

- Summary: protoc-gen-grpc-gateway-ts plugin is not support additional_bindings multiple methods (see: https://github.com/grpc-ecosystem/protoc-gen-grpc-gateway-ts/issues/32), but grpc-gateway support it.
- HTTP: `POST /apis/hydra.io/v1alpha1/apikeys-stats`
- Auth: required
- Body: required
- Flags: none
- Output: list path `dataPoints`; columns `model`, `modelType`, `timestamp`

### `dce llm-studio apikeymanagement get-api-key-usage-statistics2`

- Summary: protoc-gen-grpc-gateway-ts plugin is not support additional_bindings multiple methods (see: https://github.com/grpc-ecosystem/protoc-gen-grpc-gateway-ts/issues/32), but grpc-gateway support it.
- HTTP: `GET /apis/hydra.io/v1alpha1/apikeys-stats`
- Auth: required
- Body: none
- Flags:
  - `--start-time` (query, date-time): startTime
  - `--end-time` (query, date-time): endTime
  - `--ids` (query): ids
  - `--models` (query): models
  - `--period` (query, default `TIME_PERIOD_UNSPECIFIED`, one of: TIME_PERIOD_UNSPECIFIED|TIME_PERIOD_HOUR|TIME_PERIOD_DAY|TIME_PERIOD_WEEK|TIME_PERIOD_MONTH): period
- Output: list path `dataPoints`; columns `model`, `modelType`, `timestamp`

### `dce llm-studio apikeymanagement list-api-key`

- Summary: '当前 API 模式：CSP
- HTTP: `GET /apis/hydra.io/v1alpha1/apikeys`
- Auth: required
- Body: none
- Flags:
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `creationTimestamp`, `id`, `createBy`, `disabled`, `expireTime`

## AdminFilesStorageService

### `dce llm-studio adminfilesstorageservice create-files-storage`

- Summary: 当前 API 模式：Any
- HTTP: `POST /apis/admin.hydra.io/v1alpha1/filesstorages`
- Auth: required
- Body: required
- Flags: none

### `dce llm-studio adminfilesstorageservice create-folder`

- Summary: 当前 API 模式：Any
- HTTP: `POST /apis/admin.hydra.io/v1alpha1/filesstorages/{name}/folders/{folderName}`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): FilesStorage name
  - `--folder-name` (path, required): New folder name

### `dce llm-studio adminfilesstorageservice create-pre-pull`

- Summary: 当前 API 模式：Any
- HTTP: `POST /apis/admin.hydra.io/v1alpha1/filesstorages/{storageName}/prepulls`
- Auth: required
- Body: required
- Flags:
  - `--storage-name` (path, required): storageName

### `dce llm-studio adminfilesstorageservice create-sftp-access`

- Summary: 当前 API 模式：Any
- HTTP: `POST /apis/hydra.io/v1alpha1/filesstorages/{storageName}/sftp-access`
- Auth: required
- Body: required
- Flags:
  - `--storage-name` (path, required): storageName

### `dce llm-studio adminfilesstorageservice dataset-do-action`

- Summary: 当前 API 模式：Any
- HTTP: `POST /apis/admin.hydra.io/v1alpha1/filesstorages/{storageName}/prepulls/{prepullName}/actions`
- Auth: required
- Body: required
- Flags:
  - `--storage-name` (path, required): storageName
  - `--prepull-name` (path, required): prepullName

### `dce llm-studio adminfilesstorageservice delete-file`

- Summary: 当前 API 模式：Any
- HTTP: `POST /apis/admin.hydra.io/v1alpha1/filesstorages/{name}/files/{fileName}:delete`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): FilesStorage name
  - `--file-name` (path, required): File name

### `dce llm-studio adminfilesstorageservice delete-files-storage`

- Summary: 当前 API 模式：Any
- HTTP: `DELETE /apis/admin.hydra.io/v1alpha1/filesstorages/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name

### `dce llm-studio adminfilesstorageservice delete-pre-pull`

- Summary: 当前 API 模式：Any
- HTTP: `DELETE /apis/admin.hydra.io/v1alpha1/filesstorages/{storageName}/prepulls/{prepullName}`
- Auth: required
- Body: none
- Flags:
  - `--storage-name` (path, required): FilesStorage name
  - `--prepull-name` (path, required): prepullName

### `dce llm-studio adminfilesstorageservice get-files-storage`

- Summary: 当前 API 模式：Any
- HTTP: `GET /apis/admin.hydra.io/v1alpha1/filesstorages/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name

### `dce llm-studio adminfilesstorageservice get-pod-instance-list`

- Summary: 当前 API 模式：Any
- HTTP: `GET /apis/admin.hydra.io/v1alpha1/filesstorages/{storageName}/prepulls/{prepullName}/pods`
- Auth: required
- Body: none
- Flags:
  - `--storage-name` (path, required): storageName
  - `--prepull-name` (path, required): prepullName
  - `--workspace` (query, int32): workspace
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `namespace`, `phase`, `creationTimestamp`, `cluster`, `containerReadyCount`

### `dce llm-studio adminfilesstorageservice get-pre-pull`

- Summary: 当前 API 模式：Any
- HTTP: `GET /apis/admin.hydra.io/v1alpha1/filesstorages/{storageName}/prepulls/{prepullName}`
- Auth: required
- Body: none
- Flags:
  - `--storage-name` (path, required): storageName
  - `--prepull-name` (path, required): prepullName

### `dce llm-studio adminfilesstorageservice get-pre-pull-sync-process`

- Summary: 当前 API 模式：Any
- HTTP: `GET /apis/admin.hydra.io/v1alpha1/filesstorages/{storageName}/prepulls/{prepullName}/sync-process`
- Auth: required
- Body: none
- Flags:
  - `--storage-name` (path, required): storageName
  - `--prepull-name` (path, required): prepullName
  - `--cluster` (query): cluster

### `dce llm-studio adminfilesstorageservice get-sftp-access`

- Summary: 当前 API 模式：Any
- HTTP: `GET /apis/hydra.io/v1alpha1/filesstorages/{storageName}/sftp-access`
- Auth: required
- Body: none
- Flags:
  - `--storage-name` (path, required): storageName
  - `--workspace` (query, int32): workspace

### `dce llm-studio adminfilesstorageservice list-files`

- Summary: 当前 API 模式：Any
- HTTP: `GET /apis/admin.hydra.io/v1alpha1/filesstorages/{name}/files`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name
  - `--path` (query): path
  - `--type` (query, default `ALL`, one of: ALL|FILE|DIR): type
  - `--search-keyword` (query): searchKeyword
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `files`; columns `name`, `type`, `modificationTimestamp`, `size`

### `dce llm-studio adminfilesstorageservice list-files-storages`

- Summary: 当前 API 模式：Any
- HTTP: `GET /apis/admin.hydra.io/v1alpha1/filesstorages`
- Auth: required
- Body: none
- Flags:
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
  - `--cluster` (query): cluster
- Output: list path `items`; columns `name`, `status.phase`, `capacity`, `cluster`, `createTime`, `description`

### `dce llm-studio adminfilesstorageservice list-pre-pull-events`

- Summary: 当前 API 模式：Any
- HTTP: `GET /apis/admin.hydra.io/v1alpha1/filesstorages/{storageName}/prepulls/{prepullName}/events`
- Auth: required
- Body: none
- Flags:
  - `--storage-name` (path, required): storageName
  - `--prepull-name` (path, required): prepullName
  - `--cluster` (query): cluster
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `type`, `count`, `firstTimestamp`, `lastTimestamp`, `message`, `objKind`

### `dce llm-studio adminfilesstorageservice list-pre-pulls`

- Summary: '当前 API 模式：Any
- HTTP: `GET /apis/admin.hydra.io/v1alpha1/filesstorages/{storageName}/prepulls`
- Auth: required
- Body: none
- Flags:
  - `--storage-name` (path, required): FilesStorage name
  - `--cluster` (query): cluster
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `namespace`, `status.phase`, `creationTimestamp`, `cluster`, `description`

### `dce llm-studio adminfilesstorageservice list-referenced-by`

- Summary: 当前 API 模式：Any
- HTTP: `GET /apis/admin.hydra.io/v1alpha1/filesstorages/{name}/referencedby/{itemType}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): FilesStorage name
  - `--item-type` (path, required, one of: model|dataset): Reference file storage resource type
  - `--workspace` (query, int32): workspace
- Output: list path `items`; columns `name`, `id`

### `dce llm-studio adminfilesstorageservice update-files-storage`

- Summary: 当前 API 模式：Any
- HTTP: `PUT /apis/admin.hydra.io/v1alpha1/filesstorages/{name}`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): name

### `dce llm-studio adminfilesstorageservice update-pre-pull`

- Summary: 当前 API 模式：Any
- HTTP: `PUT /apis/admin.hydra.io/v1alpha1/filesstorages/{storageName}/prepulls/{prepullName}`
- Auth: required
- Body: required
- Flags:
  - `--storage-name` (path, required): FilesStorage name
  - `--prepull-name` (path, required): prepullName

### `dce llm-studio adminfilesstorageservice validate-data-source-secrets`

- Summary: 当前 API 模式：Any
- HTTP: `POST /apis/admin.hydra.io/v1alpha1/filesstorages/validate-secrets`
- Auth: required
- Body: required
- Flags: none

## AdminModelManagement

### `dce llm-studio adminmodelmanagement add-deploy-templates`

- Summary: 添加部署模板，只能对之前没有配置过部署模板的模型进行添加，否则会报 InvalidArgument 错误。
- HTTP: `POST /apis/admin.hydra.io/v1alpha1/models/{modelId}/deploy_templates`
- Auth: required
- Body: required
- Flags:
  - `--model-id` (path, required): 模型ID
- Output: list path `modelSupportFeature`

### `dce llm-studio adminmodelmanagement batch-create-models`

- Summary: 批量创建模型
- HTTP: `POST /apis/admin.hydra.io/v1alpha1/models:batch_create`
- Auth: required
- Body: required
- Flags: none
- Output: list path `items`; columns `creationTimestamp`, `modelName`, `hidden`, `modelAvatar`, `modelId`, `providerId`

### `dce llm-studio adminmodelmanagement create-model`

- Summary: 创建模型
- HTTP: `POST /apis/admin.hydra.io/v1alpha1/models`
- Auth: required
- Body: required
- Flags: none
- Output: list path `modelSupportFeature`

### `dce llm-studio adminmodelmanagement delete-model`

- Summary: 当前 API 模式：Any
- HTTP: `DELETE /apis/admin.hydra.io/v1alpha1/models/{modelId}`
- Auth: required
- Body: none
- Flags:
  - `--model-id` (path, required): modelId
- Output: list path `modelSupportFeature`

### `dce llm-studio adminmodelmanagement get-model`

- Summary: 当前 API 模式：Any
- HTTP: `GET /apis/admin.hydra.io/v1alpha1/models/{modelId}`
- Auth: required
- Body: none
- Flags:
  - `--model-id` (path, required): modelId
- Output: list path `modelSupportFeature`

### `dce llm-studio adminmodelmanagement list-model-servings-by-model`

- Summary: 查询模型关联的模型服务，按工作空间分组
- HTTP: `GET /apis/admin.hydra.io/v1alpha1/models/{modelId}/servings`
- Auth: required
- Body: none
- Flags:
  - `--model-id` (path, required): modelId
- Output: list path `items`; columns `workspaceId`, `workspaceName`

### `dce llm-studio adminmodelmanagement list-models`

- Summary: '当前 API 模式：Any
- HTTP: `GET /apis/admin.hydra.io/v1alpha1/models`
- Auth: required
- Body: none
- Flags:
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
  - `--show-deploy-template` (query): 是否展示公共模型价格
  - `--selector` (query, default `ALL`, one of: ALL|HAS_DEPLOY_TEMPLATE|NO_DEPLOY_TEMPLATE): 是否只展示已配置过部署模板的模型
- Output: list path `items`; columns `creationTimestamp`, `modelName`, `hidden`, `modelAvatar`, `modelId`, `providerId`

### `dce llm-studio adminmodelmanagement parse-model-specs`

- Summary: 解析导入的模型
- HTTP: `POST /apis/admin.hydra.io/v1alpha1/models:parse`
- Auth: required
- Body: required
- Flags: none
- Output: list path `items`; columns `error`, `exist`

### `dce llm-studio adminmodelmanagement publish-model`

- Summary: 上线到模型广场
- HTTP: `POST /apis/admin.hydra.io/v1alpha1/models/{modelId}:publish`
- Auth: required
- Body: required
- Flags:
  - `--model-id` (path, required): modelId
- Output: list path `modelSupportFeature`

### `dce llm-studio adminmodelmanagement unpublish-model`

- Summary: 从模型广场下线
- HTTP: `POST /apis/admin.hydra.io/v1alpha1/models/{modelId}:unpublish`
- Auth: required
- Body: required
- Flags:
  - `--model-id` (path, required): modelId
- Output: list path `modelSupportFeature`

### `dce llm-studio adminmodelmanagement update-deploy-templates`

- Summary: 更新部署模板
- HTTP: `PUT /apis/admin.hydra.io/v1alpha1/models/{modelId}/deploy_templates`
- Auth: required
- Body: required
- Flags:
  - `--model-id` (path, required): 模型ID
- Output: list path `modelSupportFeature`

### `dce llm-studio adminmodelmanagement update-model`

- Summary: 当前 API 模式：Any
- HTTP: `PUT /apis/admin.hydra.io/v1alpha1/models/{modelId}`
- Auth: required
- Body: required
- Flags:
  - `--model-id` (path, required): 模型ID
- Output: list path `modelSupportFeature`

## AdminModelTemplateManagement

### `dce llm-studio adminmodeltemplatemanagement create-model-template`

- Summary: 当前 API 模式：Any
- HTTP: `POST /apis/admin.hydra.io/v1alpha1/models/{modelId}/model-templates`
- Auth: required
- Body: required
- Flags:
  - `--model-id` (path, required): modelId

### `dce llm-studio adminmodeltemplatemanagement delete-model-template`

- Summary: 当前 API 模式：Any
- HTTP: `DELETE /apis/admin.hydra.io/v1alpha1/models/{modelId}/model-templates/{templateId}`
- Auth: required
- Body: none
- Flags:
  - `--model-id` (path, required): Optional in WS; required for Admin paths that include {model_id}.
  - `--template-id` (path, required): templateId
  - `--workspace` (query, int32): workspace

### `dce llm-studio adminmodeltemplatemanagement get-model-template`

- Summary: 当前 API 模式：Any
- HTTP: `GET /apis/admin.hydra.io/v1alpha1/models/{modelId}/model-templates/{templateId}`
- Auth: required
- Body: none
- Flags:
  - `--model-id` (path, required): Optional in WS; required for Admin paths that include {model_id}.
  - `--template-id` (path, required): templateId
  - `--workspace` (query, int32): workspace

### `dce llm-studio adminmodeltemplatemanagement list-model-templates`

- Summary: '当前 API 模式：Any
- HTTP: `GET /apis/admin.hydra.io/v1alpha1/models/{modelId}/model-templates`
- Auth: required
- Body: none
- Flags:
  - `--model-id` (path, required): modelId
  - `--workspace` (query, int32): workspace
  - `--inference-runtime` (query): inferenceRuntime
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `creationTimestamp`, `modelId`, `templateId`, `updateTimestamp`, `workspace`

### `dce llm-studio adminmodeltemplatemanagement update-model-template`

- Summary: 当前 API 模式：Any
- HTTP: `PUT /apis/admin.hydra.io/v1alpha1/models/{modelId}/model-templates/{templateId}`
- Auth: required
- Body: required
- Flags:
  - `--model-id` (path, required): Optional in WS; required for Admin paths that include {model_id}.
  - `--template-id` (path, required): templateId

## AdminModelWeightsVolumeManagement

### `dce llm-studio adminmodelweightsvolumemanagement create-model-weights-volume`

- Summary: create a new model weights volume
- HTTP: `POST /apis/admin.hydra.io/v1alpha1/models/{modelId}/weights`
- Auth: required
- Body: required
- Flags:
  - `--model-id` (path, required): modelId

### `dce llm-studio adminmodelweightsvolumemanagement delete-model-weights-volume`

- Summary: delete a model weights volume by ID
- HTTP: `DELETE /apis/admin.hydra.io/v1alpha1/models/{modelId}/weights/{id}`
- Auth: required
- Body: none
- Flags:
  - `--model-id` (path, required): modelId
  - `--id` (path, required): id

### `dce llm-studio adminmodelweightsvolumemanagement get-model-weights-volume`

- Summary: get a model weights volume by ID
- HTTP: `GET /apis/admin.hydra.io/v1alpha1/models/{modelId}/weights/{id}`
- Auth: required
- Body: none
- Flags:
  - `--model-id` (path, required): modelId
  - `--id` (path, required): id

### `dce llm-studio adminmodelweightsvolumemanagement get-storage-source`

- Summary: get storage source types for model weights volumes
- HTTP: `GET /apis/admin.hydra.io/v1alpha1/models/{modelId}/weights:storage-source`
- Auth: required
- Body: none
- Flags:
  - `--model-id` (path, required): modelId

### `dce llm-studio adminmodelweightsvolumemanagement list-model-weights-volumes`

- Summary: list model weights volumes for a model
- HTTP: `GET /apis/admin.hydra.io/v1alpha1/models/{modelId}/weights`
- Auth: required
- Body: none
- Flags:
  - `--model-id` (path, required): modelId
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
  - `--cluster-name` (query): clusterName
- Output: list path `items`; columns `creationTimestamp`, `id`, `clusterName`, `modelId`, `modelTag`, `mountPath`

### `dce llm-studio adminmodelweightsvolumemanagement update-model-weights-volume`

- Summary: update an existing model weights volume
- HTTP: `PUT /apis/admin.hydra.io/v1alpha1/models/{modelId}/weights/{id}`
- Auth: required
- Body: required
- Flags:
  - `--model-id` (path, required): modelId
  - `--id` (path, required): id

## AdminProviderManagement

### `dce llm-studio adminprovidermanagement create-provider`

- Summary: 当前 API 模式：Any
- HTTP: `POST /apis/admin.hydra.io/v1alpha1/providers`
- Auth: required
- Body: required
- Flags: none

### `dce llm-studio adminprovidermanagement delete-provider`

- Summary: 当前 API 模式：Any
- HTTP: `DELETE /apis/admin.hydra.io/v1alpha1/providers/{providerId}`
- Auth: required
- Body: none
- Flags:
  - `--provider-id` (path, required): providerId

### `dce llm-studio adminprovidermanagement get-provider`

- Summary: 当前 API 模式：Any
- HTTP: `GET /apis/admin.hydra.io/v1alpha1/providers/{providerId}`
- Auth: required
- Body: none
- Flags:
  - `--provider-id` (path, required): providerId

### `dce llm-studio adminprovidermanagement list-providers`

- Summary: '当前 API 模式：Any
- HTTP: `GET /apis/admin.hydra.io/v1alpha1/providers`
- Auth: required
- Body: none
- Flags:
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `providerAvatar`, `providerId`

### `dce llm-studio adminprovidermanagement update-provider`

- Summary: 当前 API 模式：Any
- HTTP: `PUT /apis/admin.hydra.io/v1alpha1/providers/{providerId}`
- Auth: required
- Body: required
- Flags:
  - `--provider-id` (path, required): 提供者ID

## AgentCommunicationService

### `dce llm-studio agentcommunicationservice report-eval-metrics`

- Summary: ReportEvalMetrics appends evaluation metrics to the corresponding job record.
- HTTP: `POST /apis/hydra.io/v1alpha1/agent/finetune/evaljob-metrics:report`
- Auth: required
- Body: required
- Flags: none

### `dce llm-studio agentcommunicationservice report-fine-tune-metrics`

- Summary: ReportFineTuneMetrics appends fine-tune loss metrics to the corresponding job record.
- HTTP: `POST /apis/hydra.io/v1alpha1/agent/finetune/finetunejob-metrics:report`
- Auth: required
- Body: required
- Flags: none

## Cluster

### `dce llm-studio cluster get-prerequisite`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/prerequisites/{prerequisite}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--cluster` (path, required): cluster
  - `--prerequisite` (path, required, one of: PREREQUISITE_UNSPECIFIED|PREREQUISITE_PREFLIGHT): prerequisite

## Core

### `dce llm-studio core list-role-permissions-by-workspace-for-current-user`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/permissions`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
- Output: list path `permissions`

## CoreService

### `dce llm-studio coreservice admin-list-cluster`

- Summary: 当前 API 模式：Any
- HTTP: `GET /apis/admin.hydra.io/v1alpha1/clusters`
- Auth: required
- Body: none
- Flags:
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `agentInstalled`, `baseUrl`, `status`

### `dce llm-studio coreservice admin-list-constants`

- Summary: 当前 API 模式：Any
- HTTP: `GET /apis/admin.hydra.io/v1alpha1/constants`
- Auth: required
- Body: none
- Flags: none

### `dce llm-studio coreservice get-analysis-uri`

- Summary: 当前 API 模式：Any
- HTTP: `GET /apis/admin.hydra.io/v1alpha1/analysis-uri`
- Auth: required
- Body: none
- Flags: none

### `dce llm-studio coreservice get-export-uri`

- Summary: 当前 API 模式：Any
- HTTP: `GET /apis/admin.hydra.io/v1alpha1/export-uri`
- Auth: required
- Body: none
- Flags:
  - `--module` (query, default `EXPORT_MODULE_UNSPECIFIED`, one of: EXPORT_MODULE_UNSPECIFIED|EXPORT_MODULE_AI_AUDIT_LOG): module

### `dce llm-studio coreservice list-platform-role-permissions-for-current-user`

- Summary: 当前 API 模式：Any
- HTTP: `GET /apis/admin.hydra.io/v1alpha1/permissions`
- Auth: required
- Body: none
- Flags: none
- Output: list path `permissions`

## CostMockConfigManagement

### `dce llm-studio costmockconfigmanagement create-cost-mock-config`

- Summary: 当前 API 模式：WS
- HTTP: `POST /apis/hydra.io/v1alpha1/analysis-center/cost-mock-config`
- Auth: required
- Body: required
- Flags: none
- Output: list path `gpuCosts`; columns `cluster`, `hourlyPrice`, `productName`, `sn`

### `dce llm-studio costmockconfigmanagement delete-cost-mock-config`

- Summary: 当前 API 模式：WS
- HTTP: `DELETE /apis/hydra.io/v1alpha1/analysis-center/cost-mock-config`
- Auth: required
- Body: none
- Flags: none
- Output: list path `gpuCosts`; columns `cluster`, `hourlyPrice`, `productName`, `sn`

### `dce llm-studio costmockconfigmanagement get-cost-mock-config`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/analysis-center/cost-mock-config`
- Auth: required
- Body: none
- Flags: none
- Output: list path `gpuCosts`; columns `cluster`, `hourlyPrice`, `productName`, `sn`

### `dce llm-studio costmockconfigmanagement update-cost-mock-config`

- Summary: 当前 API 模式：WS
- HTTP: `PUT /apis/hydra.io/v1alpha1/analysis-center/cost-mock-config`
- Auth: required
- Body: required
- Flags: none
- Output: list path `gpuCosts`; columns `cluster`, `hourlyPrice`, `productName`, `sn`

## Image

### `dce llm-studio image detect-kangaroo`

- Summary: DetectKangaroo returns whether the kangaroo is installed.
- HTTP: `GET /apis/hydra.io/v1alpha1/registries/kangaroo`
- Auth: required
- Body: none
- Flags: none

### `dce llm-studio image get-image-info`

- Summary: GetImageInfo parses an image reference and resolves its registry metadata.
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/imageinfo`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--image` (query): image is the full image reference to resolve, e.g. "registry.example.com/project/repo:tag".

### `dce llm-studio image list-artifacts`

- Summary: ListArtifacts returns a list of tags of specified image
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/registries/{registry}/repositories/{repository}/artifacts`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--registry` (path, required): Registry is registry name.
  - `--repository` (path, required): Repository is image name.
  - `--project` (query): Project is the project to request.
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `creationTimestamp`, `digest`, `imageSize`

### `dce llm-studio image list-projects`

- Summary: ListProjects returns a list of projects of specified registry
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/registries/{registry}/projects`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--registry` (path, required): Registry is registry name.
  - `--public` (query): Public is distinguish public projects and private projects.
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
  - `--only-bind` (query): if true only return bound data.
  - `--all` (query): if true return all projects.
- Output: list path `items`; columns `name`, `visible`

### `dce llm-studio image list-registries`

- Summary: ListRegistries returns a list of registries
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/registries`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--global` (query): Global is to list all global registries.
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `type`, `host`, `scope`

### `dce llm-studio image list-repositories`

- Summary: ListRepositories returns a list of image names of specified project
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/registries/{registry}/repositories`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--registry` (path, required): Registry is registry name.
  - `--project` (query): Project is the project to request, "/" is a possible value.
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `updateTimestamp`

### `dce llm-studio image list-secrets`

- Summary: ListSecrets lists a secret under the namespaces of a specific cluster
- HTTP: `GET /apis/hydra.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/secrets`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Cluster represents which cluster the secret belongs to.
  - `--namespace` (path, required): Namespace is the metadata.namespace of the referenced secret.
  - `--type` (query): Type is used to filter secrets by type.
- Output: list path `items`; columns `name`, `namespace`, `type`, `cluster`

## MAASService

### `dce llm-studio maasservice create-maas-model`

- Summary: 当前 API 模式：Any
- HTTP: `POST /apis/admin.hydra.io/v1alpha1/maas-models`
- Auth: required
- Body: required
- Flags: none
- Output: list path `upstreamModels`; columns `apiKey`, `endpoint`, `modelId`, `status`

### `dce llm-studio maasservice get-maas-model`

- Summary: 当前 API 模式：Any
- HTTP: `GET /apis/admin.hydra.io/v1alpha1/maas-models/{modelId}`
- Auth: required
- Body: none
- Flags:
  - `--model-id` (path, required): 模型ID
- Output: list path `upstreamModels`; columns `apiKey`, `endpoint`, `modelId`, `status`

### `dce llm-studio maasservice list-maas-models`

- Summary: '当前 API 模式：Any
- HTTP: `GET /apis/admin.hydra.io/v1alpha1/maas-models`
- Auth: required
- Body: none
- Flags:
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `creationTimestamp`, `cluster`, `enabled`, `gatewayStatus`, `tokenWeight`

### `dce llm-studio maasservice update-maas-model`

- Summary: 更新MAAS模型的限流，负载均衡配置
- HTTP: `PUT /apis/admin.hydra.io/v1alpha1/maas-models/{modelId}`
- Auth: required
- Body: required
- Flags:
  - `--model-id` (path, required): 模型ID
- Output: list path `upstreamModels`; columns `apiKey`, `endpoint`, `modelId`, `status`

### `dce llm-studio maasservice update-maas-model-status`

- Summary: 启用/禁用MAAS模型的体验功能
- HTTP: `PUT /apis/admin.hydra.io/v1alpha1/maas-models/{modelId}/status`
- Auth: required
- Body: required
- Flags:
  - `--model-id` (path, required): 模型ID
- Output: list path `upstreamModels`; columns `apiKey`, `endpoint`, `modelId`, `status`

## Management

### `dce llm-studio management get-web-search-agent-config`

- Summary: 当前 API 模式：Any
- HTTP: `GET /apis/hydra.io/v1alpha1/web-search-agent/config`
- Auth: required
- Body: none
- Flags: none

### `dce llm-studio management list-gpu-types`

- Summary: 当前 API 模式：Any
- HTTP: `GET /apis/hydra.io/v1alpha1/gpu-types`
- Auth: required
- Body: none
- Flags: none
- Output: list path `items`; columns `gpuName`, `gpuType`

### `dce llm-studio management list-inference-runtimes`

- Summary: 当前 API 模式：Any
- HTTP: `GET /apis/hydra.io/v1alpha1/inference-runtimes`
- Auth: required
- Body: none
- Flags: none
- Output: list path `items`; columns `distributedSupported`, `runtimeCommand`

## ModelManagement

### `dce llm-studio modelmanagement get-model`

- Summary: 当前 API 模式：CSP
- HTTP: `GET /apis/hydra.io/v1alpha1/models/{modelId}`
- Auth: required
- Body: none
- Flags:
  - `--model-id` (path, required): modelId
- Output: list path `modelSupportFeature`

### `dce llm-studio modelmanagement list-models`

- Summary: '当前 API 模式：CSP
- HTTP: `GET /apis/hydra.io/v1alpha1/models`
- Auth: required
- Body: none
- Flags:
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
  - `--show-public-model-price` (query): 是否展示公共模型价格
- Output: list path `items`; columns `creationTimestamp`, `modelName`, `finetune`, `modelAvatar`, `modelDeploymentsExists`, `modelId`

## ModelServingManagement

### `dce llm-studio modelservingmanagement create-model-serving`

- Summary: 当前 API 模式：CSP
- HTTP: `POST /apis/hydra.io/v1alpha1/model-serving`
- Auth: required
- Body: required
- Flags: none
- Output: list path `modelSupportFeature`

### `dce llm-studio modelservingmanagement delete-model-serving`

- Summary: 当前 API 模式：CSP
- HTTP: `DELETE /apis/hydra.io/v1alpha1/model-serving/{id}`
- Auth: required
- Body: required
- Flags:
  - `--id` (path, required): id
- Output: list path `modelSupportFeature`

### `dce llm-studio modelservingmanagement do-model-serving-action`

- Summary: 当前 API 模式：CSP
- HTTP: `POST /apis/hydra.io/v1alpha1/model-serving/{id}/actions`
- Auth: required
- Body: required
- Flags:
  - `--id` (path, required): id
- Output: list path `modelSupportFeature`

### `dce llm-studio modelservingmanagement get-model-serving`

- Summary: 当前 API 模式：CSP
- HTTP: `GET /apis/hydra.io/v1alpha1/model-serving/{id}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id
- Output: list path `modelSupportFeature`

### `dce llm-studio modelservingmanagement list-model-serving`

- Summary: '当前 API 模式：CSP
- HTTP: `GET /apis/hydra.io/v1alpha1/model-serving`
- Auth: required
- Body: none
- Flags:
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `namespace`, `creationTimestamp`, `id`, `modelName`, `accessModelName`

### `dce llm-studio modelservingmanagement update-model-serving-replicas`

- Summary: 当前 API 模式：CSP
- HTTP: `PATCH /apis/hydra.io/v1alpha1/model-serving/{id}/replicas`
- Auth: required
- Body: required
- Flags:
  - `--id` (path, required): id
- Output: list path `modelSupportFeature`

## ProviderManagement

### `dce llm-studio providermanagement get-provider`

- Summary: 当前 API 模式：CSP
- HTTP: `GET /apis/hydra.io/v1alpha1/providers/{id}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id

### `dce llm-studio providermanagement list-provider`

- Summary: '当前 API 模式：CSP
- HTTP: `GET /apis/hydra.io/v1alpha1/providers`
- Auth: required
- Body: none
- Flags:
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `providerAvatar`, `providerId`

## QueueManagement

### `dce llm-studio queuemanagement check-queue`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/queues/{name}/capacites`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--cluster` (path, required): cluster
  - `--name` (path, required): name
  - `--type` (query, default `QUEUE_TYPE_UNSPECIFIED`, one of: QUEUE_TYPE_UNSPECIFIED|KUEUE): 队列类型
  - `--namespace` (query): namespace

### `dce llm-studio queuemanagement create-local-queue`

- Summary: 当前 API 模式：WS
- HTTP: `POST /apis/hydra.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/localqueues`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace

### `dce llm-studio queuemanagement list-queues`

- Summary: '当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/queues`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (query, int32): workspace
  - `--cluster` (query): cluster
  - `--type` (query, default `QUEUE_TYPE_UNSPECIFIED`, one of: QUEUE_TYPE_UNSPECIFIED|KUEUE): type
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `status.phase`, `type`, `cluster`, `description`, `preemptionWithinClusterQueue`

### `dce llm-studio queuemanagement list-queues2`

- Summary: '当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspace/{workspace}/queues`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--cluster` (query): cluster
  - `--type` (query, default `QUEUE_TYPE_UNSPECIFIED`, one of: QUEUE_TYPE_UNSPECIFIED|KUEUE): type
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `status.phase`, `type`, `cluster`, `description`, `preemptionWithinClusterQueue`

## SKUManagement

### `dce llm-studio skumanagement get-region`

- Summary: 当前 API 模式：CSP
- HTTP: `GET /apis/hydra.io/v1alpha1/regions/{region}`
- Auth: required
- Body: none
- Flags:
  - `--region` (path, required): region

### `dce llm-studio skumanagement list-regions`

- Summary: 获取地区信息。
- HTTP: `GET /apis/hydra.io/v1alpha1/regions`
- Auth: required
- Body: none
- Flags:
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `baseUrl`, `region`

### `dce llm-studio skumanagement list-sk-us`

- Summary: 获取 SKU 信息。
- HTTP: `GET /apis/hydra.io/v1alpha1/skus`
- Auth: required
- Body: none
- Flags:
  - `--region` (query): region
  - `--resource-type` (query, default `RESOURCE_TYPE_UNSPECIFIED`, one of: RESOURCE_TYPE_UNSPECIFIED|MODEL): resourceType
  - `--resource-id` (query): resourceId
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `id`, `available`, `description`, `paymentMethod`, `priceCurrency`, `pricePerUnit`

## UserService

### `dce llm-studio userservice current-user`

- Summary: 获取用户信息
- HTTP: `GET /apis/hydra.io/v1alpha1/current-user`
- Auth: required
- Body: none
- Flags: none

## WSAPIKeyManagement

### `dce llm-studio wsapikeymanagement create-wsapi-key`

- Summary: 当前 API 模式：WS
- HTTP: `POST /apis/hydra.io/v1alpha1/workspaces/{workspace}/apikeys`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace
- Output: list path `allowModels`

### `dce llm-studio wsapikeymanagement delete-wsapi-key`

- Summary: 当前 API 模式：WS
- HTTP: `DELETE /apis/hydra.io/v1alpha1/workspaces/{workspace}/apikeys/{id}`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--id` (path, required): id
- Output: list path `allowModels`

### `dce llm-studio wsapikeymanagement get-api-key-usage-statistics`

- Summary: 当前 API 模式：WS
- HTTP: `POST /apis/hydra.io/v1alpha1/workspaces/{workspace}/apikeys-stats`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace
- Output: list path `dataPoints`; columns `model`, `modelType`, `timestamp`

### `dce llm-studio wsapikeymanagement get-api-key-usage-statistics2`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/apikeys-stats`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--start-time` (query, date-time): startTime
  - `--end-time` (query, date-time): endTime
  - `--ids` (query): ids
  - `--models` (query): models
  - `--period` (query, default `TIME_PERIOD_UNSPECIFIED`, one of: TIME_PERIOD_UNSPECIFIED|TIME_PERIOD_HOUR|TIME_PERIOD_DAY|TIME_PERIOD_WEEK|TIME_PERIOD_MONTH): period
- Output: list path `dataPoints`; columns `model`, `modelType`, `timestamp`

### `dce llm-studio wsapikeymanagement list-my-wsapi-keys`

- Summary: '当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/my-apikeys`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `creationTimestamp`, `id`, `createBy`, `disabled`, `expireTime`

### `dce llm-studio wsapikeymanagement list-wsapi-key`

- Summary: '当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/apikeys`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `creationTimestamp`, `id`, `createBy`, `disabled`, `expireTime`

### `dce llm-studio wsapikeymanagement update-wsapi-key-quota`

- Summary: 当前 API 模式：WS
- HTTP: `PUT /apis/hydra.io/v1alpha1/workspaces/{workspace}/apikeys/{id}/quota`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--id` (path, required): id
- Output: list path `allowModels`

### `dce llm-studio wsapikeymanagement update-wsapi-key-status`

- Summary: 当前 API 模式：WS
- HTTP: `PUT /apis/hydra.io/v1alpha1/workspaces/{workspace}/apikeys/{id}/status`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--id` (path, required): id
- Output: list path `allowModels`

## WSDashboardManagement

### `dce llm-studio wsdashboardmanagement get-ws-dashboard-summary`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/dashboard/summary`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--start-time` (query, date-time): startTime
  - `--end-time` (query, date-time): endTime
  - `--compare-start-time` (query, date-time): compareStartTime
  - `--compare-end-time` (query, date-time): compareEndTime
  - `--timezone` (query): timezone

### `dce llm-studio wsdashboardmanagement list-ws-instance-token-usage`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/dashboard/instances/token-usage`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--start-time` (query, date-time): startTime
  - `--end-time` (query, date-time): endTime
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
  - `--sort-by` (query): sortBy
  - `--sort-order` (query): sortOrder
- Output: list path `items`; columns `modelName`, `cachedTokens`, `inputTokens`, `instanceId`, `instanceName`, `lastUsedTime`

### `dce llm-studio wsdashboardmanagement list-ws-user-token-usage`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/dashboard/users/token-usage`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--start-time` (query, date-time): startTime
  - `--end-time` (query, date-time): endTime
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
  - `--sort-by` (query): sortBy
  - `--sort-order` (query): sortOrder
- Output: list path `items`; columns `cachedTokens`, `inputTokens`, `lastUsedTime`, `outputTokens`, `requestCount`, `totalTokens`

## WSDatasetManagement

### `dce llm-studio wsdatasetmanagement create-private-dataset`

- Summary: 当前 API 模式：WS
- HTTP: `POST /apis/hydra.io/v1alpha1/workspaces/{workspace}/private-datasets`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace

### `dce llm-studio wsdatasetmanagement delete-private-dataset`

- Summary: 当前 API 模式：WS
- HTTP: `DELETE /apis/hydra.io/v1alpha1/workspaces/{workspace}/private-datasets/{datasetId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--dataset-id` (path, required): datasetId

### `dce llm-studio wsdatasetmanagement get-private-dataset`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/private-datasets/{datasetId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--dataset-id` (path, required): datasetId

### `dce llm-studio wsdatasetmanagement get-ws-dataset-template`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/datasets:template`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--framework` (query, default `DATASET_FRAMEWORK_UNSPECIFIED`, one of: DATASET_FRAMEWORK_UNSPECIFIED|DATASET_FRAMEWORK_LLAMAFACTORY): framework
  - `--format` (query, default `DATASET_FORMAT_UNSPECIFIED`, one of: DATASET_FORMAT_UNSPECIFIED|DATASET_FORMAT_ALPACA|DATASET_FORMAT_SHAREGPT): format
  - `--usage-type` (query, default `DATASET_USAGE_TYPE_UNSPECIFIED`, one of: DATASET_USAGE_TYPE_UNSPECIFIED|DATASET_USAGE_TYPE_SFT|DATASET_USAGE_TYPE_KTO|DATASET_USAGE_TYPE_PREFERENCE): usageType

### `dce llm-studio wsdatasetmanagement list-private-datasets`

- Summary: '当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/private-datasets`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `creationTimestamp`, `datasetAvatar`, `datasetId`, `datasetName`, `providerId`, `source`

### `dce llm-studio wsdatasetmanagement update-private-dataset`

- Summary: 当前 API 模式：WS
- HTTP: `PUT /apis/hydra.io/v1alpha1/workspaces/{workspace}/private-datasets/{datasetId}`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--dataset-id` (path, required): datasetId

## WSDatasetVolumeManagement

### `dce llm-studio wsdatasetvolumemanagement create-ws-dataset-volume`

- Summary: create a new dataset volume in a workspace
- HTTP: `POST /apis/hydra.io/v1alpha1/datasets/{datasetId}/workspaces/{workspace}/volumes`
- Auth: required
- Body: required
- Flags:
  - `--dataset-id` (path, required): datasetId
  - `--workspace` (path, required, int32): workspace

### `dce llm-studio wsdatasetvolumemanagement delete-ws-dataset-volume`

- Summary: delete a dataset volume by ID in a workspace
- HTTP: `DELETE /apis/hydra.io/v1alpha1/datasets/{datasetId}/workspaces/{workspace}/volumes/{id}`
- Auth: required
- Body: none
- Flags:
  - `--dataset-id` (path, required): datasetId
  - `--workspace` (path, required, int32): workspace
  - `--id` (path, required): id

### `dce llm-studio wsdatasetvolumemanagement get-ws-dataset-storage-source`

- Summary: get storage source types for dataset volumes in a workspace
- HTTP: `GET /apis/hydra.io/v1alpha1/datasets/{datasetId}/workspaces/{workspace}/volumes:storage-source`
- Auth: required
- Body: none
- Flags:
  - `--dataset-id` (path, required): datasetId
  - `--workspace` (path, required, int32): workspace

### `dce llm-studio wsdatasetvolumemanagement get-ws-dataset-volume`

- Summary: get a dataset volume by ID in a workspace
- HTTP: `GET /apis/hydra.io/v1alpha1/datasets/{datasetId}/workspaces/{workspace}/volumes/{id}`
- Auth: required
- Body: none
- Flags:
  - `--dataset-id` (path, required): datasetId
  - `--workspace` (path, required, int32): workspace
  - `--id` (path, required): id

### `dce llm-studio wsdatasetvolumemanagement list-ws-dataset-volumes`

- Summary: list dataset volumes for a dataset in a workspace
- HTTP: `GET /apis/hydra.io/v1alpha1/datasets/{datasetId}/workspaces/{workspace}/volumes`
- Auth: required
- Body: none
- Flags:
  - `--dataset-id` (path, required): datasetId
  - `--workspace` (path, required, int32): workspace
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
  - `--cluster-name` (query): clusterName
  - `--dataset-format` (query, default `DATASET_FORMAT_UNSPECIFIED`, one of: DATASET_FORMAT_UNSPECIFIED|DATASET_FORMAT_ALPACA|DATASET_FORMAT_SHAREGPT): datasetFormat
  - `--dataset-usage-type` (query, default `DATASET_USAGE_TYPE_UNSPECIFIED`, one of: DATASET_USAGE_TYPE_UNSPECIFIED|DATASET_USAGE_TYPE_SFT|DATASET_USAGE_TYPE_KTO|DATASET_USAGE_TYPE_PREFERENCE): datasetUsageType
- Output: list path `items`; columns `creationTimestamp`, `id`, `clusterName`, `datasetFormat`, `datasetId`, `datasetTag`

### `dce llm-studio wsdatasetvolumemanagement update-ws-dataset-volume`

- Summary: update a dataset volume by ID in a workspace
- HTTP: `PUT /apis/hydra.io/v1alpha1/datasets/{datasetId}/workspaces/{workspace}/volumes/{id}`
- Auth: required
- Body: required
- Flags:
  - `--dataset-id` (path, required): datasetId
  - `--workspace` (path, required, int32): workspace
  - `--id` (path, required): id

## WSEvalJobManagement

### `dce llm-studio wsevaljobmanagement create-ws-eval-job`

- Summary: 当前 API 模式：WS
- HTTP: `POST /apis/hydra.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/finetune-evaljobs`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
- Output: list path `env`; columns `name`, `value`

### `dce llm-studio wsevaljobmanagement default-eval-job`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/finetune-evaljobs:default`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
- Output: list path `env`; columns `name`, `value`

### `dce llm-studio wsevaljobmanagement delete-ws-eval-job`

- Summary: 当前 API 模式：WS
- HTTP: `DELETE /apis/hydra.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/finetune-evaljobs/{id}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--id` (path, required): id

### `dce llm-studio wsevaljobmanagement get-ws-eval-job`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/finetune-evaljobs/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
- Output: list path `env`; columns `name`, `value`

### `dce llm-studio wsevaljobmanagement get-ws-eval-metrics`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/finetune-evaljobs/{id}/metrics`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--id` (path, required): id

### `dce llm-studio wsevaljobmanagement list-ws-eval-jobs`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/finetune-evaljobs`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
  - `--finetune-job-id` (query): finetuneJobId
- Output: list path `items`; columns `name`, `namespace`, `phase`, `creationTimestamp`, `id`, `cluster`

## WSExportJobService

### `dce llm-studio wsexportjobservice creat-export-job`

- Summary: 当前 API 模式：WS
- HTTP: `POST /apis/hydra.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/finetune-exportjobs`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): ID of the workspace to which the resource belongs.
  - `--cluster` (path, required): The cluster where the K8s job is deployed.
  - `--namespace` (path, required): The namespace where the K8s job is deployed.

### `dce llm-studio wsexportjobservice default-export-job`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/finetune-exportjobs:default`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace

### `dce llm-studio wsexportjobservice delete-export-job`

- Summary: 当前 API 模式：WS
- HTTP: `DELETE /apis/hydra.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/finetune-exportjobs/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): ID of the workspace to which the resource belongs.
  - `--cluster` (path, required): The cluster where the K8s job is deployed.
  - `--namespace` (path, required): The namespace where the K8s job is deployed.
  - `--name` (path, required): Name of the export job.

### `dce llm-studio wsexportjobservice get-export-job`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/finetune-exportjobs/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): ID of the workspace to which the resource belongs.
  - `--cluster` (path, required): The cluster where the K8s job is deployed.
  - `--namespace` (path, required): The namespace where the K8s job is deployed.
  - `--name` (path, required): Name of the export job.

### `dce llm-studio wsexportjobservice list-export-job`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/finetune-exportjobs`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): ID of the workspace to which the resource belongs.
  - `--cluster` (path, required): The cluster where the K8s job is deployed.
  - `--namespace` (path, required): The namespace where the K8s job is deployed.
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
  - `--finetune-job-id` (query): finetuneJobId
- Output: list path `exportJobs`; columns `name`, `namespace`, `cluster`, `creationTime`, `exportDevice`, `exportLegacyFormat`

## WSFilesStorageService

### `dce llm-studio wsfilesstorageservice create-ws-files-storage`

- Summary: 当前 API 模式：WS
- HTTP: `POST /apis/hydra.io/v1alpha1/workspaces/{workspace}/filesstorages`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace

### `dce llm-studio wsfilesstorageservice create-ws-folder`

- Summary: 当前 API 模式：WS
- HTTP: `POST /apis/hydra.io/v1alpha1/workspaces/{workspace}/filesstorages/{name}/folders/{folderName}`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--name` (path, required): FilesStorage name
  - `--folder-name` (path, required): New folder name

### `dce llm-studio wsfilesstorageservice delete-ws-file`

- Summary: 当前 API 模式：WS
- HTTP: `POST /apis/hydra.io/v1alpha1/workspaces/{workspace}/filesstorages/{name}/files/{fileName}:delete`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--name` (path, required): FilesStorage name
  - `--file-name` (path, required): File name

### `dce llm-studio wsfilesstorageservice delete-ws-files-storage`

- Summary: 当前 API 模式：WS
- HTTP: `DELETE /apis/hydra.io/v1alpha1/workspaces/{workspace}/filesstorages/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--name` (path, required): name

### `dce llm-studio wsfilesstorageservice get-ws-files-storage`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/filesstorages/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--name` (path, required): name

### `dce llm-studio wsfilesstorageservice list-ws-files`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/filesstorages/{name}/files`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--name` (path, required): name
  - `--path` (query): path
  - `--type` (query, default `ALL`, one of: ALL|FILE|DIR): type
  - `--search-keyword` (query): searchKeyword
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `files`; columns `name`, `type`, `modificationTimestamp`, `size`

### `dce llm-studio wsfilesstorageservice list-ws-files-storages`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/filesstorages`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
  - `--cluster` (query): cluster
- Output: list path `items`; columns `name`, `status.phase`, `capacity`, `cluster`, `createTime`, `description`

### `dce llm-studio wsfilesstorageservice list-ws-referenced-by`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/filesstorages/{name}/referencedby/{itemType}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--name` (path, required): FilesStorage name
  - `--item-type` (path, required, one of: model|dataset): Reference file storage resource type
- Output: list path `items`; columns `name`, `id`

### `dce llm-studio wsfilesstorageservice update-ws-files-storage`

- Summary: 当前 API 模式：WS
- HTTP: `PUT /apis/hydra.io/v1alpha1/workspaces/{workspace}/filesstorages/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--name` (path, required): name

### `dce llm-studio wsfilesstorageservice ws-create-pre-pull`

- Summary: 当前 API 模式：WS
- HTTP: `POST /apis/hydra.io/v1alpha1/workspaces/{workspace}/filesstorages/{storageName}/prepulls`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--storage-name` (path, required): storageName

### `dce llm-studio wsfilesstorageservice ws-create-sftp-access`

- Summary: 当前 API 模式：WS
- HTTP: `POST /apis/hydra.io/v1alpha1/workspaces/{workspace}/filesstorages/{storageName}/sftp-access`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--storage-name` (path, required): storageName

### `dce llm-studio wsfilesstorageservice ws-dataset-do-action`

- Summary: 当前 API 模式：WS
- HTTP: `POST /apis/hydra.io/v1alpha1/workspaces/{workspace}/filesstorages/{storageName}/prepulls/{prepullName}/actions`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--storage-name` (path, required): storageName
  - `--prepull-name` (path, required): prepullName

### `dce llm-studio wsfilesstorageservice ws-delete-pre-pull`

- Summary: 当前 API 模式：WS
- HTTP: `DELETE /apis/hydra.io/v1alpha1/workspaces/{workspace}/filesstorages/{storageName}/prepulls/{prepullName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--storage-name` (path, required): FilesStorage name
  - `--prepull-name` (path, required): prepullName

### `dce llm-studio wsfilesstorageservice ws-get-pod-instance-list`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/filesstorages/{storageName}/prepulls/{prepullName}/pods`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--storage-name` (path, required): storageName
  - `--prepull-name` (path, required): prepullName
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `namespace`, `phase`, `creationTimestamp`, `cluster`, `containerReadyCount`

### `dce llm-studio wsfilesstorageservice ws-get-pre-pull`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/filesstorages/{storageName}/prepulls/{prepullName}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--storage-name` (path, required): storageName
  - `--prepull-name` (path, required): prepullName

### `dce llm-studio wsfilesstorageservice ws-get-pre-pull-sync-process`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/filesstorages/{storageName}/prepulls/{prepullName}/sync-process`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--storage-name` (path, required): storageName
  - `--prepull-name` (path, required): prepullName
  - `--cluster` (query): cluster

### `dce llm-studio wsfilesstorageservice ws-get-sftp-access`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/filesstorages/{storageName}/sftp-access`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--storage-name` (path, required): storageName

### `dce llm-studio wsfilesstorageservice ws-list-pre-pull-events`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/filesstorages/{storageName}/prepulls/{prepullName}/events`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--storage-name` (path, required): storageName
  - `--prepull-name` (path, required): prepullName
  - `--cluster` (query): cluster
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `type`, `count`, `firstTimestamp`, `lastTimestamp`, `message`, `objKind`

### `dce llm-studio wsfilesstorageservice ws-list-pre-pulls`

- Summary: '当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/filesstorages/{storageName}/prepulls`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--storage-name` (path, required): FilesStorage name
  - `--cluster` (query): cluster
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `namespace`, `status.phase`, `creationTimestamp`, `cluster`, `description`

### `dce llm-studio wsfilesstorageservice ws-update-pre-pull`

- Summary: 当前 API 模式：WS
- HTTP: `PUT /apis/hydra.io/v1alpha1/workspaces/{workspace}/filesstorages/{storageName}/prepulls/{prepullName}`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--storage-name` (path, required): FilesStorage name
  - `--prepull-name` (path, required): prepullName

### `dce llm-studio wsfilesstorageservice ws-validate-data-source-secrets`

- Summary: 当前 API 模式：WS
- HTTP: `POST /apis/hydra.io/v1alpha1/workspaces/{workspace}/filesstorages/validate-secrets`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace

## WSFineTuneConfigManagement

### `dce llm-studio wsfinetuneconfigmanagement create-ws-fine-tune-config`

- Summary: CreateWSFineTuneConfig creates a new fine-tune config CR
- HTTP: `POST /apis/hydra.io/v1alpha1/workspaces/{workspace}/train-configs`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace

### `dce llm-studio wsfinetuneconfigmanagement delete-ws-fine-tune-config`

- Summary: DeleteWSFineTuneConfig deletes a fine-tune config CR
- HTTP: `DELETE /apis/hydra.io/v1alpha1/workspaces/{workspace}/train-configs/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--name` (path, required): name

### `dce llm-studio wsfinetuneconfigmanagement get-ws-fine-tune-config`

- Summary: GetWSFineTuneConfig retrieves a fine-tune config CR by name
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/train-configs/{name}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--name` (path, required): name

### `dce llm-studio wsfinetuneconfigmanagement list-ws-fine-tune-configs`

- Summary: ListWSFineTuneConfigs lists all fine-tune config CRs
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/train-configs`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--cluster` (query): cluster
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
  - `--dataset-id` (query): datasetId
- Output: list path `items`; columns `name`, `namespace`, `cluster`, `createdAt`, `finetuningType`, `modelSource`

### `dce llm-studio wsfinetuneconfigmanagement update-ws-fine-tune-config`

- Summary: UpdateWSFineTuneConfig updates an existing fine-tune config CR
- HTTP: `PUT /apis/hydra.io/v1alpha1/workspaces/{workspace}/train-configs/{name}`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--name` (path, required): name

## WSFineTuneJobManagement

### `dce llm-studio wsfinetunejobmanagement create-ws-fine-tune-job`

- Summary: CreateWSFineTuneJob creates a fine-tune job in the specified workspace.
- HTTP: `POST /apis/hydra.io/v1alpha1/workspaces/{workspace}/finetune/jobs`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace
- Output: list path `env`; columns `name`, `value`

### `dce llm-studio wsfinetunejobmanagement delete-ws-fine-tune-job`

- Summary: DeleteWSFineTuneJob deletes the specified fine-tune job and its runtime resources.
- HTTP: `DELETE /apis/hydra.io/v1alpha1/workspaces/{workspace}/finetune/jobs/{id}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--id` (path, required): id

### `dce llm-studio wsfinetunejobmanagement get-ws-fine-tune-job`

- Summary: GetWSFineTuneJob returns a single fine-tune job by id.
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/finetune/jobs/{id}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--id` (path, required): id
- Output: list path `env`; columns `name`, `value`

### `dce llm-studio wsfinetunejobmanagement list-ws-fine-tune-jobs`

- Summary: ListWSFineTuneJobs lists fine-tune jobs in the specified workspace.
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/finetune/jobs`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--cluster` (query): cluster
  - `--namespace` (query): namespace
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `namespace`, `creationTimestamp`, `id`, `cluster`, `completionTimestamp`

## WSModelManagement

### `dce llm-studio wsmodelmanagement create-private-model`

- Summary: 当前 API 模式：WS
- HTTP: `POST /apis/hydra.io/v1alpha1/workspaces/{workspace}/private-models`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace
- Output: list path `modelSupportFeature`

### `dce llm-studio wsmodelmanagement delete-private-model`

- Summary: 当前 API 模式：WS
- HTTP: `DELETE /apis/hydra.io/v1alpha1/workspaces/{workspace}/private-models/{modelId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--model-id` (path, required): modelId
- Output: list path `modelSupportFeature`

### `dce llm-studio wsmodelmanagement get-private-model`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/private-models/{modelId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--model-id` (path, required): modelId
- Output: list path `modelSupportFeature`

### `dce llm-studio wsmodelmanagement get-ws-model`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/models/{modelId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--model-id` (path, required): modelId
- Output: list path `modelSupportFeature`

### `dce llm-studio wsmodelmanagement list-private-models`

- Summary: '当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/private-models`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `creationTimestamp`, `modelName`, `finetune`, `modelAvatar`, `modelDeploymentsExists`, `modelId`

### `dce llm-studio wsmodelmanagement list-ws-models`

- Summary: '当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/models`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `creationTimestamp`, `modelName`, `finetune`, `modelAvatar`, `modelDeploymentsExists`, `modelId`

### `dce llm-studio wsmodelmanagement update-private-model`

- Summary: 当前 API 模式：WS
- HTTP: `PUT /apis/hydra.io/v1alpha1/workspaces/{workspace}/private-models/{modelId}`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--model-id` (path, required): modelId
- Output: list path `modelSupportFeature`

## WSModelServingManagement

### `dce llm-studio wsmodelservingmanagement create-ws-model-serving`

- Summary: 创建工作空间模型服务
- HTTP: `POST /apis/hydra.io/v1alpha1/workspaces/{workspace}/model-serving`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace
- Output: list path `configMapMounts`; columns `configMapName`, `mountPath`, `subPath`

### `dce llm-studio wsmodelservingmanagement delete-ws-model-serving`

- Summary: 当前 API 模式：WS
- HTTP: `DELETE /apis/hydra.io/v1alpha1/workspaces/{workspace}/model-serving/{id}`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--id` (path, required): id
- Output: list path `configMapMounts`; columns `configMapName`, `mountPath`, `subPath`

### `dce llm-studio wsmodelservingmanagement detect-ws-model-serving`

- Summary: 检测模型服务是否可部署
- HTTP: `POST /apis/hydra.io/v1alpha1/workspaces/{workspace}/model-serving/detect`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace
- Output: list path `conditions`; columns `type`, `message`, `ready`

### `dce llm-studio wsmodelservingmanagement do-model-ws-serving-action`

- Summary: 当前 API 模式：WS
- HTTP: `POST /apis/hydra.io/v1alpha1/workspaces/{workspace}/model-serving/{id}/actions`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--id` (path, required): id
- Output: list path `configMapMounts`; columns `configMapName`, `mountPath`, `subPath`

### `dce llm-studio wsmodelservingmanagement get-ws-model-serving`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/model-serving/{id}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--id` (path, required): id
- Output: list path `configMapMounts`; columns `configMapName`, `mountPath`, `subPath`

### `dce llm-studio wsmodelservingmanagement list-ws-model-serving`

- Summary: '当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/model-serving`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--cluster` (query): cluster
  - `--namespace` (query): Optional, if namespace was empty, the server will find all visible namespaces
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `namespace`, `creationTimestamp`, `id`, `modelName`, `accessModelName`

### `dce llm-studio wsmodelservingmanagement update-ws-model-serving-replicas`

- Summary: 当前 API 模式：WS
- HTTP: `PATCH /apis/hydra.io/v1alpha1/workspaces/{workspace}/model-serving/{id}/replicas`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--id` (path, required): id
- Output: list path `configMapMounts`; columns `configMapName`, `mountPath`, `subPath`

## WSModelTemplateManagement

### `dce llm-studio wsmodeltemplatemanagement create-ws-model-template`

- Summary: 当前 API 模式：WS
- HTTP: `POST /apis/hydra.io/v1alpha1/workspaces/{workspace}/models/{modelId}/model-templates`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--model-id` (path, required): modelId

### `dce llm-studio wsmodeltemplatemanagement delete-ws-model-template`

- Summary: 当前 API 模式：WS
- HTTP: `DELETE /apis/hydra.io/v1alpha1/workspaces/{workspace}/models/{modelId}/model-templates/{templateId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--model-id` (path, required): Optional in WS; required for Admin paths that include {model_id}.
  - `--template-id` (path, required): templateId

### `dce llm-studio wsmodeltemplatemanagement get-ws-model-template`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/models/{modelId}/model-templates/{templateId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--model-id` (path, required): Optional in WS; required for Admin paths that include {model_id}.
  - `--template-id` (path, required): templateId

### `dce llm-studio wsmodeltemplatemanagement list-ws-model-templates`

- Summary: '当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/models/{modelId}/model-templates`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--model-id` (path, required): modelId
  - `--inference-runtime` (query): inferenceRuntime
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `creationTimestamp`, `modelId`, `templateId`, `updateTimestamp`, `workspace`

### `dce llm-studio wsmodeltemplatemanagement update-ws-model-template`

- Summary: 当前 API 模式：WS
- HTTP: `PUT /apis/hydra.io/v1alpha1/workspaces/{workspace}/models/{modelId}/model-templates/{templateId}`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--model-id` (path, required): Optional in WS; required for Admin paths that include {model_id}.
  - `--template-id` (path, required): templateId

## WSModelWeightsVolumeManagement

### `dce llm-studio wsmodelweightsvolumemanagement create-ws-model-weights-volume`

- Summary: create a new model weights volume in a workspace
- HTTP: `POST /apis/hydra.io/v1alpha1/models/{modelId}/workspaces/{workspace}/weights`
- Auth: required
- Body: required
- Flags:
  - `--model-id` (path, required): modelId
  - `--workspace` (path, required, int32): workspace

### `dce llm-studio wsmodelweightsvolumemanagement delete-ws-model-weights-volume`

- Summary: delete a model weights volume by ID in a workspace
- HTTP: `DELETE /apis/hydra.io/v1alpha1/models/{modelId}/workspaces/{workspace}/weights/{id}`
- Auth: required
- Body: none
- Flags:
  - `--model-id` (path, required): modelId
  - `--workspace` (path, required, int32): workspace
  - `--id` (path, required): id

### `dce llm-studio wsmodelweightsvolumemanagement get-ws-model-weights-volume`

- Summary: get a model weights volume by ID in a workspace
- HTTP: `GET /apis/hydra.io/v1alpha1/models/{modelId}/workspaces/{workspace}/weights/{id}`
- Auth: required
- Body: none
- Flags:
  - `--model-id` (path, required): modelId
  - `--workspace` (path, required, int32): workspace
  - `--id` (path, required): id

### `dce llm-studio wsmodelweightsvolumemanagement get-ws-storage-source`

- Summary: get storage source types for model weights volumes in a workspace
- HTTP: `GET /apis/hydra.io/v1alpha1/models/{modelId}/workspaces/{workspace}/weights:storage-source`
- Auth: required
- Body: none
- Flags:
  - `--model-id` (path, required): modelId
  - `--workspace` (path, required, int32): workspace

### `dce llm-studio wsmodelweightsvolumemanagement list-ws-model-weights-volumes`

- Summary: list model weights volumes for a model in a workspace
- HTTP: `GET /apis/hydra.io/v1alpha1/models/{modelId}/workspaces/{workspace}/weights`
- Auth: required
- Body: none
- Flags:
  - `--model-id` (path, required): modelId
  - `--workspace` (path, required, int32): workspace
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
  - `--cluster-name` (query): clusterName
- Output: list path `items`; columns `creationTimestamp`, `id`, `clusterName`, `modelId`, `modelTag`, `mountPath`

### `dce llm-studio wsmodelweightsvolumemanagement update-ws-model-weights-volume`

- Summary: update a model weights volume by ID in a workspace
- HTTP: `PUT /apis/hydra.io/v1alpha1/models/{modelId}/workspaces/{workspace}/weights/{id}`
- Auth: required
- Body: required
- Flags:
  - `--model-id` (path, required): modelId
  - `--workspace` (path, required, int32): workspace
  - `--id` (path, required): id

## WSProviderManagement

### `dce llm-studio wsprovidermanagement get-ws-provider`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/providers/{id}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--id` (path, required): id

### `dce llm-studio wsprovidermanagement list-ws-provider`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/providers`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `creationTimestamp`, `providerAvatar`, `providerId`, `workspace`

## WebSearchAgentService

### `dce llm-studio websearchagentservice get-agent-address`

- Summary: GetAgentAddress retrieves the address of the web search agent.
- HTTP: `GET /apis/hydra.io/v1alpha1/web-search-agent/address`
- Auth: required
- Body: none
- Flags: none

## WorkspaceQuotaService

### `dce llm-studio workspacequotaservice list-workspace-quotas`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/admin.hydra.io/v1alpha1/workspace-quotas`
- Auth: required
- Body: none
- Flags:
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
  - `--workspace` (query, int32): workspace
- Output: list path `items`; columns `allocatedQuota`, `nextRefreshTime`, `quota`, `refreshCycle`, `unlimitedQuota`, `updateTime`

### `dce llm-studio workspacequotaservice update-workspace-quota`

- Summary: 当前 API 模式：WS
- HTTP: `PUT /apis/admin.hydra.io/v1alpha1/workspace-quotas/{workspace}`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace

### `dce llm-studio workspacequotaservice update-workspace-quota-refresh-cycle`

- Summary: 当前 API 模式：WS
- HTTP: `PUT /apis/admin.hydra.io/v1alpha1/workspace-quotas/{workspace}/refresh-cycle`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace

## WorkspaceService

### `dce llm-studio workspaceservice list-cluster-namespaces`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/cluster-namespaces`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--cluster` (query): 集群名称，如果不传递，表示查询所有集群
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `namespace`, `cluster`

### `dce llm-studio workspaceservice list-clusters`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/clusters`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
- Output: list path `items`; columns `name`, `agentInstalled`, `baseUrl`, `status`

### `dce llm-studio workspaceservice list-config-maps`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces/{workspace}/configmaps`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--cluster` (query): cluster
  - `--namespace` (query): namespace
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
  - `--name` (query): name
- Output: list path `items`; columns `name`, `namespace`

### `dce llm-studio workspaceservice list-workspaces`

- Summary: 当前 API 模式：WS
- HTTP: `GET /apis/hydra.io/v1alpha1/workspaces`
- Auth: required
- Body: none
- Flags:
  - `--page.total` (query, int64): 总共有多少条目，请求时可以不用传递
  - `--page.page` (query, int32): 当前页索引，从 1 开始，为 0 时，会自动重置为默认值 constants.DefaultPage
  - `--page.page-size` (query, int32): 每页数据量，为 -1 时表示查询全部，为 0 时会重置为默认值
  - `--page.sort` (query): 排序规则，支持字符串和数字类型的字段进行排序
  - `--page.search` (query): 搜索关键字，支持模糊搜索,精准匹配和高级搜索.
  - `--cluster` (query): cluster
- Output: list path `items`; columns `alias`, `workspaceId`

