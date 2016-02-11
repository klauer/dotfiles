DOTFILES=`pwd`

# Add source zshrc line
conf_line="$(grep $DOTFILES/zshrc $HOME/.zshrc)"

if [ -z "$conf_line" ]; then
    echo "Adding zshrc config"
    echo "source $DOTFILES/zshrc" >> $HOME/.zshrc
fi

# Install oh-my-zsh because it seems handy
zsh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
