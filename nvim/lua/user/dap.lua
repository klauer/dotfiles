local dapui_ok, dapui = pcall(require, "dapui")
if not dapui_ok then
	return
end

local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
	return
end

local conda_env_root = vim.env.HOME .. "/mc/envs"
local nvim_debugpy_python = conda_env_root .. "/debugpy/bin/python"

require("dapui").setup({
	icons = { expanded = "▾", collapsed = "▸" },
	mappings = {
		-- Use a table to apply multiple mappings
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	-- Expand lines larger than the window
	-- Requires >= 0.7
	expand_lines = vim.fn.has("nvim-0.7"),
	-- Layouts define sections of the screen to place windows.
	-- The position can be "left", "right", "top" or "bottom".
	-- The size specifies the height/width depending on position. It can be an Int
	-- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
	-- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
	-- Elements are the elements shown in the layout (in order).
	-- Layouts are opened in order so that earlier layouts take priority in window sizing.
	layouts = {
		{
			elements = {
				-- Elements can be strings or table with id and size keys.
				{ id = "scopes", size = 0.25 },
				"breakpoints",
				"stacks",
				"watches",
			},
			size = 40, -- 40 columns
			position = "left",
		},
		{
			elements = {
				"repl",
				"console",
			},
			size = 0.25, -- 25% of total lines
			position = "bottom",
		},
	},
	floating = {
		max_height = nil, -- These can be integers or a float between 0 and 1.
		max_width = nil, -- Floats will be treated as percentage of your screen.
		border = "single", -- Border style. Can be "single", "double" or "rounded"
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
	render = {
		max_type_length = nil, -- Can be integer or nil.
	},
})

vim.api.nvim_set_keymap("n", "<S-<f5>>", ":lua require'dap'.run()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<f5>", ":lua require'dap'.continue()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<f10>", ":lua require'dap'.step_over()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<f11>", ":lua require'dap'.step_into()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<f9>", ":lua require'dap'.toggle_breakpoint()<cr>", { noremap = true, silent = true })

dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		pythonPath = function()
			return vim.g.python_for_completion
		end,
	},
}

dap.adapters.python = {
	type = "executable",
	command = nvim_debugpy_python,
	args = { "-m", "debugpy.adapter" },
}
