# Module `agentclaw`

## Source

- Backend: `swagger`
- Repository: `unknown`
- Pinned tag: ``unknown``
- Files: `specs/agentclaw/agent.swagger.json`, `specs/agentclaw/feature_gate.swagger.json`, `specs/agentclaw/skill_publish.swagger.json`, `specs/agentclaw/model.swagger.json`, `specs/agentclaw/networkpolicy.swagger.json`, `specs/agentclaw/overview.swagger.json`, `specs/agentclaw/skill.swagger.json`, `specs/agentclaw/user.swagger.json`, `specs/agentclaw/workspace.swagger.json`

## AgentService

### `dce agentclaw agentservice create-workspace-agent-instance`

- Summary: Create an AgentClaw instance
- HTTP: `POST /apis/agentclaw.io/v1alpha1/workspaces/{workspaceId}/agent-instances`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): Workspace ID，必填
- Notes:
  - Mutating operation: review the generated request body and target workspace before execution.
- Prerequisites:
  - Confirm the target workspace ID and deployment cluster/namespace in the request body.

### `dce agentclaw agentservice delete-workspace-agent-instance`

- Summary: Delete an AgentClaw instance
- HTTP: `DELETE /apis/agentclaw.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/agent-instances/{instanceId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): Workspace ID
  - `--cluster` (path, required): 集群名称
  - `--namespace` (path, required): 命名空间
  - `--instance-id` (path, required): 实例 ID
- Notes:
  - Destructive operation: require explicit user confirmation immediately before execution.

### `dce agentclaw agentservice get-agent-instance-behavior-analysis`

- Summary: Get AgentClaw behavior analysis for an instance
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
- Prerequisites:
  - Use Unix timestamps for --range-query.start and --range-query.end.

### `dce agentclaw agentservice get-agent-instance-performance-usage`

- Summary: Get AgentClaw performance and usage metrics
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
- Prerequisites:
  - Use Unix timestamps for --range-query.start and --range-query.end.

### `dce agentclaw agentservice get-agent-instance-token-trend`

- Summary: Get token usage trend for an AgentClaw instance
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

- Summary: Get token usage for an AgentClaw instance
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

- Summary: Get one AgentClaw instance
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/agent-instances/{instanceId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): Workspace ID
  - `--cluster` (path, required): 集群名称
  - `--namespace` (path, required): 命名空间
  - `--instance-id` (path, required): 实例 ID（{userinput}-{random5}，也是底层 deploy 名）；老资源沿用其 deploy name 直接作为 instance_id。
- Prerequisites:
  - Resolve workspace ID, cluster, namespace, and instance ID before calling this command.

### `dce agentclaw agentservice list-workspace-agent-image`

- Summary: AgentService_ListWorkspaceAgentImage
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/agent-images`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): Workspace ID
- Output: list path `items`; columns `image`

### `dce agentclaw agentservice list-workspace-agent-instances`

