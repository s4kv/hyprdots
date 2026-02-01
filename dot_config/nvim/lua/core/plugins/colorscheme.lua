return {
  'ficcdaf/ashen.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    style_presets = {
      bold_functions = true,
      italic_comments = true,
    },

    plugins = {
      -- keep autoload on, but *skip* lualine
      override = { 'lualine' },
      -- (or set autoload=false if you’d rather
      --  enable integrations manually)
    },

    hl = {
      -- completely overwrite the default for error underlines
      force_override = {
        -- this changes mini.statusline
        MiniStatuslineModeNormal = { 'red_flame', 'red_ember' },
        MiniStatuslineModeInsert = { 'orange_smolder', 'orange_glow' },
        -- ["@lsp.type.class.java"] = { "#eab5ee", nil, { bold = true } },
        -- ["@lsp.type.interface.java"] = { "#eab5ee", nil, { bold = true } },
        -- ["@lsp.modifier.static"] = { "#00dfff" },
        -- link helpers (alternative):
        -- ["@lsp.type.class.java"]   = { link = "@type.definition" },
        --
        --            fg  , bg  , style-table
        DiagnosticUnderlineError = {
          nil,
          nil, -- keep the current fg / bg
          {
            underdouble = false, -- ⟵ double line
            underline = true, -- ⟵ solid line
            undercurl = false, -- turn the dots off
            -- sp = "#BF65FF",
            sp = '#8755E1',
          }, -- underline colour
        },
      },
    },

    colors = {
      -- red variations
      -- red_flame = "#BF65FF",
      red_flame = '#8755E1',
      red_glowing = '#d7bafb',
      red_ember = '#eab5ee',

      -- orange variations
      --  orange_glow = "#D87C4A", -- Bright, glowing orange
      -- orange_blaze = "#C4693D", -- Vibrant blaze orange
      -- orange_smolder = "#E49A44",
      orange_glow = '#afc9e7',
      orange_blaze = '#81d5ce',
      orange_smolder = '#cce8e4',
    },
  },

  -- config = function(_, opts)
  -- 	-- Load the colorscheme here.
  -- 	-- Like many other themes, this one has different styles, and you could load
  -- 	-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
  -- 	require("ashen").setup(opts)
  -- 	vim.cmd.colorscheme("ashen")
  -- end,
}
