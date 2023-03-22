local fn = vim.fn

-- Automatically install packer
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

local opts = {}
lazy.setup({ { import = "user.plugins" } }, opts)

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- local group = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
-- vim.api.nvim_create_autocmd("BufWritePost", {
-- 	command = "source <afile> | PackerSync",
-- 	pattern = "plugins.lua",
-- 	group = group,
-- })
