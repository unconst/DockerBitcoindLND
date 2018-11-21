FROM ctarwater/armhf-alpine-rpi-glibc

# The first two Exposed ports are for rpc, the second are used for ZQM block updates. 
EXPOSE 8883 8882 18309 19345

# Install Bitcoind. Change the BITCOIN_VERSION for later or earlier Bitcoin versions.
ENV BITCOIN_VERSION=0.17.0
ENV BITCOIN_DIR_VERSION=0.17.0
RUN apk update \
	&& apk --no-cache add wget ca-certificates \
	&& wget https://bitcoin.org/bin/bitcoin-core-${BITCOIN_VERSION}/bitcoin-${BITCOIN_VERSION}-arm-linux-gnueabihf.tar.gz \
	&& tar xzvf bitcoin-${BITCOIN_VERSION}-arm-linux-gnueabihf.tar.gz \
	&& apk del wget ca-certificates tzdata \
	&& mv bitcoin-${BITCOIN_DIR_VERSION}/bin/* /usr/local/bin/ \
	&& rm -rf bitcoin-${BITCOIN_VBITCOIN_DIR_VERdockerSIONRSION}/ \
	&& rm -rf bitcoin-${BITCOIN_VERSION}-arm-linux-gnueabihf.tar.gz

# Create a bitcoin volume at /root/.bitcoin. This folder stores chainstate, wallets, mempool etc.
# We mount the folder bitcoind/bitcoin into this volume during start up which keeps those two folders
# in linked state.
RUN mkdir -p /root/.bitcoin
VOLUME ["/root/.bitcoin"]

# Copy and CHMOD the start script. This script is run in the container when we call 'docker-compose up'.
# start-bitcoind.sh which uses config from bitcoin.conf to start eh deamon. 
# Run docker-run up --build to rebuild with new configs if you make a change bitcoind/bitcoin.conf
COPY "start-bitcoind.sh" .
RUN chmod +x start-bitcoind.sh
COPY "bitcoin.conf" "/root/bitcoin.conf"


