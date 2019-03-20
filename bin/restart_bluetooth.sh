#!/bin/bash
#
# Restart Bluetooth Module on Mac OS X
#
# Requires Blueutil to be installed: http://brewformulas.org/blueutil

BT="/usr/local/bin/blueutil"

log() {
	echo "$@"
	logger -p notice -t bt_restarter "$@"
}

err() {
	echo "$@" >&2
	logger -p error -t bt_restarter "$@"
}

if [ -f "$BT" ]; then
	if [[ $("$BT" -p) == *1 ]];
		then
		echo "Bluetooth on, restarting ..."
		($("$BT" -p 0) &> /dev/null && echo "Bluetooth Module stopped") || (err "Couldn't stop Bluetooth Module" && exit 1)
		($("$BT" -p 1) &> /dev/null && echo "Bluetooth Module started") || (err "Couldn't start Bluetooth Module" && exit 1) 
		log "Successfully restarted Bluetooth" && exit 0
	else
		echo "Bluetooth is off, nothing to do ..."
	fi
else
	err "Couldn't find blueutil, please install http://brewformulas.org/blueutil" && exit 1
fi
