# Module `agentclaw`

## Source

- Backend: `swagger`
- Repository: `unknown`
- Pinned tag: ``unknown``
- Files: `specs/agentclaw/agent.swagger.json`, `specs/agentclaw/skill.swagger.json`, `specs/agentclaw/skill_publish.swagger.json`, `specs/agentclaw/workspace.swagger.json`, `specs/agentclaw/user.swagger.json`, `specs/agentclaw/model.swagger.json`, `specs/agentclaw/networkpolicy.swagger.json`, `specs/agentclaw/overview.swagger.json`, `specs/agentclaw/feature_gate.swagger.json`

## AgentService

### `dce agentclaw agentservice create-workspace-agent-instance`

- Summary: AgentService_CreateWorkspaceAgentInstance
- HTTP: `POST /apis/agentclaw.io/v1alpha1/workspaces/{workspaceId}/agent-instances`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): Workspace ID，必填

### `dce agentclaw agentservice delete-workspace-agent-instance`

- Summary: AgentService_DeleteWorkspaceAgentInstance
- HTTP: `DELETE /apis/agentclaw.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/agent-instances/{instanceId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): Workspace ID
  - `--cluster` (path, required): 集群名称
  - `--namespace` (path, required): 命名空间
  - `--instance-id` (path, required): 实例 ID

### `dce agentclaw agentservice get-agent-instance-behavior-analysis`

- Summary: AgentService_GetAgentInstanceBehaviorAnalysis
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/agent-instances/{instanceId}/behavior-analysis`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--instance-id` (path, required): instanceId
  - `--range-query.start` (query, int64): rangeQuery.start
  - `--range-query.end` (query, int64): end unix timestamp .e.g. 1697597347
  - `--range-query.step` (query, double): step time step in seconds; if unset, server calculates it from start and end.
- Output: list path `modelUsageDistribution`; columns `name`, `percentage`, `value`

### `dce agentclaw agentservice get-agent-instance-performance-usage`

- Summary: AgentService_GetAgentInstancePerformanceUsage
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/agent-instances/{instanceId}/performance-usage`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--instance-id` (path, required): instanceId
  - `--range-query.start` (query, int64): rangeQuery.start
  - `--range-query.end` (query, int64): end unix timestamp .e.g. 1697597347
  - `--range-query.step` (query, double): step time step in seconds; if unset, server calculates it from start and end.

### `dce agentclaw agentservice get-agent-instance-token-trend`

- Summary: AgentService_GetAgentInstanceTokenTrend
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/agent-instances/{instanceId}/token-trend`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--instance-id` (path, required): instanceId
  - `--range-query.start` (query, int64): rangeQuery.start
  - `--range-query.end` (query, int64): end unix timestamp .e.g. 1697597347
  - `--range-query.step` (query, double): step time step in seconds; if unset, server calculates it from start and end.
- Output: list path `tokenUsageTrend`; columns `time`, `value`

### `dce agentclaw agentservice get-agent-instance-token-usage`

- Summary: AgentService_GetAgentInstanceTokenUsage
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/agent-instances/{instanceId}/token-usage`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--instance-id` (path, required): instanceId
  - `--range-query.start` (query, int64): rangeQuery.start
  - `--range-query.end` (query, int64): end unix timestamp .e.g. 1697597347
  - `--range-query.step` (query, double): step time step in seconds; if unset, server calculates it from start and end.

### `dce agentclaw agentservice get-workspace-agent-instance`

- Summary: AgentService_GetWorkspaceAgentInstance
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/agent-instances/{instanceId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): Workspace ID
  - `--cluster` (path, required): 集群名称
  - `--namespace` (path, required): 命名空间
  - `--instance-id` (path, required): 实例 ID（{userinput}-{random5}，也是底层 deploy 名）；老资源沿用其 deploy name 直接作为 instance_id。

### `dce agentclaw agentservice list-workspace-agent-image`

- Summary: AgentService_ListWorkspaceAgentImage
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/agent-images`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
- Output: list path `items`; columns `image`

