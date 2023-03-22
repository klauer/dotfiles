vim.cmd([[
try
  colorscheme tokyonight
catch /^Vim\%((\a\+)\)\=:E185/
  try
    colorscheme minischeme
  catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme desert
  set background=dark
endtry
]])
