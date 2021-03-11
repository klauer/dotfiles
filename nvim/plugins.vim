let bundle_path=config_path . "/plugged"
call plug#begin(bundle_path)

" Treesitter/language-server settings
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/completion-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

" Autodocstring magic to replace my snippets:
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

" Flake8 / autopep8 by way of ALE...?
Plug 'dense-analysis/ale'

" fzf - fuzzy file searching
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'edkolev/tmuxline.vim'

Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

" -- tpope
" commentary with motion 'gc'
Plug 'tpope/vim-commentary'
" surround
Plug 'tpope/vim-surround'
" unimpaired - mappings for [ and ]
"              such as buffer, args, quickfix, loc, tags (b, a, q, l, t)
Plug 'tpope/vim-unimpaired'

" -- git
" git wrapper fugitive
Plug 'tpope/vim-fugitive'
" enable Gbrowse
Plug 'tpope/vim-rhubarb'
" git gutter annotation :GitGutter*
Plug 'airblade/vim-gitgutter'
" git blame in a popup
Plug 'rhysd/git-messenger.vim'

" -- tmux
" better tmux integration
Plug 'christoomey/vim-tmux-navigator'
" tmux syntax highlighting
Plug 'tmux-plugins/vim-tmux'
" Focus event fix for tmux
Plug 'tmux-plugins/vim-tmux-focus-events'

" choosewin - toggle an overlay on windows to quickly jump to them
Plug 't9md/vim-choosewin'

" aerojump - fuzzy find in buffer
" Plug 'ripxorip/aerojump.nvim', { 'do': ':UpdateRemotePlugins' }

" location/quickfix list tools
Plug 'romainl/vim-qf'

" add emacs/readline style bindings to the command line
Plug 'vim-utils/vim-husk'

" Python
" coverage
" Plug 'mgedmin/coverage-highlight.vim'

" PEP8 indentation
Plug 'Vimjas/vim-python-pep8-indent'

" Slime
Plug 'jpalardy/vim-slime'

" colorschemes
Plug 'NLKNguyen/papercolor-theme'
" Plug 'kaicataldo/material.vim'
" Plug 'sainnhe/edge'
" Plug 'Iron-E/nvim-highlite'
Plug 'arzg/vim-colors-xcode'

" ansi escape sequences
Plug 'vim-scripts/AnsiEsc.vim'

" IEC 61131-3 syntax
" Plug 'jubnzv/IEC.vim'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" EPICS syntax highlighting + snippets
Plug 'NickeZ/epics.vim'
Plug 'klauer/epics-ultisnips'

" tagbar
Plug 'preservim/tagbar'

" indentation markers
Plug 'Yggdroot/indentLine'

" Jinja
" Plug 'Glench/Vim-Jinja2-Syntax'

" Code context!
Plug 'wellle/context.vim'

" Left/right motion for params
Plug 'AndrewRadev/sideways.vim'

" " indentation-level objects (unmaintained original)
" Plug 'klauer/vim-indent-object'
" Try relying on treesitter for now

call plug#end()
