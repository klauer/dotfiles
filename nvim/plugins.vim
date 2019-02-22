if has('nvim')
    let config_path=$HOME . "/.config/nvim"
    runtime! plugin/python_setup.vim
else
    let config_path=$HOME . "/.vim"
endif

let bundle_path=config_path . "/plugged"

call plug#begin(bundle_path)

" fzf - fuzzy file searching
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Airline
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" better tmux integration
Plug 'christoomey/vim-tmux-navigator'
" Python position information
Plug 'mgedmin/pythonhelper.vim'
" git wrapper fugitive
Plug 'tpope/vim-fugitive'
" enable Gbrowse
Plug 'tpope/vim-rhubarb'
" git gutter annotation :GitGutter*
Plug 'airblade/vim-gitgutter'
" Plug 'mhinz/vim-signify'
" unimpaired - mappings for [ and ]
"              such as buffer, args, quickfix, loc, tags (b, a, q, l, t)
Plug 'tpope/vim-unimpaired'
" fugitive extension for managing/merging git branches
Plug 'idanarye/vim-merginal', { 'branch': 'develop' }
" jedi-vim not for completion, but for jump-to-definition
Plug 'davidhalter/jedi-vim'
" Asynchronous completion with deoplete
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'zchee/deoplete-jedi'
" snippets
if version >= 704
    "Plug 'SirVer/ultisnips'
endif
Plug 'honza/vim-snippets'
" easy alignment with motions
Plug 'junegunn/vim-easy-align'
" choosewin - toggle an overlay on windows to quickly jump to them
Plug 't9md/vim-choosewin'
" commentary with motion 'gc'
Plug 'tpope/vim-commentary'
" surround
Plug 'tpope/vim-surround'
" sessions
Plug 'tpope/vim-obsession'
" " Python coverage
Plug 'mgedmin/coverage-highlight.vim'

" EPICS syntax highlighting
Plug 'NickeZ/epics.vim'
" Unite/unite-outline
Plug 'Shougo/unite.vim'
Plug 'Shougo/unite-outline'
" toggle location/quickfix list
Plug 'milkypostman/vim-togglelist'
" add emacs/readline style bindings to the command line
Plug 'vim-utils/vim-husk'

" tmux syntax highlighting
Plug 'tmux-plugins/vim-tmux'

" New neovim linter
Plug 'w0rp/ale'
" Highlighting of f/F t/T motions
Plug 'unblevable/quick-scope'

" " Docstring area
" Plug 'Shougo/echodoc.vim'

" Python PEP8 indentation
Plug 'hynek/vim-python-pep8-indent'
" And assisted formatting, if desirable
Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }

" colorschemes
" Plug 'jnurmine/Zenburn'
Plug 'NLKNguyen/papercolor-theme'
Plug 'zenorocha/dracula-theme', {'rtp': 'vim/'}

" rust
Plug 'sebastianmarkow/deoplete-rust'

" ansi escape sequences
Plug 'vim-scripts/AnsiEsc.vim'

call plug#end()            " required

" call glaive#Install()
