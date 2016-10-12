#!/bin/bash
# ref: https://gist.github.com/ryin/3106801
set -e

# Variable version #
TMUX_VERSION=2.3

# Clean up
rm -rf $HOME/programs/libevent
rm -rf $HOME/programs/ncurses
rm -rf $HOME/programs/tmux


# Create our directories #
mkdir -p $HOME/install
mkdir -p $HOME/programs/libevent
mkdir -p $HOME/programs/ncurses
mkdir -p $HOME/programs/tmux

############
# libevent #
############
cd $HOME/install
wget https://github.com/downloads/libevent/libevent/libevent-2.0.19-stable.tar.gz
tar xvzf libevent-2.0.19-stable.tar.gz
cd libevent-*/
./configure --prefix=$HOME/programs/libevent --disable-shared
make
make install

############
# ncurses  #
############
cd $HOME/install
wget ftp://ftp.gnu.org/gnu/ncurses/ncurses-5.9.tar.gz
tar xvzf ncurses-5.9.tar.gz
cd ncurses-5.9
./configure --prefix=$HOME/programs/ncurses --enable-symlinks # LDFLAGS="-static"
make
make install

############
# tmux     #
############
cd $HOME/install
wget -O tmux-${TMUX_VERSION}.tar.gz https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz
tar xvzf tmux-${TMUX_VERSION}.tar.gz
cd tmux-${TMUX_VERSION}

# Build #
./configure --prefix=$HOME/programs/tmux CFLAGS="-I$HOME/programs/libevent/include -I$HOME/programs/ncurses/include/ncurses" LDFLAGS="-L$HOME/programs/libevent/lib -L$HOME/programs/libevent/include -L$HOME/programs/ncurses/lib -L$HOME/programs/ncurses/include/ncurses" PKG_CONFIG=/bin/false
CPPFLAGS="-I$HOME/programs/libevent/include -I$HOME/programs/ncurses/include/ncurses" LDFLAGS="-L$HOME/programs/libevent/lib -L$HOME/programs/libevent/include -L$HOME/programs/ncurses/lib -L$HOME/programs/ncurses/include/ncurses" make

# Move #
cp tmux $HOME/local/bin/tmux
