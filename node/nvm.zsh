#!/bin/zsh
# init according to man page
export NVM_DIR=${HOME}/.nvm
export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/dist
export NVM_IOJS_ORG_MIRROR=https://npm.taobao.org/mirrors/iojs
# export PATH=$PATH:${HOME}/.npm/bin
# export PATH=${NVM_DIR}/versions/node/v10.21.0/bin:$PATH

# yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# alias nvminit='source $NVM_DIR/nvm.sh'
# alias time-nvm='time (source "$NVM_DIR/nvm.sh")'
# source $(brew --prefix nvm)/nvm.sh --no-use
# source $(brew --prefix nvm)/nvm.sh
# source ${NVM_DIR}/nvm.sh
