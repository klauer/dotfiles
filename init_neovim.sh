echo "* neovim"
if [ -z "$DOTFILES" ]; then
    DOTFILES=$PWD
fi

PLUGGED_PATH=$DOTFILES/nvim/plugged
PLUG_VIM=$HOME/.config/nvim/autoload/plug.vim

if [ ! -d $HOME/.config/nvim ]; then
    ln -sf $DOTFILES/nvim/ $HOME/.config/nvim
else
    echo "** neovim config directory already exists"
fi

mkdir -p $PLUGGED_PATH
mkdir -p $(dirname $PLUG_VIM)

echo "** install plugged"
curl -fLo $PLUG_VIM --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if [ ! -f "$PLUG_VIM" ]; then
    wget -O $PLUG_VIM https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

pip install --user neovim

echo "** installing bundles"
nvim -c ":PlugInstall"
