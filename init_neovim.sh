echo "* neovim"
if [ -z "$DOTFILES" ]; then
    DOTFILES=$PWD
fi

NVIM_VUNDLE_PATH=$HOME/.nvim/plugged
if [ ! -d $HOME/.nvim ]; then
    ln -sf $DOTFILES/nvim/ $HOME/.nvim
else
    echo "** neovim config directory already exists"
fi

if [ ! -a $HOME/.nvimrc ]; then
    ln -sf $DOTFILES/nvim/nvimrc $HOME/.nvimrc
else
    echo "** nvimrc already exists"
fi

mkdir -p nvim/bundle

echo "** install plugged"
PLUG_VIM=$HOME/.nvim/autoload/plug.vim
# if [ ! -f "$PLUG_VIM" ]; then
#     curl -fLo $PLUG_VIM --create-dirs \
#         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# fi

if [ ! -f "$PLUG_VIM" ]; then
    mkdir -p $(dirname $PLUG_VIM)
    wget -O $PLUG_VIM https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

pip install neovim

echo "** installing bundles"
nvim -c ":PlugInstall"
