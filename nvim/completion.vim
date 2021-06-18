" vi: sw=2 ts=2 sts=2

" nvim-lsp configuration + treesitter setup
"
if "$CONDA_PREFIX" != ""
  let g:python_for_completion = $CONDA_PREFIX . '/bin/python'
else
  let g:python_for_completion = system('which python')
endif

lua << EOF
  local lspconfig = require('lspconfig')

  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- require'diagnostic'.on_attach()
    require'completion'.on_attach()

    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
      buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
      buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
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

  lspconfig["pyls_ms"].setup {
    on_attach = on_attach,
    filetypes = { "python" },
    cmd = { "dotnet", "exec", "$HOME/.cache/nvim/nvim_lsp/pyls_ms/Microsoft.Python.LanguageServer.dll" },
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
EOF


lua << EOF
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
              ["iL"] = { -- you can define your own textobjects directly here
              python = "(function_definition) @function",
              cpp = "(function_definition) @function",
              c = "(function_definition) @function",
              java = "(method_declaration) @function"
              },
              -- or you use the queries from supported languages with textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["aC"] = "@class.outer",
              ["iC"] = "@class.inner",
              ["ac"] = "@conditional.outer",
              ["ic"] = "@conditional.inner",
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
EOF

" Gitsigns config (should move this out)
lua << EOF
require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
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
  watch_index = {
    interval = 1000
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  use_decoration_api = true,
  use_internal_diff = true,  -- If luajit is present
}

EOF

" fzf - Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Map <tab> to trigger completion and navigate to the next item:
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"

" Configure the completion chains
let g:completion_chain_complete_list = {
			\'default' : {
			\	'default' : [
			\		{'complete_items' : ['lsp', 'snippet']},
			\		{'mode' : 'file'}
			\	],
			\	'comment' : [],
			\	'string' : []
			\	},
			\'vim' : [
			\	{'complete_items': ['snippet']},
			\	{'mode' : 'cmd'}
			\	],
			\'c' : [
			\	{'complete_items': ['ts']}
			\	],
			\'python' : [
			\	{'complete_items': ['lsp', 'snippet']}
			\	],
			\'lua' : [
			\	{'complete_items': ['ts']}
			\	],
			\}

" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()

command! -buffer -nargs=0 LspShowLineDiagnostics lua require'jumpLoc'.openLineDiagnostics()
nnoremap <buffer><silent> <Leader>d <Cmd>LspShowLineDiagnostics<CR>

command! Format execute 'lua vim.lsp.buf.formatting()'

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" c	don't give |ins-completion-menu| messages.  For example,
"  "-- XXX completion (YYY)", "match 1 of 2", "The only match",
"  "Pattern not found", "Back at original", etc.
set shortmess+=c

" Auto close popup menu when finish completion
" autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Use tab as trigger key
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ completion#trigger_completion()

" Chain completion list
let g:completion_chain_complete_list = {
\  'default' : {
\    'default': [
\        {'complete_items': ['lsp', 'snippet']},
\        {'mode': '<c-p>'},
\        {'mode': '<c-n>'}],
\    'comment': [],
\    'string' : [{'complete_items': ['path']}]
\   }
\ }


" Completion-nvim
let g:completion_enable_auto_hover = 0
let g:completion_enable_auto_signature = 1
let g:completion_enable_fuzzy_match = 1
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_matching_ignore_case = 1
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']


" Diagnostic-nvim
let g:diagnostic_auto_popup_while_jump = 1
let g:diagnostic_auto_popup_while_jump = 1
let g:diagnostic_enable_underline = 1
let g:diagnostic_enable_virtual_text = 0
let g:diagnostic_show_sign = 1
let g:diagnostic_virtual_text_prefix = ' '
let g:space_before_virtual_text = 10   " this is for diagnostic-nvim


" ALE linters + fixers
let g:ale_linters = {
\   'python': ['flake8'],
\   'sh': ['shellcheck'],
\}

let g:ale_fixers = {
\   'python': ['black'],
\}

" Disable warnings about trailing whitespace for Python files.
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_warn_about_trailing_whitespace = 0

" Doge... uh, yeah.. it works surprisingly well
let g:doge_doc_standard_python = 'numpy'
let g:doge_enable_mappings = 1
let g:doge_mapping = "<Leader>z"
