-- vi: sw=4 ts=4 sts=4 expandtab
--
-- Install packer, if needed
local execute = vim.api.nvim_command

vim.g.config_path = vim.env.HOME .. "/.config/nvim"

local dotfiles = vim.env.HOME .. '/dotfiles/nvim'
local conda_env_root = vim.env.HOME .. '/mc/envs'
local nvim_conda_python = conda_env_root .. '/nvim/bin/python'
local nvim_debugpy_python = conda_env_root .. '/debugpy/bin/python'

local packer_path  = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_repo = 'wbthomason/packer.nvim'
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
  execute('!git clone https://github.com/' .. packer_repo .. ' ' .. packer_path)
end

vim.g.python_for_completion = vim.env.CONDA_PREFIX .. "/bin/python"
if vim.fn.empty(vim.g.python_for_completion) > 0 then
    vim.g.python_for_completion = nvim_conda_python
end

-- Install packer if necessary
local start_path = dotfiles .. '/start'
local packer_repo = 'wbthomason/packer.nvim'

-- Recompile packer after updating init.lua
vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]], false)

local use = require('packer').use

require('packer').startup(function()
    use 'wbthomason/packer.nvim'              -- Package manager
    use 'tpope/vim-fugitive'                  -- Git commands in nvim
    use 'tpope/vim-rhubarb'                   -- Fugitive-companion to interact with github
    use 'tpope/vim-commentary'                -- "gc" to comment visual regions/lines
    use 'tpope/vim-surround'                  -- 
    use 'tpope/vim-unimpaired'                -- mappings for [ and ], such as buffer, args, quickfix, loc, tags (b, a, q, l, t)
    use 'ludovicchabant/vim-gutentags'        -- Automatic tags management
    use 'vim-utils/vim-husk'                  -- emacs/readline-style bindings in commandline
    use 'mbbill/undotree'                     -- undo tree viewing

    -- UI to select things (files, grep results, open buffers...)
    use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }
    use {'joshdick/onedark.vim', branch = 'main' } -- Theme inspired by Atom
    use 'itchyny/lightline.vim'               -- Fancier statusline
    use 't9md/vim-choosewin'                  -- Choose a window with an overlay
    use 'romainl/vim-qf'                      -- location/quickfix list tools

    -- tmux-related
    use 'christoomey/vim-tmux-navigator'
    use 'tmux-plugins/vim-tmux'               -- tmux syntax highlighting
    use 'jpalardy/vim-slime'                  -- send text to other panes

    -- clipboard-related
    use 'klauer/vim-oscyank'                  -- use OSC-52 to copy through tmux/vim/etc (set clipboard below)

    -- use 'tmux-plugins/vim-tmux-focus-events'  -- Focus events fix (obsolete)
    -- Add indentation guides even on blank lines
    use 'lukas-reineke/indent-blankline.nvim'

    -- Add git related info in the signs columns and popups
    use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'} }
    use 'rhysd/git-messenger.vim'             -- Git blame in a popup

    -- LSP-related
    use 'neovim/nvim-lspconfig'               -- Collection of configurations for built-in LSP client
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'hrsh7th/nvim-compe'                  -- Autocompletion plugin
    
    -- Python
    use 'Vimjas/vim-python-pep8-indent'       -- PEP8 indentation
    use 'preservim/tagbar'
    use 'wellle/context.vim'                  -- Code context
    -- use 'AndrewRadev/sideways.vim'            -- Left/right motion for params
    -- Flake8 / autopep8 by way of ALE...?
    -- use 'dense-analysis/ale'

    -- Miscellaneous
    use 'vim-scripts/AnsiEsc.vim'             -- ANSI escape sequences
    use { 
        'idbrii/textobj-word-column.vim',     -- Column selection (ic, aC)
        requires = { 'kana/vim-textobj-user' },
    }

    -- Web dev
    use 'mattn/emmet-vim'                     -- Easier tags, at least

    -- Debugging / debug adapter protocol
    use { 
        'rcarriga/nvim-dap-ui', 
        requires = {'mfussenegger/nvim-dap'} 
    }

    -- Snippets
    use 'SirVer/ultisnips'
    use 'honza/vim-snippets'

    -- EPICS
    use 'NickeZ/epics.vim'
    use 'klauer/epics-ultisnips'

    -- colorschemes
    use 'arzg/vim-colors-xcode'
    use 'kaicataldo/material.vim'

