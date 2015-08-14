#!/bin/bash

export http_proxy=
export https_proxy=

has_git=$(which git 2> /dev/null)
if [ -n "$has_git" ]; then
    git config --global --unset http.proxy
    git config --global --unset https.proxy
fi