### `dce agentclaw agentservice list-workspace-agent-instances`

- Summary: AgentService_ListWorkspaceAgentInstances
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspaceId}/agent-instances`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): Workspace ID，必填
  - `--fuzzy-name` (query): 按名称过滤（模糊匹配）
  - `--page` (query, int32): 分页页码，从 1 开始
  - `--page-size` (query, int32): 每页数量
- Output: list path `items`; columns `name`, `namespace`, `creationTimestamp`, `cluster`, `gatewayToken`, `image`; pagination `offset`

### `dce agentclaw agentservice query-open-claw-root-spans`

- Summary: AgentService_QueryOpenClawRootSpans
- HTTP: `POST /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/agent-instances/{instanceId}/spans`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--instance-id` (path, required): instanceId
- Output: list path `items`; columns `costUsd`, `durationMs`, `entryPoint`, `jaegerUri`, `lane`, `operationName`

### `dce agentclaw agentservice query-open-claw-sessions`

- Summary: AgentService_QueryOpenClawSessions
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespaces/{namespace}/agent-instances/{instanceId}/sessions`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--instance-id` (path, required): instanceId
  - `--range-query.start` (query, int64): rangeQuery.start
  - `--range-query.end` (query, int64): end unix timestamp .e.g. 1697597347
  - `--range-query.step` (query, double): step time step in seconds; if unset, server calculates it from start and end.
- Output: list path `sessions`

### `dce agentclaw agentservice restart-workspace-agent-instance`

- Summary: AgentService_RestartWorkspaceAgentInstance
- HTTP: `POST /apis/agentclaw.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/agent-instances/{instanceId}/restart`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): Workspace ID
  - `--cluster` (path, required): 集群名称
  - `--namespace` (path, required): 命名空间
  - `--instance-id` (path, required): 实例 ID

### `dce agentclaw agentservice start-workspace-agent-instance`

- Summary: AgentService_StartWorkspaceAgentInstance
- HTTP: `POST /apis/agentclaw.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/agent-instances/{instanceId}/start`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): Workspace ID
  - `--cluster` (path, required): 集群名称
  - `--namespace` (path, required): 命名空间
  - `--instance-id` (path, required): 实例 ID

### `dce agentclaw agentservice stop-workspace-agent-instance`

- Summary: AgentService_StopWorkspaceAgentInstance
- HTTP: `POST /apis/agentclaw.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/agent-instances/{instanceId}/stop`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): Workspace ID
  - `--cluster` (path, required): 集群名称
  - `--namespace` (path, required): 命名空间
  - `--instance-id` (path, required): 实例 ID

### `dce agentclaw agentservice update-workspace-agent-instance`

- Summary: AgentService_UpdateWorkspaceAgentInstance
- HTTP: `PUT /apis/agentclaw.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/agent-instances/{instanceId}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): Workspace ID
  - `--cluster` (path, required): 集群名称
  - `--namespace` (path, required): 命名空间
  - `--instance-id` (path, required): 实例 ID（不可修改）

### `dce agentclaw agentservice watch-feishu-onboard`

- Summary: AgentService_WatchFeishuOnboard
- HTTP: `POST /apis/agentclaw.io/v1alpha1/workspaces/{workspaceId}/agent-instances/channels/feishu-onboard`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId

## FeatureGateService

### `dce agentclaw featuregateservice list-feature-gates`

- Summary: ListFeatureGates 返回平台各 feature-gate 的开关状态，供前端按开关展示/隐藏功能入口。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/feature-gates`
- Auth: required
- Body: none
- Flags: none
- Output: list path `featureGates`; columns `enabled`, `gate`

## ModelService

### `dce agentclaw modelservice list-api-key`

- Summary: ModelService_ListAPIKey
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/apikeys`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--sort` (query): option
- Output: list path `items`; columns `name`, `id`

