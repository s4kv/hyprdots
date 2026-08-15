return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = {}, -- LazyVim relies on the defaults
  -- config = function(_, opts)
  --   require('persistence').setup(opts)
  -- end,
}
