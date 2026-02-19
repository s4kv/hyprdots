return {
  'xiyaowong/transparent.nvim',

  -- Load *after* your colourscheme so it can clear the highlights it sets.
  -- Setting `lazy = false` ensures it’s started during Neovim’s first “very lazy”
  -- phase, i.e. right after all other non-lazy plugins and your colourscheme.
  lazy = false,

  opts = {
    -- Extra groups whose background you also want gone.
    extra_groups = {
      'NormalFloat', -- floating windows
      'NvimTreeNormal', -- neo-tree / nvim-tree
      'NeoTreeNormal',
      'TelescopeNormal',
      'TelescopeBorder',
      'WhichKeyFloat',
    },

    -- Anything you *do* want to keep opaque.
    -- exclude_groups = { "VertSplit", "StatusLine", "StatusLineNC" },
  },

  config = function(_, opts)
    require('transparent').setup(opts)
    require('transparent').clear_prefix 'BufferLine'
    require('transparent').clear_prefix 'TabLine'
    require('transparent').clear_prefix 'WildMenu'
    -- require('transparent').clear_prefix 'ToggleTerm'
    -- require("transparent").clear_prefix("Markview")

    -- Optional: start Neovim with transparency off and let the user toggle.
    -- Comment this line if you want transparency ON by default.
    -- vim.cmd("TransparentDisable")
  end,
}
