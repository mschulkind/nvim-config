-- =============================================================================
-- FILETREE NAVIGATION
-- =============================================================================
-- Modern file tree and directory navigation plugins for enhanced file management.
-- Provides a clean, efficient file explorer with git integration and modern UI.

return {
  {
    "nvim-tree/nvim-tree.lua",
    cond = function()
      return vim.g.vscode ~= 1  -- File explorer conflicts with VSCode's explorer
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        -- view = { width = 30 },  -- Custom tree width
        -- renderer = { group_empty = false },  -- Group empty folders
        -- filters = { dotfiles = false },  -- Hide hidden files
        -- git = { enable = true },  -- Enable git integration
        -- actions = { open_file = { quit_on_open = false } },  -- Quit on file open
        
        view = {
          width = 30,  -- Set tree width to 30 columns
        },
        renderer = {
          indent_markers = {
            enable = true,  -- Show indent markers for better visual hierarchy
          },
        },
        filters = {
          dotfiles = false,  -- Show hidden files (dotfiles)
        },
      })
    end,
    keys = {
      { "<F6>", function()
        require("nvim-tree.api").tree.toggle({ find_file = true })
      end, desc = "Toggle NvimTree and find current file", silent = true },
    },
  },
}
