#!/bin/zsh
# Docker Sandboxes (sbx) 补全
# 补全脚本随 app bundle 发布，不复制一份，避免版本错位。
# 手装在 ~/Applications，brew cask 在 /Applications，两个位置都探一下。

_sbx_comp_dir=""
for _sbx_candidate in \
  "$HOME/Applications/Sbx.app/Contents/Resources/completions/zsh" \
  "/Applications/Sbx.app/Contents/Resources/completions/zsh"; do
  if [[ -d $_sbx_candidate ]]; then
    _sbx_comp_dir=$_sbx_candidate
    break
  fi
done

if [[ -n $_sbx_comp_dir ]]; then
  fpath=($_sbx_comp_dir $fpath)
  autoload -Uz _sbx
  compdef _sbx sbx
fi

unset _sbx_comp_dir _sbx_candidate