# OpenCode Prompts — Usage Instructions

Supplement your own `~/.config/opencode/instructions.md` with the relevant sections below. These agents provide specialized prompts for code review and development. Each section applies only if the corresponding agent is installed.

---

## Code Review Agent

*If `code-review.md` is installed.*

Use this agent when reviewing code. It analyzes code and outputs findings to `REVIEW.md` files — it never modifies source code.

### When to use

- Before merging a branch
- When asked to review specific files or directories
- After completing a feature to self-review

### How to invoke

```
/review src/auth/
/review --branch feature/login
```

Or ask directly: "Review the changes in src/auth/"

### Behavior

- Reads files with `read`, `glob`, `grep`
- Uses `bash` for `git diff` and other git commands
- Writes findings to `REVIEW.md`, `REVIEW.1.md`, etc.
- Never edits source files
- Categorizes issues as Critical, Warning, or Suggestion

---

## Code Review Agent (Enhanced)

*If `code-review-enhanced.md` is installed. Requires [opencode-plugins](https://github.com/ryonsherman/opencode-plugins).*

Enhanced version with plugin support for context-aware reviews.

### Additional capabilities

- `git_context()` — Understands branch state and recent commits
- `project_profile()` — Follows project conventions
- `codebase_search()` — Finds related code and patterns
- `error_search()` — Checks for past related errors
- `decision_search()` — Verifies alignment with past decisions
- `memory_store/retrieve()` — Remembers review patterns across sessions

### When to use

Use instead of the basic `code-review` agent when you want:
- Reviews that consider past architectural decisions
- Pattern recognition across the codebase
- Memory of past review findings
- Convention enforcement from project profile

---

## Coding Agent

*If `coding-agent.md` is installed.*

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

### How to invoke

Ask directly: "Add a function to validate email addresses"

Or for complex tasks: "Implement user authentication with JWT tokens"

---

## Coding Agent (Enhanced)

*If `coding-agent-enhanced.md` is installed. Requires [opencode-plugins](https://github.com/ryonsherman/opencode-plugins).*

Enhanced version with full plugin support for memory, search, and task tracking.

### Additional capabilities

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

### When to use

Use instead of the basic `coding-agent` when you want:
- Memory of past work and decisions
- Automatic convention enforcement
- Task tracking for complex multi-step work
- Reusable snippet library
- Error tracking and pattern matching

### Workflow

The enhanced agent follows this workflow:

1. **Gather context**: `project_profile()`, `codebase_search()`, `memory_retrieve()`, `decision_search()`
2. **Plan**: `todo_add()` for multi-step tasks
3. **Implement**: Edit files, following conventions
4. **Verify**: Run linters/tests, `command_log()` results
5. **Record**: `memory_store()`, `decision_log()`, `snippet_save()` as appropriate

---

## Installation

1. Run `make install` (or `make install-<name>`) from this repo to copy agents to `~/.config/opencode/agents/`
2. Add the relevant sections from this file to your own `~/.config/opencode/instructions.md`
3. For enhanced agents, also install [opencode-plugins](https://github.com/ryonsherman/opencode-plugins)
