return {
  'wsdjeg/record-key.nvim',
  cmds = { 'RecordKeyToggle' },
  config_before = function()
    vim.keymap.set('n', '<leader>rk', '<cmd>RecordKeyToggle<cr>', { silent = true })
  end,
}