end)


-- Secure modeline processing
vim.o.secure = true
vim.o.visualbell = false  -- no beeping!

--Incremental live completion (test)
vim.o.inccommand = "nosplit"

-- Split options
vim.g.splitbelow = true

--Set highlight on search
vim.o.hlsearch = true
vim.o.incsearch = true

--Make line numbers default
vim.wo.number = true
vim.wo.numberwidth = 5
vim.o.ruler = true -- Show the cursor position at all times

--Hidden buffers
vim.o.hidden = false

--Enable mouse mode
vim.o.mouse = "a"
-- vim.o.ttymouse  (not in neovim)

--Enable break indent
vim.o.breakindent = true

-- History options
-- keep x lines of command line history
vim.o.history = 10000

--Save undo history
vim.o.undofile = true
vim.o.undolevels = 10000
vim.o.undoreload = 20000

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 100
vim.wo.signcolumn = "yes"

--Set colorscheme (order is important here)
if vim.env.TERM == "screen-256color" then
    vim.o.termguicolors = true
end

-- ignore options
vim.opt.wildignore = {
  '*/tmp/*',
  '*.so',
  '*.swp',
  '*.zip',
  '*\\tmp\\*',
  '*.exe',
  '__pycache__',
  '*.pyc',
  'node_modules',
}

-- diff options
vim.opt.diffopt = {"internal", "filler", "closeoff", "context:3"}

