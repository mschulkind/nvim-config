-- =============================================================================
-- FORMATTING AND LINTING CONFIGURATION
-- =============================================================================
-- Code formatting, linting, and quality tools for maintaining code standards.
-- Provides automatic code formatting with Conform, linting with pylint/mypy,
-- and quality checks to ensure consistent, clean, and error-free code.

return {
  {
    "stevearc/conform.nvim",
    config = function()
      local conform = require("conform")
      conform.setup({
        
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "ruff_organize_imports", "ruff_format" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
        log_level = vim.log.levels.WARN,
      })
    end,
  },
  
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        python = { "pylint", "mypy" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>l", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },
}
