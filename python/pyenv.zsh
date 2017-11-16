# init according to man page
if (( $+commands[pyenv] ))
then
    export PYENV_ROOT=/usr/local/var/pyenv
    # eval "$(pyenv init - --no-rehash)"
    # if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
fi
# export PYENV_VIRTUALENV_DISABLE_PROMPT=0
# export PYTHON_BUILD_MIRROR_URL="http://pyenv.qiniudn.com/pythons/"

# Lazy load pyenv
if type pyenv &> /dev/null; then
    local PYENV_SHIMS="${PYENV_ROOT:-${HOME}/.pyenv}/shims"
    export PATH="${PYENV_SHIMS}:${PATH}"
    function pyenv() {
        unset pyenv
        eval "$(command pyenv init - --no-rehash)"
        if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
        # eval "$(command pyenv init -)"
        pyenv $@
    }
fi
