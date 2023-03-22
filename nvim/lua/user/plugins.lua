return {
	-- An implementation of the Popup API from vim in Neovim
	"nvim-lua/popup.nvim",
	-- Useful lua functions used ny lots of plugins
	"nvim-lua/plenary.nvim",
	-- Autopairs, integrates with both cmp and treesitter
	"windwp/nvim-autopairs",
	-- Easily comment stuff
	"numToStr/Comment.nvim",
	"kyazdani42/nvim-web-devicons",
	"kyazdani42/nvim-tree.lua",
	"akinsho/bufferline.nvim",
	"moll/vim-bbye",
	"nvim-lualine/lualine.nvim",
	"akinsho/toggleterm.nvim",
	"ahmedkhalf/project.nvim",
	"lewis6991/impatient.nvim",
	"lukas-reineke/indent-blankline.nvim",
	-- use "goolord/alpha-nvim"

	--  -- This is needed to fix lsp doc highlig
	--   "antoinemadec/FixCursorHold.nvim"
	{
		"folke/which-key.nvim",
	},

	-- lua
	"bfredl/nvim-luadev",

	-- Colorschemes
	-- A bunch of colorschemes you can try out
	"lunarvim/colorschemes",
	"lunarvim/darkplus.nvim",
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
			-- lsp signature
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
	"NickeZ/epics.vim",

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
		},
	},

	-- Git
	"lewis6991/gitsigns.nvim",
	-- Git commands in nvim
	"tpope/vim-fugitive",
	-- Fugitive-companion to interact with github
	"tpope/vim-rhubarb",
	-- "gc" to comment visual regions/lines
	"tpope/vim-commentary",
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
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-python",
		},
	},

	{
		"echasnovski/mini.nvim",
	},

	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
	-- Org mode trial
	-- use {'nvim-orgmode/orgmode', config = function()
	--   require('orgmode').setup{}
	-- end
	-- }
}
