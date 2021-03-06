# Path to your oh-my-zsh installation.
export ZSH=$HOME/dotfiles/remote/oh-my-zsh

# brew
export PATH="$HOME/.linuxbrew/bin:$PATH"
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
alias brew="https_proxy=$http_proxy brew"

# export CONDA_ROOT=$HOME/mc
# export CONDA_DEFAULT_ENV=bs

export CONDA_ROOT=$HOME/ramdisk/mc
unset CONDA_DEFAULT_ENV

# export PATH=$HOME/.local/bin:$CONDA_ROOT/$CONDA_DEFAULT_ENV/bin:$PATH
if [ -z "$CONDA_DEFAULT_ENV" ]; then
    export PATH="$CONDA_ROOT/bin:$PATH"
else
    echo "Setting conda environment to: $CONDA_DEFAULT_ENV"
    export PATH="$CONDA_ROOT/envs/$CONDA_DEFAULT_ENV/bin:$PATH"
    # export CONDA_OLD_PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\u@\h:\w\$ "
    # export PS1="($CONDA_DEFAULT_ENV)$CONDA_OLD_PS1"
fi

# local bin directory
export PATH="$HOME/.local/bin/:$PATH"



# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

source $HOME/.bash_aliases
