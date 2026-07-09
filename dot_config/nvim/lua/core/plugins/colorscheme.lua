return {
  {
    'olivercederborg/poimandres.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('poimandres').setup {
        -- leave this setup function empty for default config
        -- or refer to the configuration section
        -- for configuration options
        disable_background = true, -- disable background
        disable_float_background = true, -- disable background for floats
      }
    end,

    -- optionally set the colorscheme within lazy config
    -- init = function()
    --   vim.cmd 'colorscheme poimandres'
    -- end,
  },

  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('nordic').setup {
        transparent = {
          -- Enable transparent background.
          bg = true,
          -- Enable transparent background for floating windows.
          float = true,
        },
      }

      -- require('nordic').load()
    end,
  },

  {
    'vossenwout/guts.nvim',
    config = function()
      vim.cmd 'colorscheme guts'

      local background = '#101113'
      local foreground = '#9f9e99'

      -- MiniStatusLine
      local cBack = '#101113'
      local iBack = '#161719'
      local iFore = '#554a62'
      vim.api.nvim_set_hl(0, 'MiniStatuslineFilename', { bg = background, fg = foreground })
      vim.api.nvim_set_hl(0, 'MiniStatuslineDevinfo', { bg = background, fg = foreground })
      vim.api.nvim_set_hl(0, 'MiniStatuslineFileinfo', { bg = background, fg = foreground })
      vim.api.nvim_set_hl(0, 'MiniStatuslineModeCommand', { bg = cBack, fg = foreground })
      vim.api.nvim_set_hl(0, 'MiniStatuslineInactive', { bg = iBack, fg = iFore })
      vim.api.nvim_set_hl(0, 'MiniStatuslineModeNormal', { bg = foreground, fg = background })

      -- Cursor
      vim.api.nvim_set_hl(0, 'CursorLine', { fg = 'NONE', bold = true })
    end,
  },

  -- {
  --   'vague-theme/vague.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require('vague').setup {
  --       transparent = true,
  --       italic = false, -- Disable italic globally
  --     }
  --
  --     vim.cmd 'colorscheme vague'
  --   end,
  -- },

  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup {
        styles = {
          bold = true,
          italic = false,
          transparency = true,
        },
      }

      -- vim.cmd 'colorscheme rose-pine'
    end,
  },
  -- {
  --   url = 'https://codeberg.org/jthvai/lavender.nvim',
  --   branch = 'stable', -- versioned tags + docs updates from main
  --   lazy = false,
  --   priority = 1000,
  --
  --   config = function()
  --     vim.g.lavender = {
  --       transparent = {
  --         background = true, -- do not render the main background
  --         float = true, -- do not render the background in floating windows
  --         popup = true, -- do not render the background in popup menus
  --         sidebar = true, -- do not render the background in sidebars
  --       },
  --       contrast = true, -- colour the sidebar and floating windows differently to the main background
  --
  --       italic = {
  --         comments = true, -- italic comments
  --         functions = true, -- italic function names
  --         keywords = false, -- italic keywords
  --         variables = false, -- italic variables
  --       },
  --
  --       signs = true, -- use icon (patched font) diagnostic sign text
  --
  --       -- new values will be merged in
  --       overrides = {
  --         -- highlight groups - see theme.lua
  --         -- existing groups will be entirely replaced
  --         theme = {
  --           -- (1) comments
  --           ['@comment'] = { fg = 'mcomments' },
  --           Comment = { fg = 'mcomments' },
  --
  --           -- (2) table keys like `theme =`, `colors =`
  --           ['@field'] = { fg = 'key_fg' },
  --           ['@property'] = { fg = 'key_fg' },
  --
  --           -- optional: if LSP semantic tokens override the above in Lua files
  --           -- ['@lsp.type.property'] = { fg = 'key_fg' },
  --           -- ['@lsp.type.property.lua'] = { fg = 'key_fg' },
  --
  --           -- strings (Tree-sitter + legacy)
  --           ['@string'] = { fg = 'mpurple', ctermfg = 'mpurple' },
  --           String = { fg = 'mpurple', ctermfg = 'mpurple' },
  --
  --           -- (optional) if you also want escapes like "\n" to match
  --           ['@string.escape'] = { fg = 'mpurple', ctermfg = 'mpurple' },
  --           ['@string.special'] = { fg = 'mpurple', ctermfg = 'mpurple' },
  --
  --           -- gitsigns
  --           GitSignsAdd = { fg = 'gs_add' },
  --
  --           -- indent-blankline (new "ibl")
  --           IblIndent = { fg = 'indent_guide' },
  --           IblScope = { fg = 'indent_guide' },
  --
  --           -- indent-blankline (older)
  --           IndentBlanklineChar = { fg = 'indent_guide' },
  --           IndentBlanklineContextChar = { fg = 'indent_guide' },
  --           IndentBlanklineContextStart = { fg = 'indent_guide' },
  --
  --           -- mini.indentscope
  --           MiniIndentscopeSymbol = { fg = 'indent_guide' },
  --
  --           -- snacks.nvim indent
  --           SnacksIndent = { fg = 'indent_guide' },
  --           SnacksIndentScope = { fg = 'mpurple' },
  --
  --           -- Snacks.nvim Dashboard
  --           SnacksDashboardTitle = { fg = 'mpurple' },
  --           SnacksDashboardFooter = { fg = 'mpurple' },
  --           SnacksDashboardHeader = { fg = 'mpurple' },
  --
  --           SnacksDashboardFile = { fg = 'mpink' },
  --           SnacksDashboardDesc = { fg = 'mpink' },
  --           SnacksDashboardIcon = { fg = 'mpink' },
  --           SnacksDashboardSpecial = { fg = 'mpink' },
  --
  --           -- normal line numbers
  --           LineNr = { fg = 'line_nr' },
  --
  --           -- variables
  --           ['@variable'] = { fg = 'white' },
  --           ['@variable.lua'] = { fg = 'white' },
  --           ['@variable.parameter'] = { fg = 'mpink' },
  --           ['@variable.member'] = { fg = 'white' },
  --
  --           -- function
  --           ['@function'] = { fg = 'mmember' },
  --
  --           -- make the whole line bar consistent across columns
  --           CursorLineNr = { bg = 'mcursor' },
  --           CursorLineSign = { bg = 'mcursor' },
  --           CursorLineFold = { bg = 'mcursor' },
  --
  --           -- Snacks picker
  --           SnacksPickerCursorLine = { bg = 'mcursor' },
  --           SnacksPickerBoxCursorLine = { bg = 'mcursor' },
  --           SnacksPickerInputCursorLine = { bg = 'mcursor' },
  --
  --           -- booleans
  --           ['@boolean'] = { fg = 'lit_teal' },
  --           Boolean = { fg = 'lit_teal' },
  --
  --           -- numbers
  --           ['@number'] = { fg = 'lit_teal' },
  --           Number = { fg = 'lit_teal' },
  --           ['@float'] = { fg = 'lit_teal' }, -- optional (some parsers use @float)
  --           Float = { fg = 'lit_teal' }, -- optional fallback
  --
  --           -- optional LSP semantic tokens (if they override TS)
  --           ['@lsp.type.boolean'] = { fg = 'lit_teal' },
  --           ['@lsp.type.number'] = { fg = 'lit_teal' },
  --
  --           -- Cursor and visuals
  --           Cursor = { bg = 'white' }, -- character under the cursor
  --           lCursor = { link = 'mcursor' }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
  --           CursorIM = { link = 'mcursor' }, -- like Cursor, but used when in IME mode |CursorIM|
  --           CursorColumn = { bg = 'mcursor' }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
  --           Visual = { bg = 'mcursor' },
  --           Search = { bg = 'search' },
  --           CursorLine = { bg = 'mpurple', bold = true, italic = false }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
  --           LspReferenceRead = { bg = 'line_nr' },
  --           LspReferenceText = { bg = 'line_nr' },
  --           LspReferenceWrite = { bg = 'line_nr' },
  --
  --           BlinkCmpMenuSelection = {
  --             fg = 'mpurple',
  --             bold = true,
  --             italic = true,
  --           },
  --
  --           -- mini
  --           MiniStatuslineModeNormal = { bg = 'flamepurple' },
  --         },
  --
  --         colors = {
  --           cterm = {}, -- cterm colours - see colors/cterm.lua
  --           hex = {
  --             flamepurple = '#8755E1',
  --             mpurple = '#d7bafb',
  --             mpink = '#eab5ee',
  --             mcomments = '#6F6F6F',
  --             gs_add = '#ADADAD',
  --             indent_guide = '#515151',
  --             line_nr = '#515151',
  --             mmember = '#81d5ce',
  --             mcursor = '#353535',
  --             lit_teal = '#3E7171',
  --             key_fg = '#ffffff',
  --             search = '#8E9092',
  --           }, -- hex (true) colours - see colors/hex.lua
  --         },
  --       },
  --     }
  --
  --     vim.cmd 'colorscheme lavender'
  --   end,
  -- },

  -- -- commented out the ashen
  -- {
  --   'ficcdaf/ashen.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     style_presets = {
  --       bold_functions = true,
  --       italic_comments = true,
  --     },
  --
  --     plugins = {
  --       -- keep autoload on, but *skip* lualine
  --       override = { 'lualine' },
  --       -- (or set autoload=false if you’d rather
  --       --  enable integrations manually)
  --     },
  --
  --     hl = {
  --       -- completely overwrite the default for error underlines
  --       force_override = {
  --         -- this changes mini.statusline
  --         MiniStatuslineModeNormal = { 'red_flame', 'red_ember' },
  --         MiniStatuslineModeInsert = { 'orange_smolder', 'orange_glow' },
  --         -- ["@lsp.type.class.java"] = { "#eab5ee", nil, { bold = true } },
  --         -- ["@lsp.type.interface.java"] = { "#eab5ee", nil, { bold = true } },
  --         -- ["@lsp.modifier.static"] = { "#00dfff" },
  --         -- link helpers (alternative):
  --         -- ["@lsp.type.class.java"]   = { link = "@type.definition" },
  --         --
  --         --            fg  , bg  , style-table
  --         DiagnosticUnderlineError = {
  --           nil,
  --           nil, -- keep the current fg / bg
  --           {
  --             underdouble = false, -- ⟵ double line
  --             underline = true, -- ⟵ solid line
  --             undercurl = false, -- turn the dots off
  --             -- sp = "#BF65FF",
  --             sp = '#8755E1',
  --           }, -- underline colour
  --         },
  --       },
  --     },
  --
  --     colors = {
  --       -- red variations
  --       -- red_flame = "#BF65FF",
  --       red_flame = '#8755E1',
  --       red_glowing = '#d7bafb',
  --       red_ember = '#eab5ee',
  --
  --       -- orange variations
  --       --  orange_glow = "#D87C4A", -- Bright, glowing orange
  --       -- orange_blaze = "#C4693D", -- Vibrant blaze orange
  --       -- orange_smolder = "#E49A44",
  --       orange_glow = '#afc9e7',
  --
  --       orange_blaze = '#81d5ce',
  --       orange_smolder = '#cce8e4',
  --     },
  --   },
  --
  --   -- config = function(_, opts)
  --   -- 	-- Load the colorscheme here.
  --   -- 	-- Like many other themes, this one has different styles, and you could load
  --   -- 	-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
  --   -- 	require("ashen").setup(opts)
  --   -- 	vim.cmd.colorscheme("ashen")
  --   -- end,
  -- },
}
