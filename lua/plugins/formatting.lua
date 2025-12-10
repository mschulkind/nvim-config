-- =============================================================================
-- FORMATTING AND LINTING CONFIGURATION
-- =============================================================================
-- Code formatting, linting, and quality tools for maintaining code standards.
-- Provides automatic code formatting with Conform, linting with ESLint/Stylelint,
-- and quality checks to ensure consistent, clean, and error-free code.

return {
  {
    url = "https://github.com/stevearc/conform.nvim.git",
    event = "BufWritePre",  -- Load before saving
    after = function()
      local conform = require("conform")
      conform.setup({
        
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
          -- TypeScript/JavaScript/JSX/TSX with Prettier
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          -- CSS/SCSS/Less with Prettier
          css = { "prettier" },
          scss = { "prettier" },
          less = { "prettier" },
          -- JSON with Prettier
          json = { "prettier" },
          -- HTML with Prettier
          html = { "prettier" },
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
    url = "https://github.com/mfussenegger/nvim-lint.git",
    event = "BufReadPost",  -- Load after opening a file
    after = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        python = { "ruff", "mypy" },
        -- CSS linting with Stylelint
        -- (ESLint LSP handles JavaScript/TypeScript via ts_ls)
        css = { "stylelint" },
        scss = { "stylelint" },
        less = { "stylelint" },
      }
      
      -- Override stylelint cmd to search PATH properly
      -- nvim-lint inherits PATH from Neovim's environment
      -- which should include your shell's PATH if launched from shell
      local stylelint = lint.linters.stylelint
      if stylelint then
        -- Store original cmd function
        local original_cmd = stylelint.cmd
        stylelint.cmd = function()
          -- First try the local node_modules (original behavior)
          local result = original_cmd()
          if vim.fn.executable(result) == 1 then
            return result
          end
          
          -- If that didn't work, explicitly search PATH for stylelint
          -- This handles cases where stylelint is installed globally via npm/mise/etc
          local path_stylelint = vim.fn.exepath("stylelint")
          if path_stylelint ~= "" then
            return path_stylelint
          end
          
          -- Fallback to just "stylelint" and let system resolve it
          return "stylelint"
        end
      end

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
