-- =============================================================================
-- GRUVBOX COLORSCHEME
-- =============================================================================
-- Retro groove color scheme with warm, muted colors and excellent contrast.
-- Provides a comfortable editing experience with carefully crafted syntax
-- highlighting that's easy on the eyes during long coding sessions.

return {
  {
    "ellisonleao/gruvbox.nvim",
    cond = function()
      return vim.g.vscode ~= 1  -- Colorscheme conflicts with VSCode's theme
    end,
    config = function()
      require("gruvbox").setup({
        -- terminal_colors = true,  -- Enable terminal colors
        -- undercurl = true,  -- Enable undercurl support
        -- underline = true,  -- Enable underline support
        -- bold = true,  -- Enable bold text
        -- italic = { strings = true, comments = true, operators = false, folds = true },  -- Italic text options
      })
      vim.cmd("colorscheme gruvbox")
    end,
  },
}