# opencode-prompts

Agent prompts for the [OpenCode](https://opencode.ai) CLI agent. Installed to `~/.config/opencode/agents/`.

| Prompt | Description |
|--------|-------------|
| [api](#apimd) | API agent - designs, implements, and documents REST and GraphQL APIs |
| [api-enhanced](#api-enhancedmd) | API agent with plugins - memory, search, decisions, snippets |
| [code-review](#code-reviewmd) | Code review agent - analyzes code and outputs findings to REVIEW.md |
| [code-review-enhanced](#code-review-enhancedmd) | Code review with plugins - memory, search, git context, error/decision tracking |
| [coding-agent](#coding-agentmd) | Coding agent - Python preferred, Node.js secondary, strict standards |
| [coding-agent-enhanced](#coding-agent-enhancedmd) | Coding agent with plugins - memory, search, tasks, snippets, utilities |
| [debug](#debugmd) | Debug agent - diagnoses and fixes bugs, errors, and unexpected behavior |
| [debug-enhanced](#debug-enhancedmd) | Debug agent with plugins - memory, search, error tracking, snippets |
| [document](#documentmd) | Documentation agent - analyzes code and generates comprehensive documentation |
| [document-enhanced](#document-enhancedmd) | Documentation agent with plugins - memory, search, decisions, snippets |
| [migration](#migrationmd) | Migration agent - handles framework, language, and dependency migrations |
| [migration-enhanced](#migration-enhancedmd) | Migration agent with plugins - memory, search, decisions, snippets |
| [optimize](#optimizemd) | Optimization agent - analyzes and fixes performance/quality issues autonomously |
| [optimize-enhanced](#optimize-enhancedmd) | Optimization with plugins - memory, search, decisions, snippets |
| [refactor](#refactormd) | Refactor agent - restructures code for clarity and maintainability |
| [refactor-enhanced](#refactor-enhancedmd) | Refactor agent with plugins - memory, search, decisions, snippets |
| [security](#securitymd) | Security agent - audits code for vulnerabilities and fixes them |
| [security-enhanced](#security-enhancedmd) | Security agent with plugins - memory, search, error tracking, snippets |
| [test](#testmd) | Test agent - analyzes coverage gaps and writes tests autonomously |
| [test-enhanced](#test-enhancedmd) | Test agent with plugins - memory, search, error tracking, snippets |

## Setup

```bash
git clone git@github.com:ryonsherman/opencode-prompts.git
cd opencode-prompts
```

Install all prompts:

```bash
make install
```

Install or uninstall a specific prompt:

```bash
make install-<name>
make uninstall-<name>
```

Uninstall all prompts:

```bash
make uninstall
```

Show how to configure prompt instructions for OpenCode:

```bash
make instructions
```

Other useful commands:

```bash
make list        # List available prompts
make installed   # Show which prompts are currently installed
```

See `instructions.md` for detailed usage guidance.

## Enhanced Prompts

The `-enhanced` versions require [opencode-plugins](https://github.com/ryonsherman/opencode-plugins):

```bash
git clone git@github.com:ryonsherman/opencode-plugins.git
cd opencode-plugins
make install
```

## Prompts

### `code-review.md`

Code review agent. Analyzes code and outputs findings to `REVIEW.md` files — never modifies source code.

**Tools:**

| Tool | Enabled |
|------|---------|
| `read` | yes |
| `glob` | yes |
| `grep` | yes |
| `write` | yes (REVIEW.md only) |
| `edit` | no |
| `bash` | yes (git commands) |

**Features:**
- Reads files with `read`, `glob`, `grep`
- Uses `bash` for `git diff` and other git commands
- Writes findings to `REVIEW.md`, `REVIEW.1.md`, etc.
- Never edits source files
- Categorizes issues as Critical, Warning, or Suggestion

**Output format:**
- Stats summary (files reviewed, critical/warning/suggestion counts)
- Critical issues with file, line, code snippet, recommendation
- Warnings with file, line, code snippet, recommendation
- Suggestions for improvements
- Positive observations

### `code-review-enhanced.md`

Enhanced code review with plugin support for context-aware reviews.

**Additional tools:**

| Tool | Description |
|------|-------------|
| `git_context` | Understands branch state and recent commits |
| `git_dirty` | See modified files |
| `git_recent` | Recent commit history |
| `project_profile` | Follows project conventions |
| `codebase_search` | Finds related code and patterns |
| `error_search` | Checks for past related errors |
| `error_log` | Logs new errors found during review |
| `decision_search` | Verifies alignment with past decisions |
| `decision_log` | Records decisions identified during review |
| `memory_store` | Stores review summaries |
| `memory_retrieve` | Recalls past review patterns |
| `diff_lines` | Compares code versions |

**Additional features:**
- Gathers context before reviewing (git state, project profile, past errors/decisions)
- Checks code against project conventions
- Verifies alignment with past architectural decisions
- Stores review summaries for future reference
- Convention violations section in output
- Decision alignment section in output

### `coding-agent.md`

Coding agent for implementing features, fixing bugs, and writing code.

**Tools:**

| Tool | Enabled |
|------|---------|
| `read` | yes |
| `glob` | yes |
| `grep` | yes |
| `write` | yes |
| `edit` | yes |
| `bash` | yes |

**Language priority:**
1. Python (preferred)
2. Node.js/TypeScript (secondary)
3. Other languages (when required)

**Behavior:**
- Reads existing code before writing
- Follows existing patterns and conventions
- Runs linters and type checkers after changes
- Prefers editing existing files over creating new ones
- No unnecessary comments or emoji

**Workflow:**
1. Analyze — read request, identify files, check patterns
2. Implement — incremental changes, follow style, handle errors
3. Verify — run linter/formatter, type checker, tests
4. Report — summarize changes

### `coding-agent-enhanced.md`

Enhanced coding agent with full plugin support for memory, search, and task tracking.

**Additional tools:**

| Tool | Description |
|------|-------------|
| `git_context` | Branch state and recent commits |
| `git_dirty` | Modified files |
| `project_profile` | Auto-detect conventions |
| `project_convention_add` | Add new conventions |
| `codebase_search` | Find existing patterns |
| `memory_store` | Store implementation context |
| `memory_retrieve` | Recall past work |
| `error_search` | Check for past errors |
| `error_log` | Log new errors |
| `error_resolve` | Record fixes |
| `decision_search` | Check past decisions |
| `decision_log` | Record new decisions |
| `snippet_save` | Store reusable code |
| `snippet_search` | Find saved patterns |
| `todo_add` | Create tasks |
| `todo_update` | Update task status |
| `todo_list` | List outstanding tasks |
| `command_log` | Log significant commands |
| `regex_test` | Validate regex patterns |
| `json_validate` | Validate JSON |
| `hash` | Compute hashes |
| `math_eval` | Evaluate expressions |
| `unit_convert` | Convert units |

**Enhanced workflow:**
1. **Gather context** — `project_profile()`, `codebase_search()`, `memory_retrieve()`, `decision_search()`
2. **Plan** — `todo_add()` for multi-step tasks
3. **Implement** — Edit files, follow conventions
4. **Verify** — Run linters/tests, `command_log()` results
5. **Record** — `memory_store()`, `decision_log()`, `snippet_save()` as appropriate

### `optimize.md`

Optimization agent for analyzing and fixing performance, quality, and maintainability issues. **Fully autonomous** — analyzes, fixes, verifies, and documents without requiring another agent.

**Tools:**

| Tool | Enabled |
|------|---------|
| `read` | yes |
| `glob` | yes |
| `grep` | yes |
| `write` | yes |
| `edit` | yes |
| `bash` | yes |

**What it optimizes:**

| Category | Issues |
|----------|--------|
| Performance (Critical) | O(n²) algorithms, N+1 queries, missing memoization, memory leaks, inefficient imports |
| Performance (High) | Redundant calls, missing pagination, unoptimized regex, string concat in loops |
| Code Quality (Medium) | Duplication, long functions, deep nesting, dead code, missing types |
| Maintainability (Low) | Poor naming, magic numbers, complex conditionals |

**Behavior:**
- Analyzes code to identify optimization opportunities
- **Directly edits source files** to apply fixes
- Runs linters and tests after changes
- Documents all changes in `OPTIMIZATIONS.md`
- Prioritizes by impact: Critical > High > Medium > Low

### `optimize-enhanced.md`

Enhanced optimization agent with plugin support.

**Additional tools:**

| Tool | Description |
|------|-------------|
| `git_context` | Branch state and recent commits |
| `project_profile` | Follow project conventions |
| `codebase_search` | Find similar patterns across codebase |
| `memory_store` | Store optimization context |
| `memory_retrieve` | Recall past optimization work |
| `error_search` | Check for past performance issues |
| `decision_search` | Check past optimization decisions |
| `decision_log` | Record optimization decisions |
| `snippet_save` | Save reusable optimization patterns |
| `command_log` | Log verification results |
| `diff_lines` | Compare before/after changes |

### `test.md`

Test agent for analyzing coverage gaps and writing tests. **Fully autonomous** — analyzes, writes tests, runs them, and documents without requiring another agent.

**Tools:**

| Tool | Enabled |
|------|---------|
| `read` | yes |
| `glob` | yes |
| `grep` | yes |
| `write` | yes |
| `edit` | yes |
| `bash` | yes |

**What it tests:**

| Priority | Areas |
|----------|-------|
| Critical | Public APIs, validation, auth, payments, database ops, error handling |
| High | Business logic, state transitions, integrations, async operations |
| Medium | Utilities, helpers, configuration, caching |
| Low | Simple getters, pass-through functions |

**Behavior:**
- Analyzes code to identify test coverage gaps
- **Directly writes test files** following existing patterns
- Runs tests to verify they pass
- Documents coverage analysis in `TESTS.md`
- Prioritizes by importance: Critical > High > Medium > Low

### `test-enhanced.md`

Enhanced test agent with plugin support.

**Additional tools:**

| Tool | Description |
|------|-------------|
| `git_context` | Branch state and recent commits |
| `project_profile` | Match existing test framework and patterns |
| `codebase_search` | Find existing test patterns |
| `memory_store` | Store testing context |
| `memory_retrieve` | Recall past testing work |
| `error_search` | Find bugs that need regression tests |
| `decision_search` | Check past testing decisions |
| `decision_log` | Record testing decisions |
| `snippet_save` | Save reusable test patterns |
| `command_log` | Log test run results |

### `document.md`

Documentation agent for analyzing code and generating comprehensive documentation. **Fully autonomous** — analyzes, documents, and verifies without requiring another agent.

**Tools:**

| Tool | Enabled |
|------|---------|
| `read` | yes |
| `glob` | yes |
| `grep` | yes |
| `write` | yes |
| `edit` | yes |
| `bash` | yes |

**What it documents:**
- README files
- API documentation
- Architecture documentation
- Inline code documentation
- User guides

**Behavior:**
- Analyzes code structure and patterns
- **Directly writes documentation files**
- Follows project conventions for doc style
- Documents in `DOCUMENTATION.md` or appropriate files
- Generates OpenAPI specs for APIs when applicable

### `document-enhanced.md`

Enhanced documentation agent with plugin support.

**Additional tools:**

| Tool | Description |
|------|-------------|
| `git_context` | Branch state and recent commits |
| `project_profile` | Follow project conventions |
| `codebase_search` | Find patterns to document |
| `memory_store` | Store documentation context |
| `memory_retrieve` | Recall past documentation work |
| `decision_search` | Include relevant decisions |
| `decision_log` | Record documentation decisions |
| `snippet_save` | Save reusable doc patterns |

### `security.md`

Security agent for auditing code and fixing vulnerabilities. **Fully autonomous** — analyzes, fixes, verifies, and documents without requiring another agent.

**Tools:**

| Tool | Enabled |
|------|---------|
| `read` | yes |
| `glob` | yes |
| `grep` | yes |
| `write` | yes |
| `edit` | yes |
| `bash` | yes |

**What it audits:**

| Priority | Vulnerabilities |
|----------|-----------------|
| Critical | SQL injection, command injection, hardcoded secrets, broken auth |
| High | XSS, CSRF, insecure deserialization, path traversal |
| Medium | Missing rate limiting, weak crypto, verbose errors |
| Low | Missing security headers, outdated dependencies |

**Behavior:**
- Scans code for security vulnerabilities
- **Directly edits source files** to apply fixes
- Runs linters and tests after changes
- Documents findings and fixes in `SECURITY.md`
- Prioritizes by severity: Critical > High > Medium > Low

### `security-enhanced.md`

Enhanced security agent with plugin support.

**Additional tools:**

| Tool | Description |
|------|-------------|
| `git_context` | Branch state and recent commits |
| `project_profile` | Follow security conventions |
| `codebase_search` | Find vulnerable patterns |
| `memory_store` | Store audit context |
| `memory_retrieve` | Recall past security work |
| `error_search` | Check for past security issues |
| `error_log` | Log new vulnerabilities found |
| `decision_search` | Check past security decisions |
| `decision_log` | Record security decisions |
| `snippet_save` | Save secure coding patterns |

### `refactor.md`

Refactor agent for restructuring code without changing behavior. **Fully autonomous** — analyzes, refactors, verifies, and documents without requiring another agent.

**Tools:**

| Tool | Enabled |
|------|---------|
| `read` | yes |
| `glob` | yes |
| `grep` | yes |
| `write` | yes |
| `edit` | yes |
| `bash` | yes |

**What it refactors:**

| Impact | Refactorings |
|--------|--------------|
| High | Extract functions, remove duplication, split god classes, flatten nesting |
| Medium | Rename unclear identifiers, replace magic numbers, simplify conditionals |
| Low | Reorder functions, add early returns, organize imports |

**Behavior:**
- Analyzes code for refactoring opportunities
- **Directly edits source files** preserving behavior
- Runs tests after each change
- Documents changes in `REFACTOR.md`
- Prioritizes by impact: High > Medium > Low

### `refactor-enhanced.md`

Enhanced refactor agent with plugin support.

**Additional tools:**

| Tool | Description |
|------|-------------|
| `git_context` | Branch state and recent commits |
| `project_profile` | Follow project conventions |
| `codebase_search` | Find duplicate patterns |
| `memory_store` | Store refactoring context |
| `memory_retrieve` | Recall past refactoring work |
| `decision_search` | Check past architectural decisions |
| `decision_log` | Record refactoring decisions |
| `snippet_save` | Save refactoring patterns |
| `diff_lines` | Verify behavior unchanged |

### `migration.md`

Migration agent for handling codebase migrations. **Fully autonomous** — analyzes, migrates, verifies, and documents without requiring another agent.

**Tools:**

| Tool | Enabled |
|------|---------|
| `read` | yes |
| `glob` | yes |
| `grep` | yes |
| `write` | yes |
| `edit` | yes |
| `bash` | yes |

**Migration types:**
- Framework migrations (Express to Fastify, React class to hooks)
- Language version migrations (Python 2 to 3, Node.js upgrades)
- Dependency migrations (moment to date-fns, lodash upgrades)
- Architectural migrations (CommonJS to ES Modules, callbacks to async/await)

**Behavior:**
- Analyzes codebase for migration targets
- **Directly edits source files** with migration changes
- Runs tests after each migration step
- Documents changes in `MIGRATION.md`
- Handles deprecation warnings

### `migration-enhanced.md`

Enhanced migration agent with plugin support.

**Additional tools:**

| Tool | Description |
|------|-------------|
| `git_context` | Branch state and recent commits |
| `project_profile` | Follow project conventions |
| `codebase_search` | Find migration targets |
| `memory_store` | Store migration context |
| `memory_retrieve` | Recall past migration work |
| `decision_search` | Check past migration decisions |
| `decision_log` | Record migration decisions |
| `snippet_save` | Save migration patterns |
| `diff_lines` | Verify migration correctness |

### `debug.md`

Debug agent for diagnosing and fixing bugs. **Fully autonomous** — investigates, diagnoses, fixes, and documents without requiring another agent.

**Tools:**

| Tool | Enabled |
|------|---------|
| `read` | yes |
| `glob` | yes |
| `grep` | yes |
| `write` | yes |
| `edit` | yes |
| `bash` | yes |

**Bug patterns handled:**
- Logic errors (off-by-one, wrong operators, missing edge cases)
- Data errors (null/undefined, type mismatches)
- Async errors (race conditions, missing await)
- State errors (stale state, mutation issues)
- Integration errors (API mismatches, config errors)

**Behavior:**
- Reproduces the bug to verify it exists
- Traces stack to find root cause
- **Directly edits source files** with minimal fixes
- Runs tests to verify fix
- Documents fixes in `DEBUG.md`

### `debug-enhanced.md`

Enhanced debug agent with plugin support.

**Additional tools:**

| Tool | Description |
|------|-------------|
| `git_context` | Branch state and recent commits |
| `project_profile` | Follow project conventions |
| `codebase_search` | Find related code |
| `memory_store` | Store debugging context |
| `memory_retrieve` | Recall past debugging work |
| `error_search` | Check for past similar errors |
| `error_log` | Log new errors found |
| `error_resolve` | Record how errors were fixed |
| `decision_search` | Check past debugging decisions |
| `decision_log` | Record debugging decisions |
| `snippet_save` | Save fix patterns |

### `api.md`

API agent for designing, implementing, and documenting APIs. **Fully autonomous** — designs, implements, tests, and documents without requiring another agent.

**Tools:**

| Tool | Enabled |
|------|---------|
| `read` | yes |
| `glob` | yes |
| `grep` | yes |
| `write` | yes |
| `edit` | yes |
| `bash` | yes |

**API types:**
- REST APIs (Express, FastAPI, etc.)
- GraphQL APIs (Apollo, etc.)

**Behavior:**
- Designs endpoints following REST/GraphQL best practices
- **Directly implements route handlers** with validation
- Implements proper error handling and status codes
- Tests endpoints with curl
- Documents API in `API.md` or OpenAPI spec

### `api-enhanced.md`

Enhanced API agent with plugin support.

**Additional tools:**

| Tool | Description |
|------|-------------|
| `git_context` | Branch state and recent commits |
| `project_profile` | Follow project conventions |
| `codebase_search` | Find existing API patterns |
| `memory_store` | Store API design context |
| `memory_retrieve` | Recall past API work |
| `decision_search` | Check past API decisions |
| `decision_log` | Record API design decisions |
| `snippet_save` | Save reusable API patterns |
| `command_log` | Log curl test results |
