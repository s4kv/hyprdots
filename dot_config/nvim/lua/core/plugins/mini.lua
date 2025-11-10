return {
  { -- Collection of various small independent plugins/modules
    'nvim-mini/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup {
        mappings = {
          add = 'gsa',
          delete = 'gsd',
          find = 'gsf',
          find_left = 'gsF',
          highlight = 'gsh',
          replace = 'gsr',
          update_n_lines = 'gsn',
        },
      }

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim

      require('mini.icons').setup()

      require('mini.sessions').setup()

      require('mini.splitjoin').setup {
        mappings = {
          toggle = '<cr>',
        },
      }

      local map = require 'mini.map'
      map.setup {
        integrations = {
          map.gen_integration.builtin_search(),
          map.gen_integration.diff(),
          map.gen_integration.diagnostic(),
        },

        window = {
          winblend = 100,
          width = 5,
        },
      }

      vim.keymap.set('n', '<Leader>mq', MiniMap.close, { desc = 'MiniMap Close' })
      vim.keymap.set('n', '<Leader>mf', MiniMap.toggle_focus, { desc = 'MiniMap Toggle Focus' })
      vim.keymap.set('n', '<Leader>mo', MiniMap.open, { desc = 'MiniMap Open' })
      vim.keymap.set('n', '<Leader>mr', MiniMap.refresh, { desc = 'MiniMap Refresh' })
      vim.keymap.set('n', '<Leader>mw', MiniMap.toggle_side, { desc = 'MiniMap Toggle Side' })
      vim.keymap.set('n', '<Leader>mt', MiniMap.toggle, { desc = 'MiniMap Toggle' })

      -- Only start mini.map when the Lsp is attached
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'Open MiniMap when entering Neovim',
        group = vim.api.nvim_create_augroup('mini-map-open', { clear = true }),
        callback = function()
          MiniMap.open()
        end,
      })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
