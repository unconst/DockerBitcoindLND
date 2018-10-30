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

check_config() {
    BLANK_STRING='""'
    BITCOIN_CONFIG_VAR="$1"

    if [[ -z "$BITCOIN_CONFIG_VAR" || "$BITCOIN_CONFIG_VAR" == "$BLANK_STRING" ]]; then
    	error "You must specify your BITCOIN_CONFIG environment variable. Make sure you have set the BITCOIN_CONFIG environment variable"
    fi

   return "$BITCOIN_CONFIG_VAR"
}

BITCOIN_CONFIG=$(check_config "$BITCOIN_CONFIG")

# Build config file.
rm -f /root/bitcoin/bitcoin.conf
touch /root/bitcoin/bitcoin.conf
echo -en $BITCOIN_CONFIG > /root/bitcoin/bitcoin.conf

# Print bitcoin.conf.
echo "Starting Bitcoind with /root/bitcoin/bitcoin.conf"
cat /root/bitcoin/bitcoin.conf

# Start Bitcoind.
exec bitcoind -conf=/root/bitcoin/bitcoin.conf
