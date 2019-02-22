" only use jedi completion with ctrl-space, not after '.'
" let g:jedi#goto_assignments_command = "<Leader>g"
let g:jedi#auto_initialization = 1
let g:jedi#goto_definitions_command = "<Leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<Leader>n"
let g:jedi#completions_command = ""
let g:jedi#rename_command = "<Leader>r"
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
let g:jedi#show_call_signatures = 1
let g:jedi#use_splits_not_buffers = "top"
let g:jedi#smart_auto_mappings = 0
let g:jedi#force_python_version = 3

" use deoplete instead of jedi:
let g:jedi#completions_enabled = 0
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#show_docstring = 1
let g:deoplete#sources#jedi#ignore_errors = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
" let g:deoplete#disable_auto_complete = 1

augroup omnifuncs
  autocmd!
  autocmd FileType python setlocal omnifunc=jedi#completions
augroup end

" fzf - Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" <CR>/enter: close completion popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return deoplete#mappings#smart_close_popup() . "\<CR>"
  "replace with deoplete#mappings#close_popup() to allow completion to occur
endfunction

set completeopt+=preview,menu,menuone
