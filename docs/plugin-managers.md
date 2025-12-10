# Plugin Manager Configuration

This Neovim configuration uses **vim.pack** (Neovim's built-in plugin manager) combined with **lz.n** for lazy loading.

## Overview

**Plugin Manager:** vim.pack + lz.n

This configuration provides:
- Automatic plugin discovery from `lua/plugins/` directory
- Fast plugin installation via vim.pack
- Smart lazy loading via lz.n (events, keys, filetypes)
- No external plugin manager dependencies

## Requirements

vim.pack requires **Neovim 0.12+** (nightly build as of December 2025).

Check your version:
```bash
nvim --version
```

## Plugin Format

All plugins use a simple Lua table format with full GitHub URLs:

```lua
return {
  {
    url = "https://github.com/author/plugin-name.git",
    event = "BufReadPost",  -- Lazy load trigger
    after = function()
      -- Plugin configuration (runs after plugin loads)
      require("plugin-name").setup({})
    end,
    keys = {
      { "<leader>key", "<cmd>Command<cr>", desc = "Description" }
    },
    enabled = function()
      return vim.g.vscode ~= 1  -- Disable in VSCode
    end,
  }
}
```

## Lazy Loading Options (lz.n)

| Option | Description | Example |
|--------|-------------|---------|
| `event` | Load on Neovim event | `"BufReadPost"`, `"InsertEnter"` |
| `keys` | Load when key is pressed | `{ "<leader>f", ... }` |
| `ft` | Load for filetype | `"lua"`, `{ "typescript", "javascript" }` |
| `colorscheme` | Load when colorscheme is set | `"gruvbox"` |
| `lazy` | Explicit lazy (default true) | `lazy = false` for immediate load |

## Features

- **Built-in**: Uses Neovim's native vim.pack (no external manager)
- **Fast**: lz.n provides efficient lazy loading
- **Simple**: Single-file implementation in `lua/lib/plugin_manager_lzn.lua`
- **Automatic discovery**: Drop plugin files in `lua/plugins/`

## Files

- `lua/plugins/` - Plugin configurations
- `lua/lib/plugin_manager_lzn.lua` - vim.pack + lz.n integration
- `lua/plugins/lz-n.lua` - lz.n plugin spec (loaded first)
- `lua/plugins/dependencies.lua` - Shared dependencies

That's it! The plugin system just works - drop plugin files in `lua/plugins/` and they'll be automatically discovered and loaded.

