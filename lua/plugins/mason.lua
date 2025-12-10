-- =============================================================================
-- MASON - LSP SERVER MANAGER
-- =============================================================================
-- Automatically installs and manages LSP servers, formatters, and linters.
-- This ensures you have the necessary tools for language support.

return {
  {
    url = "https://github.com/williamboman/mason.nvim.git",
    lazy = false,  -- Load immediately for LSP support
    after = function()
      require("mason").setup({
        ui = {
          border = "single",
          icons = {
            package_installed = "✓",
            package_pending = "➤",
            package_uninstalled = "✗",
          },
        },
      })
      
      -- IMPORTANT: Setup mason-lspconfig and handlers HERE (in mason.nvim's config)
      -- to guarantee proper load order (mason must be setup before mason-lspconfig)
      
      -- Use vim.schedule to defer LSP setup until after all plugins are loaded
      -- This is necessary with vim.pack to ensure mason-lspconfig is available
      vim.schedule(function()
        -- Load shared LSP handlers
        local ok_handlers, handlers = pcall(require, "lsp.handlers")
        if not ok_handlers then
          vim.notify("Failed to load lsp.handlers: " .. tostring(handlers), vim.log.levels.ERROR)
          return
        end
        
        local on_attach = handlers.on_attach
        local capabilities = handlers.capabilities()

        -- Setup mason-lspconfig with ensure_installed
        local ok_mason_lsp, mason_lspconfig = pcall(require, "mason-lspconfig")
        if not ok_mason_lsp then
          vim.notify("mason-lspconfig not available yet, skipping LSP setup", vim.log.levels.WARN)
          return
        end
        
        mason_lspconfig.setup({
          -- Automatically install these LSP servers (use lspconfig server names)
          ensure_installed = {
            "ts_ls",      -- TypeScript/JavaScript (was renamed from tsserver)
            "jsonls",     -- JSON
            "html",       -- HTML
            "cssls",      -- CSS
            "somesass_ls", -- SCSS/SASS (some-sass-language-server with full @use/@forward support)
            "pyright",    -- Python
            "eslint",     -- JavaScript/TypeScript linting (LSP)
          },
          -- Automatically set up servers listed in ensure_installed
          automatic_installation = true,
        })

        -- Setup LSP servers using native vim.lsp.config (Neovim 0.11+)
        
        -- Define servers to configure
        local servers = {
          { name = "pyright", 
            handlers = {
              -- Disable all diagnostics from pyright by ignoring publishDiagnostics
              ['textDocument/publishDiagnostics'] = function() end,
            },
          },
          { name = "ts_ls" },
          { name = "jsonls" },
          { name = "html" },
          { name = "cssls" },
          { name = "somesass_ls" },  -- SCSS/SASS language server (some-sass with @use/@forward)
          { name = "eslint" },
        }
        
        -- Setup each server with vim.lsp.config
        for _, server in ipairs(servers) do
          local server_name = server.name
          
          -- Create a definition handler for this server that opens in a split
          local definition_handler = require("lsp.handlers").get_definition_handler("split")
          
          -- Use native vim.lsp.config API with explicit handler
          vim.lsp.config(server_name, {
            capabilities = capabilities,
            settings = server.settings or {},
          })
          
          -- Register the on_attach callback via autocmd for this server
          vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
              local client = vim.lsp.get_client_by_id(args.data.client_id)
              if client and client.name == server_name then
                -- Override handlers for this specific server
                if server.handlers then
                  for method, handler in pairs(server.handlers) do
                    client.handlers[method] = handler
                  end
                end
                -- Set the definition handler for this specific client
                client.handlers["textDocument/definition"] = definition_handler
                -- Call on_attach to set up mappings
                on_attach(client, args.buf)
              end
            end,
          })
        end
      end)
    end,
  },
  
  {
    url = "https://github.com/williamboman/mason-lspconfig.nvim.git",
    lazy = true,  -- Loaded by mason.nvim
  },
  
  {
    url = "https://github.com/neovim/nvim-lspconfig.git",
    lazy = true,  -- Loaded by mason.nvim
  },
}
