#!/bin/bash

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    RED='\033[1;31m'
    RESET='\033[0m'
    echo "${RED}Source this script!${RESET}"
    exit 1
fi

http_proxy="http://192.168.1.165:3128"
https_proxy="https://192.168.1.165:3128"
no_proxy=""

source set_proxy.sh
