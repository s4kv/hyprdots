---@module "lazy"
---@type LazySpec
return {
  -- https://github.com/fedepujol/move.nvim
  "fedepujol/move.nvim",
  lazy = true,
  keys = {
    { "K", ":MoveBlock(-1)<CR>", mode = { "v" }, silent = true, desc = "Move block up/down" },
    { "J", ":MoveBlock(1)<CR>", mode = { "v" }, silent = true, desc = "Move block up/down" },
  },
  config = function()
    require("move").setup({})
  end,
}