### `dce agentclaw modelservice list-models`

- Summary: ModelService_ListModels
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/models`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--search` (query): option
  - `--model-type` (query, default `MODEL_TYPE_UNSPECIFIED`, one of: MODEL_TYPE_UNSPECIFIED|MODEL_TYPE_PUBLIC|MODEL_TYPE_PRIVATE): default MODEL_TYPE_PUBLIC
- Output: list path `items`; columns `modelName`, `modelId`

## NetworkPolicyService

### `dce agentclaw networkpolicyservice create-network-policy-template`

- Summary: CreateNetworkPolicyTemplate 创建一个新的策略模版（admin 权限）。
- HTTP: `POST /apis/agentclaw.io/v1alpha1/networkpolicy-templates`
- Auth: required
- Body: required
- Flags: none

### `dce agentclaw networkpolicyservice delete-network-policy-template`

- Summary: DeleteNetworkPolicyTemplate 删除一个策略模版（admin 权限）。
- HTTP: `DELETE /apis/agentclaw.io/v1alpha1/networkpolicy-templates/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): 模版名称，必填。

### `dce agentclaw networkpolicyservice disable-network-policy-template`

- Summary: DisableNetworkPolicyTemplate 停用模版（patch enabled label 为 'false'）。
- HTTP: `POST /apis/agentclaw.io/v1alpha1/networkpolicy-templates/{name}/disable`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): 模版名称，必填。

### `dce agentclaw networkpolicyservice enable-network-policy-template`

- Summary: EnableNetworkPolicyTemplate 启用模版（patch enabled label 为 'true'）。
- HTTP: `POST /apis/agentclaw.io/v1alpha1/networkpolicy-templates/{name}/enable`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): 模版名称，必填。

### `dce agentclaw networkpolicyservice get-network-policy-template`

- Summary: GetNetworkPolicyTemplate 查询单个模版详情（优先读 TemplateRuleCache）。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/networkpolicy-templates/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): 模版名称，必填。

### `dce agentclaw networkpolicyservice list-network-policy-templates`

- Summary: ListNetworkPolicyTemplates 列出全部模版（遍历 TemplateRuleCache，零 K8s 查询）。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/networkpolicy-templates`
- Auth: required
- Body: none
- Flags:
  - `--enabled` (query): 按 enabled 过滤：UNSPECIFIED=全部 / TRUE=仅启用 / FALSE=仅停用。
  - `--scope` (query, default `UNSPECIFIED`, one of: UNSPECIFIED|SYSTEM|INSTANCE): scope
  - `--fuzzy-name` (query): 按名称模糊匹配（可选）。
  - `--page` (query, int32): 分页：页码（从 1 开始），0 / 负数视为 1。
  - `--page-size` (query, int32): 分页：每页大小，0 表示不分页返回全部。
- Output: list path `items`; columns `name`, `creationTimestamp`, `alias`, `enabled`, `scope`; pagination `offset`

### `dce agentclaw networkpolicyservice update-network-policy-template`

- Summary: UpdateNetworkPolicyTemplate 修改已有策略模版的规则内容（admin 权限）。
- HTTP: `PUT /apis/agentclaw.io/v1alpha1/networkpolicy-templates/{name}`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): 模版名称，必填，不可修改。

## OverviewService

### `dce agentclaw overviewservice get-overview-running-state`

- Summary: 运行状况
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/overview/running-state`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--range-query.start` (query, int64): rangeQuery.start
  - `--range-query.end` (query, int64): end unix timestamp .e.g. 1697597347
  - `--range-query.step` (query, double): step time step in seconds; if unset, server calculates it from start and end.
- Output: list path `callTrend`; columns `time`, `value`

### `dce agentclaw overviewservice get-overview-summary`

