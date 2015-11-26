echo "* neovim"
NVIM_VUNDLE_PATH=$HOME/.nvim/plugged
if [ ! -d $HOME/.vim ]; then
    ln -sf `pwd`/nvim/ $HOME/.nvim
else
    echo "** neovim config directory already exists"
fi

if [ ! -a $HOME/.nvimrc ]; then
    ln -sf $HOME/.nvim/nvimrc $HOME/.nvimrc
else
    echo "** nvimrc already exists"
fi

mkdir -p nvim/bundle

echo "** install plugged"
if [ ! -d $NVIM_VUNDLE_PATH ]; then
    curl -fLo $HOME/.nvim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

pip install --user neovim

echo "** installing bundles"
nvim -c ":PlugInstall"
