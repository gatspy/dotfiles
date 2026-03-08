#!/usr/bin/env zsh
# ==========================================
# 🔍 FZF 配置 (使用 Homebrew 安装)
# ==========================================

# 1. 激活 FZF (按键绑定 Ctrl+R/Ctrl+T 与智能补全)
# 新版 fzf 原生语法，自动处理 completion 和 key-bindings
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

# 2. 引擎替换：用 fd 替换 find
# 极速、支持并行，自动忽略 .git 和 node_modules
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'

# 3. UI 配置
# --height 40%: 从下往上弹窗，不遮挡屏幕
# --layout=reverse: 输入框在最上方
# --border: 加边框
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --info=inline"
