fun! FzfFindRoot()
    let s:top_marker_directories = ['.git', '.hg', 'configure']
    for marker_dir in s:top_marker_directories
        let path = finddir(marker_dir, expand("%:p:h").";")
        if path != ''
            return fnamemodify(substitute(path, marker_dir, "", ""), ":p:h")
        endif
    endfor
    return path
endfun


" " Better navigating through omnicomplete option list
" " See
" http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
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


" Camel case conversion stuff on visual selection
function! s:get_visual_selection()
  " http://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction


function! s:to_underscores(name)
python <<endpython
import re
import vim
name = vim.eval('a:name')
s1 = re.sub('(.)([A-Z][a-z]+)', r'\1_\2', name)
underscores = re.sub('([a-z0-9])([A-Z])', r'\1_\2', s1).lower()
vim.command('return "{}"'.format(underscores))
endpython
endfunction

function! Selection_CamelToUnderscores()
    let selection = s:get_visual_selection()
    let @x = s:to_underscores(selection)
    normal gvd
    normal "xP
endfunction


function! SelectMatchingCharacterColumn()
  " search pattern to determine the up and down motion counts
  let c=matchstr(getline('.'),'\%'.virtcol('.').'v.')
  let c=escape(c,'~$*\.')
  let p='^\(.*\%'.virtcol('.').'v'.c.'\)\@!.*$'
  " up motion (and reset) to select the top column segment
  let k=search(p,'nWb')
  let k=!k?line('.')-1:line('.')-k-1
  let k=!k?'':k.'ko'
  " down motion to select the bottom column segment
  let j=search(p,'nW')
  let j=!j?line('$')-line('.'):j-1-line('.')
  let j=!j?'':j.'j'
  " key sequence to select the whole column
  return "\<C-v>".k.j.(v:count>0?'V':'')
endfunction

