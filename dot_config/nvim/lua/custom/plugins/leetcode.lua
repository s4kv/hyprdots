return {
	"kawre/leetcode.nvim",
	cmd = "Leet",
	build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
	dependencies = {
		-- include a picker of your choice, see picker section for more details
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		-- configuration goes here
		theme = {
			normal = { fg = "#dddddd" },
		},
	},
}
