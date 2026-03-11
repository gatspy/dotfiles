#!/usr/bin/env zsh

# Go Environment Configuration
# Uses platform detection for cross-architecture compatibility

go_env() {
   
    export GOPATH=${LOCAL_ROOT}/golang
    export GOBIN=$GOPATH/bin
    export GO111MODULE=on
    export GOCACHE="/tmp/gocache"
    export GOPROXY=https://goproxy.cn,direct
}

# Initialize if mise is available
if (( $+commands[mise] )); then
    go_env
fi
