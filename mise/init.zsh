#!/usr/bin/env zsh

# Lazy load mise
# eval "$(mise activate zsh)"
eval "$(mise activate zsh --shims)"

# Check if 'mise' is a command in $PATH
if [ $commands[mise] ]; then

  # Placeholder 'mise' shell function:
  # Will only be executed on the first call to 'mise'
  mise() {

    # Remove this function, subsequent calls will execute 'mise' directly
    unfunction "$0"

    # Execute 'mise' binary
    $0 "$@"
  }
fi
