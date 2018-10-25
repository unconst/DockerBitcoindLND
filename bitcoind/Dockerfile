FROM frolvlad/alpine-glibc

EXPOSE 8883 8882 18309 19345

ENV BITCOIN_VERSION=0.17.0
ENV BITCOIN_DIR_VERSION=0.17.0

# Install Bitcoind.
RUN apk update \
	&& apk --no-cache add wget ca-certificates \
	&& wget https://bitcoin.org/bin/bitcoin-core-${BITCOIN_VERSION}/bitcoin-${BITCOIN_VERSION}-arm-linux-gnueabihf.tar.gz \
	&& tar xzvf bitcoin-${BITCOIN_VERSION}-arm-linux-gnueabihf.tar.gz \
	&& mkdir /root/.bitcoin \
	&& apk del wget ca-certificates tzdata \
	&& mv bitcoin-${BITCOIN_DIR_VERSION}/bin/* /usr/local/bin/ \
	&& rm -rf bitcoin-${BITCOIN_VBITCOIN_DIR_VERdockerSIONRSION}/ \
	&& rm -rf bitcoin-${BITCOIN_VERSION}-arm-linux-gnueabihf.tar.gz


# Add bash.
RUN apk add --no-cache bash

# Copy Start Script.
COPY "start-bitcoind.sh" .
RUN chmod +x start-bitcoind.sh

# Copy Data & Create Volume.
COPY "data" "data"
VOLUME ["/data"]
