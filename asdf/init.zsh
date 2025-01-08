#!/usr/bin/env zsh

# Lazy load asdf

# Check if 'asdf' is a command in $PATH
if [ $commands[asdf] ]; then

  # Placeholder 'asdf' shell function:
  # Will only be executed on the first call to 'asdf'
  asdf() {

    # Remove this function, subsequent calls will execute 'asdf' directly
    unfunction "$0"

    # Execute 'asdf' binary
    $0 "$@"
  }
fi
