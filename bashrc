# If not running interactively, don't do anything
[ -z "$PS1" ] && return

function tmux() {
    # update-env command addition from:
    #   https://raim.codingfarm.de/blog/2013/01/30/tmux-update-environment/
    local tmux=$(type -fp tmux)
    case "$1" in
        update-environment|update-env|env-update)
            local v
            while read v; do
                if [[ $v == -* ]]; then
                    unset ${v/#-/}
                else
                    # Add quotes around the argument
                    v=${v/=/=\"}
                    v=${v/%/\"}
                    eval export $v
                fi
            done < <(tmux show-environment)
            ;;
        *)
            $tmux "$@"
            ;;
    esac
}

# disable ctrl-s/ctrl-q
stty stop ''
stty start ''
stty -ixon
stty -ixoff

export EDITOR=vim
export EPICS_BASE=/usr/lib/epics
export EDMDATAFILES=.:/usr/lib/epics/op/edl

if [ -z "$(find /usr/share/terminfo -name st-256color 2> /dev/null)" ]; then
    export TERM=screen-256color
else
    export TERM=st-256color
fi

export DOTFILES=$HOME/dotfiles
# path
export PATH=$DOTFILES/bin:$HOME/.local/bin:$PATH

# proxy settings
export LOCATION="`python $DOTFILES/bin/get_location.py`"

if [ "${LOCATION}" == "beamline" ]; then
    source $DOTFILES/bin/proxy-beamline.sh
elif [ "${LOCATION}" == "campus" ]; then
    source $DOTFILES/bin/proxy-campus.sh
else
    if [ -z "${LOCATION}" ]; then
        echo "* Unknown location; clearing proxy settings"
    else
        echo "* Location \"${LOCATION}\": clearing proxy settings"
    fi
    source $DOTFILES/bin/clear_proxy.sh
fi

# EPICS address listings
export EPICS_CA_AUTO_ADDR_LIST=NO
export EPICS_CA_ADDR_LIST="`python $DOTFILES/bin/get_ca_bcast_addr.py`"
export EPICS_CA_MAX_ARRAY_BYTES=20000000

# neovim TUI config (note: may change)
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
export NVIM_TUI_ENABLE_TRUE_COLOR=1
