return {
  'wsdjeg/record-key.nvim',
  cmds = { 'RecordKeyToggle' },
  config = function()
    vim.keymap.set('n', '<leader>rk', '<cmd>RecordKeyToggle<cr>', { silent = true })
    require('record-key').setup {
      timeout = 3000,
      max_count = 5,
      winhighlight = 'NormalFloat:Normal',
    }
  end,
}