- Summary: overview 概览
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/overview/summary`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace

### `dce agentclaw overviewservice get-token-distribution`

- Summary: Token Distribution
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/overview/token-distribution`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--range-query.start` (query, int64): rangeQuery.start
  - `--range-query.end` (query, int64): end unix timestamp .e.g. 1697597347
  - `--range-query.step` (query, double): step time step in seconds; if unset, server calculates it from start and end.
- Output: list path `tokenDistribution`; columns `name`, `percentage`, `value`

### `dce agentclaw overviewservice list-top-users-or-instances`

- Summary: top user/instances
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/overview/top-user-instances`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--rank-type` (query, default `USER`, one of: USER|INSTANCE): rankType
  - `--range-query.start` (query, int64): rangeQuery.start
  - `--range-query.end` (query, int64): end unix timestamp .e.g. 1697597347
  - `--range-query.step` (query, double): step time step in seconds; if unset, server calculates it from start and end.
  - `--page` (query, int32): 分页页码，从 1 开始
  - `--page-size` (query, int32): 每页数量
- Output: pagination `offset`

## SkillService

### `dce agentclaw skillservice approve-skill-review`

- Summary: ApproveSkillReview 批准审核任务。
- HTTP: `POST /apis/agentclaw.io/v1alpha1/skill-reviews/{namespace}/{reviewId}/approve`
- Auth: required
- Body: required
- Flags:
  - `--namespace` (path, required): namespace
  - `--review-id` (path, required, int64): reviewId

### `dce agentclaw skillservice delete-skill`

- Summary: DeleteSkill 永久删除一个 skill。
- HTTP: `DELETE /apis/agentclaw.io/v1alpha1/skills/{namespace}/{slug}`
- Auth: required
- Body: none
- Flags:
  - `--namespace` (path, required): namespace
  - `--slug` (path, required): slug

### `dce agentclaw skillservice download-skill-file`

- Summary: DownloadSkillFile 下载版本内单个文件：返回原始字节，并通过
- HTTP: `GET /apis/agentclaw.io/v1alpha1/skills/{namespace}/{slug}/versions/{version}/file/download`
- Auth: required
- Body: none
- Flags:
  - `--namespace` (path, required): namespace
  - `--slug` (path, required): slug
  - `--version` (path, required): version
  - `--path` (query): 包内文件相对路径，例如 "assets/logo.png"
- Output: list path `extensions`; columns `@type`

### `dce agentclaw skillservice get-skill`

- Summary: GetSkill 获取单个 skill 详情。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/skills/{namespace}/{slug}`
- Auth: required
- Body: none
- Flags:
  - `--namespace` (path, required): namespace
  - `--slug` (path, required): slug

### `dce agentclaw skillservice get-skill-file`

- Summary: GetSkillFile 文本文件预览。仅支持文本（markdown / yaml / 源码 / 配置 等）；
- HTTP: `GET /apis/agentclaw.io/v1alpha1/skills/{namespace}/{slug}/versions/{version}/file`
- Auth: required
- Body: none
- Flags:
  - `--namespace` (path, required): namespace
  - `--slug` (path, required): slug
  - `--version` (path, required): version
  - `--path` (query): 包内文件相对路径，例如 "README.md"

### `dce agentclaw skillservice get-skill-overview`

- Summary: GetSkillOverview 返回 SKILL.md 的内容（已去除 frontmatter），用于 skill 详情页"概览"展示。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/skills/{namespace}/{slug}/versions/{version}/overview`
- Auth: required
- Body: none
- Flags:
  - `--namespace` (path, required): namespace
  - `--slug` (path, required): slug
  - `--version` (path, required): version

### `dce agentclaw skillservice get-skill-registry`

- Summary: GetSkillRegistry 返回前端拼装 `npx clawhub install ... --registry <url>` 所需的注册中心地址。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/skills/registry`
- Auth: required
- Body: none
- Flags: none

### `dce agentclaw skillservice get-skill-review`

