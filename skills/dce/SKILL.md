---
name: dce
description: >
  Use when operating the dce generated CLI. Discover commands, inspect parameters,
  check auth state, and execute API operations safely.
---

# dce CLI

Use this skill when a user asks you to operate `dce`, inspect its API commands, or find the right generated command for an API task.

## Workflow

1. Search for candidates with `dce search "<intent>" --json`; use `--limit` when needed. Search is only candidate discovery.
2. Inspect the exact command with `dce commands show <path...> --json` before executing an unfamiliar command.
3. If the command detail has `auth.required=true`, run `dce auth status --hostname <host>` before execution. If it is not logged in, stop and ask the user to authenticate.
4. Execute only after flags, body, auth, HTTP path, and output hints are clear from `commands show`.

## General Commands

- `dce commands --json`: full generated command catalog.
- `dce commands --include-hidden --json`: include hidden generated commands.
- `dce commands show <path...> --json`: source of truth for one command.
- `dce commands schema --json`: catalog schema version for parser compatibility.
- `dce search "<intent>" --json`: ranked candidate commands.

## References

- Read `references/catalog.md` for the command discovery protocol and catalog field meanings.
- Read `references/modules/amamba.md` for the `amamba` module command index.
- Read `references/modules/container-management.md` for the `container-management` module command index.
- Read `references/modules/elasticsearch.md` for the `elasticsearch` module command index.
- Read `references/modules/global-management.md` for the `global-management` module command index.
- Read `references/modules/insight.md` for the `insight` module command index.
- Read `references/modules/kafka.md` for the `kafka` module command index.
- Read `references/modules/minio.md` for the `minio` module command index.
- Read `references/modules/mongodb.md` for the `mongodb` module command index.
- Read `references/modules/mysql.md` for the `mysql` module command index.
- Read `references/modules/operations-management.md` for the `operations-management` module command index.
- Read `references/modules/postgresql.md` for the `postgresql` module command index.
- Read `references/modules/rabbitmq.md` for the `rabbitmq` module command index.
- Read `references/modules/redis.md` for the `redis` module command index.
- Read `references/modules/rocketmq.md` for the `rocketmq` module command index.
- Read `references/modules/seaweedfs.md` for the `seaweedfs` module command index.

## Rules

- Do not guess flags or request body shape from command names.
- Do not execute directly from search results; confirm with `commands show` first.
- Prefer `-o json` for machine-readable command output unless the user asks for human-readable output.
- Use `--file`, `--set`, or `--set-str` for JSON request bodies according to `commands show` body requirements.

## Module availability

The catalog (`dce commands` / `dce search`) lists every module `dce` was built with, **regardless of which modules are actually installed on the target host**. A command appearing in the catalog does not guarantee its module is deployed.

A `404` / route-not-found at the **module path level** (the API route itself does not exist, not a specific object) is ambiguous: the module may not be installed, or the path/version may be wrong. On such a `404`, **actively confirm before concluding** by running `dce global-management about list-g-product-versions -o json` (global-management is the always-present base module, so this is always available). Then:

- **Module not in the list** → it is not installed on this host. Do not retry, do not try sibling commands in the same module, and do not tell the user the capability exists — state plainly that the module is not installed.
- **Module in the list** → it is installed, so the `404` is not a missing module. Re-check the exact path and params with `dce commands show <path...> --json` (likely a wrong path/version or a resource-level not-found); do not report the module as missing.
- **Resource-level `404`** (a specific ID/name on an otherwise-working module) means **that object** doesn't exist, not that the module is missing — handle that normally.
