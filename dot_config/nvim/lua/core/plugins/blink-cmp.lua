return {
  { -- Autocompletion
    'saghen/blink.cmp',
    -- event = 'VimEnter',
    event = { 'InsertEnter', 'CmdlineEnter' },
    version = '1.*',
    dependencies = {
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
        opts = {},
      },
      'folke/lazydev.nvim',
      -- NOTE: this is for menu colors
      {
        'xzbdmw/colorful-menu.nvim',
        config = function()
          -- You don't need to set these options.
          require('colorful-menu').setup {
            ls = {
              lua_ls = {
                -- Maybe you want to dim arguments a bit.
                arguments_hl = '@comment',
              },
              gopls = {
                -- By default, we render variable/function's type in the right most side,
                -- to make them not to crowd together with the original label.

                -- when true:
                -- foo             *Foo
                -- ast         "go/ast"

                -- when false:
                -- foo *Foo
                -- ast "go/ast"
                align_type_to_right = true,
                -- When true, label for field and variable will format like "foo: Foo"
                -- instead of go's original syntax "foo Foo". If align_type_to_right is
                -- true, this option has no effect.
                add_colon_before_type = false,
                -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
                preserve_type_when_truncate = true,
              },
              -- for lsp_config or typescript-tools
              ts_ls = {
                -- false means do not include any extra info,
                -- see https://github.com/xzbdmw/colorful-menu.nvim/issues/42
                extra_info_hl = '@comment',
              },
              vtsls = {
                -- false means do not include any extra info,
                -- see https://github.com/xzbdmw/colorful-menu.nvim/issues/42
                extra_info_hl = '@comment',
              },
              ['rust-analyzer'] = {
                -- Such as (as Iterator), (use std::io).
                extra_info_hl = '@comment',
                -- Similar to the same setting of gopls.
                align_type_to_right = true,
                -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
                preserve_type_when_truncate = true,
              },
              clangd = {
                -- Such as "From <stdio.h>".
                extra_info_hl = '@comment',
                -- Similar to the same setting of gopls.
                align_type_to_right = true,
                -- the hl group of leading dot of "•std::filesystem::permissions(..)"
                import_dot_hl = '@comment',
                -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
                preserve_type_when_truncate = true,
              },
              zls = {
                -- Similar to the same setting of gopls.
                align_type_to_right = true,
              },
              roslyn = {
                extra_info_hl = '@comment',
              },
              dartls = {
                extra_info_hl = '@comment',
              },
              -- The same applies to pyright/pylance
              basedpyright = {
                -- It is usually import path such as "os"
                extra_info_hl = '@comment',
              },
              pylsp = {
                extra_info_hl = '@comment',
                -- Dim the function argument area, which is the main
                -- difference with pyright.
                arguments_hl = '@comment',
              },
              -- If true, try to highlight "not supported" languages.
              fallback = true,
              -- this will be applied to label description for unsupport languages
              fallback_extra_info_hl = '@comment',
            },
            -- If the built-in logic fails to find a suitable highlight group for a label,
            -- this highlight is applied to the label.
            fallback_highlight = '@variable',
            -- If provided, the plugin truncates the final displayed text to
            -- this width (measured in display cells). Any highlights that extend
            -- beyond the truncation point are ignored. When set to a float
            -- between 0 and 1, it'll be treated as percentage of the width of
            -- the window: math.floor(max_width * vim.api.nvim_win_get_width(0))
            -- Default 60.
            max_width = 60,
          }
        end,
      },
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        -- 'default' (recommended) for mappings similar to built-in completions
        --   <c-y> to accept ([y]es) the completion.
        --    This will auto-import if your LSP supports it.
        --    This will expand snippets if the LSP sent a snippet.
        -- 'super-tab' for tab to accept
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- For an understanding of why the 'default' preset is recommended,
        -- you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        --
        -- All presets have the following mappings:
        -- <tab>/<s-tab>: move to right/left of your snippet expansion
        -- <c-space>: Open menu or open docs if already open
        -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
        -- <c-e>: Hide menu
        -- <c-k>: Toggle signature help
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        preset = 'enter',

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = { auto_show = true, auto_show_delay_ms = 500 },

        -- NOTE: this is the menu colors implementation
        menu = {
          draw = {
            -- We don't need label_description now because label and label_description are already
            -- combined together in label by colorful-menu.nvim.
            columns = { { 'kind_icon' }, { 'label', gap = 1 } },
            components = {
              label = {
                text = function(ctx)
                  return require('colorful-menu').blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require('colorful-menu').blink_components_highlight(ctx)
                end,
              },
            },
          },
        },
      },

      sources = {
        -- NOTE: you could add buffer, to also get the text in the document
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },

      snippets = { preset = 'luasnip' },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See :h blink-cmp-config-fuzzy for more information
      -- fuzzy = { implementation = 'lua' },
      fuzzy = { implementation = 'prefer_rust_with_warning' },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },

      -- term
      term = {
        enabled = true,

        keymap = { preset = 'inherit' },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
