vim.cmd([[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd =
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end
]])

-- Autoformat
-- augroup _lsp
--   autocmd!
--   autocmd BufWritePre * lua vim.lsp.buf.formatting()
-- augroup end

-- Not-yet-converted vimscript - augroups and other files

-- Formatter settings
vim.api.nvim_exec(
  [[
    augroup formatting
      autocmd!
      autocmd FileType sh setlocal formatprg=shfmt\ -i\ 4
      autocmd FileType markdown setlocal formatprg=prettier\ --parser\ markdown
      autocmd FileType css setlocal formatprg=prettier\ --parser\ css
      autocmd FileType html setlocal formatprg=prettier\ --parser\ html
      autocmd FileType json setlocal formatprg=prettier\ --parser\ json
      autocmd FileType python setlocal formatprg=black-partial
      autocmd FileType lua setlocal formatprg=stylua\ --stdin-filepath\ %h\ -
      autocmd BufEnter *.lark setlocal formatprg=lark-format
    augroup END
]],
  false
)

-- When editing a file, always jump to the last known cursor position.  Don't
-- do it when the position is invalid or when inside an event handler (happens
-- when dropping a file on gvim).
vim.api.nvim_exec(
  [[
    function! GoToLastKnownPosition()
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal g`\""
        endif
    endfunction

    augroup LastKnownPosition
        autocmd!
        autocmd BufReadPost * call GoToLastKnownPosition()
    augroup end
]],
  false
)

-- pandoc
vim.api.nvim_exec(
  [[
    if executable('pandoc')
        autocmd! BufReadPost *.doc,*.docx,*.rtf,*.odp,*.odt silent %!pandoc "%" -t markdown -o /dev/stdout --columns=78
        " Remove docx from the list of extensions that zipplugin should use:
        let g:zipPlugin_ext='*.zip,*.jar,*.xpi,*.ja,*.war,*.ear,*.celzip,*.oxt,*.kmz,*.wsz,*.xap,*.docm,*.dotx,*.dotm,*.potx,*.potm,*.ppsx,*.ppsm,*.pptx,*.pptm,*.ppam,*.sldx,*.thmx,*.xlam,*.xlsx,*.xlsm,*.xlsb,*.xltx,*.xltm,*.xlam,*.crtx,*.vdw,*.glox,*.gcsx,*.gqsx'
    endif
]],
  false
)

-- pdftotext
vim.api.nvim_exec(
  [[
    if executable('pdftotext')
        autocmd BufReadPre *.pdf silent set ro
        autocmd BufReadPost *.pdf silent %!pdftotext -nopgbrk -layout -q -eol unix "%" - | fmt -w78
    endif
]],
  false
)

-- colorcolumn only on active window
vim.api.nvim_exec(
  [[
    " CR is colon in normal/visual mode, but not in quickfix mode:
    autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

    augroup ColorColumnOnEnter
        autocmd!
        autocmd WinEnter * set colorcolumn=80
        autocmd WinLeave * set colorcolumn=0
    augroup END
]],
  false
)

-- cursorline only on active window
vim.api.nvim_exec(
  [[
    augroup CursorLineOnlyInActiveWindow
        autocmd!
        autocmd VimEnter,WinEnter,BufWinEnter,FocusGained * setlocal cursorline
        autocmd VimLeave,WinLeave,BufLeave,FocusLost * setlocal nocursorline
    augroup END
]],
  false
)

-- active window background change
vim.api.nvim_exec(
  [[
    augroup ActiveWindowBackground
        autocmd!
        let g:background_blacklist = ["tagbar"]

        function! BackgroundChangeEnter()
            if index(g:background_blacklist, &ft) < 0
                if &background == "dark"
                    set winhighlight=Normal:ActiveWindowDarkBackground
                else
                    set winhighlight=Normal:ActiveWindowLightBackground
                endif
            endif
        endfunction

        function! BackgroundChangeLeave()
            if index(g:background_blacklist, &ft) < 0
                if &background == "dark"
                    set winhighlight=Normal:InactiveWindowDarkBackground
                else
                    set winhighlight=Normal:InactiveWindowLightBackground
                endif
            endif
        endfunction

        autocmd VimEnter,WinEnter,BufWinEnter,FocusGained * call BackgroundChangeEnter()
        autocmd VimLeave,WinLeave,BufLeave,FocusLost * call BackgroundChangeLeave()
    augroup END
]],
  false
)

-- relative numbers on active window
vim.api.nvim_exec(
  [[
    autocmd FileType jinja setlocal noautoindent nocindent nosmartindent indentexpr=
    set number relativenumber

    augroup numbertoggle
        autocmd!
        autocmd VimEnter,WinEnter,BufWinEnter,FocusGained * set relativenumber
        autocmd VimLeave,WinLeave,BufLeave,FocusLost * set norelativenumber
    augroup END
]],
  true
)
