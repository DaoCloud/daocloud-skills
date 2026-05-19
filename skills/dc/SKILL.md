---
name: dc
description: >
  Use when operating the dc generated CLI. Discover commands, inspect parameters,
  check auth state, and execute API operations safely.
---

# dc CLI

Use this skill when a user asks you to operate `dc`, inspect its API commands, or find the right generated command for an API task.

## Workflow

1. Search for candidates with `dc search "<intent>" --json`; use `--limit` when needed. Search is only candidate discovery.
2. Inspect the exact command with `dc commands show <path...> --json` before executing an unfamiliar command.
3. If the command detail has `auth.required=true`, run `dc auth status --hostname <host>` before execution. If it is not logged in, stop and ask the user to authenticate.
4. Execute only after flags, body, auth, HTTP path, and output hints are clear from `commands show`.

## General Commands

- `dc commands --json`: full generated command catalog.
- `dc commands --include-hidden --json`: include hidden generated commands.
- `dc commands show <path...> --json`: source of truth for one command.
- `dc commands schema --json`: catalog schema version for parser compatibility.
- `dc search "<intent>" --json`: ranked candidate commands.

## References

- Read `references/catalog.md` for the command discovery protocol and catalog field meanings.
- Read `references/modules/container-management.md` for the `container-management` module command index.
- Read `references/modules/global-management.md` for the `global-management` module command index.
- Read `references/modules/insight.md` for the `insight` module command index.

## Rules

- Do not guess flags or request body shape from command names.
- Do not execute directly from search results; confirm with `commands show` first.
- Prefer `-o json` for machine-readable command output unless the user asks for human-readable output.
- Use `--file`, `--set`, or `--set-str` for JSON request bodies according to `commands show` body requirements.
