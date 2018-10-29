#!/usr/bin/env bash

# exit from script if error was raised.
set -e

# error function is used within a bash function in order to send the error
# message directly to the stderr output and exit.
error() {
    echo "$1" > /dev/stderr
    exit 0
}

# return is used within bash function in order to return the value.
return() {
    echo "$1"
}

# set_default function gives the ability to move the setting of default
# env variable from docker file to the script thereby giving the ability to the
# user override it durin container start.
set_default() {
    # docker initialized env variables with blank string and we can't just
    # use -z flag as usually.
    BLANK_STRING='""'

    VARIABLE="$1"
    DEFAULT="$2"

    if [[ -z "$VARIABLE" || "$VARIABLE" == "$BLANK_STRING" ]]; then

        if [ -z "$DEFAULT" ]; then
            error "You should specify default variable"
        else
            VARIABLE="$DEFAULT"
        fi
    fi

   return "$VARIABLE"
}

RPCUSER=$(set_default "$RPCUSER" "devuser")
RPCPASS=$(set_default "$RPCPASS" "devpass")
DEBUG=$(set_default "$DEBUG" "debug")


CONFIGS="
logdir=/root/.lnd/logs \n\
datadir=/root/.lnd/data \n\
bitcoin.active=1 \n\
bitcoin.mainnet=1 \n\
bitcoin.node=bitcoind \n\
bitcoind.rpchost=bitcoind_container \n\
bitcoind.rpcuser=$RPCUSER \n\
bitcoind.rpcpass=$RPCPASS \n\
bitcoind.zmqpubrawblock=tcp://bitcoind_container:18309 \n\
bitcoind.zmqpubrawtx=tcp://bitcoind_container:19345 \n\
debuglevel=$DEBUG \n
"

# Build config file.
rm -f /root/.lnd/lnd.conf
touch /root/.lnd/lnd.conf
echo -en $CONFIGS > /root/.lnd/lnd.conf

# Print bitcoin.conf.
echo "Starting LND with /root/.lnd/lnd.conf"
cat /root/.lnd/lnd.conf

# Start LND
exec lnd --configfile=/root/.lnd/lnd.conf
