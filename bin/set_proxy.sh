#!/bin/bash

if [ -z "$http_proxy" ]; then
    exit 0
fi


echo "Setting proxy to $http_proxy"
export http_proxy=$http_proxy
export https_proxy=$https_proxy
export no_proxy=$no_proxy


has_git=$(which git 2> /dev/null)
if [ -n "$has_git" ]; then
    git config --global http.proxy $http_proxy 2> /dev/null
    git config --global https.proxy $https_proxy 2> /dev/null
fi
