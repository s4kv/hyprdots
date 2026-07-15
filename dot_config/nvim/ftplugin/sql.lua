-- Postgres LSP (postgres_lsp) only attaches when a `postgres-language-server.jsonc`
-- exists in the project root -- it declares workspace_required, so it deliberately
-- stays silent in DBUI scratch buffers and one-off .sql files.
--
-- To turn it on for a project, drop this file in the repo root and gitignore it:
--
--   {
--     "database": {
--       "host": "localhost",
--       "port": 5432,
--       "username": "postgres",
--       "password": "postgres",
--       "database": "mydb",
--       "connTimeoutSecs": 10,
--       // schemas where the "execute statement under cursor" code action is allowed
--       "allowStatementExecutionsAgainst": ["public"]
--     }
--   }
--
-- Prefer a dedicated read-only user over admin credentials. Setting
-- "disableConnection": true keeps syntax diagnostics and linting while dropping
-- anything that needs the live schema (completion, hover, type checking) -- use it
-- if you would rather not keep a password on disk at all.

local bufnr = vim.api.nvim_get_current_buf()

vim.opt_local.commentstring = '-- %s'
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2

vim.keymap.set('n', '<leader>Dr', '<Plug>(DBUI_ExecuteQuery)', { desc = '[D]atabase [r]un query', buffer = bufnr })
vim.keymap.set('v', '<leader>Dr', '<Plug>(DBUI_ExecuteQuery)', { desc = '[D]atabase [r]un selection', buffer = bufnr })
