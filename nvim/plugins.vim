let bundle_path=config_path . "/plugged"
call plug#begin(bundle_path)

" Use release branch
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" fzf - fuzzy file searching
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'


Plug 'edkolev/tmuxline.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

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
Plug 'jreybert/vimagit'
" fugitive extension for managing/merging git branches
Plug 'idanarye/vim-merginal', { 'branch': 'develop' }

" -- tmux
" better tmux integration
Plug 'christoomey/vim-tmux-navigator'
" tmux syntax highlighting
Plug 'tmux-plugins/vim-tmux'
" Focus event fix for tmux
Plug 'tmux-plugins/vim-tmux-focus-events'

" " Python position information
" Plug 'mgedmin/pythonhelper.vim'

" choosewin - toggle an overlay on windows to quickly jump to them
Plug 't9md/vim-choosewin'


" Python coverage
Plug 'mgedmin/coverage-highlight.vim'

" EPICS syntax highlighting
Plug 'NickeZ/epics.vim'

" " toggle location/quickfix list
" Plug 'milkypostman/vim-togglelist'

" location/quickfix list tools
Plug 'romainl/vim-qf'

" add emacs/readline style bindings to the command line
Plug 'vim-utils/vim-husk'

" " New neovim linter
" Plug 'w0rp/ale'

" colorschemes
Plug 'NLKNguyen/papercolor-theme'

" ansi escape sequences
Plug 'vim-scripts/AnsiEsc.vim'

" Use release branch
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()
