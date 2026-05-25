# daocloud-skills

A generated CLI and AI skill package for DaoCloud Enterprise (DCE). It wraps the DCE REST API into a `dc` command-line tool and bundles a companion skill for AI agents.

## Overview

- **`dc`** — a CLI generated from DCE OpenAPI specs (global-management, container-management). Supports API discovery, search, and execution with built-in auth management.
- **`skills/dc`** — an AI agent skill that teaches agents how to use `dc` safely.

Currently supported products:

| Module | Description |
|---|---|
| `global-management` | Global Management — users, groups, workspaces, roles, audit |
| `container-management` | Container Management — clusters, namespaces, workloads, storage |
| `insight` | Insight — observability, metrics, alerting, and related operations |

## Prerequisites

- Go 1.25+
- Git (for spec sync)
- Docker with [buildx](https://docs.docker.com/buildx/working-with-buildx/) (for container image builds)

## Quick Start

```bash
# Sync OpenAPI specs and regenerate code
make bootstrap

# Build dc
make build

# Install dc and symlink skill for local development
make dev
```

The `make dev` target installs `dc` to `/usr/local/bin` and symlinks `skills/dc` into `~/.agents/skills/dc` for live local development in an AI agent runtime.

## Install the Skill

Install the `dc` skill globally:

```bash
npx skills add daocloud/daocloud-skills -g
```

For non-interactive installs, add confirmation flags:

```bash
npx -y skills add daocloud/daocloud-skills -g -y
```

The `-g` flag installs the skill into the selected agent's user-level skills directory, so it is available across projects. Omit `-g` if you want to install the skill only for the current project.

This installs the skill only. The skill helps an AI agent use `dc`, but it does not install the `dc` CLI. Install the CLI separately before running DCE operations.

### Install for a Specific Agent

Use `--agent` to install the `dc` skill for a specific AI coding agent. Common client targets include:

**Claude Code**

```bash
npx skills add daocloud/daocloud-skills -g --skill dc --agent claude-code
```

**Codex**

```bash
npx skills add daocloud/daocloud-skills -g --skill dc --agent codex
```

**Cursor**

```bash
npx skills add daocloud/daocloud-skills -g --skill dc --agent cursor
```

Use `--agent` more than once to install the same skill into multiple agents:

```bash
npx skills add daocloud/daocloud-skills -g \
  --skill dc \
  --agent claude-code \
  --agent codex \
  --agent cursor
```

This installs the skill from the repository's default branch. To inspect available skills before installing:

```bash
npx skills add daocloud/daocloud-skills --list
```

To uninstall the global `dc` skill, use `remove` with the same agent target:

```bash
npx skills remove -g dc --agent codex
```

After installation, open a new agent session and ask it to use the `dc` skill for DCE operations, for example:

```text
Use the dc skill to list DCE clusters.
```

## Install the CLI

For regular users, download a prebuilt archive from GitHub Releases:

```bash
VERSION=v0.1.0-rc.4
OS=linux
ARCH=amd64
PKG="dc-${VERSION}-${OS}-${ARCH}"

curl -fL "https://github.com/DaoCloud/daocloud-skills/releases/download/${VERSION}/${PKG}.tar.gz" -o dc.tar.gz
tar -xzf dc.tar.gz
sudo install -m 0755 "${PKG}/dc" /usr/local/bin/dc
```

Use `OS=darwin` for macOS and `OS=linux` for Linux. Use `ARCH=arm64` for Apple Silicon or ARM64 Linux, and `ARCH=amd64` for Intel macOS or x86_64 Linux.

Verify the CLI is available:

```bash
dc --help
```

For source builds from this repository:

```bash
make build
sudo cp bin/dc /usr/local/bin/dc
```

For local development, use `make dev` to build the CLI, copy it to `/usr/local/bin/dc`, and symlink the local skill directory:

```bash
make dev
```

## Usage

```bash
# Log in to a DCE instance
dc auth login --hostname https://<dce-host>

# Browse available commands
dc commands --json

# Search for a command by intent
dc search "list clusters" --json

# Inspect a command before executing
dc commands show container-management cluster list-clusters --json

# Execute a command
dc container-management cluster list-clusters -o json
```

## Container Image

The image bundles the `dc` binary and the `skills/dc` directory under `/app/`, intended for use as a Kubernetes init container to distribute the tooling into a shared volume.

```bash
# Build multi-arch image locally
make image

# Build and push to registry
make image-push IMAGE_REPO=registry.example.com/dc IMAGE_TAG=v1.0.0
```

Default values: `IMAGE_REPO=daocloud/dc`, `IMAGE_TAG=latest`.

### Init Container Example

```yaml
initContainers:
  - name: install-dc
    image: daocloud/dc:latest
    command:
      - sh
      - -c
      - |
        cp /app/dc /target/bin/dc
        cp -r /app/skills/dc /target/.agents/skills/dc
    volumeMounts:
      - name: tools
        mountPath: /target

volumes:
  - name: tools
    emptyDir: {}
```

After the init container completes, the shared volume contains:

- `/target/bin/dc` — CLI binary
- `/target/.agents/skills/dc/` — AI agent skill

## Development

| Target | Description |
|---|---|
| `make bootstrap` | Sync specs + regenerate all code |
| `make specsync` | Pull latest OpenAPI specs from upstream |
| `make codegen` | Regenerate Go code and skill references from specs |
| `make sync-one SOURCE=<name>` | Sync and regenerate a single source (e.g. `ghippo`) |
| `make build` | Build `bin/dc` |
| `make image` | Build multi-arch image locally (`linux/amd64`, `linux/arm64`) |
| `make image-push` | Build and push multi-arch image to registry |
| `make dev` | Build, install, and symlink skill for local debugging |
| `make dev-clean` | Remove installed binary and skill symlink |
| `make clean` | Remove `.cache` and `bin` |

## Project Structure

```
.
├── cli.yaml                  # CLI name and auth config
├── specs/sources.yaml        # OpenAPI source definitions (pinned commits)
├── internal/
│   ├── generated/            # Generated Go command modules (do not edit)
│   └── overlay/              # Per-source field overrides for codegen
├── skills/dc/            # AI agent skill (SKILL.md + references)
├── docs/                     # Developer guides
├── cmd/dc/main.go        # CLI entrypoint
└── doc.go                    # Embeds cli.yaml for use by main
```

## Guides

- [Adding a new product](docs/add-new-product.md) — step-by-step guide for onboarding a new DCE product (spec source, overlay, codegen, verification)

## How It Works

1. **`specsync`** clones the pinned commit of `daocloud-api-docs` and extracts the OpenAPI JSON files into `.cache/specs-sync/`.
2. **`codegen`** reads each spec, applies the overlay from `internal/overlay/<source>.yaml`, and emits:
   - Go cobra subcommands under `internal/generated/<source>/`
   - A command index at `skills/dc/references/modules/<source>.md`
   - An updated `internal/generated/modules_gen.go` that mounts all modules
3. **`go build`** compiles everything into a single static binary `bin/dc`.

Overlay files are the only place where human-maintained configuration lives — everything else is generated and should not be edited by hand.

## Updating a Pinned Spec

Update the `pinned_tag` for the relevant source in `specs/sources.yaml`, then run:

```bash
make sync-one SOURCE=<name>
```
