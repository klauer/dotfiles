local options = {
  backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 2,                           -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  cursorline = true,                       -- highlight the current line
  expandtab = true,                        -- convert tabs to spaces
  fileencoding = "utf-8",                  -- the encoding written to a file
  guifont = "monospace:h17",               -- the font used in graphical neovim applications
  hidden = false,                          -- hidden buffers
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  incsearch = true,                        -- incremental search highlight
  mouse = "a",                             -- allow the mouse to be used in neovim
  number = true,                           -- set numbered lines
  numberwidth = 4,                         -- set number column width to 2 {default 4}
  pumheight = 10,                          -- pop up menu height
  relativenumber = false,                  -- set relative numbered lines
  scrolloff = 8,                           -- is one of my fav
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2,                         -- always show tabs
  sidescrolloff = 8,
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  tabstop = 2,                             -- insert 2 spaces for a tab
  timeoutlen = 300,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  undolevels = 10000,
  undoreload = 20000,
  updatetime = 100,                        -- faster completion (4000ms default)
  wrap = false,                            -- display lines as one long line
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

--Set colorscheme (order is important here)
if vim.env.TERM == "screen-256color" then
    vim.o.termguicolors = true
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work

vim.g.config_path = vim.env.HOME .. "/.config/nvim"

vim.g.dotfiles = vim.env.HOME .. '/dotfiles/nvim'

local conda_env_root = vim.env.HOME .. '/mc/envs'
local nvim_conda_python = conda_env_root .. '/nvim/bin/python'

vim.g.python_for_completion = vim.env.CONDA_PREFIX .. "/bin/python"
if vim.fn.empty(vim.g.python_for_completion) > 0 then
    vim.g.python_for_completion = nvim_conda_python
end

vim.g.python3_host_prog = nvim_conda_python
