echo "* tmux"
if [ -z "$DOTFILES" ]; then
    DOTFILES=$PWD
fi

if [ ! -a $HOME/.tmux.conf ]; then
    ln -sf $DOTFILES/tmux.conf $HOME/.tmux.conf
else
    echo "** tmux configuration already exists"
fi

if [ ! -d $HOME/.config/tmux ]; then
    ln -sf $DOTFILES/tmux $HOME/.config/tmux
else
    echo "** tmux xdg config path exists"
fi

if [ ! -d $HOME/.terminfo ]; then
    ln -sf $DOTFILES/terminfo $HOME/terminfo
fi

TPM_PATH=$HOME/.config/tmux/plugins/tpm

if [ ! -d "$TPM_PATH" ]; then
    git clone https://github.com/tmux-plugins/tpm $TPM_PATH
    # fb path picker for tmux-fpp
    # brew install fpp
fi
