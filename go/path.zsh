export GOROOT=/usr/local/opt/go/libexec
export GORACH=amd64
export GOOS=darwin
# export GOPATH=${HOME}/Home/Work/golang/vender:${HOME}/Home/Work/golang/project
export GOPATH=${WORKDIR}/golang/vender:${WORKDIR}/Home/Work/golang/project
# export GOTOOLDIR=${HOME}/Home/App/go/pkg/tool/darwin_amd64
# export GO15VENDOREXPERIMENT=1
export PATH="$GOROOT/bin:${GOPATH//://bin:}/bin:$PATH"
