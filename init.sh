#!/bin/bash

# TODO: use rcm? https://github.com/thoughtbot/rcm

VUNDLE_PATH=~/.vim/bundle/Vundle.vim

echo "* vim"
ln -sf `pwd`/vim/ ~/.vim
ln -sf ~/.vim/vimrc ~/.vimrc

mkdir -p vim/bundle

echo "** install vundle"
if [ ! -d $VUNDLE_PATH ]; then
    git clone https://github.com/gmarik/Vundle.vim.git $VUNDLE_PATH
fi

echo "** installing bundles"
vim -c ":BundleInstall"

echo "* tmux"
ln -sf `pwd`/tmux.conf ~/.tmux.conf

echo "* bash"
echo "** aliases"
ln -sf `pwd`/aliases ~/.bash_aliases

echo "** source bashrc"
echo "source `pwd`/bashrc" >> ~/.bashrc

