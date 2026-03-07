#!/bin/sh
# Karabiner-Elements 配置安装脚本

info 'installing karabiner'

# 检查 Karabiner-Elements 是否已安装
if [ ! -d "/Applications/Karabiner-Elements.app" ]; then
  warning 'Karabiner-Elements not found, skipping configuration'
  return
fi

# 确保 karabiner 配置目录存在
KARABINER_CONFIG="$HOME/.config/karabiner"
mkdir -p "$KARABINER_CONFIG"

# 备份现有配置
if [ -e "$KARABINER_CONFIG/karabiner.json" ]; then
  backup_file "$KARABINER_CONFIG/karabiner.json"
fi

# 复制配置文件
cp "$DOTFILES_ROOT/karabiner/karabiner.json" "$KARABINER_CONFIG/karabiner.json"

success 'karabiner configured'
