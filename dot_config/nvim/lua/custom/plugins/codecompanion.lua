return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		enabled = true,
		lazy = true,
		opts = {
			display = {
				chat = {
					intro_message = "Welcome to Sakvi | Press ? for options",
					show_header_separator = false, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
					auto_scroll = false,
				},
			},
			strategies = {
				chat = {
					adapter = "copilot",
					roles = {
						llm = "CodeCompanion",
						user = "Me",
					},
					-- slash_commands = generate_slash_commands(),
					keymaps = {
						close = {
							modes = {
								n = "q",
							},
							index = 3,
							callback = "keymaps.close",
							description = "Close Chat",
						},
						stop = {
							modes = {
								n = "<C-c",
							},
							index = 4,
							callback = "keymaps.stop",
							description = "Stop Request",
						},
					},
				},
			},
			inline = {
				adapter = "copilot",
			},
		},
		keys = {
			{
				"<leader>ac",
				"<cmd>CodeCompanionActions<cr>",
				mode = { "n", "v" },
				noremap = true,
				silent = true,
				desc = "CodeCompanion actions",
			},
			{
				"<leader>aa",
				"<cmd>CodeCompanionChat Toggle<cr>",
				mode = { "n", "v" },
				noremap = true,
				silent = true,
				desc = "CodeCompanion chat",
			},
			{
				"<leader>ad",
				"<cmd>CodeCompanionChat Add<cr>",
				mode = "v",
				noremap = true,
				silent = true,
				desc = "CodeCompanion add to chat",
			},
		},
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		-- ft = { "markdown", "codecompanion" },
		ft = { "codecompanion" },
	},
	-- {
	--   "OXY2DEV/markview.nvim",
	--   lazy = false,
	--   opts = {
	--     preview = {
	--       filetypes = { "markdown", "codecompanion" },
	--       ignore_buftypes = {},
	--     },
	--   },
	--   {
	--     "HakonHarnes/img-clip.nvim",
	--     opts = {
	--       filetypes = {
	--         codecompanion = {
	--           prompt_for_file_name = false,
	--           template = "[Image]($FILE_PATH)",
	--           use_absolute_path = true,
	--         },
	--       },
	--     },
	--   },
	-- },
	{
		"echasnovski/mini.diff",
		config = function()
			local diff = require("mini.diff")
			diff.setup({
				-- Disabled by default
				source = diff.gen_source.none(),
			})
		end,
	},
	{
		"saghen/blink.cmp",
		dependencies = { "olimorris/codecompanion.nvim", "saghen/blink.compat" },
		event = "InsertEnter",
		opts = {
			enabled = function()
				return vim.bo.buftype ~= "prompt" and vim.b.completion ~= false
			end,
			completion = {
				accept = {
					auto_brackets = {
						kind_resolution = {
							blocked_filetypes = { "typescriptreact", "javascriptreact", "vue", "codecompanion" },
						},
					},
				},
			},
			sources = {
				per_filetype = {
					codecompanion = { "codecompanion" },
				},
			},
		},
	},
}
