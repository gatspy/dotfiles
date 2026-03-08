#!/usr/bin/env zsh
set -euo pipefail
# Hammerspoon 配置安装脚本

# Source common functions
DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
source "${DOTFILES}/script/lib.sh" 2>/dev/null || true

log_info "Installing Hammerspoon..."

# 检查 Hammerspoon 是否已安装
if [[ ! -d "/Applications/Hammerspoon.app" ]]; then
  log_warning "Hammerspoon not found, skipping configuration"
  exit 0
fi

# 创建符号链接（支持备份）
symlink_with_backup "$DOTFILES/hammerspoon" "$HOME/.hammerspoon"

log_success "Hammerspoon configured"
