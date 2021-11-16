#!/bin/sh
alias gotest='go test -covermode=count -coverprofile=coverage.out'
alias gocover='gotest && go tool cover -html=coverage.out'
alias go2w='cd ${GOPATH%:*}/../project/src'
alias go2b='cd ${GOPATH%:*}/'
