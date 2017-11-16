# init according to man page
if (( $+commands[rbenv] ))
then
  export RBENV_ROOT=${HOME}/.rbenv
  # eval "$(rbenv init - --no-rehash)"
fi


if type rbenv &> /dev/null; then
    local RBENV_SHIMS="${RBENV_ROOT:-${HOME}/.rbenv}/shims"
    export PATH="${RBENV_SHIMS}:${PATH}"
    function rbenv() {
        unset rbenv
        eval "$(command rbenv init - --no-rehash)"
        rbenv $@
    }
fi
