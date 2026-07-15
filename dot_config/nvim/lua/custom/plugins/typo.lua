return {
  'axieax/typo.nvim',
  config = function()
    require('typo').setup {
      autocmd = { check_directory = false },
    }
  end,
}
