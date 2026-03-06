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

# {{{ History Ignore Patterns

# Define commands to ignore in history (using zsh array)
typeset -ga HIST_IGNORE_PATTERNS
HIST_IGNORE_PATTERNS=(
  # Basic navigation and status
  'l' 'l *' 'ls' 'ls *' 'cd' 'cd -' 'cd ..' 'pwd' 'exit' 'st' 'st *'

  # Git related (keep useful commands like git log)
  'gs'
  'git status'
  'git add *'
  'git commit*'
  'git push*'
  'git pull*'
  'gac'
  '*git add*&& git commit*'

  # Development tools and env managers
  'code *' 'zed *' 'cursor *' 'qoder *'
  'npm *' 'mise *' 'node *' 'fvm *' 'fnm *' 'goenv *' 'pyenv *' 'adb *'

  # Network and system tools
  'ping *' 'echo *' 'export *' 'open *' 'which *' 'where *'

  # AI tools
  'atuin *' 'cloud-reno *' 'fanyi *' 'fy *' 'mkp *'
  'ai-tool *' 'trae *' 'claude *' 'gemini *' 'ai *'
)

# }}}

# Enable cd history (optional)
#setopt AUTO_PUSHD
#setopt PUSHD_IGNORE_DUPS
