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

echo "** install plug"
if [ ! -d $VIM_VUNDLE_PATH ]; then
    curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

pip install --user flake8

echo "** installing bundles"
vim -c ":PlugInstall"
