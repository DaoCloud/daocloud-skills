# ---- build stage ----
FROM --platform=$BUILDPLATFORM docker.m.daocloud.io/library/golang:1.25.7 AS builder

ARG TARGETOS
ARG TARGETARCH
ARG VERSION=dev
ARG COMMIT=none

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH \
    make build BIN_OUT=/out/dc VERSION=$VERSION COMMIT=$COMMIT

# ---- runtime stage ----
FROM docker.m.daocloud.io/library/alpine:3.21

RUN apk add --no-cache ca-certificates

COPY --from=builder /out/dc /app/dc
COPY skills/dc /app/skills/dc

WORKDIR /app
ENTRYPOINT ["/app/dc"]
