local loaded_neotest, neotest = pcall(require, "neotest")
if not loaded_neotest then
  return
end

local loaded_neotest_python, neotest_python = pcall(require, "neotest-python")
if not loaded_neotest_python then
  return
end

local loaded_neotest_plenary, neotest_plenary = pcall(require, "neotest-plenary")
if not loaded_neotest_plenary then
  return
end

-- neotest.setup({
--   adapters = {
--     neotest_python({
--       -- Extra arguments for nvim-dap configuration
--       dap = { justMyCode = false },
--       -- Command line arguments for runner
--       -- Can also be a function to return dynamic values
--       args = {"--log-level", "DEBUG"},
--       -- Runner to use. Will use pytest if available by default.
--       -- Can be a function to return dynamic value.
--       runner = "pytest",
--     }),
--     neotest_plenary,
--   },
-- })
require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
    }),
    require("neotest-plenary"),
  },
})

local dap = require("dap")
dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = "launch",
    name = "Launch file",

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}", -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      return vim.g.python_for_completion
      -- local cwd = vim.fn.getcwd()
      -- if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
      --   return cwd .. '/venv/bin/python'
      -- elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
      --   return cwd .. '/.venv/bin/python'
      -- else
      --   return '/usr/bin/python'
      -- end
    end,
  },
}
