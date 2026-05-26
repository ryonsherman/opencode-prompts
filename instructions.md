# OpenCode Prompts — Usage Instructions

Supplement your own `~/.config/opencode/instructions.md` with the relevant sections below. These agents provide specialized prompts for code review, development, optimization, and testing. Each section applies only if the corresponding agent is installed.

---

## Code Review Agent

*If `code-review.md` or `code-review-enhanced.md` is installed.*

Use this agent when reviewing code. It analyzes code and outputs findings to `REVIEW.md` files — it never modifies source code.

### When to use

- Before merging a branch
- When asked to review specific files or directories
- After completing a feature to self-review

### Behavior

- Reads files with `read`, `glob`, `grep`
- Uses `bash` for `git diff` and other git commands
- Writes findings to `REVIEW.md`, `REVIEW.1.md`, etc.
- Never edits source files
- Categorizes issues as Critical, Warning, or Suggestion

The enhanced version (`code-review-enhanced.md`) adds plugin support:
- `git_context()` — Understands branch state and recent commits
- `project_profile()` — Follows project conventions
- `codebase_search()` — Finds related code and patterns
- `error_search()` — Checks for past related errors
- `decision_search()` — Verifies alignment with past decisions
- `memory_store/retrieve()` — Remembers review patterns across sessions

---

## Coding Agent

*If `coding-agent.md` or `coding-agent-enhanced.md` is installed.*

Use this agent for implementing features, fixing bugs, and writing code.

### Language priority

1. **Python** (preferred)
2. **Node.js/TypeScript** (secondary)
3. **Other languages** (when required)

### When to use

- Implementing new features
- Refactoring existing code
- Writing utilities or scripts
- Any code modification task

### Behavior

- Reads existing code before writing
- Follows existing patterns and conventions
- Runs linters and type checkers after changes
- Prefers editing existing files over creating new ones
- Adds helpful comments to aid human understanding of the code
- No emoji

The enhanced version (`coding-agent-enhanced.md`) adds plugin support:
- `project_profile()` — Auto-detects and follows project conventions
- `codebase_search()` — Finds existing patterns before writing
- `memory_store/retrieve()` — Remembers context across sessions
- `decision_log/search()` — Records and follows architectural decisions
- `error_log/search/resolve()` — Tracks errors and resolutions
- `snippet_save/search()` — Stores reusable code patterns
- `todo_add/update/list()` — Tracks multi-step tasks
- `command_log()` — Records significant commands
- `regex_test()` — Validates regex before using
- `json_validate()` — Validates JSON structures
- `hash()`, `math_eval()`, `unit_convert()` — Utilities (never hallucinates)

### Enhanced workflow

1. **Gather context**: `project_profile()`, `codebase_search()`, `memory_retrieve()`, `decision_search()`
2. **Plan**: `todo_add()` for multi-step tasks
3. **Implement**: Edit files, following conventions
4. **Verify**: Run linters/tests, `command_log()` results
5. **Record**: `memory_store()`, `decision_log()`, `snippet_save()` as appropriate

---

## Optimization Agent

*If `optimize.md` or `optimize-enhanced.md` is installed.*

Use this agent to analyze code for performance, quality, and maintainability issues, then apply fixes directly. This is a **fully autonomous agent** — it analyzes, fixes, verifies, and documents without requiring another agent.

### When to use

- Final optimization pass before release
- Performance tuning a slow module
- Code quality improvements
- Reducing technical debt

### Behavior

- Analyzes code for performance bottlenecks, code quality issues, and maintainability problems
- **Directly edits source files** to apply optimizations
- Runs linters and tests after changes
- Documents all changes in `OPTIMIZATIONS.md`
- Prioritizes by impact: Critical > High > Medium > Low

### What it optimizes

**Performance**: O(n²) algorithms, N+1 queries, missing memoization, memory leaks, inefficient imports
**Code Quality**: Duplication, long functions, deep nesting, dead code, missing types
**Maintainability**: Poor naming, magic numbers, complex conditionals

The enhanced version (`optimize-enhanced.md`) adds plugin support:
- `project_profile()` — Follows project conventions
- `codebase_search()` — Finds similar patterns across codebase
- `memory_store/retrieve()` — Remembers optimization patterns
- `decision_log/search()` — Records optimization decisions
- `error_search()` — Checks for past performance issues
- `snippet_save()` — Saves reusable optimization patterns
- `command_log()` — Logs verification results
- `diff_lines()` — Compares before/after changes

