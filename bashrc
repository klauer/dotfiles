#!/bin/bash
# vi: sw=2 ts=2 sts=2

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

realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
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

cdd() {
  # fzf cd to docs
  local dir
 
  if [ ! -z "$@" ]; then
    query_str="-q $@"
  else
    if [ ! -z "$TMUX_SESSION_NAME" ]; then
      query_str="-q ${TMUX_SESSION_NAME}"
    else
      query_str=""
    fi
  fi
  dir=$(find $HOME/docs -maxdepth 1 -type d 2> /dev/null | fzf +m $query_str) &&
  echo "cd \"$dir\"" &&
  history -s "cd \"$dir\"" &&
  cd "$dir"
}

cdr() {
  # fzf cd to repo
  local dir
 
  if [ ! -z "$@" ]; then
    query_str="-q $@"
  else
    if [ ! -z "$TMUX_SESSION_NAME" ]; then
      query_str="-q ${TMUX_SESSION_NAME}"
    else
      query_str=""
    fi
  fi
  dir=$(find $HOME/Repos -maxdepth 1 -type d 2> /dev/null | fzf +m $query_str) &&
  echo "cd \"$dir\"" &&
  history -s "cd \"$dir\"" &&
  cd "$dir"
}

function cdR() {
  # cd to repo
  repo="${1:-$TMUX_SESSION_NAME}"
  if [ -n "${repo}" ]; then
      cd "$HOME/Repos/${repo}"
  else
      cdr
  fi
}

function cdp() {
    MODULE=$1
    prev_path=$PWD
    cd /

    module_path=$(python -c "import $MODULE, pathlib; print(str(pathlib.Path($MODULE.__file__).parent))")
    cd $prev_path
    pushd $module_path
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
    codesign -s "My Python Certificate 2022" -f $(which python)

    # GDB? https://sourceware.org/gdb/wiki/PermissionsDarwin
}

if [ ! -z "$TMUX" ]; then
    export TMUX_SESSION_NAME=$(tmux display-message -p '#S')
    conda deactivate && conda deactivate
    CONDA_ENV=base
    if [ -f "$HOME/Repos/$TMUX_SESSION_NAME/.conda_env" ]; then
        CONDA_ENV=$(cat "$HOME/Repos/$TMUX_SESSION_NAME/.conda_env")
        echo "Found .conda_env file in $TMUX_SESSION_NAME repository: $CONDA_ENV"
    elif [ -n "$TMUX_SESSION_NAME" ] && [ -d "$HOME/mc/envs/$TMUX_SESSION_NAME" ]; then
        echo "Using tmux session name for conda: $TMUX_SESSION_NAME"
        CONDA_ENV=$TMUX_SESSION_NAME
    fi
    conda activate "$CONDA_ENV"
    echo "python -> $(which python)"
    if test -n "$(command -v ipython)"; then
        echo "ipython -> $(which ipython)"
    fi
fi

# sshcd - ssh to a host, retaining your current directory
#   Usage:   sshcd hostname [optional command to run]
#   Example: sshcd lfe-console ls -l
sshrun() {
    host=$1;
    shift;
    command="$*";

    ssh -t "$host" "
        bash --init-file <(
          echo \"source ~/.bash_profile;
          ${command} 
          \"
        )
      "
}

sshcd() {
    host=$1;
    shift;
    command="$*";
    path="$PWD"

    if [[ "$path" =~ $HOME/.* ]]; then
      path=${path#"$HOME/"}
      echo 'Adjusting path for $HOME:' "$path"
    fi

    sshrun "$host" "
      cd '$path';
      pwd;
      source pcds_conda;
      ${command}
    "
}
