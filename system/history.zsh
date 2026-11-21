# {{{ History Configuration

# History file path
HISTFILE="$HOME/.zsh_history"

# Set history size (large enough for serious work)
HISTSIZE=500000
SAVEHIST=$HISTSIZE

# Enable history expansion (!)
setopt BANG_HIST

# Enable timestamped history
setopt EXTENDED_HISTORY

# Write to history immediately (share across terminals)
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Deduplication
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS

# Don't record commands starting with space
setopt HIST_IGNORE_SPACE

# Reduce blanks in history
setopt HIST_REDUCE_BLANKS

# Verify before executing history expansion
setopt HIST_VERIFY
setopt HIST_BEEP

# }}}

# Enable cd history (optional)
#setopt AUTO_PUSHD
#setopt PUSHD_IGNORE_DUPS