-- gui options
-- vim.o.guioptions = "cmgTr"
vim.o.guifont = "Consolas:h10"
-- Disable the IME (gvim and unicode don't play well on different locale)
-- vim.o.imdisable = true

-- fold options
vim.o.foldlevel = 99
vim.o.foldmethod = 'indent'

-- tab options
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.wrap = true

-- backspace and cursor keys wrap to previous/next line
vim.opt.backspace = {'indent', 'eol', 'start'}
vim.opt.whichwrap = vim.opt.whichwrap + {
  ['<'] = true, 
  ['>'] = true,
  ['['] = true,
  [']'] = true,
}

-- directory options
vim.o.autochdir = true
-- vim.o.autochdir = false

-- backup files
vim.o.backup = false
vim.o.writebackup = false

-- Show (partial) command in the last line of the screen.
-- In Visual mode the size of the selected area is shown:
vim.o.showcmd = true

vim.g.python3_host_prog = nvim_conda_python

 
--indent-blankline settings
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile'}
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_char_list = {'|', '¦', '┆', '┊'}
vim.g.indent_blankline_filetype_exclude = { 'packer' }
vim.g.indent_blankline_show_first_indent_level = false
vim.g.indent_blankline_space_char = '.'
vim.g.indent_blankline_use_treesitter = true

-- tagbar
vim.g.tagbar_left = 1

-- slime
vim.g.slime_target = "tmux"
local slime_default_config = {}
slime_default_config.socket_name = "default"
slime_default_config.target_pane = "{last}"
vim.g.slime_default_config = slime_default_config
vim.g.slime_python_ipython = 1

-- context
vim.g.context_enabled = 0
vim.g.context_nvim_no_redraw = 0

-- git messenger
vim.g.git_messenger_no_default_mappings = true

-- choosewin
vim.g.choosewin_overlay_enable = 1

-- Main mapping section
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent=true})
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.api.nvim_set_keymap('n', '<CR>', ':', { noremap = true })
vim.api.nvim_set_keymap('v', '<CR>', ':', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>u', ':call Selection_CamelToUnderscores()<cr>', { noremap = true })
-- Make p in Visual mode replace the selected text with the "" register.
vim.api.nvim_set_keymap('v', 'p', '<Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>', { noremap = true} )
-- Matching characters in column
vim.api.nvim_set_keymap('n', 'g<C-v>', ':call SelectMatchingCharacterColumn()<cr>', { noremap = true, silent = true })

-- remember to use: [b ]b from unimpaired now
-- vim.api.nvim_set_keymap('n', '<leader>j', ':bnext<cr>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>k', ':bprevious<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>p', '!python %<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>G', ':Telescope git_bcommits<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>b', ':Telescope git_commits<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>H', ':Telescope help_tags<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>T', ':Telescope current_buffer_tags<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>b', ':Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>gb', ':GitMessenger<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>o', ':Telescope git_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>t', ':Tagbar<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>cc', ':ContextPeek<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader><Leader>', '<C-^>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-P>', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fg', ':Telescope live_grep<CR>', { noremap = true, silent = true })

-- Tab completion (see above)
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

-- Tmux navigation in normal, terminal modes
vim.api.nvim_set_keymap('n', '<bs>', ':TmuxNavigateLeft<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<c-j>', ':TmuxNavigateDown<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<c-k>', ':TmuxNavigateUp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<c-l>', ':TmuxNavigateRight<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<c-h>', ':TmuxNavigateLeft<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('t', '<c-j>', ':TmuxNavigateDown<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<c-k>', ':TmuxNavigateUp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<c-l>', ':TmuxNavigateRight<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<c-h>', ':TmuxNavigateLeft<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('x', '<c-k>', ':<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Leader>w', ':ChooseWin<CR>', { noremap = true, silent = true })

-- Mouse helper
-- Toggle to disable mouse mode and indentlines for easier paste
ToggleMouse = function()
  if vim.o.mouse == 'a' then
    vim.cmd[[IndentBlanklineDisable]]
    vim.wo.signcolumn='no'
    vim.o.mouse = 'v'
    vim.wo.relativenumber = false
    vim.wo.number = false
    print("Mouse disabled")
  else
    vim.cmd[[IndentBlanklineEnable]]
    vim.wo.signcolumn='yes'
    vim.o.mouse = 'a'
    vim.wo.relativenumber = true
    vim.wo.number = true
    print("Mouse enabled")
  end
end

vim.api.nvim_set_keymap('n', '<F12>', '<cmd>lua ToggleMouse()<cr>', { noremap = true })

-- Don't use Ex mode, use Q for formatting (TODO remap)
vim.api.nvim_set_keymap('n', 'Q', 'gq', { noremap = false, silent = true })

-- Map :Format to vim.lsp.buf.formatting()
vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])

-- Completion
vim.opt.completeopt = {'menuone', 'noinsert', 'noselect'}

-- Compe setup (TODO)
require'compe'.setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 200;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = true;

    source = {
        path = true;
        nvim_lsp = true;
    };
}


local replace_termcodes = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return replace_termcodes "<C-n>"
    elseif check_back_space() then
        return replace_termcodes "<Tab>"
    else
        return vim.fn['compe#complete']()
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return replace_termcodes "<C-p>"
    else
        return replace_termcodes "<S-Tab>"
    end
end

local lspconfig = require('lspconfig')

local on_attach = function(_client, bufnr)
    local opts = { noremap=true, silent=true }
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gk', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if _client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif _client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

    -- Set autocommands conditional on server_capabilities
    if _client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
            hi LspReferenceRead cterm=bold ctermbg=red guibg=Black
            hi LspReferenceText cterm=bold ctermbg=red guibg=Black
            hi LspReferenceWrite cterm=bold ctermbg=red guibg=Black
            augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]], false)
    end
end

lspconfig["pyright"].setup {
    on_attach = on_attach,
    filetypes = { "python" },
    init_options = {
      analysisUpdates = true,
      asyncStartup = true,
      displayOptions = {},
      interpreter = {
        properties = {
          InterpreterPath = vim.g.python_for_completion,
          Version = "3.7"
        }
      }
    },
    settings = {
      python = {
        linting={enabled=true},
        analysis = {
          disabled = {},
          errors = {},
          info = {}
        }
      }
    }
}

