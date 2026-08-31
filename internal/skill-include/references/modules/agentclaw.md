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
