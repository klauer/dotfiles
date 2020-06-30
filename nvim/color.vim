" vi: sw=2 ts=2 sts=2

let g:default_dark_theme = 'edge'
" let g:default_dark_theme = 'nightfly'
" let g:default_dark_theme = 'material'
let g:default_light_theme = 'PaperColor'

autocmd FileType tagbar
  \ if &background == "dark" |
  \   set winhighlight=Normal:TagbarDarkBackground |
  \ else |
  \   set winhighlight=Normal:TagbarLightBackground |
  \ endif

let g:airline_theme = 'edge'
let g:airline#extensions#tmuxline#enabled = 1

let g:edge_enable_italic = 1

function DarkBackground()
  set background=dark
  exec "colorscheme " . g:default_dark_theme

  if g:default_dark_theme == "material"
    let g:material_theme_style = 'default'
    hi ActiveWindowDarkBackground guibg=#1e282d
    hi InactiveWindowDarkBackground guibg=#33454d
    " Fix up matching parentheses:
    " hi MatchParen cterm=bold ctermfg=220 gui=bold guifg=#ffcc00 guibg=#263238
  elseif g:default_dark_theme == "nightfly"
    hi ActiveWindowDarkBackground guibg=#011627
    hi InactiveWindowDarkBackground guibg=#404060
  elseif g:default_dark_theme == "edge"
    hi ActiveWindowDarkBackground guibg=#2c2e34
    hi InactiveWindowDarkBackground guibg=#3c3e54
  endif
  hi TagbarDarkBackground guibg=black
endfunction

function LightBackground()
  set background=light
  exec "colorscheme " . g:default_light_theme

  hi ActiveWindowLightBackground guibg=white
  hi InactiveWindowLightBackground guibg=gray
  hi TagbarLightBackground guibg=white
endfunction

"nnoremap yol :silent call LightBackground()<cr>
"nnoremap yod :silent call DarkBackground()<cr>
"nnoremap yob :silent call SwapBackground()<cr>

" call LightBackground()
call DarkBackground()

