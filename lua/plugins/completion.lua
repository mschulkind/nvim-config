-- =============================================================================
-- COMPLETION PLUGINS
-- =============================================================================
-- AI-powered code completion and intelligent autocomplete functionality.
-- Copilot provides GitHub's AI suggestions while Blink.cmp offers a modern
-- completion engine with fuzzy matching and LSP integration.

return {
  {
    "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup({
        -- suggestion = { keymap = { accept = "<Tab>" } },  -- Custom accept key
        -- panel = { enabled = false },  -- Enable Copilot panel
        -- filetypes = { ["*"] = true },  -- Enable for all filetypes
        -- server_opts_overrides = {},  -- Server options overrides
        -- suggestion = { auto_trigger = true },  -- Enable auto-trigger
        
        suggestion = { 
          auto_trigger = true, 
          keymap = { accept = "<Tab>" } 
        } 
      })
    end,
  },
  
  {
    "saghen/blink.cmp",
    dependencies = {
      "zbirenbaum/copilot.lua",
    },
    config = function()
      local blink_cmp = require("blink.cmp")
      blink_cmp.setup({
        keymap = { preset = "default" },
        appearance = {
          nerd_font_variant = "mono",
        },
        completion = {
          documentation = { auto_show = false },
        },
        cmdline = {
          keymap = { preset = "none" },
        },
        sources = {
          default = {
            "lsp",
            "path", 
            "snippets",
            "buffer",
          },
        },
        fuzzy = { implementation = "lua" },
      })
    end,
  },
}