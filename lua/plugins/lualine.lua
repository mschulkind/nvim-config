-- =============================================================================
-- LUALINE - STATUS LINE
-- =============================================================================
-- Modern status line with customizable sections and themes.
-- Displays file information, git status, LSP diagnostics, and more
-- in a clean, informative status bar that enhances the editing experience.

return {
  {
    "nvim-lualine/lualine.nvim",
    cond = function()
      return vim.g.vscode ~= 1  -- Status line conflicts with VSCode's status bar
    end,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require('lualine').setup({
        
        options = {
          theme = 'material',
        },
      })
    end,
  },
}