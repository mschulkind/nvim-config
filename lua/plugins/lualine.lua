-- =============================================================================
-- LUALINE - STATUS LINE
-- =============================================================================
-- Modern status line with customizable sections and themes.
-- Displays file information, git status, LSP diagnostics, and more
-- in a clean, informative status bar that enhances the editing experience.

return {
  {
    url = "https://github.com/nvim-lualine/lualine.nvim.git",
    lazy = false,  -- Load immediately for status line
    enabled = function()
      return vim.g.vscode ~= 1  -- Status line conflicts with VSCode's status bar
    end,
    after = function()
      -- Define the custom file path function to be reused
      local function custom_filepath()
        local filepath = vim.fn.expand('%:p')
        local git_root = vim.fn.systemlist('git -C ' .. vim.fn.expand('%:p:h') .. ' rev-parse --show-toplevel')[1]
        if git_root and git_root ~= '' and filepath:find(git_root, 1, true) == 1 then
          return filepath:sub(#git_root + 2)
        else
          return vim.fn.expand('%:t')
        end
      end

      require('lualine').setup({
        options = {
          theme = 'material',
        },
        sections = {
          lualine_c = {
            {
              custom_filepath,
              icon = '',
              desc = "Path from repo root"
            }
          }
        },
        inactive_sections = {
          lualine_c = {
            {
              custom_filepath,
              icon = '',
              desc = "Path from repo root"
            }
          }
        }
      })
    end,
  },
}