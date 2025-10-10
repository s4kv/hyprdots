-- lua/plugins/java.lua
return {
  -- core lsp bridge for java
  'mfussenegger/nvim-jdtls',
  ft = { 'java' },
  dependencies = {
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'mfussenegger/nvim-dap',
  },
  config = function()
    local jdtls = require 'jdtls'

    -- use the jdtls wrapper installed by mason if available
    local cmd = { vim.fn.exepath 'jdtls' }

    -- inject lombok agent (mason puts lombok.jar alongside jdtls)
    -- safe even if you don't use lombok.
    local mason = vim.fn.stdpath 'data' .. '/mason'
    local lombok = mason .. '/share/jdtls/lombok.jar'
    if vim.uv.fs_stat(lombok) then
      table.insert(cmd, ('--jvm-arg=-javaagent:%s'):format(lombok))
    end

    -- root markers for maven/gradle/git projects
    local root_dir = vim.fs.root(0, { 'mvnw', 'gradlew', 'pom.xml', '.git' })

    -- give jdtls a stable, per-project workspace (prevents reindexing every boot)
    local project_name = root_dir and vim.fs.basename(root_dir) or 'default'
    local jdtls_cache = vim.fn.stdpath 'cache' .. '/jdtls/' .. project_name
    table.insert(cmd, '-configuration')
    table.insert(cmd, jdtls_cache .. '/config')
    table.insert(cmd, '-data')
    table.insert(cmd, jdtls_cache .. '/workspace')

    -- optional: tell jdtls about other installed jdks you use for builds
    -- (so features like project preview/lint match your toolchain)
    local settings = {
      java = {
        configuration = {
          -- example: point to multiple jdks; jdtls itself still runs on 21.
          -- runtimes = {
          --   { name = "javase-17", path = "/usr/lib/jvm/java-17" },
          --   { name = "javase-21", path = "/usr/lib/jvm/java-21", default = true },
          -- },
        },
        format = {
          -- use eclipse-style formatter xml (see section 4 below)
          -- settings = { url = "file:///abs/path/eclipse-java-google-style.xml", profile = "googlestyle" },
        },
      },
    }

    -- debug & test bundles from mason
    local bundles = {}
    local debug_glob = vim.fn.glob(mason .. '/share/java-debug-adapter/com.microsoft.java.debug.plugin-*.jar', false, true)
    for _, v in ipairs(debug_glob) do
      table.insert(bundles, v)
    end
    local test_glob = vim.fn.glob(mason .. '/share/java-test/*.jar', false, true)
    for _, v in ipairs(test_glob) do
      table.insert(bundles, v)
    end

    local function on_attach(client, bufnr)
      local jdtls = require 'jdtls'
      -- DAP & auto-discovered main classes after the server is attached
      jdtls.setup_dap { hotcodereplace = 'auto' }
      require('jdtls.dap').setup_dap_main_class_configs()
    end

    local config = {
      cmd = cmd,
      root_dir = root_dir,
      settings = settings,
      init_options = { bundles = bundles },
      on_attach = on_attach,
      -- cmp capabilities etc. (works fine with kickstart defaults)
    }

    jdtls.start_or_attach(config)

    -- nice extras from nvim-jdtls
    vim.keymap.set('n', '<leader>jo', jdtls.organize_imports, { buffer = true, desc = 'java: organize imports' })
    vim.keymap.set('n', '<leader>jv', jdtls.extract_variable, { buffer = true, desc = 'java: extract variable' })
    vim.keymap.set('v', '<leader>jm', function()
      jdtls.extract_method(true)
    end, { buffer = true, desc = 'java: extract method' })

    -- dap wiring (debug apps / junit)
    -- jdtls.setup_dap { hotcodereplace = 'auto' }
    -- require('jdtls.dap').setup_dap_main_class_configs()
  end,
}
