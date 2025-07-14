-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Save file with <C-s>
vim.keymap.set({ "n", "v" }, "<C-s>", "<Cmd>w<CR>", { desc = "Save file" })
vim.keymap.set("i", "<C-s>", "<Esc><Cmd>w<CR>", { desc = "Save file" })

-- Move through buffers with <S-h> and <S-l>
vim.keymap.set("n", "<S-h>", "<Cmd>bprevious<CR>", { desc = "Buffer: previous" })
vim.keymap.set("n", "<S-l>", "<Cmd>bnext<CR>", { desc = "Buffer: next" })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>x", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set({ "n", "i", "v" }, "<leader>|", "<cmd>vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set({ "n", "i", "v" }, "<leader>-", "<cmd>split<CR>", { desc = "Split window horizontally" })

-- Session management keymaps
---- load the session for the current directory
vim.keymap.set("n", "<leader>qs", function()
	require("persistence").load()
end, { desc = "Load session for current directory" })

-- select a session to load
vim.keymap.set("n", "<leader>qS", function()
	require("persistence").select()
end, { desc = "Select a session to load" })

-- load the last session
vim.keymap.set("n", "<leader>ql", function()
	require("persistence").load({ last = true })
end, { desc = "Load last session" })

-- stop Persistence => session won't be saved on exit
vim.keymap.set("n", "<leader>qd", function()
	require("persistence").stop()
end, { desc = "Stop Persistence" })

-- wrap with leader u w toggle
vim.keymap.set("n", "<leader>uw", "<cmd>ToggleWrapMode<CR>", { desc = "Toggle wrap" })

-- toggle vim.diagnostic.config({ virtual_lines = true })
vim.keymap.set("n", "<leader>ul", function()
	local config = vim.diagnostic.config()
	if not config then
		vim.notify("Diagnostic config not found", vim.log.levels.ERROR)
		return
	end
	local current = config.virtual_lines
	local enabled = (current ~= nil) and current or false
	vim.diagnostic.config({ virtual_lines = not enabled })
end, { desc = "Toggle virtual lines" })
