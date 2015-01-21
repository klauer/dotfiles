#!/bin/sh

script="${0##*/}"

fatal() {
        printf "$script"': %s\n' "$*"
        exit 1
}

cmd=""
case "$1" in
    "copy" )
        if [ $(command -v pbcopy) ]; then
            cmd="pbcopy"
        elif [ $(command -v xclip) ]; then
            cmd="xclip -selection clipboard -i"
        elif [ $(command -v xsel) ]; then
            cmd="xsel -ib"
        else
            fatal "No clipboard utility found for copy."
        fi
        ;;
    "paste" )
        if [ $(command -v pbpaste) ]; then
            cmd="pbpaste"
        elif [ $(command -v xclip) ]; then
            cmd="xclip -selection clipboard -o"
        elif [ $(command -v xsel) ]; then
            cmd="xsel -ob"
        else
            fatal "No clipboard utility found for paste."
        fi
        ;;
    * )
        fatal "Unknown command."
        ;;
esac

touch /tmp/foobar

if [ $(command -v reattach-to-user-namespace) ]; then
    exec reattach-to-user-namespace "$cmd"
else
    eval "$cmd"
fi