---

## Test Agent

*If `test.md` or `test-enhanced.md` is installed.*

Use this agent to analyze code for test coverage gaps and write comprehensive tests. This is a **fully autonomous agent** — it analyzes, writes tests, runs them, and documents without requiring another agent.

### When to use

- Adding test coverage to untested code
- Ensuring critical paths are tested
- Writing regression tests after bug fixes
- Comprehensive test pass before release

### Behavior

- Analyzes code to identify what needs testing
- **Directly writes test files** following existing patterns
- Runs tests to verify they pass
- Documents coverage analysis in `TESTS.md`
- Prioritizes by importance: Critical > High > Medium > Low

### What it tests

**Critical**: Public APIs, validation, auth, payments, database ops, error handling
**High**: Business logic, state transitions, integrations, async operations
**Medium**: Utilities, helpers, configuration, caching
**Low**: Simple getters, pass-through functions

The enhanced version (`test-enhanced.md`) adds plugin support:
- `project_profile()` — Matches existing test framework and patterns
- `codebase_search()` — Finds existing test patterns
- `memory_store/retrieve()` — Remembers testing patterns
- `decision_log/search()` — Records testing decisions
- `error_search()` — Finds bugs that need regression tests
- `snippet_save()` — Saves reusable test patterns
- `command_log()` — Logs test run results

---

## Documentation Agent

*If `document.md` or `document-enhanced.md` is installed.*

Use this agent to analyze code and generate comprehensive documentation. This is a **fully autonomous agent** — it analyzes, documents, and verifies without requiring another agent.

### When to use

- Creating README files for new projects
- Documenting APIs (REST, GraphQL)
- Writing architecture documentation
- Generating user guides

### Behavior

- Analyzes code structure and patterns
- **Directly writes documentation files**
- Follows project conventions for doc style
- Documents in `DOCUMENTATION.md` or appropriate files
- Generates OpenAPI specs for APIs when applicable

The enhanced version (`document-enhanced.md`) adds plugin support:
- `project_profile()` — Follows project conventions
- `codebase_search()` — Finds patterns to document
- `memory_store/retrieve()` — Remembers documentation patterns
- `decision_log/search()` — Includes relevant decisions
- `snippet_save()` — Saves reusable doc patterns

---

## Security Agent

*If `security.md` or `security-enhanced.md` is installed.*

Use this agent to audit code for security vulnerabilities and apply fixes. This is a **fully autonomous agent** — it analyzes, fixes, verifies, and documents without requiring another agent.

### When to use

- Security audit before deployment
- Reviewing authentication/authorization code
- Checking for common vulnerabilities (OWASP Top 10)
- Hardening sensitive code paths

### Behavior

- Scans code for security vulnerabilities
- **Directly edits source files** to apply fixes
- Runs linters and tests after changes
- Documents findings and fixes in `SECURITY.md`
- Prioritizes by severity: Critical > High > Medium > Low

### What it audits

**Critical**: SQL injection, command injection, hardcoded secrets, broken auth
**High**: XSS, CSRF, insecure deserialization, path traversal
**Medium**: Missing rate limiting, weak crypto, verbose errors
**Low**: Missing security headers, outdated dependencies

The enhanced version (`security-enhanced.md`) adds plugin support:
- `project_profile()` — Follows security conventions
- `codebase_search()` — Finds vulnerable patterns
- `memory_store/retrieve()` — Remembers audit patterns
- `error_log/search()` — Tracks security issues
- `decision_log/search()` — Records security decisions
- `snippet_save()` — Saves secure coding patterns

---

## Refactor Agent

*If `refactor.md` or `refactor-enhanced.md` is installed.*

Use this agent to restructure code for clarity and maintainability without changing behavior. This is a **fully autonomous agent** — it analyzes, refactors, verifies, and documents without requiring another agent.

### When to use

- Cleaning up code after rapid development
- Reducing technical debt
- Improving code readability
- Preparing code for new features

### Behavior

- Analyzes code for refactoring opportunities
- **Directly edits source files** preserving behavior
- Runs tests after each change
- Documents changes in `REFACTOR.md`
- Prioritizes by impact: High > Medium > Low

