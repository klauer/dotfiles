#!/bin/bash

# TODO: use rcm? https://github.com/thoughtbot/rcm
# TODO: or dotbot? https://github.com/anishathalye/dotbot

# -- bash
echo "* bash"
echo "** aliases"
ln -sf `pwd`/aliases $HOME/.bash_aliases

conf_line="$(grep `pwd`/bashrc $HOME/.bashrc)"

echo "** source bashrc"
if [ -z "$conf_line" ]; then
    echo "Adding bashrc config"
    echo "source `pwd`/bashrc" >> $HOME/.bashrc
    source $HOME/.bashrc
else
    echo "bashrc config already set"
fi

# -- gdb
echo "* gdb"

if [ ! -d $HOME/.gdbinit ]; then
    wget -O gdbinit https://raw.githubusercontent.com/cyrus-and/gdb-dashboard/master/.gdbinit
    ln -sf `pwd`/gdbinit $HOME/.gdbinit
else
    echo "** gdb init already exists"
fi


# -- vim
source init_vim.sh

# -- neovim
source init_neovim.sh

# -- tmux
echo "* tmux"
if [ ! -a $HOME/.nvimrc ]; then
    ln -sf `pwd`/tmux.conf $HOME/.tmux.conf
else
    echo "** tmux configuration already exists"
fi


# -- git
echo "* git"
if [ ! -a $HOME/.gitconfig ]; then
    ln -sf `pwd`/gitconfig $HOME/.gitconfig
else
    echo "** git configuration already exists"
fi

# -- hg
echo "* hg"
if [ ! -a $HOME/.hgrc ]; then
    ln -sf `pwd`/hgrc $HOME/.hgrc
else
    echo "** hg configuration already exists"
fi

# -- conda
echo "* conda"
if [ ! -a $HOME/.condarc ]; then
    ln -sf `pwd`/condarc $HOME/.condarc
else
    echo "** conda configuration already exists"
fi

# -- binstar
echo "* binstar"

mkdir -p $HOME/.config/binstar

if [ ! -a $HOME/.config/binstar/config.yaml ]; then
    ln -sf `pwd`/binstar_config.yaml $HOME/.config/binstar/config.yaml
else
    echo "** binstar configuration already exists"
fi

# -- flake8 settings
echo "* flake8"
if [ ! -a $HOME/.config/flake8 ]; then
    ln -sf `pwd`/flake8 $HOME/.config/flake8
else
    echo "** flake8 configuration already exists"
fi

source remote/init.sh
