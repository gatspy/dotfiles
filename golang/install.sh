#!/bin/sh
if [ "$(which go)" ] && [ -n "$GOPATH" ]; then
	mkdir -p "$GOPATH/bin" "$GOPATH/src/github.com/"

	packages="
    github.com/nsf/gocode
    github.com/uudashr/gopkgs/cmd/gopkgs
    github.com/ramya-rao-a/go-outline
    github.com/newhook/go-symbols
    golang.org/x/tools/cmd/guru
    golang.org/x/tools/cmd/gorename
    github.com/cweill/gotests/...
    github.com/fatih/gomodifytags
    github.com/josharian/impl
    github.com/davidrjenni/reftools/cmd/fillstruct
    github.com/haya14busa/goplay/cmd/goplay
    github.com/go-delve/delve/cmd/dlv
    golang.org/x/tools/cmd/goimports
    golang.org/x/lint/golint
    github.com/koron/iferr
    github.com/fatih/motion
    honnef.co/go/tools/cmd/keyify
    github.com/jstemmer/gotags
    golang.org/x/tools/gopls
    github.com/rogpeppe/godef
    github.com/kisielk/errcheck
    github.com/klauspost/asmfmt/cmd/asmfmt
    golang.org/x/tools/cmd/cover
    golang.org/x/tools/cmd/godoc
    github.com/golangci/golangci-lint/cmd/golangci-lint
  "
    # github.com/lukehoban/go-outline

	for pkg in $packages; do
		go get -u -v "$pkg"
	done
	# "$GOPATH"/bin/gometalinter --install --update
fi
