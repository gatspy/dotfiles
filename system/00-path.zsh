#!/usr/bin/env zsh

# =============================================================================
# 统一 PATH 配置
# 所有 PATH 设置集中在此处，使用 typeset -U 自动去重
# =============================================================================

typeset -U path manpath

# Homebrew prefix is arch-dependent (/usr/local on Intel, /opt/homebrew on Apple
# Silicon). zshrc exports HOMEBREW_PREFIX before the path phase loads this file.
brew_prefix=${HOMEBREW_PREFIX:-/usr/local}

# 核心工具路径（按优先级）
path=(
  "$DOTFILES/bin"
  "${HOME}/.local/bin"
  "${brew_prefix}/bin"
  "${brew_prefix}/sbin"
  "${HOME}/.antigravity/antigravity/bin"(N)
  "$ANDROID_HOME/platform-tools"(N)
  "$ANDROID_CMD_TOOL/bin"(N)
  "$ANDROID_HOME/build-tools/34.0.0"(N)
  "$ANDROID_EMULATOR_HOME"(N)
  "$ANDROID_NDK_ROOT/prebuilt/${ndk_arch:-darwin-x86_64}/bin"(N)
  "$M2HOME/bin"(N)
  "$QT_QMAKE_DIR"(N)
  "$BUN_INSTALL/bin"(N)
  "${brew_prefix}/opt/openssl@3/bin"(N)
  "$path[@]"
)

# MANPATH
manpath=(
  "/usr/local/man"
  "/usr/local/mysql/man"
  "/usr/local/git/man"
  "$manpath[@]"
)

# FZF PATH (if fzf is found elsewhere, it will be added by fzf/init.zsh)
# Flutter/Dart pub cache (added by fvm.zsh if needed)
