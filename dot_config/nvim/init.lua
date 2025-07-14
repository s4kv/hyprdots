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
require("config.lazy") -- Load lazy.nvim plugins

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
