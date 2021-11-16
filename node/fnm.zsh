#!/bin/zsh
eval "$(fnm env)"
export FNM_NODE_DIST_MIRROR=https://npm.taobao.org/dist

# yarn
export PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
