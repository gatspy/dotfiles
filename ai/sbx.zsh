#!/bin/zsh
# Docker Sandboxes (sbx) — 让 agent 默认在隔离的工作区里干活
#
#   sbx-task <claude|codex> [-- agent 参数]   一次性任务：私有 clone，宿主仓库只读
#   sbx-work <claude|codex> [-- agent 参数]   长会话：直接挂载当前工作区，改动即时可见
#   sbx-take <sandbox>                        把 task 沙箱里的提交 fetch 回宿主
#
# 顺序很重要：sbx rm / sbx prune 会连 clone 里的提交一起删掉。
#   sbx-task → sbx-take → 合并 → sbx rm
# 没 take 就 prune，等于把 agent 一晚上的活扔了。

_sbx_require() {
  if ! (( $+commands[sbx] )); then
    print -u2 "$1: 找不到 sbx，检查 ~/.local/bin 是否在 PATH"
    return 1
  fi
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    print -u2 "$1: 需要在 git 仓库内运行"
    return 1
  fi
}

# 沙箱名只允许字母、数字、连字符和点，统一从仓库名派生，避免大小写和中文路径
_sbx_name() {
  local agent=$1 suffix=$2 repo
  repo=$(basename "$(git rev-parse --show-toplevel 2>/dev/null)" 2>/dev/null) || repo=repo
  repo=${repo:l}
  repo=${repo//[^a-z0-9.-]/-}
  print -r -- "${agent}-${repo}-${suffix}"
}

# 用全局数组而不是命令替换，避免名字里有空格时被拆开
_sbx_git_env() {
  local name email
  name=$(git config user.name 2>/dev/null)
  email=$(git config user.email 2>/dev/null)
  typeset -ga _sbx_env
  _sbx_env=(
    -e "GIT_AUTHOR_NAME=${name:-agent}"
    -e "GIT_AUTHOR_EMAIL=${email:-agent@localhost}"
    -e "GIT_COMMITTER_NAME=${name:-agent}"
    -e "GIT_COMMITTER_EMAIL=${email:-agent@localhost}"
  )
}

# 把宿主的 Claude provider 配置带进沙箱的 ~/.claude/settings.json
# 只取 env 段：宿主上的 hooks / statusLine 在沙箱里没有对应程序，带进去只会报错。
# 注意：token 会留在沙箱文件系统里；不要把这种沙箱 template save 成模板。
_sbx_seed_claude() {
  local name=$1 src=$HOME/.claude/settings.json
  [[ -f $src ]] || return 0

  if ! (( $+commands[jq] )); then
    print -u2 "sbx: 需要 jq 来提取 settings.json 的 env 段"
    return 1
  fi

  local tmp home rc
  tmp=$(mktemp "${TMPDIR:-/tmp}/sbx-claude.XXXXXX") || return 1
  chmod 600 "$tmp"
  if ! jq '{env: .env}' "$src" > "$tmp"; then
    print -u2 "sbx: 解析 $src 失败"
    rm -f "$tmp"
    return 1
  fi

  home=$(sbx exec "$name" sh -c 'printf %s "$HOME"' 2>/dev/null)
  if [[ -z $home ]]; then
    print -u2 "sbx: 取不到沙箱内的 HOME"
    rm -f "$tmp"
    return 1
  fi

  sbx exec "$name" sh -c 'mkdir -p "$HOME/.claude"' >/dev/null 2>&1
  sbx cp "$tmp" "$name:$home/.claude/settings.json" >/dev/null
  rc=$?
  rm -f "$tmp"

  if (( rc != 0 )); then
    print -u2 "sbx: settings.json 注入失败，claude 会回落到默认 API"
  fi
  return $rc
}

sbx-task() {
  local agent=${1:-claude}
  (( $# )) && shift
  _sbx_require sbx-task || return 1

  # clone 只复制已提交的历史，未提交的改动在沙箱里看不见
  if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
    print -u2 "sbx-task: 工作区有未提交改动，clone 模式看不到。先 commit，或改用 sbx-work。"
    return 1
  fi

  local name
  name=$(_sbx_name "$agent" "$(date +%H%M%S)")
  print -r -- "sandbox: $name"

  _sbx_git_env
  sbx run "$agent" --name "$name" --clone -m 8g -d \
    "${_sbx_env[@]}" >/dev/null || return 1

  _sbx_seed_claude "$name" || return 1

  sbx run --name "$name" -- "$@"

  print -r -- ""
  print -r -- "取回改动: sbx-take $name"
  print -r -- "合并之后: sbx rm $name"
}

sbx-work() {
  local agent=${1:-claude}
  (( $# )) && shift
  _sbx_require sbx-work || return 1

  local name
  name=$(_sbx_name "$agent" work)
  print -r -- "sandbox: $name"

  # 直接挂载：agent 的改动立刻出现在你的工作区，适合边看边改
  _sbx_git_env
  sbx run "$agent" --name "$name" -m 8g -d \
    "${_sbx_env[@]}" >/dev/null || return 1

  _sbx_seed_claude "$name" || return 1

  sbx run --name "$name" -- "$@"
}

sbx-take() {
  local name=${1:?用法: sbx-take <sandbox-name>}
  if ! git fetch "sandbox-$name" 2>/dev/null; then
    print -u2 "sbx-take: fetch sandbox-$name 失败，沙箱可能已删除或未创建"
    return 1
  fi
  print -r -- "已取回，分支如下："
  git for-each-ref --format='  %(refname:short)' "refs/remotes/sandbox-$name/" 2>/dev/null
  print -r -- ""
  print -r -- "对比: git diff HEAD..sandbox-$name/<branch>"
}

alias sbxl='sbx ls'
alias sbxrm='sbx rm'