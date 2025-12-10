-- =============================================================================
-- LEAP.NVIM - MOTION PLUGIN
-- =============================================================================
-- Revolutionary motion plugin for lightning-fast navigation across any distance.
-- Provides labeled jumps to any visible text with minimal keystrokes, making
-- it the foundation for efficient text navigation and movement in Neovim.

return {
  {
    url = "https://github.com/ggandor/leap.nvim.git",
    after = function()
      require("leap").setup({
        -- case_sensitive = false,  -- Make searches case sensitive
        -- max_phase_one_targets = 10,  -- Max targets in phase one
        -- highlight = { backdrop = false },  -- Highlight backdrop
        -- equivalence_classes = { " \t\r\n" },  -- Characters treated as equivalent
        -- special_keys = { repeat_search = ";" },  -- Repeat last search key
      })
    end,
    keys = {
      -- =============================================================================
      -- LEAP KEYBINDINGS (beyond what Flit provides)
      -- =============================================================================
      -- Direct jump motions (these are Leap's main features)
      { "s", "<Plug>(leap-forward-to)", desc = "Leap forward to any 2 characters" },
      { "S", "<Plug>(leap-backward-to)", desc = "Leap backward to any 2 characters" },
      { "gs", "<Plug>(leap-from-window)", desc = "Leap to any 2 characters in window" },
      
      -- Visual mode extensions
      { "s", "<Plug>(leap-forward-to)", mode = "x", desc = "Leap forward to extend selection" },
      { "S", "<Plug>(leap-backward-to)", mode = "x", desc = "Leap backward to extend selection" },
      
      -- Repeat motions
      { ";", "<Plug>(leap-repeat)", desc = "Repeat last leap motion" },
      { ",", "<Plug>(leap-repeat-backward)", desc = "Repeat last leap motion backward" },
    },
  },
}
