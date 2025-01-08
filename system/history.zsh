#关于历史纪录的配置 {{{

#历史记录文件
HISTFILE="$HOME/.zsh_history"
#历史记录条目数量
HISTSIZE=500000
#注销后保存的历史纪录条目数量
SAVEHIST=$HISTSIZE

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
#历史记录中的命令添加时间戳
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
#增量的方式立即添加到 $HISTFILE
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
#共享历史记录
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
#如果连续输入的命令相同，历史纪录中只保留一个
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
#不保留重复的历史记录项
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
#命令前添加空格，不将此命令添加到文件中
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.


HISTORY_IGNORE="(l|l *|ls|ls *|cd|cd *|cd ..*|cd -|pwd|exit|st |st *|code|code *|ping|ping *|gs|gac|which *|where *|glog|git log|atuin|atuin *|echo|echo *|export *|open *|sh|sh *|make|make *|cloud-reno|cloud-reno *|* cloud-reno|* cloud-reno *|)"

#启用 cd 命令的历史纪录，cd -[TAB]进入历史路径
#setopt AUTO_PUSHD
#相同的历史路径只保留一个
#setopt PUSHD_IGNORE_DUPS

#}}}
