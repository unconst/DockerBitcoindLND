FROM alpine

# Install LND
RUN apk update \
	&& apk --no-cache add wget ca-certificates tar \
	&& wget https://github.com/lightningnetwork/lnd/releases/download/v0.5-beta/lnd-linux-armv7-v0.5-beta.tar.gz \
	&& tar -xzC . -f lnd-linux-armv7-v0.5-beta.tar.gz \
	&& mv lnd-linux-armv7-v0.5-beta/* /usr/local/bin/ \
	&& apk del wget ca-certificates tar

## Add bash.
RUN apk add --no-cache bash

# Copy Start Script.
COPY "start-lnd.sh" .
RUN chmod +x start-lnd.sh

# Create LND Volume.
RUN mkdir -p /root/.lnd
VOLUME ["/root/.lnd"]
