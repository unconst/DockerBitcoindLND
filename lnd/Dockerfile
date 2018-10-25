FROM golang:1.10-alpine as builder

## Install Lightning.
RUN apk update \
	&&  apk upgrade \
	&&  apk add make \
	&&  apk add git \
	&&  go get -d github.com/lightningnetwork/lnd \
	&&  cd /go/src/github.com/lightningnetwork/lnd \
	&&  make \
	&&  make install

## Add bash.
RUN apk add --no-cache bash

## Copy Start Script.
COPY "start-lnd.sh" .
RUN chmod +x start-lnd.sh
