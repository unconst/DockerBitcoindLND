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
    LND_CONFIG_VAR="$1"

    if [[ -z "$LND_CONFIG_VAR" || "$LND_CONFIG_VAR" == "$BLANK_STRING" ]]; then
    	error "You must specify your LND_CONFIG environment variable. Make sure you have set the LND_CONFIG environment variable"
    fi

   return "$LND_CONFIG_VAR"
}

LND_CONFIG=$(check_config "$LND_CONFIG")

# Build config file.
rm -f /root/.lnd/lnd.conf
touch /root/.lnd/lnd.conf
echo -en $LND_CONFIG > /root/.lnd/lnd.conf

# Print bitcoin.conf.
echo "Starting LND with /root/.lnd/lnd.conf"
cat /root/.lnd/lnd.conf

# Start LND
exec lnd --configfile=/root/.lnd/lnd.conf
