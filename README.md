# opencode-prompts

Agent prompts for the [OpenCode](https://opencode.ai) CLI agent. Installed to `~/.config/opencode/agents/`.

| Prompt | Description |
|--------|-------------|
| [code-review](#code-reviewmd) | Code review agent - analyzes code and outputs findings to REVIEW.md |
| [code-review-enhanced](#code-review-enhancedmd) | Code review with plugins - memory, search, git context, error/decision tracking |
| [coding-agent](#coding-agentmd) | Coding agent - Python preferred, Node.js secondary, strict standards |
| [coding-agent-enhanced](#coding-agent-enhancedmd) | Coding agent with plugins - memory, search, tasks, snippets, utilities |

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

**Additional features:**
- Follows project conventions from `project_profile()`
- Tracks multi-step work with `todo_add/update`
- Stores reusable patterns to snippet library
- Logs errors and records resolutions
- Records architectural decisions
- Uses utilities (regex, json, hash, math) instead of hallucinating