require'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true,                    -- false will disable the whole extension
      disable = { },                    -- list of language that will be disabled
      custom_captures = {               -- mapping of user defined captures to highlight groups
        -- ["foo.bar"] = "Identifier"   -- highlight own capture @foo.bar with highlight group "Identifier", see :h nvim-treesitter-query-extensions
      },
    },
    incremental_selection = {
      enable = true,
      disable = { },
      keymaps = {                       -- mappings for incremental selection (visual mappings)
        init_selection = 'gii',         -- maps in normal mode to init the node/scope selection
        node_incremental = "gin",       -- increment to the upper named parent
        scope_incremental = "gis",      -- increment to the upper scope (as defined in locals.scm)
        node_decremental = "gid",       -- decrement to the previous node
      }
    },
    refactor = {
      highlight_definitions = {
        enable = true
      },
      highlight_current_scope = {
        enable = true
      },
      smart_rename = {
        enable = true,
        keymaps = {
          smart_rename = "gsr"          -- mapping to rename reference under cursor
        }
      },
      navigation = {
        enable = true,
        keymaps = {
          goto_definition = "grd",      -- mapping to go to definition of symbol under cursor
          list_definitions = "grD"      -- mapping to list all definitions in current file
        }
      }
    },
    textobjects = {
        -- syntax-aware textobjects
        select = {
          disable = {},
          enable = true,
          keymaps = {
              -- ["iL"] = { -- you can define your own textobjects directly here
              -- python = "(function_definition) @function",
              -- cpp = "(function_definition) @function",
              -- c = "(function_definition) @function",
              -- java = "(method_declaration) @function"
              -- },
              -- or you use the queries from supported languages with textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              -- ["aC"] = "@class.outer",
              -- ["iC"] = "@class.inner",
              -- ["ac"] = "@conditional.outer",
              -- ["ic"] = "@conditional.inner",
              ["ae"] = "@block.outer",
              ["ie"] = "@block.inner",
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
              ["is"] = "@statement.inner",
              ["as"] = "@statement.outer",
              ["ad"] = "@comment.outer",
              ["am"] = "@call.outer",
              ["im"] = "@call.inner"
          }
          }
    },
    ensure_installed = 'python'
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        -- Enable underline, use default values
        underline = true,
        -- Enable virtual text, override spacing to 4
        virtual_text = {
            spacing = 100,
            prefix = '~',
        },
        -- Use a function to dynamically turn signs off
        -- and on, using buffer local variables
        signs = function(bufnr, client_id)
          local ok, result = pcall(vim.api.nvim_buf_get_var, bufnr, 'show_signs')
          -- No buffer local variable set, so just enable by default
          if not ok then
            return true
          end

          return result
        end,
        -- Disable a feature
        update_in_insert = false,
    }
)

-- Gitsigns config (TODO)
require('gitsigns').setup {
    signs = {
        add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
        change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    },
    numhl = false,
    linehl = false,
    keymaps = {
        -- Default keymap options
        noremap = true,
        buffer = true,

        ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
        ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

        ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
        ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
        ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
        ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
        ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
        ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',

        -- Text objects
        ['o ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
        ['x ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>'
    },
    watch_gitdir = {
        interval = 1000
    },
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    use_internal_diff = true,  -- If luajit is present
}

-- Telescope config (TODO, evaluating)
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
    generic_sorter =  require'telescope.sorters'.get_fzy_sorter,
    file_sorter =  require'telescope.sorters'.get_fzy_sorter,
  }
}


-- Highlight on yank (evaluating)
vim.api.nvim_exec([[
    augroup YankHighlight
        autocmd!
        autocmd TextYankPost * silent! lua vim.highlight.on_yank()
    augroup end
]], false)

-- Y yank until the end of line (evaluating)
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true})

-- Snippets
vim.g.UltiSnipsEnableSnipMate=0
vim.g.UltiSnipsExpandTrigger='<c-s>'
vim.g.UltiSnipsJumpBackwardTrigger='<c-k>'
vim.g.UltiSnipsJumpForwardTrigger='<c-j>'
vim.g.UltiSnipsRemoveSelectModeMappings = 1
vim.g.ultisnips_python_style='numpy'
vim.g.UltiSnipsEditSplit='vertical'

-- The default value for g:UltiSnipsJumpBackwardTrigger interferes with the
-- built-in complete function: |i_CTRL-X_CTRL-K|. A workaround:
vim.api.nvim_set_keymap('i', '<c-x><c-k>', '<c-x><c-k>', { noremap = true, silent = true })

