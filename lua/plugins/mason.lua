-- =============================================================================
-- MASON - LSP SERVER MANAGER
-- =============================================================================
-- Automatically installs and manages LSP servers, formatters, and linters.
-- This ensures you have the necessary tools for language support.

return {
  {
    "williamboman/mason.nvim",
    config = function()
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
    end,
  },
  
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        -- Automatically install these LSP servers
        ensure_installed = {
          "tsserver",    -- TypeScript/JavaScript
          "jsonls",      -- JSON
          "html",        -- HTML
          "cssls",       -- CSS
          "pyright",     -- Python
        },
        -- Automatically set up servers listed in ensure_installed
        automatic_installation = true,
      })
    end,
  },
}
