LATHE      := go tool lathe
IMAGE_REPO ?= daocloud/dce
IMAGE_TAG  ?= latest

BIN_OUT    ?= bin/dce
VERSION    ?= dev
COMMIT     ?= $(shell git rev-parse HEAD 2>/dev/null || echo none)
DATE       ?= $(shell date -u +%Y-%m-%dT%H:%M:%SZ)
GO_LDFLAGS := -s -w -X 'main.Version=$(VERSION)' -X 'main.Commit=$(COMMIT)' -X 'main.Date=$(DATE)'

.PHONY: bootstrap specsync codegen build image image-push clean

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

build:
	go build -trimpath -ldflags="$(GO_LDFLAGS)" -o $(BIN_OUT) ./cmd/dce

# dev: install dce to PATH and symlink skill into opencode for live debugging
dev: build
	@mkdir -p ~/.agents/skills
	@if [ ! -f skills/dce/_meta.json ]; then \
		echo '{"slug":"dce","version":"dev"}' > skills/dce/_meta.json; \
	fi
	@if [ -L ~/.agents/skills/dce ]; then \
		echo "skill symlink already exists"; \
	elif [ -d ~/.agents/skills/dce ]; then \
		echo "warning: ~/.agents/skills/dce is a real directory, remove it first"; \
		exit 1; \
	else \
		ln -s "$(CURDIR)/skills/dce" ~/.agents/skills/dce; \
		echo "skill symlinked: ~/.agents/skills/dce -> $(CURDIR)/skills/dce"; \
	fi
	@if command -v dce >/dev/null 2>&1 && [ "$$(which dce)" != "$(CURDIR)/bin/dce" ]; then \
		echo "note: dce in PATH is $$(which dce), not $(CURDIR)/bin/dce"; \
	fi
	cp bin/dce /usr/local/bin/dce
	@echo "done — restart opencode to pick up skill changes"

dev-clean:
	rm -f ~/.agents/skills/dce
	rm -f /usr/local/bin/dce

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
