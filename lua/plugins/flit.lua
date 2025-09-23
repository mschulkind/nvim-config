-- =============================================================================
-- FLIT.NVIM - ENHANCED F/T MOTIONS
-- =============================================================================
-- Enhanced f, F, t, T motions with labeled targets and clever repeat functionality.
-- Extends Vim's basic f/t motions with visual labels, multiline support,
-- and intelligent repeat behavior for more precise and efficient character navigation.

return {
  {
    "ggandor/flit.nvim",
    config = function()
      require("flit").setup({
        
        -- =============================================================================
        -- CURRENT CONFIGURATION
        -- =============================================================================
        keys = { f = 'f', F = 'F', t = 't', T = 'T' },
        labeled_modes = "nv",  -- Enable labels in normal and visual modes
        clever_repeat = true,  -- Smart repeat with ; and ,
        multiline = true,  -- Allow jumping across lines
      })
    end,
  },
}

