return {
  'otavioschwanck/arrow.nvim',
  event = 'VeryLazy',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' },
    -- or if using `mini.icons`
    -- { 'echasnovski/mini.icons' },
  },
  opts = {
    show_icons = true,
    leader_key = ';', -- Recommended to be a single key
    buffer_leader_key = 'm', -- Per Buffer Mappings
    hide_handbook = false,
  },

  config = function(_, opts)
    require('arrow').setup(opts)
    -- vim.keymap.del('n', ';')
    -- vim.keymap.set('n', ';', ':Arrow open<CR>', { silent = true, desc = 'open arrow' })
  end,
}
