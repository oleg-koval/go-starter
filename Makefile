.PHONY: build test lint fmt cover tidy run clean hooks release-dry

BINARY  := bin/app
PKG     := ./...
VERSION := $(shell git describe --tags --always --dirty 2>/dev/null || echo "dev")
COMMIT  := $(shell git rev-parse --short HEAD 2>/dev/null || echo "none")
DATE    := $(shell date -u +%Y-%m-%dT%H:%M:%SZ)
LDFLAGS := -s -w -X main.version=$(VERSION) -X main.commit=$(COMMIT) -X main.date=$(DATE)

build:
	go build -ldflags "$(LDFLAGS)" -o $(BINARY) ./cmd/app

run:
	go run ./cmd/app

test:
	go test -race -count=1 $(PKG)

cover:
	go test -race -coverprofile=coverage.out $(PKG)
	go tool cover -html=coverage.out -o coverage.html
	@echo "Coverage report: coverage.html"

lint:
	golangci-lint run $(PKG)

fmt:
	go fmt $(PKG)
	gofmt -s -w .

tidy:
	go mod tidy

clean:
	rm -rf bin/ coverage.out coverage.html

hooks:
	pre-commit install

release-dry:
	goreleaser release --snapshot --clean
