-- lua/plugins/bufferline.lua
return {
	"akinsho/bufferline.nvim",
	event = { "VeryLazy", "ColorScheme" }, -- This is still important
	opts = {
		highlights = {
			fill = { bg = "none" },
			background = { bg = "none" },
			buffer_selected = { bg = "none" },
			buffer_visible = { bg = "none" },
			separator = { bg = "none" },
			separator_selected = { bg = "none" },
			separator_visible = { bg = "none" },
		},
	},
}