- Summary: List AgentClaw instances in a workspace
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspaceId}/agent-instances`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): Workspace ID，必填
  - `--fuzzy-name` (query): 按名称过滤（模糊匹配）
  - `--page` (query, default `1`, int32): 分页页码，从 1 开始
  - `--page-size` (query, default `20`, int32): Number of instances per page
- Output: list path `items`; columns `name`, `namespace`, `creationTimestamp`, `cluster`, `gatewayToken`, `image`; pagination `offset`
- Example:

```
dce agentclaw agentservice list-workspace-agent-instances --workspace-id <workspace-id> -o json
dce agentclaw agentservice list-workspace-agent-instances --workspace-id <workspace-id> --fuzzy-name openclaw
```

### `dce agentclaw agentservice query-open-claw-root-spans`

- Summary: Query OpenClaw root spans for an AgentClaw instance
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

- Summary: Query OpenClaw sessions for an AgentClaw instance
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

- Summary: Restart an AgentClaw instance
- HTTP: `POST /apis/agentclaw.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/agent-instances/{instanceId}/restart`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): Workspace ID
  - `--cluster` (path, required): 集群名称
  - `--namespace` (path, required): 命名空间
  - `--instance-id` (path, required): 实例 ID
- Notes:
  - Mutating operation: require explicit user confirmation before execution.

### `dce agentclaw agentservice start-workspace-agent-instance`

- Summary: Start an AgentClaw instance
- HTTP: `POST /apis/agentclaw.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/agent-instances/{instanceId}/start`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): Workspace ID
  - `--cluster` (path, required): 集群名称
  - `--namespace` (path, required): 命名空间
  - `--instance-id` (path, required): 实例 ID
- Notes:
  - Mutating operation: require explicit user confirmation before execution.

### `dce agentclaw agentservice stop-workspace-agent-instance`

- Summary: Stop an AgentClaw instance
- HTTP: `POST /apis/agentclaw.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/agent-instances/{instanceId}/stop`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): Workspace ID
  - `--cluster` (path, required): 集群名称
  - `--namespace` (path, required): 命名空间
  - `--instance-id` (path, required): 实例 ID
- Notes:
  - Mutating operation: require explicit user confirmation before execution.

### `dce agentclaw agentservice update-workspace-agent-instance`

- Summary: Update an AgentClaw instance
- HTTP: `PUT /apis/agentclaw.io/v1alpha1/workspaces/{workspaceId}/clusters/{cluster}/namespaces/{namespace}/agent-instances/{instanceId}`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): Workspace ID
  - `--cluster` (path, required): 集群名称
  - `--namespace` (path, required): 命名空间
  - `--instance-id` (path, required): 实例 ID（不可修改）
- Notes:
  - Mutating operation: instance ID cannot be changed.

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

- Summary: Create a network policy template
- HTTP: `POST /apis/agentclaw.io/v1alpha1/networkpolicy-templates`
- Auth: required
- Body: required
- Flags: none
- Notes:
  - Admin-only mutating operation: require explicit confirmation before execution.

### `dce agentclaw networkpolicyservice delete-network-policy-template`

- Summary: Delete a network policy template
- HTTP: `DELETE /apis/agentclaw.io/v1alpha1/networkpolicy-templates/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): 模版名称，必填。
- Notes:
  - Destructive admin operation: require explicit confirmation; force deletion may break bound agents.

### `dce agentclaw networkpolicyservice disable-network-policy-template`

- Summary: Disable a network policy template
- HTTP: `POST /apis/agentclaw.io/v1alpha1/networkpolicy-templates/{name}/disable`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): 模版名称，必填。
- Notes:
  - Mutating operation: disabling a template changes effective network policy; require explicit confirmation.

### `dce agentclaw networkpolicyservice enable-network-policy-template`

- Summary: Enable a network policy template
- HTTP: `POST /apis/agentclaw.io/v1alpha1/networkpolicy-templates/{name}/enable`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): 模版名称，必填。
- Notes:
  - Mutating operation: enabling a template can affect bound agents; require explicit confirmation.

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
  - `--page` (query, default `1`, int32): 分页：页码（从 1 开始），0 / 负数视为 1。
  - `--page-size` (query, default `20`, int32): 分页：每页大小，0 表示不分页返回全部。
- Output: list path `items`; columns `name`, `creationTimestamp`, `alias`, `enabled`, `scope`; pagination `offset`

### `dce agentclaw networkpolicyservice update-network-policy-template`

- Summary: Update a network policy template
- HTTP: `PUT /apis/agentclaw.io/v1alpha1/networkpolicy-templates/{name}`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): 模版名称，必填，不可修改。
- Notes:
  - Admin-only mutating operation: require explicit confirmation before execution.

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
  - `--page` (query, default `1`, int32): 分页页码，从 1 开始
  - `--page-size` (query, default `20`, int32): 每页数量
- Output: pagination `offset`

## SkillService

### `dce agentclaw skillservice approve-workspace-skill-review`

- Summary: Approve a workspace skill review
- HTTP: `POST /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/skill-reviews/{reviewId}/approve`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--review-id` (path, required, int64): reviewId
- Notes:
  - Governance operation: require explicit confirmation and verify reviewer permissions.

### `dce agentclaw skillservice delete-global-skill`

- Summary: Permanently delete a global skill
- HTTP: `DELETE /apis/agentclaw.io/v1alpha1/skills/global/{slug}`
- Auth: required
- Body: none
- Flags:
  - `--slug` (path, required): slug
- Notes:
  - Destructive operation: require explicit user confirmation immediately before execution.

### `dce agentclaw skillservice delete-workspace-skill`

- Summary: Permanently delete a workspace skill
- HTTP: `DELETE /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/skills/{namespace}/{slug}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--namespace` (path, required): skill 归属命名空间："global" 或 "ws-<workspace>"。
  - `--slug` (path, required): slug
- Notes:
  - Destructive operation: require explicit user confirmation immediately before execution.

### `dce agentclaw skillservice download-global-skill-file`

- Summary: DownloadGlobalSkillFile 下载 global 版本内单个文件。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/skills/global/{slug}/versions/{version}/file/download`
- Auth: required
- Body: none
- Flags:
  - `--slug` (path, required): slug
  - `--version` (path, required): version
  - `--path` (query): path
