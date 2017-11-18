# Use `hub` as our git wrapper:
#   http://defunkt.github.com/hub/
hub_path=$(which hub)
if (( $+commands[hub] ))
then
  alias git=$hub_path
fi

# The rest of my fun git aliases
alias gl='git pull --prune'
alias glg="git log --graph --decorate --oneline --abbrev-commit"
alias glga="glg --all"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp='git push origin HEAD'
alias gpa='git push origin --all'
alias gd='git diff'

alias gco='git checkout'
alias gb='git branch -v'
alias gcb='git copy-branch-name'
alias gcl='git clone'

alias ga='git add'
alias gaa='git add -A'
alias gac='git add -A && git commit'
alias gacm='git add -A && git commit -m'

alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit -a'
alias gcam='git commit -a -m'

alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.


gi() {
    curl -s "https://www.gitignore.io/api/$*"
}
