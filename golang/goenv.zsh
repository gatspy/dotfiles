#!/usr/bin/env zsh

# Go Environment Configuration
# Uses platform detection for cross-architecture compatibility

go_env() {
    # Use platform detection (default to darwin/amd64 for backward compatibility)
    local arch=${PLATFORM_ARCH:-amd64}
    local os=${PLATFORM_OS:-darwin}

    # Map detected arch to Go's naming convention
    case "$arch" in
        arm64)  export GOARCH=arm64 ;;
        amd64)  export GOARCH=amd64 ;;
        386)    export GOARCH=386 ;;
        *)      export GOARCH=amd64 ;;  # fallback
    esac

    export GOOS=$os
    export GOPATH=${LOCAL_ROOT}/golang
    export GOBIN=$GOPATH/bin
    export GO111MODULE=on
    export GOCACHE="/tmp/gocache"
    export PATH="${GOPATH}/bin:$PATH"
    export GOPROXY=https://goproxy.cn,direct
}

# Initialize if mise is available
if (( $+commands[mise] )); then
    go_env
fi
