#!/usr/bin/env zsh

brew install go --cross-compile-common

export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
test -d "${GOPATH}" || mkdir "${GOPATH}"
test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"

go get golang.org/x/tools/cmd/godoc
go get github.com/golang/lint/golint
go get -u -d gocv.io/x/gocv
cd $GOPATH/src/gocv.io/x/gocv
