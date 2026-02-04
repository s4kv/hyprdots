-- lua/plugins/bufferline.lua
-- return {
-- 	"akinsho/bufferline.nvim",
-- 	event = { "VeryLazy", "ColorScheme" }, -- This is still important
-- 	opts = {
-- 		highlights = {
-- 			fill = { bg = "none" },
-- 			background = { bg = "none" },
-- 			buffer_selected = { bg = "none" },
-- 			buffer_visible = { bg = "none" },
-- 			separator = { bg = "none" },
-- 			separator_selected = { bg = "none" },
-- 			separator_visible = { bg = "none" },
-- 		},
-- 	},
-- }
return {
  'willothy/nvim-cokeline',
  -- event = { 'VeryLazy', 'ColorScheme' }, -- This is still important
  dependencies = {
    'nvim-lua/plenary.nvim', -- Required for v0.4.0+
    'nvim-tree/nvim-web-devicons', -- If you want devicons
    -- 'stevearc/resession.nvim', -- Optional, for persistent history
  },
  config = function()
    local get_hex = require('cokeline.hlgroups').get_hl_attr

    require('cokeline').setup {
      default_hl = {
        fg = function(buffer)
          return buffer.is_focused and get_hex('Normal', 'fg') or get_hex('Comment', 'fg')
        end,
        bg = 'NONE',
      },
      components = {
        {
          text = function(buffer)
            return (buffer.index ~= 1) and '▏' or ''
          end,
          fg = function()
            return get_hex('Normal', 'fg')
          end,
        },
        {
          text = function(buffer)
            return ' ' .. buffer.devicon.icon
          end,
          fg = function(buffer)
            return buffer.devicon.color
          end,
        },
        {
          text = function(buffer)
            return buffer.filename .. ' '
          end,
          bold = function(buffer)
            return buffer.is_focused
          end,
          fg = function(buffer)
            if buffer.is_focused then
              return '#d7bafb'
            else
              get_hex('Normal', 'fg')
            end
          end,
        },
        {
          text = function(buffer)
            return buffer.is_modified and ' ' or ' '
          end,
          fg = function(buffer)
            return buffer.is_modified and '#eab5ee' or get_hex('Normal', 'fg')
          end,
          on_click = function(_, _, _, _, buffer)
            if not buffer.is_modified then
              buffer:delete()
            end
          end,
        },
        {
          text = '  ',
        },
      },
    }
  end,
}
-- return {
--   'romgrk/barbar.nvim',
--   dependencies = {
--     'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
--     'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
--   },
--   init = function()
--     vim.g.barbar_auto_setup = false
--   end,
--   opts = {
--     -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
--     -- animation = true,
--     -- insert_at_start = true,
--     -- …etc.
--   },
--   version = '^1.0.0', -- optional: only update when a new 1.x version is released
-- }
