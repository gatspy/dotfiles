#!/usr/bin/env zsh

# Go environment & PATH entry in one place: loads in the path phase
# (before topic files), so $GOBIN injection can never outrun its assignment.
export GOPATH=${LOCAL_ROOT}/golang
export GOBIN=$GOPATH/bin
export GO111MODULE=on
export GOCACHE=/tmp/gocache
export GOPROXY=https://goproxy.cn,direct

path=("$GOBIN" $path)
