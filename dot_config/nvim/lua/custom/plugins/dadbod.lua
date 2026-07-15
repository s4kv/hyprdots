return {
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
      'DBUILastQueryInfo',
    },
    keys = {
      { '<leader>Dd', '<cmd>DBUIToggle<cr>', desc = 'Toggle Database UI' },
      { '<leader>Df', '<cmd>DBUIFindBuffer<cr>', desc = 'Database find buffer' },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1

      vim.g.db_ui_save_location = vim.fn.stdpath 'data' .. '/db_ui'
      vim.g.db_ui_tmp_query_location = vim.fn.stdpath 'data' .. '/db_ui/tmp'

      vim.g.db_ui_use_nvim_notify = 1
      vim.g.db_ui_winwidth = 35
      vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_auto_execute_table_helpers = 1
      vim.g.db_ui_use_postgres_views = 1
    end,
  },

  {
    'saghen/blink.cmp',
    opts = {
      sources = {
        per_filetype = {
          sql = { inherit_defaults = true, 'dadbod' },
          mysql = { inherit_defaults = true, 'dadbod' },
          plsql = { inherit_defaults = true, 'dadbod' },
        },
        providers = {
          dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink', score_offset = 50 },
        },
      },
    },
  },
}
