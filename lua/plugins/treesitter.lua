-- =============================================================================
-- TREESITTER - SYNTAX HIGHLIGHTING
-- =============================================================================
-- Advanced syntax highlighting and code parsing using Tree-sitter.
-- Provides accurate, fast syntax highlighting with support for incremental
-- selection, text objects, and intelligent code navigation across many languages.

return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        -- auto_install = false,  -- Automatically install missing parsers
        -- ensure_installed = {},  -- Install all available parsers
        -- textobjects = { move = { enable = true } },  -- Enable text object movements
        -- rainbow = { enable = false },  -- Enable rainbow parentheses (requires nvim-ts-rainbow)
        -- context_commentstring = { enable = false },  -- Enable context-aware commenting (requires nvim-ts-context-commentstring)
        
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
          "bash", "c", "diff", "gitcommit", "gitignore", "html",
          "javascript", "jsdoc", "json", "jsonc", "lua", "luadoc",
          "luap", "markdown", "markdown_inline", "printf", "python",
          "query", "regex", "toml", "tsx", "typescript", "vim", "vimdoc",
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
        textobjects = {
          move = {
            enable = true,
            goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
            goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
            goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
            goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
          },
        },
      })
    end,
  },
}