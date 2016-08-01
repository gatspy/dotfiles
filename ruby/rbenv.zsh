# init according to man page
if (( $+commands[rbenv] ))
then
  export RBENV_ROOT=${HOME}/.rbenv
  eval "$(rbenv init -)"
fi
