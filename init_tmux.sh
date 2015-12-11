echo "* tmux"
if [ -z "$DOTFILES" ]; then
    DOTFILES=$PWD
fi

if [ ! -a $HOME/.tmux-all.conf ]; then
    ln -sf $DOTFILES/tmux-all.conf $HOME/.tmux-all.conf
else
    echo "** tmux configuration already exists"
fi

if [ ! -a $HOME/.tmux-1.9.conf ]; then
    ln -sf $DOTFILES/tmux-1.9.conf $HOME/.tmux-1.9.conf
else
    echo "** tmux-1.9 configuration already exists"
fi

if [ ! -a $HOME/.tmux-2.1.conf ]; then
    ln -sf $DOTFILES/tmux-2.1.conf $HOME/.tmux-2.1.conf
else
    echo "** tmux-2.1 configuration already exists"
fi

TMUX_VERSION_MAJOR="$(tmux -V | cut -d' ' -f2 | cut -d'.' -f1 | sed 's/[^0-9]*//g')"
TMUX_VERSION_MINOR="$(tmux -V | cut -d' ' -f2 | cut -d'.' -f2 | sed 's/[^0-9]*//g')"

if [ $TMUX_VERSION_MAJOR -eq 2 -a $TMUX_VERSION_MINOR -ge 1 ]; then
    echo "** Using tmux 2.1 config"
    ln -sf $DOTFILES/tmux-2.1.conf $HOME/.tmux.conf
else
    echo "** Using tmux 1.9 config"
    ln -sf $DOTFILES/tmux-1.9.conf $HOME/.tmux.conf
fi

if [ ! -d $HOME/.config/tmux ]; then
    ln -sf $DOTFILES/tmux $HOME/.config/tmux
else
    echo "** tmux xdg config path exists"
fi

TPM_PATH=$HOME/.config/tmux/plugins/tpm

if [ ! -d "$TPM_PATH" ]; then
    git clone https://github.com/tmux-plugins/tpm $TPM_PATH
    # fb path picker for tmux-fpp
    brew install fpp
fi
