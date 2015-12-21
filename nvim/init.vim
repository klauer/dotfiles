" .nvimrc ($HOME/.config/nvim/init.vim)
"
" Use Vim settings, rather then Vi settings
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
colorscheme ir_black
" change dir to file location
set acd                " current directory follows file being edited
set ic                 " case-insensitive search by default
set guifont=Consolas:h10

set imdisable          " Disable the IME (gvim and unicode don't play well on different locale)
set guioptions=cmgtTr 
set autoindent         " always set autoindenting on
set history=500        " keep x lines of command line history
set ruler              " show the cursor position all the time
set showcmd            " display incomplete commands
set incsearch          " do incremental searching
let mapleader = "\<Space>" " prefix when using <leader> in map

" Don't use Ex mode, use Q for formatting
map Q gq

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " filetype plugin indent on

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

endif " has("autocmd")

" set the 'cpoptions' to its Vim default
if 1    " only do this when compiled with expression evaluation
  let s:save_cpo = &cpoptions
endif

" backspace and cursor keys wrap to previous/next line
set backspace=2 whichwrap+=<,>,[,]

" backspace in Visual mode deletes selection
vnoremap <BS> d

" Alt-Space is System menu
if has("gui")
  noremap <M-Space> :simalt ~<CR>
  inoremap <M-Space> <C-O>:simalt ~<CR>
  cnoremap <M-Space> <C-C>:simalt ~<CR>
endif

set tabstop=4 shiftwidth=4 autoindent
set expandtab          " tabs -> spaces (:retab)
set smartindent        " smartindent when starting new line
set foldmethod=indent
set foldlevel=99
set novb                 " ** visual bell, no beeping! **
set nobackup
set nowritebackup
set wrap

set mouse+=a
if !has('nvim') && &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

if &diff
  set diffopt=filler,context:3
endif

" ----- plugged ------
" set the runtime path to include plugged and initialize

if has('python')
    if has('nvim')
        let bundle_path=$HOME . "/.config/nvim/plugged"
        runtime! plugin/python_setup.vim
    else
        let bundle_path=$HOME . "/.vim/plugged"
    endif

    call plug#begin(bundle_path)

    " Ctrl-P - fuzzy file searching
    Plug 'kien/ctrlp.vim'
    " Airline
    Plug 'bling/vim-airline'
    " better tmux integration
    Plug 'christoomey/vim-tmux-navigator'
    " Python PEP8 checking
    Plug 'nvie/vim-flake8'
    " git wrapper fugitive
    Plug 'tpope/vim-fugitive'
    " git gutter annotation :GitGutter*
    Plug 'airblade/vim-gitgutter'
    " unimpaired - mappings for [ and ]
    "              such as buffer, args, quickfix, loc, tags (b, a, q, l, t)
    Plug 'tpope/vim-unimpaired'
    " fugitive extension for managing/merging git branches
    Plug 'idanarye/vim-merginal'
    " jedi-vim completion
    Plug 'davidhalter/jedi-vim'
    " snippets
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    " Tabular alignment :Tab/,
    Plug 'godlygeek/tabular'
    " QFEnter - quickfix open target window customization
    Plug 'yssl/QFEnter'
    " choosewin - toggle an overlay on windows to quickly jump to them
    Plug 't9md/vim-choosewin'
    " commentary with motion 'gc'
    Plug 'tpope/vim-commentary'

    " tmuxline
    " Plug 'edkolev/tmuxline.vim'
    " tmux syntax highlighting
    Plug 'tmux-plugins/vim-tmux'

    if has('nvim')
        " New neovim linter
        Plug 'benekastah/neomake'
    endif

    " All of your Plugins must be added before the following line
    call plug#end()            " required
    
    " ensure ctrl-h works with splits, at least on osx for now...
    nnoremap <silent> <bs> :TmuxNavigateLeft<cr>
endif

filetype plugin indent on    " required
syntax on

" ----- end plug ------

" line numbering
set number
set numberwidth=5

" Ctrl-P setup:
" -> r = nearest ancestor with repo directory
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.exe              " Windows

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|pyc|pyo)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" only use jedi completion with ctrl-space, not after '.'
let g:jedi#goto_assignments_command = "<Leader>g"
let g:jedi#goto_definitions_command = "<Leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<Leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<Leader>r"
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0

" background color for omnicomplete
highlight Pmenu ctermbg=0 gui=bold

" " Better navigating through omnicomplete option list
" " See
" http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
set completeopt=longest,menuone
function! OmniPopup(action)
    if pumvisible()
        if a:action == 'j'
            return "\<C-N>"
        elseif a:action == 'k'
            return "\<C-P>"
        endif
    endif
    return a:action
endfunction

inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>

" snippets with ctrl-s (ensure bashrc has:
"   stty stop ''; stty start ''; stty -ixon; stty -ixoff;
" )
let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsListSnippets="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEnableSnipMate=0

