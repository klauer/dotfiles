#!/bin/bash

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

function vimp() {
    /usr/bin/vim - -u NONE -es '+1' "+$*" '+%print' '+:qa!' | tail -n +2
}
# $ printf "foo\nbar\n" | vimp normal dd

function vimnp() {
    /usr/bin/vim - -u NONE -es '+1' "+normal $*" '+%print' '+:qa!' | tail -n +2
}
# $ printf "foo\nbar\n" | vimnp dd

# disable ctrl-s/ctrl-q
stty stop ''
stty start ''
stty -ixon
stty -ixoff

export GITHUB_USER=klauer
export EDITOR=vim
export DOTFILES=$HOME/dotfiles
export PATH=$DOTFILES/bin:$HOME/.local/bin:$PATH

# proxy settings
export LOCATION=$(python $DOTFILES/bin/get_location.py)

source $DOTFILES/aliases

# neovim TUI config (note: may change)
# export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
# export NVIM_TUI_ENABLE_TRUE_COLOR=1

# Setting ag as the default source for fzf - and ignore stuff in gitignore/hgignore
if [ ! -z "$(which ag 2> /dev/null)" ]; then
    export FZF_DEFAULT_COMMAND='ag -g ""'
else
    export FZF_DEFAULT_COMMAND='find .'
fi

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_DEFAULT_COMMAND='
#   (git ls-tree -r --name-only HEAD ||
#    find . -path "*/\.*" -prune -o -type f -print -o -type l -print |
#       sed s/^..//) 2> /dev/null'

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  echo "cd \"$dir\"" &&
  history -s "cd \"$dir\"" &&
  cd "$dir"
}

# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) &&
  echo "cd \"$dir\"" &&
  history -s "cd \"$dir\"" &&
  cd "$dir"
}

# fdr - cd to selected parent directory
fdr() {
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  local dir=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf-tmux --tac)
  echo "cd \"$dir\"" &&
  history -s "cd \"$dir\"" &&
  cd "$dir"
}

# cdf - cd into the directory of the selected file
cdf() {
  local file
  local dir
  file=$(fzf +m -q "$1") && dir=$(dirname "$file") && 
  echo "cd \"$dir\"" &&
  history -s "cd \"$dir\"" &&
  cd "$dir"
}


function cdr() {
    cd $HOME/Repos/${1:-$TMUX_SESSION_NAME}
}

caddr() {
    export EPICS_CA_ADDR_LIST=$1 $2 $3
    export EPICS_CA_AUTO_ADDR_LIST=NO
}


caddrauto() {
    export EPICS_CA_ADDR_LIST=
    export EPICS_CA_AUTO_ADDR_LIST=YES
}

signpython() {
    codesign -s "My Python Certificate" -f $(which python)
}
