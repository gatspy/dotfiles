# The rest of my fun git aliases
alias gl='git pull --prune'

alias glg="git log --graph --decorate --oneline --abbrev-commit"
# alias glgs="git log --oneline --all --graph --decorate  $(git reflog | awk '{print $1}')"
alias glga="glg --all"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"

alias gp='git push origin HEAD'
alias gpa='git push origin --all'
alias gd='git diff'

alias gco='git checkout'
alias gb='git branch -v'
alias gcb='git copy-branch-name'
alias gcl='git clone'

alias ga='git add'
alias gaa='git add -A'
# alias gac='git add -A && git commit'
alias gacm='git add -A && git commit -m'

alias gc='git commit'
alias gcm='git commit -m'
# alias gca='git commit -a'
alias gcam='git commit -a -m'

alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.

# show all can not push commits
alias gall='git log --oneline @{u}..'

gi() {
    curl -s "https://www.gitignore.io/api/$*"
}

git() {
  if [[ "$1" == "clone" && "$2" =~ ^[a-zA-Z0-9_-]+/[a-zA-Z0-9_.-]+$ ]]; then
    # 极客魔法：无论用户有没有输入 .git 后缀，这里强制把它剥离掉
    local clean_repo="${2%.git}"
    echo "🚀 自动拼接 GitHub SSH 链接..."

    # 统一用最干净的格式拼装最终的 SSH 地址
    command git clone "git@github.com:${clean_repo}.git" "${@:3}"
  else
    command git "$@"
  fi
}
