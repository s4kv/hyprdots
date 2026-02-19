return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    version = false,
    build = function()
      require('nvim-treesitter').update(nil, { summary = true })
    end,
    config = function()
      local TS = require 'nvim-treesitter'

      local ensure = {
        'bash',
        'c',
        'cpp',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'java',
        'rust',
        'ron',
        'typst',
        'yaml',
        'python',
        'typescript',
        'javascript',
      }

      TS.setup {
        ensure_installed = ensure,
        highlight = { enable = true },
        indent = { enable = true },
        folds = { enable = true },
      }

      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.opt.foldenable = false

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('my_treesitter_attach', { clear = true }),
        callback = function(ev)
          -- start only if ft maps to a TS lang
          if vim.treesitter.language.get_lang(ev.match) then
            pcall(vim.treesitter.start, ev.buf)
          end
        end,
      })
    end,
  },

  {
    -- tree-sitter-context.lua

    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter', branch = 'main' },
    init = function()
      vim.g.no_plugin_maps = true
    end,
    config = function()
      require('nvim-treesitter-textobjects').setup {
        select = {
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          -- You can choose the select mode (default is charwise 'v')

          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
          include_surrounding_whitespace = false,
        },
        move = {
          -- whether to set jumps in the jumplist
          set_jumps = true,
        },
      }

      -- Selects
      local select = require 'nvim-treesitter-textobjects.select'
      vim.keymap.set({ 'x', 'o' }, 'am', function()
        select.select_textobject('@function.outer', 'textobjects')
      end, { desc = 'TS: select around function (outer)' })

      vim.keymap.set({ 'x', 'o' }, 'im', function()
        select.select_textobject('@function.inner', 'textobjects')
      end, { desc = 'TS: select inside function (inner)' })

      vim.keymap.set({ 'x', 'o' }, 'ac', function()
        select.select_textobject('@class.outer', 'textobjects')
      end, { desc = 'TS: select around class (outer)' })

      vim.keymap.set({ 'x', 'o' }, 'ic', function()
        select.select_textobject('@class.inner', 'textobjects')
      end, { desc = 'TS: select inside class (inner)' })

      -- You can also use captures from other query groups like `locals.scm`
      vim.keymap.set({ 'x', 'o' }, 'as', function()
        select.select_textobject('@local.scope', 'locals')
      end, { desc = 'TS: select local scope' })

      -- Swaps
      local swap = require 'nvim-treesitter-textobjects.swap'
      vim.keymap.set('n', '<leader>a', function()
        swap.swap_next '@parameter.inner'
      end, { desc = 'TS: swap next parameter' })

      vim.keymap.set('n', '<leader>A', function()
        swap.swap_previous '@parameter.outer'
      end, { desc = 'TS: swap previous parameter' })

      -- Moves
      local move = require 'nvim-treesitter-textobjects.move'
      vim.keymap.set({ 'n', 'x', 'o' }, ']m', function()
        move.goto_next_start('@function.outer', 'textobjects')
      end, { desc = 'TS: next function start' })

      vim.keymap.set({ 'n', 'x', 'o' }, ']]', function()
        move.goto_next_start('@class.outer', 'textobjects')
      end, { desc = 'TS: next class start' })

      -- You can also pass a list to group multiple queries.
      vim.keymap.set({ 'n', 'x', 'o' }, ']o', function()
        move.goto_next_start({ '@loop.inner', '@loop.outer' }, 'textobjects')
      end, { desc = 'TS: next loop start' })

      -- You can also use captures from other query groups like `locals.scm` or `folds.scm`
      vim.keymap.set({ 'n', 'x', 'o' }, ']s', function()
        move.goto_next_start('@local.scope', 'locals')
      end, { desc = 'TS: next local scope start' })

      vim.keymap.set({ 'n', 'x', 'o' }, ']z', function()
        move.goto_next_start('@fold', 'folds')
      end, { desc = 'TS: next fold start' })

      vim.keymap.set({ 'n', 'x', 'o' }, ']M', function()
        move.goto_next_end('@function.outer', 'textobjects')
      end, { desc = 'TS: next function end' })

      vim.keymap.set({ 'n', 'x', 'o' }, '][', function()
        move.goto_next_end('@class.outer', 'textobjects')
      end, { desc = 'TS: next class end' })

      vim.keymap.set({ 'n', 'x', 'o' }, '[m', function()
        move.goto_previous_start('@function.outer', 'textobjects')
      end, { desc = 'TS: prev function start' })

      vim.keymap.set({ 'n', 'x', 'o' }, '[[', function()
        move.goto_previous_start('@class.outer', 'textobjects')
      end, { desc = 'TS: prev class start' })

      vim.keymap.set({ 'n', 'x', 'o' }, '[M', function()
        move.goto_previous_end('@function.outer', 'textobjects')
      end, { desc = 'TS: prev function end' })

      vim.keymap.set({ 'n', 'x', 'o' }, '[]', function()
        move.goto_previous_end('@class.outer', 'textobjects')
      end, { desc = 'TS: prev class end' })

      -- Go to either the start or the end, whichever is closer.
      -- Use if you want more granular movements
      vim.keymap.set({ 'n', 'x', 'o' }, ']d', function()
        move.goto_next('@conditional.outer', 'textobjects')
      end, { desc = 'TS: next conditional (closest edge)' })

      vim.keymap.set({ 'n', 'x', 'o' }, '[d', function()
        move.goto_previous('@conditional.outer', 'textobjects')
      end, { desc = 'TS: prev conditional (closest edge)' })

      local ts_repeat_move = require 'nvim-treesitter-textobjects.repeatable_move'

      -- Repeat movement with ; and ,
      -- ensure ; goes forward and , goes backward regardless of the last direction
      vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next, { desc = 'TS: repeat last move forward' })
      vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous, { desc = 'TS: repeat last move backward' })

      -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
      vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true, desc = 'Find char forward (repeatable)' })
      vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true, desc = 'Find char backward (repeatable)' })
      vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true, desc = 'Till char forward (repeatable)' })
      vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true, desc = 'Till char backward (repeatable)' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
