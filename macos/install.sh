#!/usr/bin/env zsh
set -euo pipefail
# macOS 系统更新脚本

# Source common functions
DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
source "${DOTFILES}/script/lib.sh" 2>/dev/null || true

log_info "Checking macOS system updates..."

# Only run on macOS
if ! is_macos; then
  log_warning "This script is only for macOS, skipping"
  exit 0
fi

log_info "To install all available macOS updates, run:"
log_info "  sudo softwareupdate -i -a"
log_warning "This may take a while and require a restart"

# Uncomment the following line to auto-install updates:
# sudo softwareupdate -i -a