- Output: list path `extensions`; columns `@type`

### `dce agentclaw skillservice download-workspace-skill-file`

- Summary: DownloadWorkspaceSkillFile 下载 workspace 版本内单个文件。返回原始字节，并通过
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/skills/{namespace}/{slug}/versions/{version}/file/download`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--namespace` (path, required): skill 归属命名空间："global" 或 "ws-<workspace>"。
  - `--slug` (path, required): slug
  - `--version` (path, required): version
  - `--path` (query): 包内文件相对路径，例如 "assets/logo.png"
- Output: list path `extensions`; columns `@type`

### `dce agentclaw skillservice get-global-skill`

- Summary: GetGlobalSkill 获取 global namespace 下的 skill 详情。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/skills/global/{slug}`
- Auth: required
- Body: none
- Flags:
  - `--slug` (path, required): slug

### `dce agentclaw skillservice get-global-skill-file`

- Summary: GetGlobalSkillFile 预览 global skill 的文本文件。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/skills/global/{slug}/versions/{version}/file`
- Auth: required
- Body: none
- Flags:
  - `--slug` (path, required): slug
  - `--version` (path, required): version
  - `--path` (query): path

### `dce agentclaw skillservice get-global-skill-overview`

- Summary: GetGlobalSkillOverview 返回 global skill 的 SKILL.md 内容（已去除 frontmatter）。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/skills/global/{slug}/versions/{version}/overview`
- Auth: required
- Body: none
- Flags:
  - `--slug` (path, required): slug
  - `--version` (path, required): version

### `dce agentclaw skillservice get-global-skill-security-audit`

- Summary: GetGlobalSkillSecurityAudit 获取 global skill 版本的最新安全审计结果。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/skills/global/{slugId}/versions/{versionId}/security-audit`
- Auth: required
- Body: none
- Flags:
  - `--slug-id` (path, required, int64): slugId
  - `--version-id` (path, required, int64): versionId
- Output: list path `items`; columns `id`, `createdAt`, `findingsCount`, `isSafe`, `maxSeverity`, `scanDurationSeconds`

### `dce agentclaw skillservice get-skill-registry`

- Summary: GetSkillRegistry 返回前端拼装 `npx clawhub install ... --registry <url>` 所需的注册中心地址。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/skills/registry`
- Auth: required
- Body: none
- Flags: none

### `dce agentclaw skillservice get-workspace-skill`

- Summary: GetWorkspaceSkill 获取 workspace 下的 skill 详情。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/skills/{namespace}/{slug}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): 浏览上下文 workspace，由 URL path 绑定，用于鉴权（必须 > 0）。
  - `--namespace` (path, required): skill 归属命名空间："global" 或 "ws-<workspace>"。
  - `--slug` (path, required): slug

### `dce agentclaw skillservice get-workspace-skill-file`

- Summary: GetWorkspaceSkillFile 文本文件预览，仅支持文本（markdown / yaml / 源码 / 配置 等）；
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/skills/{namespace}/{slug}/versions/{version}/file`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--namespace` (path, required): skill 归属命名空间："global" 或 "ws-<workspace>"。
  - `--slug` (path, required): slug
  - `--version` (path, required): version
  - `--path` (query): 包内文件相对路径，例如 "README.md"

### `dce agentclaw skillservice get-workspace-skill-overview`

- Summary: GetWorkspaceSkillOverview 返回 workspace skill 的 SKILL.md 内容（已去除 frontmatter）。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/skills/{namespace}/{slug}/versions/{version}/overview`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--namespace` (path, required): skill 归属命名空间："global" 或 "ws-<workspace>"。
  - `--slug` (path, required): slug
  - `--version` (path, required): version

### `dce agentclaw skillservice get-workspace-skill-review`

- Summary: GetWorkspaceSkillReview 查看 workspace 内单条审核详情。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/skill-reviews/{reviewId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--review-id` (path, required, int64): reviewId

