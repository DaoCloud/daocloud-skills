---
name: global-management:personal-access-summary-workflow
description: >
  Use when a user wants their own DCE access summary and explicitly asks to
  use a workflow: visible workspaces, user groups, roles, role sources, or
  effective global permissions. Also use for Chinese requests such as 用
  workflow 查看我的权限、工作流聚合个人中心权限、通过 workflow 查询我的用户组和工作空间.
---

# DCE Personal Access Summary via Workflow

Collect a read-only, complete access summary for the authenticated account by
using the `personal-access-summary-page` workflow.

**REQUIRED SUB-SKILL:** Use `dce` for all command execution, auth checks, and
catalog discovery.

## Scope and Boundaries

- Inspect only the account authenticated by the current DCE token. The workflow
  obtains `user.uid` itself; never accept a caller-provided user ID.
- The workflow's `workspaces` are visible workspaces, not proof of direct
  membership or a workspace-specific permission source.
- The workflow's `globalPermissions` are effective global permissions, not
  per-workspace permissions.
- `roleBindings.items` retain `type`, `roleName`, and `subjectName`; use those
  fields to show whether an assignment came directly from the user or from a
  group.
- The workflow is read-only. Do not change a role, group, workspace, or access
  token.

## Workflow

### Step 1 — Collect the First Page

Run:

```bash
dce personal-access-summary-page --page 1 --page-size 100 -o json
```

The workflow returns an aggregate JSON value. If the CLI emits it as a JSON
string, parse it once with `jq 'fromjson'` before reading fields.

Read these pagination totals independently:

```text
groups.pagination.total
roleBindings.pagination.total
workspaces.pagination.total
```

Keep `user` and `globalPermissions` from page 1 as the summary's identity and
permission snapshot.

### Step 2 — Complete Pagination Through the Workflow

The workflow runtime has no loop primitive. For each collection, calculate
`ceil(total / 100)` from page 1, then invoke the workflow for every required
page number:

```bash
dce personal-access-summary-page --page <n> --page-size 100 -o json
```

From each result, merge only the appropriate page's `groups.items`,
`roleBindings.items`, and `workspaces.items`. Deduplicate by stable identity:

- groups: `id`
- role bindings: `type + id + roleName`
- workspaces: `id`

Do not invoke the workflow again to re-read the totals. A second invocation
re-runs all five steps, including the two that do not paginate, and buys nothing
a single observation does not already state.

A failed workflow step fails that whole workflow page. Treat the collections it
covered as partial, not empty, and say which page number failed.

### Step 3 — Present the Summary

Use the same result model as the non-workflow skill:

```text
account: { uid, username, email }
workspaces: [{ id, name, alias }]
userGroups: [{ id, name }]
roleBindings: [{ type, roleName, subjectName }]
globalPermissions: [permission]
```

Do not infer a workspace-level role from a visible workspace. Do not infer a
role's permissions from its name.

## Auth Not Established

Stop and instruct the user to run:

```bash
dce auth login --hostname <host>
```

## Output Format

Put the conclusion first. State the account identity, collection time, and
whether every paginated collection was fully retrieved or partial. Present the
result as one observation taken at that time; do not claim it was verified
against a second read.

Use these sections in order:

1. `# Conclusion` — scope and completeness.
2. `## Account` — UID, username, email.
3. `## Visible Workspaces` — `ID | Alias | Name`.
4. `## Role Bindings` — `Role | Source Type | Source Name`.
5. `## Effective Global Permissions` — one permission per row or a concise
   list.
6. `## User Groups` — `ID | Name`.
7. `## Limits and Follow-up` — explicitly state that existing APIs do not
   provide a per-workspace permission source chain.

Never include a token, request authorization header, or raw command transcript.
