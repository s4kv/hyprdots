return {
	"sQVe/sort.nvim",
	event = "VeryLazy",
	-- use with go in visual mode
	config = function()
		require("sort").setup({
			-- Optional configuration overrides.
		})
	end,
}
