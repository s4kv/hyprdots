return {
  'axieax/typo.nvim',
  config = function()
    require('typo').setup {
      autocmd = {
        check_directory = false,
        check_new_file = false,
      },
    }
  end,
}
