# Plugin Sync Guide

This document explains how to check for updates in [opencode-plugins](https://github.com/ryonsherman/opencode-plugins) and incorporate any new or changed plugins into the enhanced agent prompts in this repo.

## When to Run This

Run this process when:
- New plugins have been added to opencode-plugins
- Existing plugins have new tools or changed signatures
- You want to ensure prompts are using all available plugins

## Step 1: Check for Plugin Changes

```bash
# Clone or pull the latest plugins repo
cd ~/Development/opencode
git -C opencode-plugins pull || git clone git@github.com:ryonsherman/opencode-plugins.git

# List all plugin files
ls opencode-plugins/plugins/*.ts
```

## Step 2: Extract Available Tools

Each plugin exports tools. Check what tools are available:

```bash
# Show all exported tool names from each plugin
grep -h "name:" opencode-plugins/plugins/*.ts | grep -v "//" | sort -u
```

Or read individual plugin files to understand their tools:

```
opencode-plugins/plugins/
├── codebase-index.ts      → codebase_index, codebase_search, codebase_index_status, codebase_delete_index
├── command-history.ts     → command_log, command_search, command_list
├── decision-log.ts        → decision_log, decision_search, decision_list, decision_update, decision_get
├── diff-engine.ts         → diff_lines, diff_chars
├── error-journal.ts       → error_log, error_resolve, error_search, error_list, error_delete
├── git-context.ts         → git_context, git_recent, git_dirty, git_branches
├── hash-encode.ts         → hash, hmac, encode
├── json-toolkit.ts        → json_validate, json_format, json_minify, json_query
├── math-calc.ts           → math_eval, unit_convert
├── notepad.ts             → note_add, note_update, note_list, note_search, note_delete
├── project-profile.ts     → project_profile, project_scan, project_delete, project_convention_add, project_convention_remove
├── regex-tester.ts        → regex_test, regex_replace, regex_explain
├── session-memory.ts      → memory_store, memory_retrieve, memory_list, memory_delete, memory_update, memory_promote, memory_promote_session, memory_sessions, memory_tags, memory_copy, session_set_title
├── snippet-library.ts     → snippet_save, snippet_search, snippet_list, snippet_get, snippet_delete
├── task-manager.ts        → todo_add, todo_update, todo_list, todo_sync
└── time-calc.ts           → time_calc, time_diff, time_now, time_convert
```

## Step 3: Compare with Enhanced Prompts

Enhanced prompts declare their tools in the YAML frontmatter. Check what each prompt currently uses:

```bash
# Show tools declared in each enhanced prompt
for f in prompts/*-enhanced.md; do
  echo "=== $f ==="
  sed -n '/^tools:/,/^---$/p' "$f" | head -30
done
```

## Step 4: Update Prompts for New Plugins

If a new plugin was added to opencode-plugins:

### 4a. Decide Which Prompts Should Use It

Not every prompt needs every plugin. Match plugins to prompt purposes:

| Plugin | Best for |
|--------|----------|
| codebase_search | All prompts that analyze code |
| memory_store/retrieve | All enhanced prompts (context persistence) |
| decision_log/search | Prompts that make architectural choices |
| error_log/search/resolve | debug, security, test agents |
| snippet_save/search | Prompts that create reusable patterns |
| command_log | Prompts that run verification commands |
| diff_lines | Prompts that compare before/after changes |
| git_context/dirty | All prompts (understand repo state) |
| project_profile | All prompts (follow conventions) |

### 4b. Add Tool to Frontmatter

Edit the enhanced prompt's YAML frontmatter to add the new tool:

```yaml
---
description: ...
tools:
  read: true
  glob: true
  # ... existing tools ...
  new_tool_name: true    # ← Add new plugin tool
---
```

### 4c. Add Usage Instructions to Prompt Body

Add a section explaining when/how to use the new tool. Follow the existing pattern:

```markdown
### Phase N: [Relevant Phase]

Use `new_tool()` to [what it does]:
```
new_tool(param1, param2)
```
```

### 4d. Update Plugin Usage Section

Each enhanced prompt has a "Plugin Usage During [Task]" section. Add examples:

```markdown
## Plugin Usage During [Task]

### [Category]

```
new_tool("example query")    — Description of what this finds
```
```

## Step 5: Update Documentation

After updating prompts:

1. **README.md** — Add the new tool to the "Additional tools" table for affected prompts
2. **instructions.md** — Add the tool to the plugin list for affected agents
3. **Makefile** — No changes needed (auto-discovers prompt files)

## Step 6: Test

```bash
# Reinstall prompts
make install

# Verify symlinks are correct
ls -la ~/.config/opencode/agents/
```

## Example: Adding a Hypothetical "code-metrics" Plugin

If opencode-plugins adds a `code-metrics.ts` plugin with tools `metrics_analyze` and `metrics_report`:

1. **Decide scope**: This would benefit `optimize-enhanced.md`, `code-review-enhanced.md`, `refactor-enhanced.md`

2. **Update frontmatter** in each:
   ```yaml
   tools:
     # ... existing ...
     metrics_analyze: true
     metrics_report: true
   ```

3. **Add to prompt body**:
   ```markdown
   ### Phase 1: Gather Context
   
   ```
   metrics_analyze()    — Get complexity, line counts, dependency metrics
   ```
   ```

4. **Update README.md** tool tables

5. **Update instructions.md** with new tool descriptions

6. **Commit and push**:
   ```bash
   git add -A
   git commit -m "Add code-metrics plugin support to optimize, code-review, refactor agents"
   git push
   ```

## Quick Reference: Current Plugin → Prompt Mapping

| Plugin | Prompts Using It |
|--------|------------------|
| codebase_search | All enhanced |
| memory_store/retrieve | All enhanced |
| decision_log/search | All enhanced |
| error_log/search/resolve | debug-enhanced, security-enhanced, test-enhanced |
| snippet_save/search | All enhanced |
| command_log | All enhanced |
| diff_lines | optimize-enhanced, refactor-enhanced, migration-enhanced |
| git_context/dirty | All enhanced |
| project_profile | All enhanced |
