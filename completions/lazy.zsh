# completions/lazy.zsh - 懒加载大型补全文件
#
# 仅在首次使用命令时加载补全，减少启动时间

# pixi 补全（5273 行，216K）
if [[ $commands[pixi] ]]; then
  pixi() {
    unfunction "$0"
    source "$DOTFILES/completions/pixi.completion.zsh"
    pixi "$@"
  }
fi

# django 补全（401 行，14K）
if [[ $commands[python] ]]; then
  _django_manager() {
    unfunction "$0"
    source "$DOTFILES/completions/django.completion.zsh"
    _django_manager "$@"
  }
fi