- Summary: GetSkillReview 查看单条审核详情（按 namespace 限定）。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/skill-reviews/{namespace}/{reviewId}`
- Auth: required
- Body: none
- Flags:
  - `--namespace` (path, required): namespace
  - `--review-id` (path, required, int64): reviewId

### `dce agentclaw skillservice get-skill-security-audit`

- Summary: GetSkillSecurityAudit 获取该版本的最新安全审计结果。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/skills/{namespace}/{slugId}/versions/{versionId}/security-audit`
- Auth: required
- Body: none
- Flags:
  - `--namespace` (path, required): namespace
  - `--slug-id` (path, required, int64): slugId
  - `--version-id` (path, required, int64): versionId
- Output: list path `items`; columns `id`, `createdAt`, `findingsCount`, `isSafe`, `maxSeverity`, `scanDurationSeconds`

### `dce agentclaw skillservice list-admin-managed-skills`

- Summary: ListManagedSkills 列出具有管理权限的skill
- HTTP: `GET /apis/agentclaw.io/v1alpha1/skills/managed`
- Auth: required
- Body: none
- Flags:
  - `--namespace` (query): 命名空间过滤，对应 Skill Hub 的 ?namespace= 查询参数。
  - `--fuzzy-name` (query): 按名称模糊搜索（对应 Skill Hub 的 q 参数）
  - `--sort` (query, default `NEWEST`, one of: NEWEST): sort
  - `--page` (query, int32): 页码
  - `--page-size` (query, int32): 每页大小，默认 10
- Output: list path `items`; columns `namespace`, `id`, `creator`, `displayName`, `downloadCount`, `pendingReview`; pagination `offset`

### `dce agentclaw skillservice list-skill-files`

- Summary: ListSkillFiles 列出某个版本的打包文件。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/skills/{namespace}/{slug}/versions/{version}/files`
- Auth: required
- Body: none
- Flags:
  - `--namespace` (path, required): namespace
  - `--slug` (path, required): slug
  - `--version` (path, required): version
  - `--path` (query): 目录路径，例如 "src"；空串表示根目录。仅返回该目录直接子层，不递归。
- Output: list path `items`; columns `name`, `id`, `contentType`, `filePath`, `fileSize`, `isDir`

### `dce agentclaw skillservice list-skill-reviews`

- Summary: ListSkillReviews 管理面：列出全部 namespace 的审核队列（平台 admin 用）。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/skill-reviews/managed`
- Auth: required
- Body: none
- Flags:
  - `--status` (query): 审核状态过滤；空串默认 PENDING。
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `namespace`, `reviewComment`, `reviewId`, `reviewedAt`, `reviewedBy`, `reviewedByName`; pagination `offset`

### `dce agentclaw skillservice list-skill-versions`

