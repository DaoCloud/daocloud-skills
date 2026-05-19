LATHE      := go tool lathe
IMAGE_REPO ?= daocloud/dc
IMAGE_TAG  ?= latest

BIN_OUT    ?= bin/dc
VERSION    ?= dev
COMMIT     ?= $(shell git rev-parse HEAD 2>/dev/null || echo none)
DATE       ?= $(shell date -u +%Y-%m-%dT%H:%M:%SZ)
GO_LDFLAGS := -s -w -X main.Version=$(VERSION) -X main.Commit=$(COMMIT) -X main.Date=$(DATE)

.PHONY: bootstrap specsync codegen build build-bin image image-push clean

bootstrap: specsync codegen

specsync:
	$(LATHE) specsync -sources specs/sources.yaml

codegen:
	$(LATHE) codegen \
		-manifest cli.yaml \
		-sources specs/sources.yaml \
		-overlay internal/overlay \
		-skill-root skills

# sync and regenerate a single source; usage: make sync-one SOURCE=ghippo
sync-one:
	$(LATHE) specsync -sources specs/sources.yaml -source $(SOURCE)
	$(LATHE) codegen \
		-manifest cli.yaml \
		-sources specs/sources.yaml \
		-overlay internal/overlay \
		-skill-root skills

build: internal/generated
	go build -trimpath -ldflags="$(GO_LDFLAGS)" -o $(BIN_OUT) ./cmd/dc

build-bin:
	go build -trimpath -ldflags="$(GO_LDFLAGS)" -o $(BIN_OUT) ./cmd/dc

internal/generated: .cache/specs-sync/ghippo/sync-state.yaml
	$(LATHE) codegen \
		-manifest cli.yaml \
		-sources specs/sources.yaml \
		-overlay internal/overlay \
		-skill-root skills

.cache/specs-sync/ghippo/sync-state.yaml:
	$(LATHE) specsync -sources specs/sources.yaml

# dev: install dc to PATH and symlink skill into opencode for live debugging
dev: build
	@mkdir -p ~/.agents/skills
	@if [ ! -f skills/dc/_meta.json ]; then \
		echo '{"slug":"dc","version":"dev"}' > skills/dc/_meta.json; \
	fi
	@if [ -L ~/.agents/skills/dc ]; then \
		echo "skill symlink already exists"; \
	elif [ -d ~/.agents/skills/dc ]; then \
		echo "warning: ~/.agents/skills/dc is a real directory, remove it first"; \
		exit 1; \
	else \
		ln -s "$(CURDIR)/skills/dc" ~/.agents/skills/dc; \
		echo "skill symlinked: ~/.agents/skills/dc -> $(CURDIR)/skills/dc"; \
	fi
	@if command -v dc >/dev/null 2>&1 && [ "$$(which dc)" != "$(CURDIR)/bin/dc" ]; then \
		echo "note: dc in PATH is $$(which dc), not $(CURDIR)/bin/dc"; \
	fi
	cp bin/dc /usr/local/bin/dc
	@echo "done — restart opencode to pick up skill changes"

dev-clean:
	rm -f ~/.agents/skills/dc
	rm -f /usr/local/bin/dc

image:
	docker buildx build \
		--platform linux/amd64,linux/arm64 \
		-t $(IMAGE_REPO):$(IMAGE_TAG) \
		--load \
		.

image-push:
	docker buildx build \
		--platform linux/amd64,linux/arm64 \
		-t $(IMAGE_REPO):$(IMAGE_TAG) \
		--push \
		.

clean:
	rm -rf .cache bin
