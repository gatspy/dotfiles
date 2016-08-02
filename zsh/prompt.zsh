autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

git_branch() {
  echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
  if $(! $git status -s &> /dev/null)
  then
    echo ""
  else
    if [[ $($git status --porcelain) == "" ]]
    then
      echo "on %{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo "on %{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
    fi
  fi
}

git_prompt_info () {
 ref=$($git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
}

unpushed () {
  $git cherry -v @{upstream} 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo " with %{$fg_bold[magenta]%}unpushed%{$reset_color%} "
  fi
}

ruby_version() {
  if (( $+commands[rbenv] ))
  then
    local rbicon=$(echo "\uf179")
    local icon1=$(echo "\uf104")
    local icon2=$(echo "\uf105")
    echo "$rbicon rb($(rbenv version | awk '{print $1}'))"
  fi

  if (( $+commands[rvm-prompt] ))
  then
    echo "$(rvm-prompt | awk '{print $1}')"
  fi
}

rb_prompt() {
  if ! [[ -z "$(ruby_version)" ]]
  then
    echo "%{$fg_bold[yellow]%}$(ruby_version)%{$reset_color%} "
  else
    echo ""
  fi
}

python_version() {
  if (( $+commands[pyenv] ))
  then
    # local version
    local pyicon=$(echo "\uf1ae")
    # version=${(@)$(pyenv version)[1]}
    echo "$pyicon $(pyenv version | awk '{print $1}')"
    # echo "$version"
  fi
}

py_prompt() {
  if ! [[ -z "$(python_version)" ]]
  then
    echo "%{$fg_bold[yellow]%}$(python_version)%{$reset_color%} "
  else
    echo ""
  fi
}

go_prompt() {
  local go_version
  # echo "$(go version | awk '{print $3}')[2:]"
  go_version=$(go version 2>/dev/null | sed -E "s/.*(go[0-9.]*).*/\1/")

  if [[ -n "$go_version" ]]; then
    "$1_prompt_segment" "$0" "$2" "green" "255" "$go_version"
  fi
}

directory_name() {
  echo "%{$fg_bold[cyan]%}%1/%{$reset_color%}"
}

export PROMPT=$'\n$(rb_prompt)in $(directory_name) $(git_dirty)$(need_push)\n› '
set_prompt () {
  export RPROMPT="%{$fg_bold[cyan]%}%{$reset_color%}"
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}
