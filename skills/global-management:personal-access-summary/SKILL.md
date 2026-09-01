---
name: global-management:personal-access-summary
description: >
  Use when a user wants to view, summarize, audit, or export their own DCE
  account access: visible workspaces, user groups, roles, role sources, or
  effective global permissions. Also use for Chinese requests such as 查看我的
  权限、个人中心权限信息、我在哪些工作空间、我的用户组、我的角色和权限.
---

# DCE Personal Access Summary

Collect a read-only, complete access summary for the authenticated account
without using a DCE workflow.

**REQUIRED SUB-SKILL:** Use `dce` for all command execution, auth checks, and
catalog discovery.

## Scope and Boundaries

- Inspect only the account authenticated by the current DCE token. Do not
  accept a user ID supplied by the caller and do not read or decode local token
  files.
- `workspaces` means workspaces visible to the account. It does not prove a
  direct membership or identify which role or group grants access to a specific
  workspace.
- `globalPermissions` are effective global permissions. Do not present them as
  per-workspace permissions.
- `roleBindings` come from `list-user-subjects`; retain its `type`,
  `roleName`, and `subjectName` so direct-user and group-derived assignments
  remain distinguishable.
- All operations are read-only. Do not change a role, group, workspace, or
  access token.

## Workflow

### Step 1 — Establish the Authenticated Account

Run:

```bash
dce global-management account get-user -o json
```

Read `uid` from the response. It is the only user ID allowed in subsequent
requests. If this request fails, stop and report that the account cannot be
identified. Do not try to extract a claim from the local token.

### Step 2 — Collect Every Page

Use a page size of 100. Fetch page 1 of each collection with `-o json`, read
its `pagination.total`, then fetch pages `2..ceil(total / 100)` for that
collection. Keep the three pagination loops independent: their totals can
differ.

```bash
dce global-management users list-user-groups --id <uid> --page <n> --page-size 100 -o json
dce global-management users list-user-subjects --id <uid> --page <n> --page-size 100 -o json
dce global-management workspace list-workspaces --page <n> --page-size 100 -o json
```

Preserve every `items` entry. Do not re-request page 1 to confirm a total: this
summary is a single observation, and a second read would only move the window it
claims to verify.

A failed page or a missing `pagination.total` makes that collection partial, not
empty. Keep the pages that succeeded and say which ones are missing.

### Step 3 — Collect Effective Global Permissions

Run once during the same observation window:

```bash
dce global-management account get-global-permissions -o json
```

Keep the response's `permissions` exactly as returned. An empty, successful
array means no effective global permissions; an error is not an empty array.

### Step 4 — Present the Summary

Normalize the evidence into these logical fields before reporting it:

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
