#!/bin/zsh
# PURE_CMD_MAX_EXEC_TIME=1
# PURE_PROMPT_SYMBOL="λ"

DISABLE_AUTO_TITLE="true"
PR_TITLEBAR=''

set_tab_title() {
  # sets the tab title to current dir
  echo -ne "\e]1;${PWD##*/}\a"
}

set-window-title() {
  # window_title="\e]0;${${PWD/#"$HOME"/~}/projects/p}\a"
  window_title="\e]0;${PWD/#"$HOME"/~}\a"
  echo -ne "$window_title"
}

set-window-title
add-zsh-hook precmd set-window-title
set_tab_title
add-zsh-hook precmd set_tab_title
