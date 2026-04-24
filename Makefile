STOW_DIR  := $(CURDIR)
TARGET    := $(HOME)
STOW      := stow -v -t $(TARGET) -d $(STOW_DIR)

PACKAGES  := aerospace claude ghostty nvim zsh

BREW_TAPS := neurosnap/tap
BREW_DEPS := stow zmx

BREW_DEPS_nvim := tree-sitter-cli
BREW_DEPS_zsh  := eza

TARGETS_aerospace := $(HOME)/.config/aerospace/aerospace.toml
TARGETS_claude    := $(HOME)/.claude/CLAUDE.md \
		     $(HOME)/.claude/settings.json \
                     $(HOME)/.claude/statusline-command.sh \
                     $(HOME)/.claude/commands/pr.md
TARGETS_ghostty   := $(HOME)/.config/ghostty
TARGETS_nvim      := $(HOME)/.config/nvim
TARGETS_zsh       := $(HOME)/.zshrc

.PHONY: install uninstall install-deps check-brew

define confirm
@printf "$(1) [y/N] "; \
read ans; \
[ "$$ans" = y ] || [ "$$ans" = Y ] || { echo "Aborted."; exit 1; }
endef

install: install-deps
	$(call confirm,This will override existing configuration for all packages.)
	rm -rf $(foreach pkg,$(PACKAGES),$(TARGETS_$(pkg)))
	$(STOW) --restow $(PACKAGES)

uninstall:
	$(call confirm,This will remove all package symlinks.)
	$(STOW) -D $(PACKAGES)

install-%: check-brew
	$(call confirm,This will override existing configuration for $(patsubst install-%,%,$@).)
	@for dep in $(BREW_DEPS) $(BREW_DEPS_$(patsubst install-%,%,$@)); do \
		if ! brew list --formula $$dep &>/dev/null; then \
			echo "Installing $$dep..."; \
			brew install $$dep; \
		else \
			echo "$$dep already installed."; \
		fi; \
	done
	rm -rf $(TARGETS_$(patsubst install-%,%,$@))
	$(STOW) --restow $(patsubst install-%,%,$@)

uninstall-%:
	$(call confirm,This will remove symlinks for $(patsubst uninstall-%,%,$@).)
	$(STOW) -D $(patsubst uninstall-%,%,$@)

install-deps: check-brew
	@for tap in $(BREW_TAPS); do \
		brew tap $$tap 2>/dev/null; \
	done
	@for dep in $(BREW_DEPS) $(foreach pkg,$(PACKAGES),$(BREW_DEPS_$(pkg))); do \
		if ! brew list --formula $$dep &>/dev/null; then \
			echo "Installing $$dep..."; \
			brew install $$dep; \
		else \
			echo "$$dep already installed."; \
		fi; \
	done

check-brew:
	@if ! command -v brew >/dev/null 2>&1; then \
		echo "Homebrew is required. Install it from https://brew.sh and try again."; \
		exit 1; \
	fi
