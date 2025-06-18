-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- hide all kinds of line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- **lazygit** now automatically uses the colors of your current colorscheme.
-- This is enabled by default. To disable, add the below to your `options.lua`:
-- https://github.com/LazyVim/LazyVim/commit/7d0dbc6dedc2d6cb4c3bc77fa296dc07ce5927c9
vim.g.lazygit_config = false

-- In case you don't want to use `:LazyExtras`,
-- then you need to set the option below.
-- https://www.lazyvim.org/extras/editor/telescope
vim.g.lazyvim_picker = "snacks"
vim.opt.foldopen = "jump" -- don't open folds when I navigate with { and }
vim.opt.clipboard = "unnamedplus" -- use system clipboard

-- Rust inlay_hint
vim.lsp.inlay_hint.enable(true)
