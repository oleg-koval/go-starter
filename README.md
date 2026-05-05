# <PROJECT_NAME>

> One-line description.

[![CI](https://github.com/oleg-koval/<PROJECT_NAME>/actions/workflows/ci.yml/badge.svg)](https://github.com/oleg-koval/<PROJECT_NAME>/actions/workflows/ci.yml)
[![Go Reference](https://pkg.go.dev/badge/github.com/oleg-koval/<PROJECT_NAME>.svg)](https://pkg.go.dev/github.com/oleg-koval/<PROJECT_NAME>)
[![Go Report](https://goreportcard.com/badge/github.com/oleg-koval/<PROJECT_NAME>)](https://goreportcard.com/report/github.com/oleg-koval/<PROJECT_NAME>)

## Install

```bash
go install github.com/oleg-koval/<PROJECT_NAME>/cmd/app@latest
```

Or as a library:

```bash
go get github.com/oleg-koval/<PROJECT_NAME>
```

## Usage

```bash
app Oleg
# Hello, Oleg!
```

```go
import "github.com/oleg-koval/<PROJECT_NAME>/internal/greet"

greet.Hello("Oleg") // "Hello, Oleg!"
```

## Development

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

## License

MIT - see [LICENSE](./LICENSE).
