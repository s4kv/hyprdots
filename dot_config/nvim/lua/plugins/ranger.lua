return {
    "kelly-lin/ranger.nvim",
    config = function()
        local ranger_nvim = require("ranger-nvim")
        ranger_nvim.setup({
            replace_netrw = true,
            enable_cmds = true,
            keybinds = {
                ["ov"] = ranger_nvim.OPEN_MODE.vsplit,
                ["oh"] = ranger_nvim.OPEN_MODE.split,
                ["ot"] = ranger_nvim.OPEN_MODE.tabedit,
                ["or"] = ranger_nvim.OPEN_MODE.rifle,
            },
        })
        vim.api.nvim_set_keymap("n", "<leader>ef", "", {
            noremap = true,
            callback = function()
                require("ranger-nvim").open(true)
            end,
        })
    end,
}
