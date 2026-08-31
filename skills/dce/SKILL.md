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
3. If the command detail has `auth.required=true`, run `dce auth status -o json` before execution and read `hostname` and `source`. Host resolution order: `--hostname` > `$DCE_HOST` > the selected host (`dce auth use <host>`) > `http.default_hostname` > the single host in `hosts.yml`. If none applies, stop and ask the user to authenticate or select a host.
4. Execute only after flags, body, auth, HTTP path, `mutation`, `dry_run`, and output hints are clear from `commands show`. When `mutation` is not `read`, preview with `--<dry_run.flag>` if `dry_run.mode` is `http_preview`; if preview is unavailable, obtain explicit user confirmation before execution.

## General Commands

- `dce commands --json`: full generated command catalog.
- `dce commands --include-hidden --json`: include hidden generated commands.
- `dce commands show <path...> --json`: source of truth for one command.
- `dce commands schema --json`: catalog schema version, surfaces, and dry-run result shape.
- `dce search "<intent>" --json`: ranked candidate commands.
- `dce auth status -o json`: resolved `hostname`, its `source`, the `selected` host, and every logged-in host.

## Maintenance Commands

- `dce --version` or `dce -v`: print CLI build version.

## References

- Read `references/catalog.md` for the command discovery protocol and catalog field meanings.
- Read `references/modules/agentclaw.md` for the `agentclaw` module command index.
- Read `references/modules/ai-lab.md` for the `ai-lab` module command index.
- Read `references/modules/billing-center.md` for the `billing-center` module command index.
- Read `references/modules/business-cockpit.md` for the `business-cockpit` module command index.
- Read `references/modules/container-management.md` for the `container-management` module command index.
- Read `references/modules/elasticsearch.md` for the `elasticsearch` module command index.
- Read `references/modules/global-management.md` for the `global-management` module command index.
- Read `references/modules/insight.md` for the `insight` module command index.
- Read `references/modules/kafka.md` for the `kafka` module command index.
- Read `references/modules/llm-studio.md` for the `llm-studio` module command index.
- Read `references/modules/microservice-engine.md` for the `microservice-engine` module command index.
- Read `references/modules/minio.md` for the `minio` module command index.
- Read `references/modules/mongodb.md` for the `mongodb` module command index.
- Read `references/modules/mysql.md` for the `mysql` module command index.
- Read `references/modules/operations-management.md` for the `operations-management` module command index.
- Read `references/modules/postgresql.md` for the `postgresql` module command index.
- Read `references/modules/rabbitmq.md` for the `rabbitmq` module command index.
- Read `references/modules/redis.md` for the `redis` module command index.
- Read `references/modules/rocketmq.md` for the `rocketmq` module command index.
- Read `references/modules/seaweedfs.md` for the `seaweedfs` module command index.
- Read `references/modules/virtual-machines.md` for the `virtual-machines` module command index.
- Read `references/modules/workbench.md` for the `workbench` module command index.

## Rules

- Do not guess flags or request body shape from command names.
- Do not execute directly from search results; confirm with `commands show` first.
- When `mutation` is not `read`, preview before execution if `dry_run.mode` is `http_preview`. If preview is unavailable, obtain explicit user confirmation before execution. `unknown` is not safe to treat as read.
- Prefer `-o json` for machine-readable command output unless the user asks for human-readable output.
- With `-o json` or `-o yaml`, branch on `error.code` and process exit status; `error.message` and `error.hint` are safe human guidance, and `error.http.status` is the only optional HTTP context.
- A configured stream pause is successful (`exit 0`); inspect the collected output field mapped from the pause event instead of treating it as an error.
- For collected streams, choose one mode: `-o json` for one stable document, `--stream` in the default output mode when catalog `output.streaming.policy.live` is present, or `-o raw` for wire events.
- Use `--file`, `--set`, or `--set-str` for JSON request bodies according to `commands show` body requirements.
- When `body.runtime_schema` is present, normal execution fetches and validates against that schema before the target request; an `http_preview` dry-run stays network-free and skips this preflight.
- For sensitive flags, prefer safe modes from `flags[].input_modes`: `--<flag>-env`, `--<flag>-file`, or `--<flag>-stdin`.

## Module availability

The catalog (`dce commands` / `dce search`) lists every module `dce` was built with, **regardless of which modules are actually installed on the target host**. A command appearing in the catalog does not guarantee its module is deployed.

A `404` / route-not-found at the **module path level** (the API route itself does not exist, not a specific object) is ambiguous: the module may not be installed, or the path/version may be wrong. On such a `404`, **actively confirm before concluding** by running `dce global-management about list-g-product-versions -o json` (global-management is the always-present base module, so this is always available). Then:

- **Module not in the list** → it is not installed on this host. Do not retry, do not try sibling commands in the same module, and do not tell the user the capability exists — state plainly that the module is not installed.
- **Module in the list** → it is installed, so the `404` is not a missing module. Re-check the exact path and params with `dce commands show <path...> --json` (likely a wrong path/version or a resource-level not-found); do not report the module as missing.
- **Resource-level `404`** (a specific ID/name on an otherwise-working module) means **that object** doesn't exist, not that the module is missing — handle that normally.