### What it refactors

**High Impact**: Extract functions, remove duplication, split god classes, flatten nesting
**Medium Impact**: Rename unclear identifiers, replace magic numbers, simplify conditionals
**Low Impact**: Reorder functions, add early returns, organize imports

The enhanced version (`refactor-enhanced.md`) adds plugin support:
- `project_profile()` — Follows project conventions
- `codebase_search()` — Finds duplicate patterns
- `memory_store/retrieve()` — Remembers refactoring patterns
- `decision_log/search()` — Records refactoring decisions
- `snippet_save()` — Saves refactoring patterns
- `diff_lines()` — Verifies behavior unchanged

---

## Migration Agent

*If `migration.md` or `migration-enhanced.md` is installed.*

Use this agent to handle codebase migrations. This is a **fully autonomous agent** — it analyzes, migrates, verifies, and documents without requiring another agent.

### When to use

- Upgrading framework versions (React, Django, etc.)
- Migrating language versions (Python 2→3, Node upgrades)
- Replacing dependencies (moment→date-fns)
- Architectural changes (CommonJS→ES Modules, callbacks→async/await)

### Behavior

- Analyzes codebase for migration targets
- **Directly edits source files** with migration changes
- Runs tests after each migration step
- Documents changes in `MIGRATION.md`
- Handles deprecation warnings

The enhanced version (`migration-enhanced.md`) adds plugin support:
- `project_profile()` — Follows project conventions
- `codebase_search()` — Finds migration targets
- `memory_store/retrieve()` — Remembers migration patterns
- `decision_log/search()` — Records migration decisions
- `snippet_save()` — Saves migration patterns
- `diff_lines()` — Verifies migration correctness

---

## Debug Agent

*If `debug.md` or `debug-enhanced.md` is installed.*

Use this agent to diagnose and fix bugs. This is a **fully autonomous agent** — it investigates, diagnoses, fixes, and documents without requiring another agent.

### When to use

- Tracking down elusive bugs
- Debugging error messages or stack traces
- Fixing race conditions or async issues
- Resolving null/undefined errors

### Behavior

- Reproduces the bug to verify it exists
- Traces stack to find root cause
- **Directly edits source files** with minimal fixes
- Runs tests to verify fix
- Documents fixes in `DEBUG.md`

### Bug patterns handled

**Logic errors**: Off-by-one, wrong operators, missing edge cases
**Data errors**: Null/undefined, type mismatches
**Async errors**: Race conditions, missing await
**State errors**: Stale state, mutation issues
**Integration errors**: API mismatches, config errors

The enhanced version (`debug-enhanced.md`) adds plugin support:
- `project_profile()` — Follows project conventions
- `codebase_search()` — Finds related code
- `memory_store/retrieve()` — Remembers debugging patterns
- `error_log/search/resolve()` — Tracks and resolves errors
- `decision_log/search()` — Records debugging decisions
- `snippet_save()` — Saves fix patterns

---

## API Agent

*If `api.md` or `api-enhanced.md` is installed.*

Use this agent to design, implement, and document APIs. This is a **fully autonomous agent** — it designs, implements, tests, and documents without requiring another agent.

### When to use

- Creating new REST or GraphQL APIs
- Adding endpoints to existing APIs
- Documenting API contracts
- Implementing proper error handling

### Behavior

- Designs endpoints following REST/GraphQL best practices
- **Directly implements route handlers** with validation
- Implements proper error handling and status codes
- Tests endpoints with curl
- Documents API in `API.md` or OpenAPI spec

### API types

- REST APIs (Express, FastAPI, etc.)
- GraphQL APIs (Apollo, etc.)

The enhanced version (`api-enhanced.md`) adds plugin support:
- `project_profile()` — Follows project conventions
- `codebase_search()` — Finds existing API patterns
- `memory_store/retrieve()` — Remembers API patterns
- `decision_log/search()` — Records API design decisions
- `snippet_save()` — Saves reusable API patterns
- `command_log()` — Logs curl test results

---

## Installation

1. Run `make install` (or `make install-<name>`) from this repo to copy agents to `~/.config/opencode/agents/`
2. Add the relevant sections from this file to your own `~/.config/opencode/instructions.md`
3. For enhanced agents, also install [opencode-plugins](https://github.com/ryonsherman/opencode-plugins)
