STOW_DIR  := $(CURDIR)
TARGET    := $(HOME)
STOW      := stow -v -t $(TARGET) -d $(STOW_DIR)

PACKAGES  := aerospace claude ghostty nvim zsh

BREW_TAPS := neurosnap/tap
BREW_DEPS := stow zmx

TARGETS_aerospace := $(HOME)/.config/aerospace/aerospace.toml
TARGETS_claude    := $(HOME)/.claude/CLAUDE.md \
		     $(HOME)/.claude/settings.json \
                     $(HOME)/.claude/statusline-command.sh \
                     $(HOME)/.claude/commands/pr.md
TARGETS_ghostty   := $(HOME)/.config/ghostty
TARGETS_nvim      := $(HOME)/.config/nvim
TARGETS_zsh       := $(HOME)/.zshrc

.PHONY: install uninstall install-deps check-brew \
	$(addprefix install-,$(PACKAGES)) \
	$(addprefix uninstall-,$(PACKAGES))

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

install-%: install-deps
	$(call confirm,This will override existing configuration for $(patsubst install-%,%,$@).)
	rm -rf $(TARGETS_$(patsubst install-%,%,$@))
	$(STOW) --restow $(patsubst install-%,%,$@)

uninstall-%:
	$(call confirm,This will remove symlinks for $(patsubst uninstall-%,%,$@).)
	$(STOW) -D $(patsubst uninstall-%,%,$@)

install-deps: check-brew
	@for tap in $(BREW_TAPS); do \
		brew tap $$tap 2>/dev/null; \
	done
	@for dep in $(BREW_DEPS); do \
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
