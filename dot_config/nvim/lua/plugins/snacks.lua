---@module 'lazy'

return {
    {
        "snacks.nvim",
        ---@type snacks.Config
        opts = {
            explorer = {
                replace_netrw = false, -- Replace netrw with the snacks explorer
            },
            picker = {
                debug = { scores = false, leaks = false, explorer = false, files = false },
                sources = {
                    files_with_symbols = {
                        multi = { "files", "lsp_symbols" },
                        filter = {
                            ---@param p snacks.Picker
                            ---@param filter snacks.picker.Filter
                            transform = function(p, filter)
                                local symbol_pattern = filter.pattern:match("^.-@(.*)$")
                                -- store the current file buffer
                                if filter.source_id ~= 2 then
                                    local item = p:current()
                                    if item and item.file then
                                        filter.meta.buf = vim.fn.bufadd(item.file)
                                    end
                                end

                                if symbol_pattern and filter.meta.buf then
                                    filter.pattern = symbol_pattern
                                    filter.current_buf = filter.meta.buf
                                    filter.source_id = 2
                                else
                                    filter.source_id = 1
                                end
                            end,
                        },
                    },
                },
                win = {
                    input = {
                        keys = {
                            ["<c-l>"] = { "toggle_lua", mode = { "n", "i" } },
                            -- ["<c-t>"] = { "edit_tab", mode = { "n", "i" } },
                            -- ["<Esc>"] = { "close", mode = { "n", "i" } },
                        },
                    },
                    list = {
                        keys = {},
                    },
                },
                actions = {
                    toggle_lua = function(p)
                        local opts = p.opts --[[@as snacks.picker.grep.Config]]
                        opts.ft = not opts.ft and "lua" or nil
                        p:find()
                    end,
                },
            },
            profiler = {
                runtime = "~/projects/neovim/runtime/",
                presets = {

                    on_stop = function()
                        Snacks.profiler.scratch()
                    end,
                },
            },
            indent = {
                chunk = { enabled = true },
            },
            dashboard = {
                preset = {
                    header = [[
   ▄▄▄▄▄   ██   █  █▀   ▄   ▄█ 
  █     ▀▄ █ █  █▄█      █  ██ 
▄  ▀▀▀▀▄   █▄▄█ █▀▄ █     █ ██ 
 ▀▄▄▄▄▀    █  █ █  █ █    █ ▐█ 
              █   █   █  █   ▐ 
             █   ▀     █▐      
            ▀          ▐       
 ]],
                },
            },
        },
        -- stylua: ignore
    },
}
