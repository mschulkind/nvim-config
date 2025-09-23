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
        -- options = { theme = 'auto' },  -- Custom theme
        -- sections = { lualine_a = { 'mode' } },  -- Custom sections
        -- options = { component_separators = { left = '|', right = '|' } },  -- Custom separators
        -- options = { section_separators = { left = '', right = '' } },  -- Custom section separators
        -- options = { disabled_filetypes = {} },  -- Disable for specific filetypes
        
        options = {
          theme = 'material',
        },
      })
    end,
  },
}