### `dce agentclaw skillservice get-workspace-skill-security-audit`

- Summary: GetWorkspaceSkillSecurityAudit 获取 workspace skill 版本的最新安全审计结果。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/skills/{namespace}/{slugId}/versions/{versionId}/security-audit`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--namespace` (path, required): skill 归属命名空间："global" 或 "ws-<workspace>"。
  - `--slug-id` (path, required, int64): slugId
  - `--version-id` (path, required, int64): versionId
- Output: list path `items`; columns `id`, `createdAt`, `findingsCount`, `isSafe`, `maxSeverity`, `scanDurationSeconds`

### `dce agentclaw skillservice list-admin-managed-skills`

- Summary: ListAdminManagedSkills 列出 global namespace 的 skill（平台公共 skill 管理视图）。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/skills/global-managed`
- Auth: required
- Body: none
- Flags:
  - `--fuzzy-name` (query): 按名称模糊搜索（对应 Skill Hub 的 q 参数）
  - `--sort` (query, default `NEWEST`, one of: NEWEST): sort
  - `--page` (query, default `1`, int32): 页码
  - `--page-size` (query, default `20`, int32): 每页大小，默认 10
- Output: list path `items`; columns `namespace`, `id`, `creator`, `displayName`, `downloadCount`, `ratingAvg`; pagination `offset`

### `dce agentclaw skillservice list-global-skill-files`

- Summary: ListGlobalSkillFiles 列出 global skill 版本的打包文件。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/skills/global/{slug}/versions/{version}/files`
- Auth: required
- Body: none
- Flags:
  - `--slug` (path, required): slug
  - `--version` (path, required): version
  - `--path` (query): path
- Output: list path `items`; columns `name`, `id`, `contentType`, `filePath`, `fileSize`, `isDir`

### `dce agentclaw skillservice list-global-skill-versions`

- Summary: ListGlobalSkillVersions 列出 global skill 的版本。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/skills/global/{slug}/versions`
- Auth: required
- Body: none
- Flags:
  - `--slug` (path, required): slug
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): pageSize
- Output: list path `items`; columns `id`, `changelog`, `downloadAvailable`, `fileCount`, `publishedAt`, `status`; pagination `offset`

### `dce agentclaw skillservice list-workspace-managed-skills`

- Summary: ListWorkspaceManagedSkills 列出当前用户在该 workspace 内可管理的 Skill。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/skills/managed`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--fuzzy-name` (query): 按名称模糊搜索
  - `--sort` (query, default `NEWEST`, one of: NEWEST): sort
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): pageSize
- Output: list path `items`; columns `namespace`, `id`, `creator`, `displayName`, `downloadCount`, `ratingAvg`; pagination `offset`

### `dce agentclaw skillservice list-workspace-skill-files`

- Summary: ListWorkspaceSkillFiles 列出 workspace skill 版本的打包文件。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/skills/{namespace}/{slug}/versions/{version}/files`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--namespace` (path, required): skill 归属命名空间："global" 或 "ws-<workspace>"。
  - `--slug` (path, required): slug
  - `--version` (path, required): version
  - `--path` (query): 目录路径，例如 "src"；空串表示根目录。仅返回该目录直接子层，不递归。
- Output: list path `items`; columns `name`, `id`, `contentType`, `filePath`, `fileSize`, `isDir`

### `dce agentclaw skillservice list-workspace-skill-reviews`

- Summary: ListWorkspaceSkillReviews 列出某 workspace namespace 的审核队列（workspace reviewer 用）。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/skill-reviews`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--status` (query, default `SKILL_REVIEW_STATUS_UNSPECIFIED`, one of: SKILL_REVIEW_STATUS_UNSPECIFIED|SKILL_REVIEW_STATUS_PENDING|SKILL_REVIEW_STATUS_APPROVED|SKILL_REVIEW_STATUS_REJECTED): 审核状态过滤；UNSPECIFIED = 全部状态。
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): pageSize
- Output: list path `items`; columns `namespace`, `reviewComment`, `reviewId`, `reviewedAt`, `reviewedBy`, `reviewedByName`; pagination `offset`

### `dce agentclaw skillservice list-workspace-skill-versions`

- Summary: ListWorkspaceSkillVersions 列出 workspace skill 的版本。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/skills/{namespace}/{slug}/versions`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--namespace` (path, required): skill 归属命名空间："global" 或 "ws-<workspace>"。
  - `--slug` (path, required): slug
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): pageSize
  - `--published-only` (query): 仅返回已发布版本；用于 workspace 市场视图。
- Output: list path `items`; columns `id`, `changelog`, `downloadAvailable`, `fileCount`, `publishedAt`, `status`; pagination `offset`

### `dce agentclaw skillservice list-workspace-skills`

- Summary: ListWorkspaceSkills 列出租户 workspace 下的 skill。
- HTTP: `GET /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/skills`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--fuzzy-name` (query): 按名称模糊搜索（对应 Skill Hub 的 q 参数）
  - `--sort` (query, default `NEWEST`, one of: NEWEST): sort
  - `--page` (query, default `1`, int32): 页码
  - `--page-size` (query, default `20`, int32): 每页大小，默认 10
  - `--list-public` (query): true = 只列平台公共（global namespace）的 skill；false（默认）= 只列 path 中
