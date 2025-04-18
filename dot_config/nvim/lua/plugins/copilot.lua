---@module "lazy"
---@type LazySpec
return {
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = { "giuxtaposition/blink-cmp-copilot" },
    opts = {
      sources = {
        default = { "copilot" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            kind = "Copilot",
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  },
  { "giuxtaposition/blink-cmp-copilot" },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "BufReadPost",
    opts = {
      suggestion = {
        enabled = not vim.g.ai_cmp,
        auto_trigger = true,
        hide_during_completion = vim.g.ai_cmp,
        keymap = {
          accept = false, -- handled by nvim-cmp / blink.cmp
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },

  -- {
  --   "zbirenbaum/copilot.lua",
  --   -- ../../../../../.local/share/nvim/lazy/copilot.lua/lua/copilot/config.lua
  --   cmd = "Copilot",
  --   build = ":Copilot auth",
  --   event = "InsertEnter",
  --   opts = {
  --     -- https://github.com/zbirenbaum/copilot.lua?tab=readme-ov-file#setup-and-configuration
  --     suggestion = {
  --       enabled = true,
  --       auto_trigger = true,
  --       keymap = {
  --         accept_word = "<c-l>",
  --       },
  --     },
  --     debounce = 300, --ms
  --     filetypes = {
  --       markdown = true,
  --       yaml = true,
  --       gitcommit = true,
  --       help = true,
  --     },
  --   },
  --
  --   config = function(_, opts)
  --     local copilot = require("copilot")
  --     copilot.setup(opts)
  --
  --     vim.keymap.set("i", "<S-down>", function()
  --       require("copilot.suggestion").accept_line()
  --
  --       vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, true, true), "n", true)
  --     end)
  --
  --     vim.keymap.set("i", "<S-right>", function()
  --       require("copilot.suggestion").accept()
  --     end)
  --   end,
  -- },
}
