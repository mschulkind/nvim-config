# Plugin Manager Configuration

This Neovim configuration supports two plugin managers with a simple configuration option.

## Quick Setup

### Switch Plugin Managers

Edit `init.lua` and change this line:

```lua
local PLUGIN_MANAGER = "lazy" -- Change this to "vim_pack" to use vim.pack instead
```

**Options:**
- `"lazy"` - Lazy.nvim (default, faster, lazy loading)
- `"vim_pack"` - vim.pack (built-in, simpler)

### Examples

**Use Lazy.nvim (default):**
```lua
local PLUGIN_MANAGER = "lazy"
```

**Use vim.pack:**
```lua
local PLUGIN_MANAGER = "vim_pack"
```

## Plugin Format

All plugins use Lazy.nvim format regardless of which manager is active:

```lua
return {
 {
 "author/plugin-name",
 config = function()
-- Plugin configuration
 end,
 keys = {
 { "<leader>key", "<cmd>Command<cr>", desc = "Description" }
 }
 }
}
```

## Features

- **Lazy.nvim**: Fast startup, lazy loading, modern UI
- **vim.pack**: Built-in, no dependencies, simpler
- **Automatic fallback**: Falls back to vim.pack if Lazy.nvim fails
- **Same plugin format**: All plugins work with both managers

## Files

- `init.lua` - Main configuration (change PLUGIN_MANAGER here)
- `lua/plugins/` - Plugin configurations (Lazy.nvim format)
- `lua/lib/plugin_manager/` - Plugin manager implementation

That's it! Just change one line in `init.lua` to switch between plugin managers.
