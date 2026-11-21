#!/usr/bin/env zsh

# mise 本体由 zshrc.symlink 末尾的 `mise activate zsh --shims` 统一接管。
# （懒加载占位函数已裁撤：activate 每次启动都会接管调用，占位函数只剩误导性）

export MISE_RUSTUP_HOME=$HOME/.rustup
export MISE_CARGO_HOME=$HOME/.cargo

if command -v gh >/dev/null 2>&1 && _gh_tok="$(gh auth token 2>/dev/null)" && [ -n "$_gh_tok" ]; then
  export GITHUB_TOKEN="$_gh_tok"
fi
unset _gh_tok
