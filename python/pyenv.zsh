# init according to man page
if (( $+commands[pyenv] ))
then
  export PYENV_ROOT=/usr/local/var/pyenv
  eval "$(pyenv init -)"
fi
