.PHONY: build test lint fmt cover tidy run clean hooks

BINARY := bin/app
PKG := ./...

build:
	go build -o $(BINARY) ./cmd/app

run:
	go run ./cmd/app

test:
	go test -race -count=1 $(PKG)

cover:
	go test -race -coverprofile=coverage.out $(PKG)
	go tool cover -html=coverage.out -o coverage.html

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
