return {
	{ -- You can easily change to a different colorscheme.
		-- Change the name of the colorscheme plugin below, and then
		-- change the command in the config to whatever the name of that colorscheme is.
		--
		-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
		"mellow-theme/mellow.nvim",
		-- NOTE: Non-main background
		lazy = true,
		-- priority = 1000, -- Make sure to load this before all the other start plugins.

		-- colorscheme is set in init.lua
		-- config = function()
		-- 	-- Load the colorscheme here.
		-- 	-- Like many other themes, this one has different styles, and you could load
		-- 	-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
		-- 	vim.cmd.colorscheme("mellow")
		-- end,
	},
	{
		"ficcdaf/ashen.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style_presets = {
				bold_functions = true,
				italic_comments = true,
			},

			colors = {
				-- red variations
				red_flame = "#BF65FF",
				red_glowing = "#d7bafb",
				red_ember = "#eab5ee",

				-- orange variations
				--  orange_glow = "#D87C4A", -- Bright, glowing orange
				-- orange_blaze = "#C4693D", -- Vibrant blaze orange
				-- orange_smolder = "#E49A44",
				orange_glow = "#afc9e7",
				orange_blaze = "#81d5ce",
				orange_smolder = "#cce8e4",
			},
		},
	},
	{
		"jesseleite/nvim-noirbuddy",
		-- NOTE: Non-main background
		lazy = true,
		dependencies = {
			{ "tjdevries/colorbuddy.nvim" },
		},
		-- lazy = false,
		-- priority = 1000,
		opts = {
			-- All of your `setup(opts)` will go here
		},
	},
	{
		"xero/miasma.nvim",
		-- NOTE: Non-main background
		lazy = true,
		-- lazy = false,
		-- priority = 1000,
	},
}
