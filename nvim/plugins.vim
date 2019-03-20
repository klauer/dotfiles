let bundle_path=config_path . "/plugged"

call plug#begin(bundle_path)

" fzf - fuzzy file searching
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
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

" Python position information
Plug 'mgedmin/pythonhelper.vim'
" jedi-vim not for completion, but for jump-to-definition
Plug 'davidhalter/jedi-vim'


" Asynchronous completion with deoplete
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  " Plug 'Shougo/denite.nvim'
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'deoplete-plugins/deoplete-jedi'


" snippets
Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'
" choosewin - toggle an overlay on windows to quickly jump to them
Plug 't9md/vim-choosewin'


" Python coverage
Plug 'mgedmin/coverage-highlight.vim'

" EPICS syntax highlighting
Plug 'NickeZ/epics.vim'
" toggle location/quickfix list
Plug 'milkypostman/vim-togglelist'
" add emacs/readline style bindings to the command line
Plug 'vim-utils/vim-husk'

" New neovim linter
Plug 'w0rp/ale'

" Docstring area
Plug 'Shougo/echodoc.vim'

" Python PEP8 indentation
Plug 'hynek/vim-python-pep8-indent'
" And assisted formatting, if desirable
Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }

" colorschemes
Plug 'NLKNguyen/papercolor-theme'

" ansi escape sequences
Plug 'vim-scripts/AnsiEsc.vim'

call plug#end()
