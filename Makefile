SPECSYNC   := go tool lathe specsync
CODEGEN    := go tool lathe codegen
IMAGE_REPO ?= daocloud/dc
IMAGE_TAG  ?= latest

VERSION    := $(shell git describe --tags --always --dirty 2>/dev/null || echo dev)
COMMIT     := $(shell git rev-parse --short HEAD 2>/dev/null || echo none)
DATE       := $(shell date -u +%Y-%m-%dT%H:%M:%SZ)
LDFLAGS    := -ldflags "-X main.Version=$(VERSION) -X main.Commit=$(COMMIT) -X main.Date=$(DATE)"

PLATFORMS  := linux/amd64 linux/arm64 darwin/amd64 darwin/arm64 windows/amd64 windows/arm64

.PHONY: bootstrap specsync codegen build build-all image image-push clean

bootstrap: specsync codegen

specsync:
	$(SPECSYNC) -sources specs/sources.yaml

codegen:
	$(CODEGEN) \
		-manifest cli.yaml \
		-sources specs/sources.yaml \
		-overlay internal/overlay \
		-skill-root skills

# sync and regenerate a single source; usage: make sync-one SOURCE=ghippo
sync-one:
	$(SPECSYNC) -sources specs/sources.yaml -source $(SOURCE)
	$(CODEGEN) \
		-manifest cli.yaml \
		-sources specs/sources.yaml \
		-overlay internal/overlay \
		-skill-root skills

build: internal/generated
	go build $(LDFLAGS) -o bin/dc ./cmd/dc

build-all: internal/generated
	$(foreach platform,$(PLATFORMS), \
		$(eval GOOS=$(word 1,$(subst /, ,$(platform)))) \
		$(eval GOARCH=$(word 2,$(subst /, ,$(platform)))) \
		$(eval EXT=$(if $(filter windows,$(GOOS)),.exe,)) \
		GOOS=$(GOOS) GOARCH=$(GOARCH) go build $(LDFLAGS) \
			-o bin/dc-$(GOOS)-$(GOARCH)$(EXT) ./cmd/dc;)

internal/generated: .cache/specs-sync/ghippo/sync-state.yaml
	$(CODEGEN) \
		-manifest cli.yaml \
		-sources specs/sources.yaml \
		-overlay internal/overlay \
		-skill-root skills

.cache/specs-sync/ghippo/sync-state.yaml:
	$(SPECSYNC) -sources specs/sources.yaml

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
