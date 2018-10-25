FROM alpine

EXPOSE 8883 8882 18309 19345

ENV BITCOIN_VERSION=0.17.0
ENV BITCOIN_DIR_VERSION=0.17.0
ENV GLIBC_VERSION=2.28-r0

## C standard library.
#RUN apk update \
#	&& apk --no-cache add wget ca-certificates tzdata \
##	&& wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
#	&& wget -q https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
#	&& wget -q https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk \
# 	&& apk --no-cache add glibc-${GLIBC_VERSION}.apk \
#	&& apk --no-cache add glibc-bin-${GLIBC_VERSION}.apk \
#	&& apk del wget tzdata \
#	&& rm -rf /glibc-${GLIBC_VERSION}.apk \
#	&& rm -rf /glibc-bin-${GLIBC_VERSION}.apk


RUN apk --no-cache add ca-certificates \
	&& wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub \
	&& wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.23-r3/glibc-2.23-r3.apk \
	&& apk add glibc-2.23-r3.apk

# Install Bitcoind.
RUN apk update \
	&& apk --no-cache add wget ca-certificates \
	&& wget https://bitcoin.org/bin/bitcoin-core-${BITCOIN_VERSION}/bitcoin-${BITCOIN_VERSION}-x86_64-linux-gnu.tar.gz \
	&& tar xzvf bitcoin-${BITCOIN_VERSION}-x86_64-linux-gnu.tar.gz \
	&& mkdir /root/.bitcoin \
	&& apk del wget ca-certificates tzdata \
	&& mv bitcoin-${BITCOIN_DIR_VERSION}/bin/* /usr/local/bin/ \
	&& rm -rf bitcoin-${BITCOIN_VBITCOIN_DIR_VERdockerSIONRSION}/ \
	&& rm -rf bitcoin-${BITCOIN_VERSION}-x86_64-linux-gnu.tar.gz


# Add bash.
RUN apk add --no-cache bash

# Copy Start Script.
COPY "start-bitcoind.sh" .
RUN chmod +x start-bitcoind.sh

# Copy Data & Create Volume.
COPY "data" "data"
VOLUME ["/data"]
