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
