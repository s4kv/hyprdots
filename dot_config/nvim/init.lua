-- Load all files in the config directory
-- local cfg_dir = vim.fn.stdpath("config") .. "/lua/config"
-- for _, file in ipairs(vim.fn.glob(cfg_dir .. "/*.lua", true, true)) do
-- 	local mod = file:match("lua/(.*)%.lua$"):gsub("/", ".")
-- 	-- Just *require* the module; no “()” call
-- 	-- The first require runs the file once and caches the result.
-- 	require(mod)
-- end
--
require("config.options") -- Load options
require("config.keymaps") -- Load keymaps
require("config.autocmds") -- Load autocmds
require("config.lazy") -- Load lazy.nvim plugins

-- Set colorscheme
vim.g.mellow_italic_functions = true
vim.g.mellow_bold_functions = true
vim.cmd.colorscheme("ashen")

-- wilder
local wilder = require("wilder")
wilder.setup({ modes = { ":", "/", "?" } })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
