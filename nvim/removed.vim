" old/on the way out config

" sneak mode - 2 character fwd/rev search
" replace s for now ('cl' could replace it)
nnoremap s <Plug>(Sneak_s)
nnoremap S <Plug>(Sneak_S)
xnoremap s <Plug>(Sneak_s)
xnoremap S <Plug>(Sneak_S)
onoremap s <Plug>(Sneak_s)
onoremap S <Plug>(Sneak_S)

" nnoremap f <Plug>Sneak_f
" nnoremap F <Plug>Sneak_F
" xnoremap f <Plug>Sneak_f
" xnoremap F <Plug>Sneak_F
" onoremap f <Plug>Sneak_f
" onoremap F <Plug>Sneak_F

nmap gs <Plug>(SneakStreak)
nmap gS <Plug>(SneakStreakBackward)
xmap gs <Plug>(SneakStreak)
xmap gS <Plug>(SneakStreakBackward)
omap gs <Plug>(SneakStreak)
omap gS <Plug>(SneakStreakBackward)

" I'm not sure I like this just yet...
"replace 'f' with 1-char Sneak
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
"replace 't' with 1-char Sneak
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T
let g:sneak#streak = 1

" filetype plugin indent off
" set cindent
" set cino=(0

