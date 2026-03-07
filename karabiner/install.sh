#!/usr/bin/env zsh
set -euo pipefail
# Karabiner-Elements 配置安装脚本

echo 'installing karabiner'

# 检查 Karabiner-Elements 是否已安装
if [ ! -d "/Applications/Karabiner-Elements.app" ]; then
  echo 'Karabiner-Elements not found, skipping configuration'
  exit 0
fi

# 确保 karabiner 配置目录存在
KARABINER_CONFIG="$HOME/.config/karabiner"
mkdir -p "$KARABINER_CONFIG"

# 备份现有配置
if [ -e "$KARABINER_CONFIG/karabiner.json" ]; then
  cp "$KARABINER_CONFIG/karabiner.json" "${KARABINER_CONFIG}/karabiner.json.backup.$(date +%Y%m%d%H%M%S)"
fi

# 复制配置文件
cp "$DOTFILES_ROOT/karabiner/karabiner.json" "$KARABINER_CONFIG/karabiner.json"

echo 'karabiner configured'
