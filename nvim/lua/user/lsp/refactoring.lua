local ok, refactoring = pcall(require, "refactoring")
if not ok then
  return
end

refactoring.setup({
  prompt_func_return_type = {
    go = false,
    java = false,
    cpp = false,
    c = false,
    h = false,
    hpp = false,
    cxx = false,
    python = true,
  },
  prompt_func_param_type = {
    go = false,
    java = false,
    cpp = false,
    c = false,
    h = false,
    hpp = false,
    cxx = false,
    python = true,
  },
  printf_statements = {},
  print_var_statements = {},
})
