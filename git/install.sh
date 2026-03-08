#!/usr/bin/env zsh
set -euo pipefail
# Git 配置安装脚本

# Source common functions
DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
source "${DOTFILES}/script/lib.sh" 2>/dev/null || true

log_info "Configuring Git..."

# Configure credential helper
if is_macos; then
  git config --global credential.helper osxkeychain
  log_info "Set macOS credential helper (osxkeychain)"
else
  git config --global credential.helper cache
  log_info "Set credential helper (cache)"
fi

log_success "Git configured"
