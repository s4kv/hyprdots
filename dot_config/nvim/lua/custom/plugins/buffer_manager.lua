return {
  'wasabeef/bufferin.nvim',
  cmd = { 'Bufferin' },
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    -- 'willothy/nvim-cokeline',
    'akinsho/bufferline.nvim',
  },
  config = function()
    require('bufferin').setup {
      show_window_layout = true,
      persist_buffer_sort = true,
      mappings = {
        delete = 'd', -- instead of "dd"
      },
    }
  end,

  keys = {
    { '<leader>bb', '<cmd>Bufferin<cr>', desc = 'Manage Buffers' },
  },
}
