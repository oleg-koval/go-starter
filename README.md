# go-starter

> Opinionated Go project starter — standard layout, golangci-lint, pre-commit hooks, GoReleaser.

[![CI](https://github.com/oleg-koval/go-starter/actions/workflows/ci.yml/badge.svg)](https://github.com/oleg-koval/go-starter/actions/workflows/ci.yml)
[![Go Reference](https://pkg.go.dev/badge/github.com/oleg-koval/go-starter.svg)](https://pkg.go.dev/github.com/oleg-koval/go-starter)
[![Go Report](https://goreportcard.com/badge/github.com/oleg-koval/go-starter)](https://goreportcard.com/report/github.com/oleg-koval/go-starter)
[![codecov](https://codecov.io/gh/oleg-koval/go-starter/branch/main/graph/badge.svg)](https://codecov.io/gh/oleg-koval/go-starter)

## Install

```bash
go install github.com/oleg-koval/go-starter/cmd/app@latest
```

Or as a library:

```bash
go get github.com/oleg-koval/go-starter
```

## Usage

```bash
app Oleg
# Hello, Oleg!

app version
# app v1.2.3 (abc1234) built 2026-05-22T17:00:00Z
```

```go
import "github.com/oleg-koval/go-starter/internal/greet"

greet.Hello("Oleg") // "Hello, Oleg!"
```

## Development

Requires Go 1.24+ and [golangci-lint](https://golangci-lint.run/):

```bash
brew install go golangci-lint
# or: go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
```

Then:

```bash
make hooks    # install pre-commit hooks (once)
make test     # run tests with race detector
make lint     # golangci-lint
make cover    # generate coverage report → coverage.html
make build    # build binary to bin/app (with version injection)
```

## Layout

```
cmd/app/           # main binary
internal/greet/    # private packages (not importable externally)
```

Following the [standard Go project layout](https://go.dev/doc/modules/layout).
Public packages live at the repo root when intentional.

## Releasing

Releases are automated via [GoReleaser](https://goreleaser.com/) on tag push:

```bash
git tag v1.0.0
git push origin v1.0.0
```

GitHub Actions builds cross-platform binaries (linux/darwin/windows, amd64/arm64),
creates a GitHub release, and attaches checksums. To dry-run locally:

```bash
make release-dry
```

## CI

| Check | Tool |
|-------|------|
| Tests (Go 1.23 + 1.24) | `go test -race` |
| Lint | golangci-lint |
| Coverage | Codecov |
| Releases | GoReleaser |
| Dependencies | Dependabot (weekly) |

## Contributing

PRs welcome. See [CONTRIBUTING.md](./CONTRIBUTING.md) and [AGENTS.md](./AGENTS.md).

## Other starters

Part of a set with shared conventions (AGENTS.md, Conventional Commits, MIT, GitHub Actions CI, Dependabot):

- [`ts-npm-starter`](https://github.com/oleg-koval/ts-npm-starter) - TypeScript / Node
- [`py-starter`](https://github.com/oleg-koval/py-starter) - Python (uv + ruff + ty)
- [`go-starter`](https://github.com/oleg-koval/go-starter) - Go (this repo)

## License

MIT - see [LICENSE](./LICENSE).
