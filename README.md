# opencode-prompts

Agent prompts for [OpenCode](https://opencode.ai). Installed to `~/.config/opencode/agents/`.

## Agents

| Agent | Description |
|-------|-------------|
| `api` | Designs, implements, and documents REST and GraphQL APIs |
| `code-review` | Analyzes code and outputs findings to REVIEW.md (read-only) |
| `coding-agent` | Implements features and fixes bugs (Python preferred, Node.js secondary) |
| `debug` | Diagnoses and fixes bugs, errors, and unexpected behavior |
| `document` | Analyzes code and generates comprehensive documentation |
| `migration` | Handles framework, language, and dependency migrations |
| `optimize` | Analyzes and fixes performance/quality issues |
| `refactor` | Restructures code for clarity without changing behavior |
| `security` | Audits code for vulnerabilities and applies fixes |
| `test` | Analyzes coverage gaps and writes tests |

All agents (except `code-review`) are **fully autonomous** — they analyze, act, verify, and document without requiring another agent.

### Enhanced Versions

Each agent has an `-enhanced` version (e.g., `api-enhanced`, `debug-enhanced`) that adds plugin support for:
- **Memory** — persist context across sessions
- **Codebase search** — find patterns and related code
- **Decisions** — log and recall architectural choices
- **Snippets** — save and reuse code patterns
- **Error tracking** — log errors and resolutions

Enhanced agents require [opencode-plugins](https://github.com/ryonsherman/opencode-plugins).

## Setup

```bash
git clone git@github.com:ryonsherman/opencode-prompts.git
cd opencode-prompts
make install
```

Install or uninstall specific agents:

```bash
make install-debug
make install-debug-enhanced
make uninstall-debug
```

Other commands:

```bash
make list        # List available prompts
make installed   # Show installed prompts
make uninstall   # Uninstall all prompts
make instructions # Show how to configure instructions
```

## Enhanced Agents Setup

```bash
git clone git@github.com:ryonsherman/opencode-plugins.git
cd opencode-plugins
make install
```

Then install the enhanced prompts:

```bash
cd opencode-prompts
make install-api-enhanced
make install-debug-enhanced
# etc.
```

## Documentation

- `instructions.md` — Detailed usage guidance for each agent
- `PLUGINS.md` — Guide for syncing with opencode-plugins updates
