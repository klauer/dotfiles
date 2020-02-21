" .nvimrc ($HOME/.config/nvim/init.vim)
" vi: sw=2 ts=2 sts=2
" NOTES:
" * remember \c for turning off case sensitive search and \C for turning it on,
" * \v and \V for literal searches
" * ]ob and [ob from vim-unimpaired swaps background color
" * putty: if having issues, switch to using Xterm R6 function keys

" secure modeline processing
set secure

" allow backspacing over everything in insert mode
let mapleader="\<Space>"               " prefix when using <leader> in map
set acd                                " current directory follows file being edited
set autoindent                         " always set autoindenting on
set background=dark
set backspace=2 whichwrap+=<,>,[,]     " backspace and cursor keys wrap to previous/next line
set expandtab                          " tabs -> spaces (:retab)
set foldlevel=99
set foldmethod=indent
set guifont=Consolas:h10
set guioptions=cmgtTr
set history=500                        " keep x lines of command line history
set hlsearch
set ic                                 " case-insensitive search by default
set ignorecase smartcase
set imdisable                          " Disable the IME (gvim and unicode don't play well on different locale)
set incsearch                          " do incremental searching
set mouse+=a
set nobackup
set novb                               " ** visual bell, no beeping! **
set nowritebackup
set number                             " line numbering
set numberwidth=5
set ruler                              " show the cursor position all the time
set showcmd                            " display incomplete commands
set smartindent                        " smartindent when starting new line
set tabstop=4 shiftwidth=4 autoindent
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=*\\tmp\\*,*.exe
set wrap

if !has('nvim') && &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

if has("gui") || has("gui_running")
  " Alt-Space is System menu
  noremap <M-Space> :simalt ~<CR>
  inoremap <M-Space> <C-O>:simalt ~<CR>
  cnoremap <M-Space> <C-C>:simalt ~<CR>
endif

if &diff
  set diffopt=filler,context:3
endif

if has('nvim')
    let g:config_path=$HOME . "/.config/nvim"
else
    let g:config_path=$HOME . "/.vim"
endif

execute "source " . g:config_path . "/functions.vim"

if has('python') || has('python3')
  call SourceConfig("plugins.vim")
endif

filetype plugin indent on
syntax on

silent! colorscheme PaperColor

if exists(":TmuxNavigateLeft")
  " ensure ctrl-h works with splits, at least on osx for now...
  nnoremap <silent> <bs> :TmuxNavigateLeft<cr>
  noremap <silent> <c-j> :TmuxNavigateDown<cr>
  noremap <silent> <c-k> :TmuxNavigateUp<cr>
  noremap <silent> <c-l> :TmuxNavigateRight<cr>
  noremap <silent> <c-h> :TmuxNavigateLeft<cr>
  tnoremap <silent> <c-j> <c-\><C-N>:TmuxNavigateDown<cr>
  tnoremap <silent> <c-k> <c-\><C-N>:TmuxNavigateUp<cr>
  tnoremap <silent> <c-l> <c-\><C-N>:TmuxNavigateRight<cr>
  tnoremap <silent> <c-h> <c-\><C-N>:TmuxNavigateLeft<cr>
else
  noremap <c-j> <c-w>j
  noremap <c-k> <c-w>k
  noremap <c-l> <c-w>l
  noremap <c-h> <c-w>h
endif

" Don't use Ex mode, use Q for formatting
map Q gq

" select column of same character under cursor, enter visual block mode
nnoremap <expr> g<C-v> SelectMatchingCharacterColumn()

" nnoremap <Leader>C :Colors<CR>
nnoremap <Leader>G :BCommits<CR>
nnoremap <Leader>H :Helptags<CR>
nnoremap <Leader>T :BTags<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>c :silent! HighlightCoverage<CR>
nnoremap <Leader>g :Commits<CR>
nnoremap <Leader>o :GitFiles<CR>
nnoremap <Leader>t :Tags<CR>
nnoremap <c-p> :exe 'Files ' . FzfFindRoot()<CR>
nnoremap <c-s-P> :Files .<CR>

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" fzf - Mapping selecting mappings (!)
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

