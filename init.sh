#!/bin/bash

# TODO: use rcm? https://github.com/thoughtbot/rcm
# TODO: or dotbot? https://github.com/anishathalye/dotbot

# -- vim
VIM_VUNDLE_PATH=~/.vim/bundle/Vundle.vim

echo "* vim"
ln -sf `pwd`/vim/ ~/.vim
ln -sf ~/.nvim/nvimrc ~/.vimrc

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
NVIM_VUNDLE_PATH=~/.nvim/bundle/Vundle.vim
ln -sf `pwd`/nvim/ ~/.nvim
ln -sf ~/.nvim/nvimrc ~/.nvimrc

mkdir -p nvim/bundle

echo "** install vundle"
if [ ! -d $NVIM_VUNDLE_PATH ]; then
    git clone https://github.com/gmarik/Vundle.vim.git $NVIM_VUNDLE_PATH
fi

echo "** installing bundles"
nvim -c ":BundleInstall"

# -- tmux
echo "* tmux"
ln -sf `pwd`/tmux.conf ~/.tmux.conf

# -- bash
echo "* bash"
echo "** aliases"
ln -sf `pwd`/aliases ~/.bash_aliases

echo "** source bashrc"
echo "source `pwd`/bashrc" >> ~/.bashrc

# -- git
echo "* git"
ln -sf `pwd`/gitconfig ~/.gitconfig

# -- hg
echo "* hg"
ln -sf `pwd`/hgrc ~/.hgrc

# -- conda
echo "* conda"
ln -sf `pwd`/.condarc ~/.condarc

# -- flake8 settings
echo "* flake8"
ln -sf `pwd`/flake8 ~/.config/flake8

source remote/init.sh
