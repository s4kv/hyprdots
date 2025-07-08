return {
	"eatgrass/maven.nvim",
	lazy = true,
	cmd = { "Maven", "MavenExec" },
	dependencies = "nvim-lua/plenary.nvim",
	config = function()
		require("maven").setup({
			executable = "./mvnw",
		})
	end,
}
