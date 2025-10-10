return {
  'andrewferrier/wrapping.nvim',
  event = 'VeryLazy',

  config = function()
    require('wrapping').setup()
  end,
  -- Keymappings:
  -- {
  --  [ow - soft wrap
  --  ]ow - hard wrap
  -- }
}
