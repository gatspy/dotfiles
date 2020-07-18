#!/bin/sh
if [ "$(which go)" ] && [ -n "$GOPATH" ]; then
	mkdir -p "$GOPATH/bin" "$GOPATH/src/github.com/"

	packages="
    github.com/koron/iferr
    github.com/fatih/motion
    honnef.co/go/tools/cmd/keyify
    golang.org/x/tools/cmd/guru
    github.com/jstemmer/gotags
    golang.org/x/tools/cmd/gorename
    github.com/fatih/gomodifytags
    honnef.co/go/tools/cmd/keyify
    golang.org/x/tools/gopls
    golang.org/x/lint/golint
    golang.org/x/tools/cmd/goimports
    github.com/rogpeppe/godef
    github.com/davidrjenni/reftools/cmd/fillstruct
    github.com/kisielk/errcheck
    github.com/go-delve/delve/cmd/dlv
    github.com/klauspost/asmfmt/cmd/asmfmt
    github.com/golangci/golangci-lint/cmd/golangci-lint
    golang.org/x/tools/cmd/cover
    golang.org/x/tools/cmd/godoc
    github.com/nsf/gocode
  "

	for pkg in $packages; do
		go get -u -v "$pkg"
	done
	# "$GOPATH"/bin/gometalinter --install --update
fi
