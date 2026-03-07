#!/usr/bin/env zsh
set -euo pipefail
# Hammerspoon 配置安装脚本

info 'installing hammerspoon' || echo 'installing hammerspoon'

# 检查 Hammerspoon 是否已安装
if [ ! -d "/Applications/Hammerspoon.app" ]; then
  echo 'Hammerspoon not found, skipping configuration'
  exit 0
fi

# 确保 .hammerspoon 目录不存在
if [ -e "$HOME/.hammerspoon" ]; then
  echo "Warning: $HOME/.hammerspoon exists, skipping"
  exit 0
fi

# 创建符号链接
ln -s "$DOTFILES_ROOT/hammerspoon" "$HOME/.hammerspoon"

echo 'hammerspoon configured'