let g:ultisnips_python_style='numpy'

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" make QFEnter behavior map to the same keys as Ctrl-P
let g:qfenter_vopen_map = ['<C-v>']
let g:qfenter_hopen_map = ['<C-CR>', '<C-s>', '<C-x>']
let g:qfenter_topen_map = ['<C-t>']

highlight LineNr ctermfg=red
highlight LineNr guifg=#FF0000

" let NERDTreeIgnore = ['\.pyc$']
let g:netrw_list_hide='.git,'
let g:netrw_list_hide.='\.svn,'
let g:netrw_list_hide.='\.hg,'
let g:netrw_list_hide.='\.py[co],'
let g:netrw_list_hide.='\.sw[op],'

if has('nvim')
    " use neomake's linter
    " E501 = line too long, C901 = too complex
    " let g:neomake_python_pep8_maker = {'args': ['--ignore', 'E501,C901']}
    autocmd BufWritePost *.py Neomake
else
    " for regular vim, use flake8 linter
    " flake8 config is in ~/.config/flake8
    autocmd BufWritePost *.py call Flake8()
endif

if has("autocmd")
    autocmd FileType python,c,cpp,java,php autocmd BufWritePre <buffer> :%s/\s\+$//e
endif

" -- setup airline
set t_Co=256                    " 256-color terminal
let g:airline_powerline_fonts=1 " if funny symbols show in the status line, set this to 0
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'

" -- special mappings
"  putty note: if having issues, switch to using Xterm R6 function keys
"
" F3 recursively searches all files in the current directory (with the same
"    extension as the current file) for the word under the cursor
map <F3> <ESC>:vs<CR><ESC> :execute "lvimgrep /" . expand("<cword>") . "./**/*." . expand("%:e")<CR><ESC>:lw<CR>
" F4 recursively searches all files in the current directory for the word
"    under the cursor
map <F4> <ESC>:vs<CR><ESC> :execute "lvimgrep /" . expand("<cword>") . "./**"<CR><ESC>:lw<CR>
" F5 writes the current file and runs make
map <F5> :w<cr>:make<cr>
imap <F5> <esc>:w<cr>:make<cr>

" Sudo write (not so safe...)
if executable('sudo') && executable('tee')
  command! SUwrite
        \ execute 'w !sudo tee % > /dev/null' |
        \ setlocal nomodified
endif

cmap w!! :SUwrite<cr>

" Move visual block - select and move with R/F
vnoremap F :m '>+1<CR>gv=gv 
vnoremap R :m '<-2<CR>gv=gv

noremap <S-return> <cr>
noremap <C-return> <cr>
inoremap <S-return> <cr>
inoremap <C-return> <cr>
" * to select word, %s//repl_with/cg

" Floats -> double
" map <C-F> :s/\([0-9]\)f/\1/ <cr>
" map <C-T> :s/;\s*$// <cr>

" Simplified window motion (ctrl+direction)
" note that these also get mapped with the tmux-navigator plugin
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
map <c-=> <c-w>=

" remap arrow keys to open up quickfix
map <Left> :copen<cr>
map <Right> :cclose<cr>
map <Up> :cprev<cr>
map <Down> :cnext<cr>

map <leader>H :lopen<cr>
map <leader>L :lclose<cr>
map <leader>K :lprev<cr>
map <leader>J :lnext<cr>

" Camel case conversion stuff on line
vnoremap <leader>c :s/\C\%V_\([a-z]\)/\u\1/g<CR>gUl<cr>:nohlsearch<cr>
vnoremap <leader>u :s/\C\%V\<\@!\([A-Z]\)/\_\l\1/g<CR>gul<CR>:nohlsearch<CR>

map <leader>j :bnext<cr>
map <leader>k :bprevious<cr>
" remember to use: [b ]b from unimpaired now
map <leader>p :!python %<cr>


" Carriage return is now colon
nnoremap <CR> :

nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>O :CtrlPBuffer<CR>
nmap <Leader><Leader> V

nmap  <Leader>w  <Plug>(choosewin)

" - tags (c-] for jump to definition, then ]t from vim-unimpaired)
" TODO get ptags.py... from somewhere
let ptag_path="/usr/local/Cellar/python3/3.4.3/Frameworks/Python.framework/Versions/3.4/share/doc/python3.4/examples/Tools/scripts/ptags.py"

" update the tags for the current buffer
nmap <Leader>t :execute "!python " . ptag_path . " %"<cr>

" update the tags for all files in the arglist
" nmap <Leader>T :execute "!python " . ptag_path . " " args<cr>

let g:choosewin_overlay_enable = 1

" filetype plugin indent off
" set cindent
" set cino=(0

" Tmux-related
" use the nice separators
" let g:tmuxline_powerline_separators = 1
" let g:tmuxline_preset = 'minimal'
" let g:tmuxline_theme = 'powerline'
" Tmuxline powerline minimal
" TmuxlineSnapshot ~/dotfiles/tmuxline.conf

" add on conda lib paths so that :find works
source ~/dotfiles/nvim/conda_path.vim
