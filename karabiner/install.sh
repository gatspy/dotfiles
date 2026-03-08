#!/usr/bin/env zsh
set -euo pipefail
# Karabiner-Elements 配置安装脚本

# Source common functions
DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
source "${DOTFILES}/script/lib.sh" 2>/dev/null || true

log_info "Installing Karabiner-Elements..."

# 检查 Karabiner-Elements 是否已安装
if [[ ! -d "/Applications/Karabiner-Elements.app" ]]; then
  log_warning "Karabiner-Elements not found, skipping configuration"
  exit 0
fi

# 确保 karabiner 配置目录存在
KARABINER_CONFIG="$HOME/.config/karabiner"
mkdir -p "$KARABINER_CONFIG"

# 备份现有配置
if [[ -e "$KARABINER_CONFIG/karabiner.json" ]]; then
  backup_file "$KARABINER_CONFIG/karabiner.json"
fi

# 复制配置文件
cp "$DOTFILES/karabiner/karabiner.json" "$KARABINER_CONFIG/karabiner.json"

log_success "Karabiner-Elements configured"
