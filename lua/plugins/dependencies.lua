-- =============================================================================
-- PLUGIN DEPENDENCIES
-- =============================================================================
-- Common dependencies used by other plugins.
-- These are loaded lazily when needed by other plugins.

return {
  {
    url = "https://github.com/nvim-lua/plenary.nvim.git",
    lazy = true,
  },
  
  {
    url = "https://github.com/nvim-tree/nvim-web-devicons.git",
    lazy = true,
  },
  
  {
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim.git",
    lazy = true,
  },
  
  {
    url = "https://github.com/folke/snacks.nvim.git",
    lazy = true,
  },
}
