" snippets with ctrl-s (ensure bashrc has:
"   stty stop ''; stty start ''; stty -ixon; stty -ixoff;
" )
let g:UltiSnipsEnableSnipMate=0
let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"

let g:UltiSnipsRemoveSelectModeMappings = 1
let g:ultisnips_python_style='numpy'

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" let g:UltiSnipsSnippetDirectories=[
" \   g:dotfiles . "UltiSnips",
" \   g:dotfiles . "nvim/plugged/vim-snippets/UltiSnips"
" \ ]

" The default value for g:UltiSnipsJumpBackwardTrigger interferes with the
" built-in complete function: |i_CTRL-X_CTRL-K|. A workaround:
inoremap <c-x><c-k> <c-x><c-k>

" Note: interacts with completion-nvim by way of `g:completion_enable_snippet`
