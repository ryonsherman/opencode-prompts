AGENT_DIR := $(HOME)/.config/opencode/agents
PROMPTS := $(wildcard prompts/*.md)
PROMPT_NAMES := $(notdir $(basename $(PROMPTS)))

.PHONY: install uninstall list installed instructions help $(addprefix install-,$(PROMPT_NAMES)) $(addprefix uninstall-,$(PROMPT_NAMES))

help:
	@echo "Usage:"
	@echo "  make install              Install all agent prompts"
	@echo "  make install-<name>       Install a specific agent prompt"
	@echo "  make uninstall            Uninstall all agent prompts"
	@echo "  make uninstall-<name>     Uninstall a specific agent prompt"
	@echo "  make list                 List available agent prompts"
	@echo "  make installed            Show installed agent prompts"
	@echo "  make instructions         Show how to set up instructions"
	@echo ""
	@$(MAKE) --no-print-directory list

install: $(addprefix install-,$(PROMPT_NAMES))

uninstall: $(addprefix uninstall-,$(PROMPT_NAMES))

define PROMPT_RULES
install-$(1):
	@mkdir -p $(AGENT_DIR)
	@cp prompts/$(1).md $(AGENT_DIR)/$(1).md
	@echo "Installed $(1)"

uninstall-$(1):
	@rm -f $(AGENT_DIR)/$(1).md
	@echo "Uninstalled $(1)"
endef

$(foreach name,$(PROMPT_NAMES),$(eval $(call PROMPT_RULES,$(name))))

DESC_api := API agent - designs, implements, and documents REST and GraphQL APIs
DESC_api-enhanced := API agent with plugins - memory, search, decisions, snippets
DESC_code-review := Code review agent - analyzes code and outputs findings to REVIEW.md
DESC_code-review-enhanced := Code review with plugins - memory, search, git context, error/decision tracking
DESC_coding-agent := Coding agent - Python preferred, Node.js secondary, strict standards
DESC_coding-agent-enhanced := Coding agent with plugins - memory, search, tasks, snippets, utilities
DESC_debug := Debug agent - diagnoses and fixes bugs, errors, and unexpected behavior
DESC_debug-enhanced := Debug agent with plugins - memory, search, error tracking, snippets
DESC_document := Documentation agent - analyzes code and generates comprehensive documentation
DESC_document-enhanced := Documentation agent with plugins - memory, search, decisions, snippets
DESC_migration := Migration agent - handles framework, language, and dependency migrations
DESC_migration-enhanced := Migration agent with plugins - memory, search, decisions, snippets
DESC_optimize := Optimization agent - analyzes and fixes performance/quality issues autonomously
DESC_optimize-enhanced := Optimization with plugins - memory, search, decisions, snippets
DESC_refactor := Refactor agent - restructures code for clarity and maintainability
DESC_refactor-enhanced := Refactor agent with plugins - memory, search, decisions, snippets
DESC_security := Security agent - audits code for vulnerabilities and fixes them
DESC_security-enhanced := Security agent with plugins - memory, search, error tracking, snippets
DESC_test := Test agent - analyzes coverage gaps and writes tests autonomously
DESC_test-enhanced := Test agent with plugins - memory, search, error tracking, snippets

list:
	@echo "Available agent prompts:"
	@$(foreach name,$(PROMPT_NAMES),printf "  %-25s %s\n" "$(name)" "$(DESC_$(name))";)

installed:
	@echo "Installed agent prompts ($(AGENT_DIR)):"
	@found=0; $(foreach name,$(PROMPT_NAMES),if [ -f "$(AGENT_DIR)/$(name).md" ]; then printf "  %-25s %s\n" "$(name)" "$(DESC_$(name))"; found=1; fi;) if [ "$$found" = "0" ]; then echo "  (none)"; fi

instructions:
	@echo "To configure agent instructions for OpenCode:"
	@echo ""
	@echo "  1. Open your global instructions file:"
	@echo "     ~/.config/opencode/instructions.md"
	@echo ""
	@echo "  2. Append the relevant sections from this repo's instructions file:"
	@echo "     ./instructions.md"
	@echo ""
	@echo "  3. Only include sections for agents you have installed."
	@echo "     Enhanced agents require opencode-plugins to be installed."
	@echo ""
	@echo "  Example:"
	@echo "     cat ./instructions.md >> ~/.config/opencode/instructions.md"
	@echo ""
	@echo "  Or selectively copy the sections you need into your global file."
