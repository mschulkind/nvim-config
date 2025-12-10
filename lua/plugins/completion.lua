-- =============================================================================
-- COMPLETION PLUGINS
-- =============================================================================
-- AI-powered code completion and intelligent autocomplete functionality.
-- Copilot provides GitHub's AI suggestions while Blink.cmp offers a modern
-- completion engine with fuzzy matching and LSP integration.

return {
  {
    url = "https://github.com/zbirenbaum/copilot.lua.git",
    event = "InsertEnter",  -- Load when entering insert mode
    after = function()
      require("copilot").setup({
        
        suggestion = {
          auto_trigger = true,
          keymap = { accept = "<Tab>" }
        }
      })
    end,
  },
  
  {
    url = "https://github.com/Saghen/blink.cmp.git",
    event = "InsertEnter",  -- Load when entering insert mode
    after = function()
      -- Ensure copilot is loaded first
      require("lz.n").trigger_load("copilot.lua")
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