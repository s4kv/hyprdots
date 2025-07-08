---@type LazySpec
return {
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		dependencies = {
			{ "nvim-lua/plenary.nvim", lazy = true },
		},
		keys = {
			-- 👇 in this section, choose your own keymappings!
			{
				"<leader>\\",
				mode = { "n", "v" },
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				-- Open in the current working directory
				"<leader>cw",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
			{
				"<c-up>",
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		},
		---@type YaziConfig | {}
		opts = {
			-- if you want to open yazi instead of netrw, see below for more info
			open_for_directories = true,
			keymaps = {
				show_help = "<f1>",
			},
		},
		-- 👇 if you use `open_for_directories=true`, this is recommended
		init = function()
			-- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
			-- vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
		end,
	},

	{
		name = "easyjump.yazi",
		url = "https://gitee.com/DreamMaoMao/easyjump.yazi.git",
		lazy = true,
		build = function(plugin)
			require("yazi.plugin").build_plugin(plugin)
		end,
	},
	{
		"Rolv-Apneseth/starship.yazi",
		lazy = true,
		build = function(plugin)
			require("yazi.plugin").build_plugin(plugin)
		end,
	},
	{
		"yazi-rs/flavors",
		name = "yazi-flavor-catppuccin-macchiato",
		lazy = true,
		build = function(spec)
			require("yazi.plugin").build_flavor(spec, {
				sub_dir = "catppuccin-macchiato.yazi",
			})
		end,
	},
	{
		-- https://github.com/yazi-rs/plugins
		"yazi-rs/plugins",
		name = "yazi-rs-plugins",
		lazy = true,
		build = function(plugin)
			require("yazi.plugin").build_plugin(plugin, {
				sub_dir = "git.yazi",
			})
		end,
	},
	{
		"ndtoan96/ouch.yazi",
		lazy = true,
		build = function(plugin)
			require("yazi.plugin").build_plugin(plugin)
		end,
	},
}
