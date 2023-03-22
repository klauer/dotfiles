return {
  -- An implementation of the Popup API from vim in Neovim
  "nvim-lua/popup.nvim",
  -- Useful lua functions used by lots of plugins
  "nvim-lua/plenary.nvim",
  -- Autopairs, integrates with both cmp and treesitter
  "windwp/nvim-autopairs",
  -- Easily comment stuff
  "numToStr/Comment.nvim",
  -- {
  --   -- A snazzy buffer line (with tabpage integration)
  --   "akinsho/bufferline.nvim",
  --   version = "v3.*",
  --   requires = { "nvim-tree/nvim-web-devicons" },
  -- },
  --
  -- Delete buffers without closing your windows or messing up your layout
  "moll/vim-bbye",
  -- lua statusline
  "nvim-lualine/lualine.nvim",
  -- terminal toggle with prefix-t (-> user.toggleterm)
  "akinsho/toggleterm.nvim",
  -- superior project management -> Telescope projects (-> user.project)
  "ahmedkhalf/project.nvim",
  -- Adds indentation guides to all lines (including empty lines)
  "lukas-reineke/indent-blankline.nvim",
  -- use "goolord/alpha-nvim"

  --  -- This is needed to fix lsp doc highlig
  --   "antoinemadec/FixCursorHold.nvim"
  {
    "folke/which-key.nvim",
    dependencies = {
      {
        "afreakk/unimpaired-which-key.nvim",
        version = "690f9e88e2a7dc92bcb0cca85f778a3e99fe1f7e",
      },
    },
    config = function()
      local wk = require("which-key")
      wk.setup({
        -- whatever options you got
      })
      local uwk = require("unimpaired-which-key")
      wk.register(uwk.normal_mode)
      wk.register(uwk.normal_and_visual_mode, { mode = { "n", "v" } })
    end,
  },

  -- lua
  -- This plugins set up a REPL-like environment for developing lua plugins in Nvim.
  --  -> :Luadev
  "bfredl/nvim-luadev",

  -- Colorschemes
  -- "lunarvim/colorschemes",
  -- "lunarvim/darkplus.nvim",
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  -- completion
  {
    "hrsh7th/nvim-cmp",
    -- load cmp on InsertEnter
    event = "InsertEnter",
    -- these dependencies will only be loaded when cmp loads
    -- dependencies are always lazy-loaded unless specified otherwise
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      -- buffer completions
      "hrsh7th/cmp-buffer",
      -- cmdline completions
      "hrsh7th/cmp-cmdline",
      -- path completions
      "hrsh7th/cmp-path",
      -- dunder methods at end
      "lukas-reineke/cmp-under-comparator",
      -- "hrsh7th/cmp-nvim-lsp-signature-help"
      -- snippet completions
      "saadparwaiz1/cmp_luasnip",
      -- lsp signature (-> user.signature)
      "ray-x/lsp_signature.nvim",
    },
    config = function()
      -- ...
    end,
  },

  -- snippets
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "1.*",
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    dependencies = {
      -- a bunch of snippets to use
      "rafamadriz/friendly-snippets",
      "honza/vim-snippets",
    },
  },

  -- EPICS
  -- "NickeZ/epics.vim",
  {
    -- EPICS-related tools for Neovim
    "epics-extensions/epics.nvim",
    config = function()
      require("epics").setup({
        -- Use nvim-treesitter's ensure_install to ensure you have all the required
        -- tree-sitter grammars
        ensure_ts_installed = true,
      })
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

  -- LSP
  -- enable LSP
  "neovim/nvim-lspconfig",
  -- language server settings defined in json for
  "tamago324/nlsp-settings.nvim",
  -- for formatters and linters
  "jose-elias-alvarez/null-ls.nvim",
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
  },

  {
    "danymat/neogen",
    config = function()
      require("neogen").setup({})
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

  -- tmux-related
  "christoomey/vim-tmux-navigator",
  -- tmux syntax highlighting
  "tmux-plugins/vim-tmux",
  -- send text to other panes
  "jpalardy/vim-slime",

  -- Telescope
  "nvim-telescope/telescope.nvim",

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/playground",
      -- "JoosepAlviste/nvim-ts-context-commentstring",
      "ThePrimeagen/refactoring.nvim",
    },
  },

  -- Git
  "lewis6991/gitsigns.nvim",
  -- Git commands in nvim
  "tpope/vim-fugitive",
  -- Fugitive-companion to interact with github
  "tpope/vim-rhubarb",
  -- "gc" to comment visual regions/lines
  -- "tpope/vim-commentary",
  -- use 'tpope/vim-surround'                  --
  -- mappings for [ and ], such as buffer, args, quickfix, loc, tags (b, a, q, l, t)
  "tpope/vim-unimpaired",

  -- Python
  -- PEP8 indentation
  "Vimjas/vim-python-pep8-indent",
  "preservim/tagbar",
  -- Code context
  "nvim-treesitter/nvim-treesitter-context",

  -- Debugging / debug adapter protocol
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python" },
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      -- "nvim-lua/plenary.nvim",
      -- "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-python",
    },
  },

  {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
      -- require("mini.comment").setup()
    end,
  },

  -- Org mode trial
  -- use {'nvim-orgmode/orgmode', config = function()
  --   require('orgmode').setup{}
  -- end
  -- }
}
