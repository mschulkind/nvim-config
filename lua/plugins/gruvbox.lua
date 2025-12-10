-- =============================================================================
-- GRUVBOX COLORSCHEME
-- =============================================================================
-- Retro groove color scheme with warm, muted colors and excellent contrast.
-- Provides a comfortable editing experience with carefully crafted syntax
-- highlighting that's easy on the eyes during long coding sessions.

return {
  {
    url = "https://github.com/ellisonleao/gruvbox.nvim.git",
    colorscheme = "gruvbox",  -- Load when colorscheme is set
    enabled = function()
      return vim.g.vscode ~= 1  -- Colorscheme conflicts with VSCode's theme
    end,
    before = function()
      require("gruvbox").setup({
        -- terminal_colors = true,  -- Enable terminal colors
        -- undercurl = true,  -- Enable undercurl support
        -- underline = true,  -- Enable underline support
        -- bold = true,  -- Enable bold text
        -- italic = { strings = true, comments = true, operators = false, folds = true },  -- Italic text options
      })
    end,
  },
}