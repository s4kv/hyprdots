return {
  'mrcjkb/rustaceanvim',
  version = '^6', -- Recommended
  -- lazy = false, -- This plugin is already lazy
  ft = { 'rust', 'rs' }, -- Load only for Rust files

  opts = {
    server = {
      on_attach = function(_, bufnr)
        vim.keymap.set('n', '<leader>cR', function()
          vim.cmd.RustLsp 'codeAction'
        end, { desc = 'Code Action', buffer = bufnr })
        vim.keymap.set('n', '<leader>dr', function()
          vim.cmd.RustLsp 'debuggables'
        end, { desc = 'Rust Debuggables', buffer = bufnr })
      end,
      default_settings = {
        -- rust-analyzer language server configuration
        ['rust-analyzer'] = {
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
            buildScripts = {
              enable = true,
            },
          },
          -- Add clippy lints for Rust if using rust-analyzer
          checkOnSave = diagnostics == 'rust-analyzer',
          -- Enable diagnostics if using rust-analyzer
          diagnostics = {
            enable = diagnostics == 'rust-analyzer',
          },
          procMacro = {
            enable = true,
          },
          files = {
            exclude = {
              '.direnv',
              '.git',
              '.jj',
              '.github',
              '.gitlab',
              'bin',
              'node_modules',
              'target',
              'venv',
              '.venv',
            },
            -- Avoid Roots Scanned hanging, see https://github.com/rust-lang/rust-analyzer/issues/12613#issuecomment-2096386344
            watcher = 'client',
          },
        },
      },
    },
  },
  config = function(_, opts)
    local codelldb = vim.fn.exepath 'codelldb'
    local codelldb_lib_ext = io.popen('uname'):read '*l' == 'Linux' and '.so' or '.dylib'
    local library_path = vim.fn.expand('$MASON/opt/lldb/lib/liblldb' .. codelldb_lib_ext)
    opts.dap = {
      adapter = require('rustaceanvim.config').get_codelldb_adapter(codelldb, library_path),
    }
    vim.g.rustaceanvim = vim.tbl_deep_extend('keep', vim.g.rustaceanvim or {}, opts or {})
  end,
}
