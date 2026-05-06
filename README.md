# go-starter

> One-line description.

[![CI](https://github.com/oleg-koval/go-starter/actions/workflows/ci.yml/badge.svg)](https://github.com/oleg-koval/go-starter/actions/workflows/ci.yml)
[![Go Reference](https://pkg.go.dev/badge/github.com/oleg-koval/go-starter.svg)](https://pkg.go.dev/github.com/oleg-koval/go-starter)
[![Go Report](https://goreportcard.com/badge/github.com/oleg-koval/go-starter)](https://goreportcard.com/report/github.com/oleg-koval/go-starter)

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
```

```go
import "github.com/oleg-koval/go-starter/internal/greet"

greet.Hello("Oleg") // "Hello, Oleg!"
```

## Development

Requires Go 1.23+ and [golangci-lint](https://golangci-lint.run/) for linting:

```bash
# Go: https://go.dev/dl/  (or `brew install go`)
brew install golangci-lint
# or: go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
```

Then:

```bash
make test     # run tests with race detector
make lint     # golangci-lint
make cover    # generate coverage report
make build    # build binary to bin/app
```

## Layout

```
cmd/app/           # main entry point
internal/greet/    # private packages (not importable externally)
```

Following the [standard Go project layout](https://go.dev/doc/modules/layout).
Public packages would live at the repo root.

## Contributing

PRs welcome. See [CONTRIBUTING.md](./CONTRIBUTING.md) and [AGENTS.md](./AGENTS.md).

## Other starters

Part of a set with shared conventions (AGENTS.md, Conventional Commits, MIT, GitHub Actions CI, Dependabot):

- [`ts-npm-starter`](https://github.com/oleg-koval/ts-npm-starter) - TypeScript / Node
- [`py-starter`](https://github.com/oleg-koval/py-starter) - Python (uv + ruff + ty)
- [`go-starter`](https://github.com/oleg-koval/go-starter) - Go (standard layout + golangci-lint) - this repo

## License

MIT - see [LICENSE](./LICENSE).
