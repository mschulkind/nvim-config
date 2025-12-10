-- =============================================================================
-- FUGITIVE - GIT INTEGRATION
-- =============================================================================
-- Comprehensive Git wrapper for Neovim with powerful Git operations.
-- Provides Git status, diff views, commit management, and seamless integration
-- with Git workflows directly within the editor for efficient version control.

return {
  {
    url = "https://github.com/tpope/vim-fugitive.git",
    lazy = false,  -- Load immediately
    after = function()
      vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>", { silent = true, desc = "Git status" })
      vim.api.nvim_set_hl(0, "Modified", { bg = "orange", fg = "black" })
    end,
  },
}