-- Lightline
vim.g.lightline = {
  colorscheme = "one",
  active = {
    left = { 
        { "mode", "paste" }, 
        { "gitbranch", "readonly", "filename", "modified" } 
    }
  },
  component_function = {
    gitbranch = "FugitiveHead"
  }
}

-- Not-yet-converted vimscript - augroups and other files

-- Formatter settings
vim.api.nvim_exec([[
    augroup formatting 
      autocmd!
      autocmd FileType sh setlocal formatprg=shfmt\ -i\ 4
      autocmd FileType markdown setlocal formatprg=prettier\ --parser\ markdown
      autocmd FileType css setlocal formatprg=prettier\ --parser\ css
      autocmd FileType html setlocal formatprg=prettier\ --parser\ html
      autocmd FileType json setlocal formatprg=prettier\ --parser\ json
      autocmd FileType python setlocal formatprg=black-partial
      autocmd BufEnter *.lark setlocal formatprg=lark-format
    augroup END
]], false)

-- When editing a file, always jump to the last known cursor position.  Don't
-- do it when the position is invalid or when inside an event handler (happens
-- when dropping a file on gvim).
vim.api.nvim_exec([[
    function! GoToLastKnownPosition()
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal g`\""
        endif
    endfunction

    augroup LastKnownPosition
        autocmd!
        autocmd BufReadPost * call GoToLastKnownPosition()
    augroup end
]], false)

-- pandoc
vim.api.nvim_exec([[
    if executable('pandoc')
        autocmd! BufReadPost *.doc,*.docx,*.rtf,*.odp,*.odt silent %!pandoc "%" -t markdown -o /dev/stdout --columns=78
        " Remove docx from the list of extensions that zipplugin should use:
        let g:zipPlugin_ext='*.zip,*.jar,*.xpi,*.ja,*.war,*.ear,*.celzip,*.oxt,*.kmz,*.wsz,*.xap,*.docm,*.dotx,*.dotm,*.potx,*.potm,*.ppsx,*.ppsm,*.pptx,*.pptm,*.ppam,*.sldx,*.thmx,*.xlam,*.xlsx,*.xlsm,*.xlsb,*.xltx,*.xltm,*.xlam,*.crtx,*.vdw,*.glox,*.gcsx,*.gqsx'
    endif
]], false)

-- pdftotext
vim.api.nvim_exec([[
    if executable('pdftotext')
        autocmd BufReadPre *.pdf silent set ro
        autocmd BufReadPost *.pdf silent %!pdftotext -nopgbrk -layout -q -eol unix "%" - | fmt -w78
    endif
]], false)

-- colorcolumn only on active window
vim.api.nvim_exec([[
    " CR is colon in normal/visual mode, but not in quickfix mode:
    autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

    augroup ColorColumnOnEnter
        autocmd!
        autocmd WinEnter * set colorcolumn=80
        autocmd WinLeave * set colorcolumn=0
    augroup END
]], false)

-- cursorline only on active window
vim.api.nvim_exec([[
    augroup CursorLineOnlyInActiveWindow
        autocmd!
        autocmd VimEnter,WinEnter,BufWinEnter,FocusGained * setlocal cursorline
        autocmd VimLeave,WinLeave,BufLeave,FocusLost * setlocal nocursorline
    augroup END
]], false)

-- active window background change
vim.api.nvim_exec([[
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
]], false)

-- relative numbers on active window
vim.api.nvim_exec([[
    autocmd FileType jinja setlocal noautoindent nocindent nosmartindent indentexpr=
    set number relativenumber

    augroup numbertoggle
        autocmd!
        autocmd VimEnter,WinEnter,BufWinEnter,FocusGained * set relativenumber
        autocmd VimLeave,WinLeave,BufLeave,FocusLost * set norelativenumber
    augroup END
]], true)

-- HTML stuff
vim.g.user_emmet_install_global = 0
vim.g.user_emmet_mode = "a"  -- all functions in all modes
vim.g.user_emmet_leader_key = "<C-Y>"   -- <c-y> then comma 
vim.api.nvim_exec([[
    autocmd FileType html,css,vue,tsx EmmetInstall
    autocmd FileType html,css,vue,tsx setlocal sw=2 ts=2 sts=2 expandtab
]], true)


require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
  },
  sidebar = {
    -- open_on_start = true,
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "scopes",
        size = 0.25, -- Can be float or integer > 1
      },
      { id = "breakpoints", size = 0.25 },
      { id = "stacks", size = 0.25 },
      { id = "watches", size = 00.25 },
    },
    -- width = 40,
    position = "left", -- Can be "left" or "right"
  },
  tray = {
    -- open_on_start = true,
    elements = { "repl" },
    -- height = 10,
    position = "left", -- Can be "left" or "right"
  },
  tray = {
    elements = { "repl" },
    position = "bottom", -- Can be "bottom" or "top"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
})

vim.api.nvim_set_keymap('n', '<S-<f5>>', ":lua require'dap'.run()<cr>", { noremap = true })
vim.api.nvim_set_keymap('n', '<f5>', ":lua require'dap'.continue()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<f10>', ":lua require'dap'.step_over()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<f11>', ":lua require'dap'.step_into()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<f9>', ":lua require'dap'.toggle_breakpoint()<cr>", { noremap = true, silent = true })

local dap = require('dap')
dap.configurations.python = {
  {
    type = 'python';
    request = 'launch';
    name = "Launch file";
    program = "${file}";
    pythonPath = function()
      return vim.g.python_for_completion
    end;
  },
}

dap.adapters.python = {
  type = 'executable';
  command = nvim_debugpy_python;
  args = { '-m', 'debugpy.adapter' };
}

-- Tags

vim.g.gutentags_ctags_exclude = {
    '*.git', '*.svg', '*.hg',
    '*/tests/*',
    'build',
    'dist',
    '*sites/*/files/*',
    'bin',
    'node_modules',
    'bower_components',
    'cache',
    'compiled',
    'docs',
    'example',
    'bundle',
    'vendor',
    '*.md',
    '*-lock.json',
    '*.lock',
    '*bundle*.js',
    '*build*.js',
    '.*rc*',
    '*.json',
    '*.min.*',
    '*.map',
    '*.bak',
    '*.zip',
    '*.pyc',
    '*.class',
    '*.sln',
    '*.Master',
    '*.csproj',
    '*.tmp',
    '*.csproj.user',
    '*.cache',
    '*.pdb',
    'tags*',
    'cscope.*',
    '*.exe', '*.dll',
    '*.swp', '*.swo',
    '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
    '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
    '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
    }

vim.g.gutentags_add_default_project_roots = false
vim.g.gutentags_project_root = {'package.json', '.git'}
vim.g.gutentags_cache_dir = vim.fn.expand('~/.cache/ctags/')
vim.g.gutentags_generate_on_new = true
vim.g.gutentags_generate_on_missing = true
vim.g.gutentags_generate_on_write = true
vim.g.gutentags_generate_on_empty_buffer = true
vim.cmd([[command! -nargs=0 GutentagsClearCache call system('rm ' . g:gutentags_cache_dir . '/*')]])
vim.g.gutentags_ctags_extra_args = {'--tag-relative=yes', '--fields=+ailmnS', }

-- Text object customization / column selection
-- vim.g.textobj_wordcolumn_no_default_key_mappings = 1

-- defaults: ic; iC

-- Clipboard via osc52

vim.cmd([[
let g:clipboard = {
        \   'name': 'osc52',
        \   'copy': {'+': {lines, regtype -> OSCYankString(join(lines, "\n"))}},
        \   'paste': {'+': {-> [split(getreg(''), '\n'), getregtype('')]}},
        \ }
]])

vim.g.oscyank_term = "tmux" -- TODO, but most likely correct

-- Legacy vim settings

-- Not-yet-ported functions and color settings
execute ("source " .. vim.g.config_path .. "/color.vim")
execute ("source " .. vim.g.config_path .. "/functions.vim")
-- execute ("source " .. vim.g.config_path .. "/cscope.vim")
--
vim.g.material_theme_style = "light"

-- execute ("colorscheme material")
-- execute ("colorscheme xcodelight")
execute ("colorscheme xcodedark")
