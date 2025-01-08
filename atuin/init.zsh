#!/usr/bin/env zsh

# Lazy load atuin

# if type atuin &> /dev/null; then

#     function atuin() {
#         echo "atuin"
#         unset atuin
#         eval "$(atuin init zsh)"

#         atuin $@
#     }
# fi

# Check if 'atuin' is a command in $PATH
if [ $commands[atuin] ]; then

  # Placeholder 'atuin' shell function:
  # Will only be executed on the first call to 'atuin'
  atuin() {

    # Remove this function, subsequent calls will execute 'atuin' directly
    unfunction "$0"

    export ATUIN_NOBIND="true"
    # eval "$(atuin init zsh --disable-ctrl-r)"
    eval "$(atuin init zsh)"

    bindkey '^e' atuin-search

    # bind to the up key, which depends on terminal mode
    # bindkey '^[[A' atuin-up-search
    # bindkey '^[OA' atuin-up-search

    #  Load auto-completion
    # source <(atuin completion zsh)

    # Execute 'atuin' binary
    $0 "$@"
  }

fi
