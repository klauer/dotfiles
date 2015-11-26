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
