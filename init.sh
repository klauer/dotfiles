#!/bin/bash

# TODO: use rcm? https://github.com/thoughtbot/rcm
# TODO: or dotbot? https://github.com/anishathalye/dotbot

# -- bash
echo "* bash"
echo "** aliases"
ln -sf `pwd`/aliases $HOME/.bash_aliases

conf_line="$(grep `pwd`/bashrc $HOME/.bashrc)"

echo "** source bashrc"
if [ -z "$grep" ]; then
    echo "Adding bashrc config"
    echo "source `pwd`/bashrc" >> $HOME/.bashrc
    source $HOME/.bashrc
else
    echo "bashrc config already set"
fi

# -- vim
VIM_VUNDLE_PATH=$HOME/.vim/bundle/Vundle.vim

echo "* vim"

if [ ! -d $HOME/.vim ]; then
    ln -sf `pwd`/vim/ $HOME/.vim
else
    echo "** vim config directory already exists"
fi

if [ ! -a $HOME/.vimrc ]; then
    ln -sf $HOME/.nvim/nvimrc $HOME/.vimrc
else
    echo "** vimrc already exists"
fi

mkdir -p vim/bundle

echo "** install vundle"
if [ ! -d $VIM_VUNDLE_PATH ]; then
    git clone https://github.com/gmarik/Vundle.vim.git $VIM_VUNDLE_PATH
fi

pip install --user flake8

echo "** installing bundles"
vim -c ":BundleInstall"

# -- neovim
echo "* neovim"
NVIM_VUNDLE_PATH=$HOME/.nvim/bundle/Vundle.vim
if [ ! -d $HOME/.vim ]; then
    ln -sf `pwd`/nvim/ $HOME/.nvim
fi

if [ ! -a $HOME/.nvimrc ]; then
    ln -sf $HOME/.nvim/nvimrc $HOME/.nvimrc
fi

mkdir -p nvim/bundle

echo "** install vundle"
if [ ! -d $NVIM_VUNDLE_PATH ]; then
    git clone https://github.com/gmarik/Vundle.vim.git $NVIM_VUNDLE_PATH
fi

pip install --user neovim

echo "** installing bundles"
nvim -c ":BundleInstall"

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

# -- flake8 settings
echo "* flake8"
if [ ! -a $HOME/.config/flake8 ]; then
    ln -sf `pwd`/flake8 $HOME/.config/flake8
else
    echo "** flake8 configuration already exists"
fi

source remote/init.sh
