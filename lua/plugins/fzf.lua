-- =============================================================================
-- FZF-LUA - FUZZY FINDER
-- =============================================================================
-- Fast and extensible fuzzy finder over lists using fzf
-- Alternative to Telescope with native fzf performance

local layout_opts = {
  ["--layout"] = "reverse-list",
  ["--bind"] = "change:top",
  ["--tac"] = true,
}

return {
  {
    url = "https://github.com/ibhagwan/fzf-lua.git",
    after = function()
      require("fzf-lua").setup({
        winopts = {
          preview = {
            default = "bat",
          },
        },
        fzf_opts = vim.deepcopy(layout_opts),
        buffers = {
          sort_mru = true,
          show_all_buffers = true,
          ignore_current_buffer = false,
          fzf_opts = vim.deepcopy(layout_opts),
        },
      })
    end,
    keys = {
      { 
        "<leader>b", 
        function()
          require("fzf-lua").buffers({
            sort_mru = true,
            fzf_opts = vim.deepcopy(layout_opts),
          })
        end,
        desc = "Switch buffers (MRU sorted)" 
      },
    },
  },
}
