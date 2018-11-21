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

# Print bitcoin.conf.
echo "Starting LND with /root/lnd.conf"
cat /root/lnd.conf

# Start LND
exec lnd --configfile=/root/lnd.conf
