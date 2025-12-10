# Configuration System

This Neovim configuration uses a modern, modular architecture designed for maintainability and performance.

## Architecture Overview

```
config/nvim/
├── init.lua                    # Main entry point
├── lua/
│   ├── core/                   # Core Neovim settings
│   │   ├── keymaps.lua         # Global keymaps
│   │   ├── autocmds.lua        # Auto commands
│   │   └── clipboard.lua       # Clipboard integration
│   ├── plugins/                # Plugin configurations
│   │   ├── telescope.lua       # Telescope setup
│   │   ├── completion.lua      # Copilot + blink.cmp
│   │   └── *.lua               # Other plugin files
│   ├── lib/                    # Utility libraries
│   │   └── plugin_manager_lzn.lua  # vim.pack + lz.n integration
│   ├── lsp/                    # LSP configuration
│   │   └── handlers.lua        # LSP handlers and capabilities
│   └── utils/                  # Helper utilities
└── docs/                       # Documentation
```

## Core Components

### Main Entry Point (`init.lua`)

The main entry point loads core configurations in order:

```lua
-- Enable autoloading for better performance
vim.loader.enable()

-- Set leader keys (must be before plugins)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Load core configurations
require("core.autocmds")
require("core.keymaps")
require("core.clipboard")

-- Load utility modules
require("utils.movement").setup()

-- Load plugins via vim.pack + lz.n
require("lib.plugin_manager_lzn").setup()
```

### Core Settings (in `init.lua`)

Contains fundamental Neovim settings:

- **Performance optimizations**: `vim.loader.enable()`, `vim.o.updatetime = 250`
- **UI settings**: Line numbers, cursor line, sign column
- **Search settings**: Case sensitivity (`ignorecase`, `smartcase`)
- **Indentation**: 2-space tabs, `expandtab`
- **Terminal integration**: True color support

### Keymaps (`lua/core/keymaps.lua`)

Global keymaps that work across all modes:

- **Leader key**: Set to `,` (comma)
- **Window navigation**: `<C-h/j/k/l>`
- **File operations**: Save, reload, etc.
- **Search and replace**: Clear highlights, etc.

### Plugin System (`lua/plugins/`)

The plugin system uses a data-driven approach where each plugin is defined as a configuration table.

## Plugin Management

### Plugin Manager (`lua/lib/plugin_manager_lzn.lua`)

The plugin manager provides:

- **Auto-discovery**: Automatically finds and loads plugin files from `lua/plugins/`
- **vim.pack integration**: Installs plugins using Neovim's built-in package manager
- **lz.n lazy loading**: Efficient deferred loading based on events, keys, filetypes
- **VSCode detection**: Plugins can use `enabled` to disable in VSCode
- **Error handling**: Graceful failure with notifications

### Plugin Configuration Format

Each plugin file returns an array of plugin specs:

```lua
return {
  {
    url = "https://github.com/user/repo.git",  -- Full GitHub URL (required)
    event = "BufReadPost",                     -- Lazy load trigger (optional)
    after = function()                         -- Config after load (optional)
      require("plugin").setup({})
    end,
    keys = {                                   -- Keymap triggers (optional)
      { "<leader>f", "<cmd>Command<cr>", desc = "Description" }
    },
    enabled = function()                       -- Conditional loading (optional)
      return vim.g.vscode ~= 1
    end,
  }
}
```

### VSCode Compatibility

The system automatically detects VSCode mode and disables conflicting plugins:

```lua
local function is_vscode()
 return vim.g.vscode == 1
end
```

Plugins with `vscode = false` are skipped in VSCode mode.

## Performance Features

### Autoloading (`vim.loader.enable()`)

Enables Neovim's autoloading system for faster startup:

- Modules are loaded on-demand
- Reduces initial startup time
- Available in Neovim 0.9+

### Lazy Loading

Plugins are loaded only when needed:

- Keymaps trigger plugin loading
- Commands load plugins on first use
- Telescope loads on first file search

### Optimized Settings

- **Fast update time**: `vim.o.updatetime = 250`
- **Efficient redraws**: `vim.o.lazyredraw = true`
- **Smart completion**: `vim.o.completeopt = "menu,menuone,noselect"`

## Design Principles

### 1. Modularity
- Each component has a single responsibility
- Easy to enable/disable features
- Clear separation of concerns

### 2. Performance
- Lazy loading where possible
- Minimal startup overhead
- Efficient keymap handling

### 3. Compatibility
- Works in both standalone Neovim and VSCode
- Graceful degradation
- Clear error messages

### 4. Maintainability
- Self-documenting code
- Consistent patterns
- Easy to extend

## Loading Order

1. **Core settings** - Basic Neovim configuration
2. **Auto commands** - Event handlers
3. **Keymaps** - Global keybindings
4. **Clipboard** - System integration
5. **Utilities** - Helper functions
6. **Plugins** - All plugin configurations

This order ensures dependencies are available when needed.

## Customization Points

### Adding New Plugins

1. Create a new file in `lua/plugins/`
2. Define the plugin configuration
3. The system will auto-discover and load it

### Modifying Core Settings

Edit files in `lua/core/`:
- `settings.lua` - Basic Neovim options
- `keymaps.lua` - Global keybindings
- `autocmds.lua` - Auto commands

### Adding Utilities

Place utility functions in `lua/utils/` and call them from `init.lua`.

## 🐛 Debugging

### Check Plugin Status
```vim
:checkhealth
```

### View Error Messages
```vim
:messages
```

### Reload Configuration
```vim
:source %
```

### Plugin Manager Status
```lua
:lua print(vim.inspect(vim.pack.list()))
```

## Related Documentation

- [Plugin System](plugin-system.md) - Detailed plugin management
- [Customization Guide](customization.md) - How to modify the config
- [Troubleshooting](troubleshooting.md) - Common issues and solutions
