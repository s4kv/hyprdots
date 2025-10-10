-- https://github.com/gelguy/wilder.nvim
return {
	-- "ogaken-1/wilder.nvim", -- most updated fork
	"gelguy/wilder.nvim", -- original repo, bit outdate
	-- lazy = false,
	event = "CmdlineEnter", -- load when entering command line mode
	build = ":UpdateRemotePlugins", -- required for remote plugins
	-- event = "CmdlineEnter", -- load when entering command line mode
	config = function()
		local wilder = require("wilder")
		wilder.setup({ modes = { ":", "/", "?" } })

		-- config
		-- if there's failure in functions, run :UpdateRemotePlugins
		wilder.set_option("pipeline", {
			wilder.branch(
				wilder.cmdline_pipeline({
					-- sets the language to use, 'vim' and 'python' are supported
					language = "vim",
					-- 0 turns off fuzzy matching
					-- 1 turns on fuzzy matching
					-- 2 partial fuzzy matching (match does not have to begin with the same first letter)
					fuzzy = 1,
				}),
				wilder.search_pipeline({
					pattern = "fuzzy",
				})
			),
		})
	end,
}
