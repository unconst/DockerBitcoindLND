FROM frolvlad/alpine-glibc

# Install Bitcoin Core
ARG CORE_VERSION="0.16.3"
ENV TARBALL bitcoin-${CORE_VERSION}-arm-linux-gnueabihf.tar.gz
ENV URL https://bitcoincore.org/bin/bitcoin-core-${CORE_VERSION}

RUN apk add --update --no-cache \
    curl \
    su-exec \
    gnupg

WORKDIR /usr/bin

RUN wget ${URL}/SHA256SUMS.asc \
 && gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys "01EA5486DE18A882D4C2684590C8019E36C2E964" \
 && gpg --verify SHA256SUMS.asc \
 && wget ${URL}/${TARBALL} \
 && grep ${TARBALL} SHA256SUMS.asc | sha256sum -c - \
 && tar -xzC . -f ${TARBALL} bitcoin-${CORE_VERSION}/bin/bitcoind bitcoin-${CORE_VERSION}/bin/bitcoin-cli --strip-components=2 \
 && rm -rf ${TARBALL} SHA256SUMS.asc \
 && apk del gnupg

# Copy Start Script.
COPY "start-bitcoind.sh" .
RUN chmod +x start-bitcoind.sh

# Copy Data & Create Volume.
COPY "data" "data"
VOLUME ["/data"]

EXPOSE 8332 8333 18332 18333 29000
