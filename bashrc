
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

# proxy settings
export http_proxy="http://proxy:8888"
export https_proxy="http://proxy:8888"

# path
export PATH=$HOME/dotfiles/bin:$PATH
export TERM=screen-256color

# EPICS
export EPICS_CA_AUTO_ADDR_LIST=NO
export EPICS_CA_ADDR_LIST="`python $HOME/dotfiles/bin/get_ca_bcast_addr.py`"
export EPICS_CA_MAX_ARRAY_BYTES=20000000

