FROM alpine

# Install LND
RUN apk update \
	&& apk --no-cache add wget ca-certificates tar \
	&& wget https://github.com/lightningnetwork/lnd/releases/download/v0.5-beta/lnd-linux-armv7-v0.5-beta.tar.gz \
	&& tar -xzC . -f lnd-linux-armv7-v0.5-beta.tar.gz \
	&& mv lnd-linux-armv7-v0.5-beta/* /usr/local/bin/ \
	&& apk del wget ca-certificates tar
# Create LND Volume. /root/.lnd/  remains consistent with the lnd/lnd folder on the host.
# By creating a volume these folders remain persistent across runs.
RUN mkdir -p /root/.lnd
VOLUME ["/root/.lnd"]

# Copy Start Script. This script is run when docker-compose up is run. 
# start-lnd.sh pipes the LND_CONFIG env variable into /root/.lnd/lnd.conf before starting lnd.
COPY "start-lnd.sh" .
RUN chmod +x start-lnd.sh
COPY "lnd.conf" "/root/lnd.conf"
