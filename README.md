# OpenCode Prompts

Reusable agent prompts for [opencode](https://opencode.ai).

## Installation

```bash
# Install all agents
make install

# Install specific agents
make install-code-review
make install-coding-agent

# See available agents
make list

# See installed agents
make installed
```

Agents are installed to `~/.config/opencode/agents/`.

## Prompts

### Code Review

| Prompt | Description |
|--------|-------------|
| `code-review` | Code review agent. Analyzes code and outputs findings to `REVIEW.md` (never modifies source). |
| `code-review-enhanced` | Code review with plugin support. Uses memory, codebase search, git context, error journal, and decision log. |

### Coding

| Prompt | Description |
|--------|-------------|
| `coding-agent` | Coding agent. Python preferred, Node.js secondary. Follows strict coding standards. |
| `coding-agent-enhanced` | Coding agent with plugin support. Uses all 16 plugins for memory, search, task tracking, snippets, and utilities. |

## Configuration

After installing, add the relevant sections from `instructions.md` to your global instructions:

```bash
# View setup instructions
make instructions

# Or append directly
cat ./instructions.md >> ~/.config/opencode/instructions.md
```

## Enhanced Agents

The `-enhanced` versions require [opencode-plugins](https://github.com/ryonsherman/opencode-plugins):

```bash
git clone https://github.com/ryonsherman/opencode-plugins
cd opencode-plugins
make install
```

## Output Conventions

### Code Review

Reviews are written to `REVIEW.md`, `REVIEW.1.md`, `REVIEW.2.md`, etc. The agent never modifies source files.

### Coding Agent

The coding agent follows these priorities:
1. Python (preferred)
2. Node.js/TypeScript (secondary)
3. Other languages (when required)

## Uninstall

```bash
# Uninstall all agents
make uninstall

# Uninstall specific agents
make uninstall-code-review
```
