# init according to man page
if (( $+commands[pyenv] ))
then
  export PYENV_ROOT=/usr/local/var/pyenv
  eval "$(pyenv init - --no-rehash)"
  if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
fi

# export PYTHON_BUILD_MIRROR_URL="http://pyenv.qiniudn.com/pythons/"
