#!/usr/bin/env zsh

# Check if 'sdkman' is a command in $PATH
if [ $commands[sdk] ]; then

  # Placeholder 'sdk' shell function:
  # Will only be executed on the first call to 'atuin'
  sdk() {

    # Remove this function, subsequent calls will execute 'atuin' directly
    unfunction "$0"

    export SDKMAN_DIR="/Users/gatspy/.sdkman"
    [[ -s "/Users/gatspy/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/gatspy/.sdkman/bin/sdkman-init.sh"

    $0 "$@"
  }
fi
