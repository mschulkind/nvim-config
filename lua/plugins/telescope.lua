-- =============================================================================
-- TELESCOPE - FUZZY FINDER
-- =============================================================================
-- Powerful fuzzy finder for files, buffers, and live grep searches.
-- Provides fast file navigation with preview, ripgrep integration,
-- and extensible picker system for enhanced productivity.

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      telescope.setup({
        defaults = {
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              preview_width = 0.40,
              width = 0.95,
            },
          },
          -- sorting_strategy = "descending",  -- Sort results in descending order
          -- prompt_prefix = "> ",  -- Custom prompt prefix
          -- selection_caret = "> ",  -- Custom selection indicator
          -- file_ignore_patterns = {},  -- Ignore specific patterns
          -- vimgrep_arguments = { "rg", "--vimgrep", "--no-heading" },  -- Custom grep command
        },
        pickers = {
          find_files = {
            hidden = true,
            find_command = {
              "rg",
              "--files",
              "--hidden", 
              "--no-ignore-global",
              "--follow",
              "--glob",
              "!.git/*",
            },
          },
        },
      })

      -- Custom hidden buffers picker (excludes all visible buffers)
      _G.hidden_buffers_picker = function()
        local visible = {}
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          visible[vim.api.nvim_win_get_buf(win)] = true
        end
        
        -- Get hidden buffers
        local hidden_buffers = vim.tbl_filter(function(buf)
          return vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted and not visible[buf]
        end, vim.api.nvim_list_bufs())
        
        if #hidden_buffers == 0 then
          vim.notify("No hidden buffers available", vim.log.levels.INFO)
          return
        end
        
        -- Use builtin buffers with custom results
        builtin.buffers({
          finder = require("telescope.finders").new_table({
            results = hidden_buffers,
            entry_maker = function(buf)
              local name = vim.api.nvim_buf_get_name(buf)
              local display_name = name == "" and "[No Name]" or vim.fn.fnamemodify(name, ":t")
              return { 
                value = buf, 
                display = display_name,
                ordinal = display_name,
                path = name,  -- Full path for Telescope's preview
              }
            end,
          }),
        })
      end
    end,
    keys = {
      { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>o", "<cmd>Telescope oldfiles<cr>", desc = "Find old files" },
      { "<leader>b", ":lua _G.hidden_buffers_picker()<cr>", desc = "Find hidden buffers (MRU)" },
    },
  },
}