- Output: list path `items`; columns `namespace`, `id`, `creator`, `displayName`, `downloadCount`, `ratingAvg`; pagination `offset`

### `dce agentclaw skillservice publish-global-skill`

- Summary: Publish a zipped global AgentClaw skill
- HTTP: `POST /apis/agentclaw.io/v1alpha1/skills/global/publish`
- Auth: required
- Body: none
- Flags:
  - `--authorization` (header, required): Authorization
  - `--file` (formData, required): file
  - `--slug` (formData): slug
  - `--summary` (formData): summary
  - `--version` (formData): version
  - `--visibility` (formData, default `SKILL_VISIBILITY_PUBLIC`, one of: SKILL_VISIBILITY_PUBLIC|SKILL_VISIBILITY_PRIVATE|SKILL_VISIBILITY_NAMESPACE_ONLY): visibility
- Output: response media `application/json`
- Prerequisites:
  - Validate the zip contents, global visibility, slug, and version before publishing.
  - Require explicit confirmation before changing the shared skill registry.
- Known errors:
  - HTTP 400: Invalid zip, visibility, missing file, or Skill Hub validation failure
  - HTTP 413: Request body exceeds the 128MB gateway limit
  - HTTP 424: Skill Hub integration is disabled
  - HTTP 502: Skill Hub upstream call failed

### `dce agentclaw skillservice publish-skill`

- Summary: Publish a zipped AgentClaw skill
- HTTP: `POST /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/skills/publish`
- Auth: required
- Body: none
- Flags:
  - `--workspace` (path, required): workspace
  - `--authorization` (header, required): Authorization
  - `--file` (formData, required): file
  - `--slug` (formData): slug
  - `--summary` (formData): summary
  - `--version` (formData): version
  - `--visibility` (formData, default `SKILL_VISIBILITY_PUBLIC`, one of: SKILL_VISIBILITY_PUBLIC|SKILL_VISIBILITY_PRIVATE|SKILL_VISIBILITY_NAMESPACE_ONLY): visibility
- Output: response media `application/json`
- Prerequisites:
  - Validate the zip contents and target namespace before publishing.
  - Require explicit confirmation of workspace, slug, version, and visibility.
- Known errors:
  - HTTP 400: Invalid zip, visibility, missing file, or Skill Hub validation failure
  - HTTP 413: Request body exceeds the 128MB gateway limit
  - HTTP 424: Skill Hub integration is disabled
  - HTTP 502: Skill Hub upstream call failed

### `dce agentclaw skillservice reject-workspace-skill-review`

