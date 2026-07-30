# Lathe Workflow 使用指南

Lathe Workflow 将一条固定的、顺序执行的 API 调用链生成为 `dce` 的根命令。它适合把多个已有的只读或无条件 API 操作封装成一个可发现、可验证的命令；它不是通用脚本或编排引擎。

本仓库使用 `github.com/lathe-cli/lathe v0.4.5`，工作流定义写在根目录的 [`cli.yaml`](../cli.yaml)，生成结果由 `make bootstrap` 提交到仓库。

## 适用边界

适合：步骤数量固定、严格串行、每一步都是已生成 API 操作，后续步骤只需引用前面步骤的 JSON 输出。

不适合：条件分支、循环或分页汇总、并行、重试与回滚、Shell/本地诊断、交互式选择，或需要组合多步结果为新对象的场景。这些逻辑应保留在 Skill 或手写 Go 中。

工作流按定义顺序运行；任一步失败后立即停止，先前的写操作不会自动回滚。因此优先从只读调用链开始。

## 定义一个工作流

在 `cli.yaml` 中添加 `workflow.commands`。`uses` 推荐写为 `<source>.<operationId>`；`params` 的键必须是目标操作的参数名或 flag 名，代码生成会校验它们。

```yaml
workflow:
  version: 1
  commands:
    - use: model-serving-summary
      short: "查询模型及其关联的模型服务"
      inputs:
        - name: model_id
          flag: model-id
          type: string
          required: true
      steps:
        - id: model
          uses: hydra.AdminModelManagement_GetModel
          params:
            modelId: ${input.model_id}
        - id: servings
          uses: hydra.AdminModelManagement_ListModelServingsByModel
          params:
            modelId: ${steps.model.modelId}
      output:
        from: ${steps.servings}
```

这个示例生成根命令 `dce model-serving-summary`：

1. `model` 读取 `--model-id` 指定的模型。
2. `servings` 读取上一步响应中的 `modelId`，查询关联的模型服务。
3. 命令只输出 `servings` 的响应。

引用格式如下：

- `${input.model_id}`：读取工作流输入；输入会变成普通 CLI flag。
- `${steps.model}`：读取前一步完整 JSON 响应。
- `${steps.model.modelId}`：读取前一步 JSON 的字段。

支持的输入类型为 `string`、`int64`、`float64`、`bool` 及对应的切片类型。完整的 `${...}` 参数引用会保留原始类型；若与其他文本拼接，则结果为字符串。

请求体字段可使用 `set` 和 `set_str`，语义与生成 API 命令的同名 flag 一致：`set` 会把插值后的 `true`、`false`、`null`、整数、浮点数和 JSON 数组推断为对应类型；`set_str` 始终保留为字符串。例如：

```yaml
set:
  spec.replicas: "3"
  spec.enabled: "true"
set_str:
  spec.version: ${input.version}
```

## 找到可复用的 API 操作

先构建当前 CLI，用 `search` 找候选，再用机器可读目录核对操作：

```sh
make build
bin/dce search "model" --json
bin/dce commands show llm-studio adminmodelmanagement get-model --json
```

目录输出提供 `operation_id`、HTTP 路径和 flag；再从 [`specs/sources.yaml`](../specs/sources.yaml) 确认 source key（本例为 `hydra`，不是显示模块名 `llm-studio`），即可组成 `uses` 引用。本例使用的两个操作为：

- `hydra.AdminModelManagement_GetModel`
- `hydra.AdminModelManagement_ListModelServingsByModel`

如果某个操作 ID 不便引用，也可以使用生成命令路径；优先使用上述形式，因为代码生成能更明确地报告歧义或不存在的操作。

## 生成与校验

修改 `cli.yaml` 后执行：

```sh
make bootstrap
go test ./...
make build
bin/dce __lathe verify --json
bin/dce commands show model-serving-summary --json
```

`make bootstrap` 会生成 `internal/generated/workflows/workflows_gen.go` 并更新模块挂载代码。`__lathe verify --json` 校验生成后的工作流目录合同，包括命令类型、步骤和 HTTP 元数据；它不会调用真实 DCE API。

## 运行示例

先登录到目标 DCE，再传入一个已存在的模型 ID：

```sh
bin/dce auth login --hostname <dce-host>
bin/dce model-serving-summary --model-id <model-id> --output json
```

该示例依赖 LLM Studio/Hydra API 可用，且当前账号有读取模型和模型服务的权限。自动化测试使用本地 HTTP 服务验证步骤顺序及 `${steps.model.modelId}` 的传值，不访问真实 DCE 环境。
