let g:airline#extensions#ale#enabled = 0
let g:airline_powerline_fonts=1 " if funny symbols show in the status line, set this to 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#bufferline#enabled = 0
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline_section_a = airline#section#create(['mode', 'crypt', 'paste', 'spell', 'iminsert'])
let g:airline_section_b = airline#section#create_left(['hunks', 'branch'])
let g:airline_section_c = airline#section#create(['file', ' ', 'readonly'])
let g:airline_section_y = airline#section#create_right(['ffenc'])
let g:airline_section_z = airline#section#create(['linenr', 'maxlinenr', '|%3v'])
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
call extend(g:airline_mode_map, {
    \ '__' : '------',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'v'  : 'V',
    \ 'V'  : 'VL',
    \ 'c'  : 'COMMAND',
    \ '' : 'V-BLOCK',
    \ 's'  : 'SELECT',
    \ 'S'  : 'S-LINE',
    \ '' : 'S-BLOCK',
    \ 't'  : 'TERMINAL',
    \ }, 'force')
