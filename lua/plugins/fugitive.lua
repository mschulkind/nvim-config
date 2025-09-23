-- =============================================================================
-- FUGITIVE - GIT INTEGRATION
-- =============================================================================
-- Comprehensive Git wrapper for Neovim with powerful Git operations.
-- Provides Git status, diff views, commit management, and seamless integration
-- with Git workflows directly within the editor for efficient version control.

return {
  {
    "tpope/vim-fugitive",
    config = function()
      -- Git keymaps
      vim.keymap.set("n", "<leader>gs", ":Git<CR>", { silent = true })
      vim.api.nvim_set_hl(0, "Modified", { bg = "orange", fg = "black" })
    end,
  },
}