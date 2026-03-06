#!/bin/sh
if [ "$(which go)" ] && [ -n "$GOPATH" ]; then
	mkdir -p "$GOPATH/bin" "$GOPATH/src/github.com/"

	packages="
    github.com/fatih/gomodifytags
    github.com/haya14busa/goplay/cmd/goplay
    github.com/josharian/impl
    mvdan.cc/gofumpt
    golang.org/x/tools/cmd/goimports
    github.com/cweill/gotests/gotests
    golang.org/x/lint/golint
    honnef.co/go/tools/cmd/staticcheck
    github.com/golangci/golangci-lint/cmd/golangci-lint
    github.com/mgechev/revive
    golang.org/x/tools/gopls
    github.com/go-delve/delve/cmd/dlv
    github.com/golang/vscode-go/vscgo
    github.com/kisielk/errcheck
    github.com/klauspost/asmfmt/cmd/asmfmt
    golang.org/x/tools/cmd/godoc
    gorm.io/gen/tools/gentool
    github.com/google/wire/cmd/wire
    github.com/swaggo/swag/cmd/swag
    github.com/gin-admin/gin-admin-cli/v10
    github.com/GoAdminGroup/adm
    github.com/rakyll/statik
    google.golang.org/protobuf/cmd/protoc-gen-go
    github.com/araddon/dateparse/dateparse
    github.com/air-verse/air
    "
    # github.com/lukehoban/go-outline

	for pkg in $packages; do
	    # use go install
		go install "$pkg"@latest
		# go get -u -v "$pkg"

		# use mise maintain all tools
		# mise uninstall go:"$pkg"
		# mise unuse go:"$pkg"
	done
	# "$GOPATH"/bin/gometalinter --install --update
	# github.com/davidrjenni/reftools/cmd/fillstruct
    # github.com/koron/iferr
fi
