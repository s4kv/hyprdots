return {
  {
    "ramojus/mellifluous.nvim",
  },
  {
    "dgox16/oldworld.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "mellifluous",
      background = "dark",
    },
  },
}

-- return {
--   {
--     "catppuccin/nvim",
--     lazy = true,
--     name = "catppuccin",
--     opts = {
--       integrations = {
--         aerial = true,
--         alpha = true,
--         cmp = true,
--         dashboard = true,
--         flash = true,
--         gitsigns = true,
--         headlines = true,
--         illuminate = true,
--         indent_blankline = { enabled = true },
--         leap = true,
--         lsp_trouble = true,
--         mason = true,
--         markdown = true,
--         mini = true,
--         native_lsp = {
--           enabled = true,
--           underlines = {
--             errors = { "undercurl" },
--             hints = { "undercurl" },
--             warnings = { "undercurl" },
--             information = { "undercurl" },
--           },
--         },
--         navic = { enabled = true, custom_bg = "lualine" },
--         neotest = true,
--         neotree = true,
--         noice = true,
--         notify = true,
--         semantic_tokens = true,
--         telescope = true,
--         treesitter = true,
--         treesitter_context = true,
--         which_key = true,
--       },
--     },
--   },
--
--   {
--     -- Install kanagawa
--     "rebelot/kanagawa.nvim",
--   },
--
--   {
--     "rafamadriz/neon",
--   },
--
--   {
--     "nyoom-engineering/oxocarbon.nvim",
--   },
--
--   {
--     "ramojus/mellifluous.nvim",
--   },
--
--   -- dark theme
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "mellifluous",
--       background = "dark",
--     },
--   },
--   --  light theme
--   -- {
--   --      "LazyVim/LazyVim",
--   --      opts = {
--   --          colorscheme = "catppuccin-latte",
--   --      },
--   --  },
-- }