- Summary: ListSkillVersions 列出该 skill 对调用方可见的版本。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/skills/{namespace}/{slug}/versions`
- Auth: required
- Body: none
- Flags:
  - `--namespace` (path, required): namespace
  - `--slug` (path, required): slug
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `id`, `changelog`, `downloadAvailable`, `fileCount`, `publishedAt`, `status`; pagination `offset`

### `dce agentclaw skillservice list-skills`

- Summary: ListSkills 列出 skill，支持按命名空间、名称模糊搜索与分页。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/skills`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--namespace` (query): 命名空间过滤，对应 Skill Hub 的 ?namespace= 查询参数。
  - `--fuzzy-name` (query): 按名称模糊搜索（对应 Skill Hub 的 q 参数）
  - `--sort` (query, default `NEWEST`, one of: NEWEST): sort
  - `--page` (query, int32): 页码
  - `--page-size` (query, int32): 每页大小，默认 10
- Output: list path `items`; columns `namespace`, `id`, `creator`, `displayName`, `downloadCount`, `pendingReview`; pagination `offset`

### `dce agentclaw skillservice list-workspace-managed-skills`

- Summary: ListWorkspaceManagedSkills 列出当前用户在该 workspace 内可管理的 Skill。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/skills/managed`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--fuzzy-name` (query): 按名称模糊搜索
  - `--sort` (query, default `NEWEST`, one of: NEWEST): sort
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `namespace`, `id`, `creator`, `displayName`, `downloadCount`, `pendingReview`; pagination `offset`

### `dce agentclaw skillservice list-workspace-skill-reviews`

- Summary: ListWorkspaceSkillReviews 列出某 workspace namespace 的审核队列（workspace reviewer 用）。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/skill-reviews`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--status` (query): 审核状态过滤；空串默认 PENDING。
  - `--page` (query, int32): page
  - `--page-size` (query, int32): pageSize
- Output: list path `items`; columns `namespace`, `reviewComment`, `reviewId`, `reviewedAt`, `reviewedBy`, `reviewedByName`; pagination `offset`

### `dce agentclaw skillservice publish-skill`

- Summary: PublishSkill
- HTTP: `POST /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/skills/publish`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required): 发布目标：global 或纯数字 workspace ID。
  - `--authorization` (header, required): Bearer JWT。
  - `--file` (formData, required): Skill 包 zip，上限 100MB。
  - `--slug` (formData): 覆盖包内 name，留空用包内原值。
  - `--summary` (formData): 覆盖包内 description，支持 UTF-8。
  - `--version` (formData): 覆盖包内 version。
  - `--visibility` (formData, default `SKILL_VISIBILITY_PUBLIC`, one of: SKILL_VISIBILITY_PUBLIC|SKILL_VISIBILITY_PRIVATE|SKILL_VISIBILITY_NAMESPACE_ONLY): 完整枚举名，空时默认 PUBLIC。
- Output: response media `application/json`

### `dce agentclaw skillservice reject-skill-review`

- Summary: RejectSkillReview 拒绝审核任务。
- HTTP: `POST /apis/agentclaw.io/v1alpha1/skill-reviews/{namespace}/{reviewId}/reject`
- Auth: required
- Body: required
- Flags:
  - `--namespace` (path, required): namespace
  - `--review-id` (path, required, int64): reviewId

### `dce agentclaw skillservice set-skill-listing`

- Summary: SetSkillListing 设置 skill 的上下架状态。
- HTTP: `POST /apis/agentclaw.io/v1alpha1/skills/{namespace}/{slug}/listing`
- Auth: required
- Body: required
- Flags:
  - `--namespace` (path, required): namespace
  - `--slug` (path, required): slug

## UserService

### `dce agentclaw userservice get-current-user`

- Summary: UserService_GetCurrentUser
- HTTP: `GET /apis/agentclaw.io/v1alpha1/current-user`
- Auth: required
- Body: none
- Flags: none

### `dce agentclaw userservice get-current-user-permissions`

- Summary: GetCurrentUserPermissions
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspaceId}/current-user/permissions`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
- Output: list path `permissions`

### `dce agentclaw userservice get-current-user-platform-permissions`

- Summary: UserService_GetCurrentUserPlatformPermissions
- HTTP: `GET /apis/agentclaw.io/v1alpha1/current-user/platform-permissions`
- Auth: required
- Body: none
- Flags: none
- Output: list path `permissions`

## WorkspaceService

### `dce agentclaw workspaceservice list-cluster-summary`

- Summary: WorkspaceService_ListClusterSummary
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/clustersummary`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
- Output: list path `items`; columns `name`, `status`

### `dce agentclaw workspaceservice list-namespace-summary`

- Summary: WorkspaceService_ListNamespaceSummary
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/clusters/{cluster}/namespacesummary`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--cluster` (path, required): cluster
- Output: list path `items`

### `dce agentclaw workspaceservice list-workspaces`

- Summary: WorkspaceService_ListWorkspaces
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces`
- Auth: required
- Body: none
- Flags: none
- Output: list path `items`; columns `alias`, `workspace`
