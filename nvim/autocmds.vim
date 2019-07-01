" vi: sw=2 ts=2 sts=2
" Only do this part when compiled with support for autocommands.
autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

" fzf - fix c-j and c-k
autocmd FileType fzf tnoremap <buffer> <C-j> <Down>
autocmd FileType fzf tnoremap <buffer> <C-k> <Up>

autocmd FileType xml,htm,html,tmc nnoremap ]t vatatv
autocmd FileType xml,htm,html,tmc nnoremap [t vatatov

" Close the preview window when done
autocmd InsertLeave * if pumvisible() == 0 | pclose | endif

" strip off whitespace at the ends of lines for the following languages
" before writing to disk
autocmd FileType vim,python,c,cpp,java,php,pyrex autocmd BufWritePre <buffer> :%s/\s\+$//e

au BufEnter * call NoLastQuickfix()
function! NoLastQuickfix()
  " quit if the last window showing is just a quickfix one
  if &buftype=="quickfix"
    if winbufnr(2) == -1
      quit
    endif
  endif
endfunction

if executable('pandoc')
    autocmd! BufReadPost *.doc,*.docx,*.rtf,*.odp,*.odt silent %!pandoc "%" -t markdown -o /dev/stdout --columns=78
    " Remove docx from the list of extensions that zipplugin should use:
    let g:zipPlugin_ext='*.zip,*.jar,*.xpi,*.ja,*.war,*.ear,*.celzip,*.oxt,*.kmz,*.wsz,*.xap,*.docm,*.dotx,*.dotm,*.potx,*.potm,*.ppsx,*.ppsm,*.pptx,*.pptm,*.ppam,*.sldx,*.thmx,*.xlam,*.xlsx,*.xlsm,*.xlsb,*.xltx,*.xltm,*.xlam,*.crtx,*.vdw,*.glox,*.gcsx,*.gqsx'
endif

if executable('pdftotext')
    autocmd BufReadPre *.pdf silent set ro
    autocmd BufReadPost *.pdf silent %!pdftotext -nopgbrk -layout -q -eol unix "%" - | fmt -w78
endif

" vim-fugitive Ggrep should open the quick-fix window after
autocmd QuickFixCmdPost *grep* cwindow

" CR is colon in normal/visual mode, but not in quickfix mode:
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