- Summary: Reject a workspace skill review
- HTTP: `POST /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/skill-reviews/{reviewId}/reject`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--review-id` (path, required, int64): reviewId
- Notes:
  - Governance operation: require explicit confirmation and include the rejection comment in the preview.

### `dce agentclaw skillservice set-global-skill-listing`

- Summary: Set a global skill online or offline
- HTTP: `POST /apis/agentclaw.io/v1alpha1/skills/global/{slug}/listing`
- Auth: required
- Body: required
- Flags:
  - `--slug` (path, required): slug
- Notes:
  - Mutating operation: require explicit confirmation and state whether listed=true or listed=false.

### `dce agentclaw skillservice set-workspace-skill-listing`

- Summary: Set a workspace skill online or offline
- HTTP: `POST /apis/agentclaw.io/v1alpha1/workspaces/{workspace}/skills/{namespace}/{slug}/listing`
- Auth: required
- Body: required
- Flags:
  - `--workspace` (path, required, int32): workspace
  - `--namespace` (path, required): skill 归属命名空间："global" 或 "ws-<workspace>"。
  - `--slug` (path, required): slug
- Notes:
  - Mutating operation: require explicit confirmation and state whether listed=true or listed=false.

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

# AgentClaw module guidance

AgentClaw APIs are mounted under `/apis/agentclaw.io/v1alpha1` and are available through the generated `dce agentclaw` module. All operations require authentication. The local development source is the sibling `agentclaw` repository; replace it with a pinned GitLab commit or released API artifact before publishing this CLI.

## Resolve request context first

Use `dce agentclaw workspaceservice list-workspaces -o json` when the user gives a workspace name but not an ID. The Agent instance APIs use two path conventions:

- Workspace-level inventory and create use `--workspace-id` and expect an integer workspace ID.
- Instance detail, lifecycle, telemetry, skill, and overview APIs use `--workspace`; confirm whether the endpoint expects the integer ID or the namespace identifier from the API description before calling it.

For instance detail and lifecycle operations, resolve all four identifiers: workspace, cluster, namespace, and instance ID. Do not infer a cluster or namespace from a fuzzy name when multiple instances match; list and ask the user to choose.

## Safe operation policy

Read-only inventory, telemetry, overview, model listing, permission, file preview, and audit queries can run directly after authentication. Treat the following as mutating or governance actions and require explicit confirmation immediately before execution:

- create, update, delete, start, stop, and restart Agent instances;
- publish, permanently delete, list/unlist, approve, or reject skills;
- create, update, delete, enable, or disable network-policy templates;
- Feishu onboarding and any request carrying credentials or tokens.

Before a confirmed write, show the resolved workspace/cluster/namespace/instance or skill identifiers, the selected visibility/listing state, and the request body summary. Afterward, query the affected resource again and report the resulting status.

Use `--dry-run` to inspect the resolved method, URL, headers, and body before a write. Use `-o json` when the result will feed another command or needs exact IDs. Never expose `gatewayToken`, API keys, bearer tokens, or uploaded skill contents in the response.

## Skill publish caveat

`http/skill_publish.swagger.json` is included in the source and generates `dce agentclaw skillservice publish-skill`. The endpoint requires `multipart/form-data` with a zip file, but Lathe v0.4.5 currently represents Swagger `formData` parameters as URL-encoded fields. Keep the command documented for discovery, but verify/fix multipart serialization in the CLI runtime before using it; until then, do not claim that `publish-skill` is production-ready.

## Useful read-only flows

```bash
# Discover workspaces and instances.
dce agentclaw workspaceservice list-workspaces -o json
dce agentclaw agentservice list-workspace-agent-instances --workspace-id <workspace-id> -o json

# Inspect health and usage for a selected instance.
dce agentclaw agentservice get-workspace-agent-instance \
  --workspace-id <workspace-id> --cluster <cluster> --namespace <namespace> --instance-id <instance-id> -o json
dce agentclaw agentservice get-agent-instance-performance-usage \
  --workspace <workspace> --cluster <cluster> --namespace <namespace> --instance-id <instance-id> -o json
dce agentclaw agentservice get-agent-instance-token-usage \
  --workspace <workspace> --cluster <cluster> --namespace <namespace> --instance-id <instance-id> -o json

# Inspect skills and review/audit state.
dce agentclaw skillservice list-skills --workspace <workspace> -o json
dce agentclaw skillservice list-skill-versions --workspace <workspace> --slug <slug> -o json
dce agentclaw skillservice get-skill-security-audit \
  --workspace <workspace> --slug-id <slug-id> --version-id <version-id> -o json
```

If a module-level route returns 404, first check whether AgentClaw is installed on the target host using the global module version inventory. If the module is present, re-check the exact path and parameters with `dce commands show`; a resource-level 404 means the selected object does not exist.
