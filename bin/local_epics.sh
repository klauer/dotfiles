#!/bin/bash

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    RED='\033[1;31m'
    RESET='\033[0m'
    echo "${RED}Source this script!${RESET}"
    exit 1
fi


echo "Setting up epics for localhost channel access..."
export EPICS_CA_AUTO_ADDR_LIST=no
export EPICS_CA_ADDR_LIST=127.0.0.1
