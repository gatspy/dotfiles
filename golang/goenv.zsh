# init according to man page
go_root () {
    if ([[ $(goenv version-name) == "system" ]])
    then
        export GOROOT="/usr/local/opt/go/libexec"
    else
        export GOROOT="$(goenv prefix)"
    fi
}

go_env () {
    export GORACH=amd64
    export GOOS=darwin
    export GOPATH=${PROJECTS}/golang/vendor:${PROJECTS}/golang/project
    # export GOPATH=${PROJECTS}/golang/vendor
    # export GOPATH=${PROJECTS}/golang/project
    # export GOTOOLDIR=${HOME}/Home/App/go/pkg/tool/darwin_amd64
    # export GO15VENDOREXPERIMENT=1
    export GO111MODULE=auto
    export GOCACHE="/tmp/gocache"
    export PATH="${GOPATH//://bin:}/bin:$PATH"
    # export GOPROXY=https://goproxy.io
    export GOPROXY=https://goproxy.cn,direct
}

go_mod () {
    export GO111MODULE=on
}

export GOENV_DISABLE_GOPATH=1

if (( $+commands[goenv] ))
then

    export GOENV_ROOT=/usr/local/var/goenv
    go_root
    go_env
fi
# Lazy load goenv
if type goenv &> /dev/null; then
    local GOENV_SHIMS="${GOENV_ROOT:-${HOME}/.goenv}/shims"
    export PATH="${GOENV_SHIMS}:${PATH}"
    function goenv() {

        unset goenv
        eval "$(command goenv init - --no-rehash)"
        goenv $@
    }
fi
