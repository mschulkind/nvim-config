# Formatting and Linting Plugins

This document covers the code formatting, linting, and quality tools for maintaining code standards.

## 🎨 Code Formatting

### Conform ✓
**Repository**: `stevearc/conform.nvim`  
**VSCode Compatible**: ✓  
**Purpose**: Code formatting with multiple formatters

#### Features
- **Multiple formatters** - Support for various formatting tools
- **Auto-formatting** - Format on save or manually
- **Language-specific** - Different formatters per file type
- **Fallback support** - Graceful degradation when formatters fail

#### Configuration
```lua
require("conform").setup({
  -- format_on_save = { timeout_ms = 500 },  -- Increase timeout
  -- formatters_by_ft = {
  --   lua = { "stylua" },
  --   python = { "black", "isort" },
  --   javascript = { "prettier" },
  -- },
})
```

#### Supported Formatters
- **Lua**: stylua
- **Python**: black, isort, autopep8
- **JavaScript/TypeScript**: prettier, eslint
- **Go**: gofmt, goimports
- **Rust**: rustfmt
- **And many more...**

## 🔍 Code Linting

### nvim-lint ✓
**Repository**: `mfussenegger/nvim-lint`  
**VSCode Compatible**: ✓  
**Purpose**: Asynchronous linting for code quality

#### Features
- **Asynchronous** - Non-blocking linting
- **Multiple linters** - Support for various linting tools
- **Real-time feedback** - Shows issues as you type
- **Quickfix integration** - Jump to issues quickly

#### Configuration
```lua
require("lint").linters_by_ft = {
  python = { "pylint", "mypy" },
  javascript = { "eslint" },
  typescript = { "eslint" },
  lua = { "luacheck" },
  go = { "golangci-lint" },
  rust = { "cargo" },
}
```

#### Supported Linters
- **Python**: pylint, mypy, flake8, black
- **JavaScript/TypeScript**: eslint, tsc
- **Lua**: luacheck
- **Go**: golangci-lint, go vet
- **Rust**: cargo check, clippy
- **And many more...**

## ⚙ Configuration Options

### Conform Options
```lua
-- Format on save
format_on_save = {
  timeout_ms = 500,
  lsp_fallback = true,
}

-- Custom formatters
formatters_by_ft = {
  lua = { "stylua" },
  python = { "black", "isort" },
}

-- Format keymaps
vim.keymap.set({ "n", "v" }, "<leader>f", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format code" })
```

### nvim-lint Options
```lua
-- Lint on save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

-- Lint keymaps
vim.keymap.set("n", "<leader>l", function()
  require("lint").try_lint()
end, { desc = "Lint code" })
```

## → Integration with LSP

### LSP Integration
- **Conform** works alongside LSP formatters
- **nvim-lint** complements LSP diagnostics
- **Fallback support** when LSP formatters aren't available
- **Consistent experience** across different languages

### VSCode Compatibility
- **Conform** provides similar functionality to VSCode's format on save
- **nvim-lint** shows issues in the gutter like VSCode
- **Both plugins work seamlessly** in VSCode mode

## 🔧 Advanced Usage

### Custom Formatters
```lua
-- Add custom formatter
require("conform").formatters.custom_formatter = {
  command = "custom-tool",
  args = { "--format", "$FILENAME" },
}
```

### Custom Linters
```lua
-- Add custom linter
require("lint").linters.custom_linter = {
  cmd = "custom-linter",
  stdin = true,
  args = { "--format", "json" },
  parser = require("lint.parser").from_json({
    source = "custom-linter",
    severity = vim.diagnostic.severity.WARN,
  }),
}
```

## → Best Practices

### Formatting
- **Use format on save** for consistent code style
- **Configure language-specific formatters** for best results
- **Enable LSP fallback** for better compatibility

### Linting
- **Run linting on save** to catch issues early
- **Use quickfix** to navigate between issues
- **Configure appropriate linters** for your project

## 📚 Related Documentation

- [Essential Plugins](essential.md) - Core functionality plugins
- [Utility Plugins](utilities.md) - Helper and productivity plugins
- [UI Plugins](ui.md) - Interface and appearance plugins
