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
- No unnecessary comments or emoji

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

## Installation

1. Run `make install` (or `make install-<name>`) from this repo to copy agents to `~/.config/opencode/agents/`
2. Add the relevant sections from this file to your own `~/.config/opencode/instructions.md`
3. For enhanced agents, also install [opencode-plugins](https://github.com/ryonsherman/opencode-plugins)
