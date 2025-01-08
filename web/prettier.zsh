#!/usr/bin/env zsh

if [ $commands[prettier] ]; then

    # Placeholder 'prettier' shell function:
    # Will only be executed on the first call to 'prettier'
    prettier() {

        # Remove this function, subsequent calls will execute 'prettier' directly
        unfunction "$0"

        # Execute 'prettier' binary
        $0 "$@"
    }
else
    prettier() {
        case "$1" in
        install)
            echo 'start install prettier in current project...'
            npm install --save-dev --save-exact prettier
            ;;
        init)
            echo 'start init prettier ...'
            node --eval "fs.writeFileSync('.prettierrc','{}\n')"
            ;;
        *)
            echo 'not support other...'
            ;;
        esac
    }
fi
