# AGENTS.md

Instructions for AI coding agents (Claude Code, Codex, Cursor, Copilot).

## Setup

Requires Go 1.23+ and [golangci-lint](https://golangci-lint.run/). If missing:

```bash
brew install go golangci-lint
# or: go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
```

Then:

```bash
go mod tidy
```

## Pre-commit hooks

Requires `pre-commit` (`brew install pre-commit` or `pip install pre-commit`).
Install once:

```bash
make hooks
```

Hooks run `make fmt`, `make lint`, `make test`, and a 300-line file-length check
on every commit. `git commit --no-verify` is rejected in code review.

## Commands

- Run tests: `make test` (or `go test -race ./...`)
- Lint: `make lint` (requires `golangci-lint`)
- Format: `make fmt`
- Build binary: `make build`
- Coverage: `make cover`

CI runs `make test` and `make lint`. Both must pass.

## Conventions

- Go 1.23+. Use modern features: range-over-func, generics where they help.
- Standard layout: `cmd/<name>/main.go` for binaries, `internal/` for
  private packages. Public packages at repo root only when intentional.
- Errors: wrap with `fmt.Errorf("context: %w", err)`. Use `errors.Is` /
  `errors.As` for inspection.
- Tests: prefer integration tests that exercise the full call path. Unit-test only
  pure functions with non-trivial branching. Table-driven tests with `t.Run` for subtests.
- Exported identifiers must have a doc comment starting with the name.
- No `panic` outside `main` or `init` unless documented as the contract.

## Don't

- Don't add dependencies without discussion. Stdlib first.
- Don't commit without `make test` and `make lint` passing.
- Don't ignore errors. If you must, name the variable `_` and add a comment.
- Don't use `interface{}`; use `any`.
