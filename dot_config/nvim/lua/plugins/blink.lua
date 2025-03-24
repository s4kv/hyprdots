return {
  "saghen/blink.cmp",
  version = not vim.g.lazyvim_blink_main and "*",
  build = vim.g.lazyvim_blink_main and "cargo build --release",
  opts_extend = {
    "sources.completion.enabled_providers",
    "sources.compat",
    "sources.default",
  },
  dependencies = {
    "rafamadriz/friendly-snippets",
    {
      "saghen/blink.compat",
      optional = true,
      opts = {},
      version = not vim.g.lazyvim_blink_main and "*",
    },
  },
  event = "InsertEnter",

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    snippets = {
      expand = function(snippet)
        return LazyVim.cmp.expand(snippet)
      end,
    },
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",
    },
    completion = {
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      menu = {
        draw = {
          treesitter = { "lsp" },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      ghost_text = {
        enabled = vim.g.ai_cmp,
      },
    },

    sources = {
      compat = {},
      default = { "lsp", "path", "snippets", "buffer" },
    },

    cmdline = {
      sources = {},
    },

    keymap = {
      preset = "enter",
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },
  },
  ---@param opts blink.cmp.Config | { sources: { compat: string[] } }
  config = function(_, opts)
    local enabled = opts.sources.default
    for _, source in ipairs(opts.sources.compat or {}) do
      opts.sources.providers[source] = vim.tbl_deep_extend(
        "force",
        { name = source, module = "blink.compat.source" },
        opts.sources.providers[source] or {}
      )
      if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
        table.insert(enabled, source)
      end
    end

    if not opts.keymap["<Tab>"] then
      if opts.keymap.preset == "super-tab" then
        opts.keymap["<Tab>"] = {
          require("blink.cmp.keymap.presets")["super-tab"]["<Tab>"][1],
          LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
          "fallback",
        }
      else
        opts.keymap["<Tab>"] = {
          LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
          "fallback",
        }
      end
    end

    opts.sources.compat = nil

    for _, provider in pairs(opts.sources.providers or {}) do
      if provider.kind then
        local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
        local kind_idx = #CompletionItemKind + 1

        CompletionItemKind[kind_idx] = provider.kind
        CompletionItemKind[provider.kind] = kind_idx

        local transform_items = provider.transform_items
        provider.transform_items = function(ctx, items)
          items = transform_items and transform_items(ctx, items) or items
          for _, item in ipairs(items) do
            item.kind = kind_idx or item.kind
          end
          return items
        end

        provider.kind = nil
      end
    end

    require("blink.cmp").setup(opts)
  end,
}

-- return {
--     {
--         "hrsh7th/nvim-cmp",
--         ---@param opts cmp.ConfigSchema
--         opts = function(_, opts)
--             local has_words_before = function()
--                 unpack = unpack or table.unpack
--                 local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--                 return col ~= 0
--                     and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
--             end
--
--             local cmp = require("cmp")
--
--             opts.mapping = vim.tbl_extend("force", opts.mapping, {
--                 ["<Tab>"] = cmp.mapping(function(fallback)
--                     if cmp.visible() then
--                         -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
--                         cmp.select_next_item()
--                     elseif vim.snippet.active({ direction = 1 }) then
--                         vim.schedule(function()
--                             vim.snippet.jump(1)
--                         end)
--                     elseif has_words_before() then
--                         cmp.complete()
--                     else
--                         fallback()
--                     end
--                 end, { "i", "s" }),
--                 ["<S-Tab>"] = cmp.mapping(function(fallback)
--                     if cmp.visible() then
--                         cmp.select_prev_item()
--                     elseif vim.snippet.active({ direction = -1 }) then
--                         vim.schedule(function()
--                             vim.snippet.jump(-1)
--                         end)
--                     else
--                         fallback()
--                     end
--                 end, { "i", "s" }),
--             })
--         end,
--     },
-- }
