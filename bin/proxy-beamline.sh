#!/bin/bash

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    RED='\033[1;31m'
    RESET='\033[0m'
    echo "${RED}Source this script!${RESET}"
    exit 1
fi

http_proxy="http://proxy:8888"
https_proxy="https://proxy:8888"

source set_proxy.sh
