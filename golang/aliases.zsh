#!/bin/sh
alias gotest='go test -covermode=count -coverprofile=coverage.out'
alias gocover='gotest && go tool cover -html=coverage.out'
alias gowork='cd ${GOPATH%:*}/../project/src'
alias govendor='cd ${GOPATH%:*}/'
