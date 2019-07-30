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

function! TagInStatusLine()
    " call CocActionAsync('getCurrentFunctionSymbol')
    if (exists("b:coc_current_function"))
        return b:coc_current_function
    else
        return ""
    endif
endfunction

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction

let g:airline_section_c = airline#section#create(['%{StatusDiagnostic()}', 'file', ' ', 'readonly'])
" let g:airline_section_c = airline#section#create(['?', '%{TagInStatusLine()}', 'file', ' ', 'readonly'])
" let g:airline_section_c = airline#section#create(['%{b:coc_current_function)}', 'file', ' ', 'readonly'])
" let g:airline_section_c = airline#section#create(['%{g:coc_status)}', 'file', ' ', 'readonly'])
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