nmap <silent> <leader>L :windo if &buftype == "quickfix" \|\| &buftype == "locationlist" \| lclose \| endif<CR>
nmap <script> <silent> <leader>q :copen<cr>
nmap <script> <silent> <leader>l :lopen<cr>
nmap <script> <silent> <leader>l :CocList diagnostics<cr>

map <leader>H :lopen<cr>
map <leader>L :lclose<cr>
map <leader>K :lprev<cr>
map <leader>J :lnext<cr>

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>
" vnoremap <leader>c :s/\C\%V_\([a-z]\)/\u\1/g<CR>gUl<cr>:nohlsearch<cr>
" vnoremap <leader>u :s/\C\%V\<\@!\([A-Z]\)/\_\l\1/g<CR>gul<CR>:nohlsearch<CR>
vnoremap <leader>u :call Selection_CamelToUnderscores()<cr>

" Carriage return is now colon
nnoremap <CR> :
vnoremap <CR> :

map <leader>j :bnext<cr>
map <leader>k :bprevious<cr>
" remember to use: [b ]b from unimpaired now
map <leader>p :!python %<cr>
" buffer jump
" nnoremap <leader>b :ls<cr>:b<space>
nmap <Leader><Leader> V

let g:choosewin_overlay_enable = 1
nmap <Leader>w <Plug>(choosewin)

nnoremap <Leader>e :cd %:h\|execute "term"\|cd -<cr>

" vim-fugitive Ggrep identifier under cursor
nnoremap <Leader>* :execute ":Ggrep " . expand("<cword>")<CR>

" background color for omnicomplete
highlight Pmenu ctermbg=0 gui=bold
" signify/gitgutter
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>

highlight LineNr ctermfg=red
highlight LineNr guifg=#FF0000

"
" F3 recursively searches all files in the current directory (with the same
"    extension as the current file) for the word under the cursor
map <F3> <ESC>:vs<CR><ESC> :execute "vimgrep /\\<" . expand("<cword>") . "\\>./**/*." . expand("%:e")<CR><ESC>:lw<CR>
" map <F3> <ESC>:vs<CR><ESC> :execute "lvimgrep /" . expand("<cword>") . "./**/*." . expand("%:e")<CR><ESC>:lw<CR>
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
  cmap w!! :SUwrite<cr>
endif

noremap <S-return> <cr>
noremap <C-return> <cr>

inoremap <S-return> <cr>
inoremap <C-return> <cr>

" Move visual block - select and move with ctrl-j/k
xmap <c-k> <Plug>unimpairedMoveSelectionUp<esc>gv
xmap <c-j> <Plug>unimpairedMoveSelectionDown<esc>gv

" remap arrow keys to open up quickfix
nnoremap <Left> :lprev<cr>
nnoremap <Right> :lnext<cr>
nnoremap <Up> :cprev<cr>
nnoremap <Down> :cnext<cr>

if has('nvim')
  " neovim terminal related settings
  tnoremap <Esc> <C-\><C-n>
  " tnoremap <C-h> <C-\><C-n>:TmuxNavigateLeft<cr>
  " tnoremap <silent> <C-k> <C-\><C-n>:TmuxNavigateUp<cr>
  " tnoremap <silent> <C-j> <C-\><C-n>:TmuxNavigateDown<cr>
  " tnoremap <silent> <C-l> <C-\><C-n>:TmuxNavigateRight<cr>
  map <leader>i :vsplit term://ipython<cr>
  map <leader>s :vsplit term://bash<cr>
endif

call SourceConfig("airline.vim")
if has("autocmd")
  call SourceConfig("autocmds.vim")
endif
call SourceConfig("completion.vim")
if has("cscope")
    call SourceConfig("cscope.vim")
endif
" call SourceConfig("rust.vim")
call SourceConfig("snippets.vim")

let g:netrw_list_hide='.git,'
let g:netrw_list_hide.='\.svn,'
let g:netrw_list_hide.='\.hg,'
let g:netrw_list_hide.='\.py[co],'
let g:netrw_list_hide.='\.sw[op],'

let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'

" tmux related
" use the nice separators
let g:tmuxline_powerline_separators = 1
let g:tmuxline_preset = 'minimal'
let g:tmuxline_theme = 'powerline'

" Tmuxline powerline
"TmuxlineSnapshot! ~/dotfiles/tmuxline.conf

let g:airline#extensions#tmuxline#enabled = 1
