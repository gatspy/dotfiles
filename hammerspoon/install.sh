#!/bin/sh
# Hammerspoon 配置安装脚本

info 'installing hammerspoon'

# 检查 Hammerspoon 是否已安装
if [ ! -d "/Applications/Hammerspoon.app" ]; then
  warning 'Hammerspoon not found, skipping configuration'
  return
fi

# 确保 .hammerspoon 目录存在
if [ -e "$HOME/.hammerspoon" ]; then
  backup_file "$HOME/.hammerspoon"
fi

# 创建符号链接
ln -s "$DOTFILES_ROOT/hammerspoon" "$HOME/.hammerspoon"

success 'hammerspoon configured'
