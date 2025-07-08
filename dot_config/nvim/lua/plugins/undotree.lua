return {
	"mbbill/undotree",

	config = function()
		vim.keymap.set("n", "<leader>z", vim.cmd.UndotreeToggle, { desc = "UndotreeToggle" })
	end,
}
