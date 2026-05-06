# Plan: Enforce Hard Rules — go-starter

## Context

`go-starter` uses the standard Go layout (`cmd/`, `internal/`), golangci-lint with a solid
linter set (revive, govet, staticcheck, gosec, etc.), and a Makefile with `make lint/test/fmt`
targets. CI runs `go test` and `golangci-lint` on Go 1.23 and 1.24. What's missing is **local
enforcement** — nothing blocks a bad commit locally — and the 300-line cap is not checked by
any linter or script.

Source: [oleg-koval/RULES.md §2](https://github.com/oleg-koval/starters/blob/main/RULES.md)

---

## Gaps

| Rule | Current state | Gap |
|------|--------------|-----|
| §2.2 File length 300-line cap | Not in golangci-lint config | Add `revive` `file-length-limit` rule |
| §2.4 Pre-commit hooks | Not configured (CI-only) | Add `.pre-commit-config.yaml` |
| §2.3 E2E > unit | Only unit tests, no guidance | Add E2E guidance to AGENTS.md |

---

## Changes

### 1. `.golangci.yml` — add `file-length-limit` via revive

`revive` (already enabled) supports the `file-length-limit` rule. Add it to the `revive`
settings block:

```diff
 linters:
   settings:
     revive:
       rules:
         - name: exported
           severity: warning
+        - name: file-length-limit
+          arguments:
+            - maxLines: 300
+          severity: error
```

This causes `golangci-lint` (and therefore `make lint`) to error on any `.go` file exceeding
300 lines. Generated files (protobuf, mock stubs) should be excluded via:

```yaml
exclusions:
  rules:
    - path: _test\.go
      linters:
        - gosec
+   - path: ".*\\.pb\\.go"
+     linters:
+       - revive
+   - path: ".*_gen\\.go"
+     linters:
+       - revive
```

### 2. Create `.pre-commit-config.yaml`

Uses `pre-commit` framework (installable via `brew install pre-commit` or `pip install pre-commit`).
Delegates to the existing Makefile targets so no logic is duplicated.

```yaml
repos:
  - repo: local
    hooks:
      - id: go-fmt
        name: go fmt
        language: system
        entry: bash -c 'make fmt && git diff --exit-code'
        pass_filenames: false
        types: [go]

      - id: go-lint
        name: golangci-lint
        language: system
        entry: make lint
        pass_filenames: false
        types: [go]

      - id: go-test
        name: go test
        language: system
        entry: make test
        pass_filenames: false
        types: [go]
```

> Using `local` hooks (shell/Makefile) keeps the config simple and avoids version pinning
> of the golangci-lint hook (which can lag behind the installed binary).

### 3. `Makefile` — add `hooks` target

Add an install target so contributors can set up hooks with one command:

```makefile
hooks:
	pre-commit install

.PHONY: build test lint fmt cover tidy run clean hooks
```

### 4. `AGENTS.md` — add pre-commit and E2E sections

Add after "Commands":

```markdown
## Pre-commit hooks

Requires `pre-commit` (`brew install pre-commit`). Install once:

```bash
make hooks
```

Hooks run `make fmt`, `make lint`, and `make test` on every commit. Skip is
discouraged (`git commit --no-verify`) — CI enforces the same gates.

## Test strategy

Prefer integration tests that exercise the full call path (HTTP handler →
service → storage). Unit-test only pure functions with non-trivial branching
(parsers, validators). Avoid mocking internal collaborators.
```

---

## Files changed

| File | Change |
|------|--------|
| `.golangci.yml` | Add `revive` `file-length-limit: 300` rule + generated-file exclusions |
| `.pre-commit-config.yaml` | Create — gates for fmt / lint / test via Makefile |
| `Makefile` | Add `hooks` target, update `.PHONY` |
| `AGENTS.md` | Add pre-commit section + test strategy |

---

## Verification

```bash
# 1. Install hooks
make hooks

# 2. Verify hook fires on a long file
python3 -c "print('\n'.join(['// line ' + str(i) for i in range(305)]))" > /tmp/toobig.go
cp /tmp/toobig.go internal/greet/toobig.go
make lint  # should error: file-length-limit

rm internal/greet/toobig.go

# 3. Verify clean commit passes hooks
git add -A && git commit -m "test: verify hooks pass"

# 4. CI matrix (Go 1.23 + 1.24) should still pass
# Push to a branch and verify GitHub Actions green
```
