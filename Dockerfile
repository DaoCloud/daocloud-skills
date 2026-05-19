# ---- build stage ----
FROM --platform=$BUILDPLATFORM docker.m.daocloud.io/library/golang:1.25.7 AS builder

ARG TARGETOS
ARG TARGETARCH

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH \
    go build -trimpath -o bin/dc ./cmd/dc

# ---- runtime stage ----
FROM docker.m.daocloud.io/library/alpine:3.21

RUN apk add --no-cache ca-certificates

COPY --from=builder /src/bin/dc /app/dc
COPY skills/dc /app/skills/dc
