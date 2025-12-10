# Plugin System

This Neovim configuration uses **vim.pack** (Neovim's built-in plugin manager) combined with **lz.n** for lazy loading. This provides a fast, native plugin management experience with no external dependencies.

## Architecture

### Plugin Manager

This configuration uses:

- **vim.pack** - Neovim's built-in plugin manager (requires Neovim 0.12+/nightly)
- **lz.n** - Lightweight lazy-loading library for deferred plugin loading

> **Important**: vim.pack requires Neovim 0.12+ (nightly build as of Dec 2025).

### Plugin Manager (`lua/lib/plugin_manager_lzn.lua`)

The plugin system is a single-file implementation that:

1. Auto-discovers all plugin files in `lua/plugins/`
2. Collects plugin URLs and installs them via `vim.pack.add()`
3. Hands off lazy-loading to lz.n based on events, keys, or filetypes

### Plugin Discovery

Plugins are automatically discovered by scanning the `lua/plugins/` directory:

```
lua/plugins/
├── telescope.lua       # Telescope configuration
├── fzf.lua             # FZF-lua for buffer switching
├── completion.lua      # Copilot and blink.cmp
├── treesitter.lua      # Treesitter configuration
├── fugitive.lua        # Git integration
├── lualine.lua         # Status line
├── gruvbox.lua         # Color scheme
├── filetree.lua        # File explorer (nvim-tree)
├── formatting.lua      # Conform and nvim-lint
├── flit.lua            # Enhanced f/t motions
├── leap.lua            # Lightning navigation
├── mason.lua           # LSP server manager
├── toggleterm.lua      # Terminal management
├── simple_plugins.lua  # Multiple simple plugins
├── syntax_plugins.lua  # Language-specific syntax
├── dependencies.lua    # Shared dependencies
└── lz-n.lua            # lz.n lazy-loader itself
```

## Plugin Configuration Format

### Single Plugin File

Each plugin file returns an array of plugin specs:

```lua
-- lua/plugins/example.lua
return {
  {
    url = "https://github.com/user/repo.git",  -- Full GitHub URL (required)
    event = "BufReadPost",                     -- Lazy load on event (optional)
    keys = {                                   -- Lazy load on keymap (optional)
      { "<leader>x", "<cmd>MyCommand<cr>", desc = "My command" },
    },
    after = function()                         -- Run after plugin loads (optional)
      require("plugin").setup({ ... })
    end,
    enabled = function()                       -- Conditional loading (optional)
      return vim.g.vscode ~= 1                 -- Only load when not in VSCode
    end,
  },
}
```

### Multiple Plugins in One File

For related plugins, define multiple specs in one file:

```lua
return {
  {
    url = "https://github.com/user/plugin1.git",
    lazy = false,  -- Load immediately
  },
  {
    url = "https://github.com/user/plugin2.git",
    ft = "lua",    -- Load for Lua files only
  },
}
```

## Configuration Options

### Required Options

#### `url` (string)
The full GitHub URL for the plugin:
```lua
url = "https://github.com/nvim-telescope/telescope.nvim.git"
```

### Optional Options (lz.n)

#### `lazy` (boolean)
Whether to lazy-load the plugin:
```lua
lazy = false  -- Load immediately (default: true)
```

#### `event` (string or table)
Load plugin on Neovim event:
```lua
event = "BufReadPost"           -- Single event
event = { "BufReadPre", "BufNewFile" }  -- Multiple events
```

#### `keys` (table)
Load plugin when keymap is pressed:
```lua
keys = {
  { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find files" },
}
```

#### `ft` (string or table)
Load plugin for specific filetypes:
```lua
ft = "lua"                      -- Single filetype
ft = { "typescript", "javascript" }  -- Multiple filetypes
```

#### `colorscheme` (string)
Load plugin when colorscheme is set:
```lua
colorscheme = "gruvbox"
```

#### `after` (function)
Configuration function that runs after plugin loads:
```lua
after = function()
  require("telescope").setup({ ... })
end
```

#### `before` (function)
Configuration function that runs before plugin loads:
```lua
before = function()
  vim.g.some_setting = true
end
```

#### `enabled` (function or boolean)
Conditionally enable/disable the plugin:
```lua
enabled = function()
  return vim.g.vscode ~= 1  -- Disable in VSCode
end
```
vscode = true -- Load in both modes (default)
vscode = false -- Disable in VSCode mode
```

#### `setup` (function)
Plugin configuration function:
```lua
setup = function()
 require("telescope").setup({
-- Configuration options
 })
end
```

#### `keys` (table)
Keymaps for the plugin:
```lua
keys = {
 { "n", "<leader>f", ":Telescope find_files<CR>", { desc = "Find files" } },
 { "n", "<leader>g", ":Telescope live_grep<CR>", { desc = "Live grep" } }
}
```

#### `dependencies` (table)
Plugin dependencies:
```lua
dependencies = {
 "plenary.nvim",
 "nvim-web-devicons"
}
```

## Plugin Loading Process

### 1. Discovery Phase
- Scan `lua/plugins/` directory
- Load each plugin file
- Extract configuration tables

### 2. Filtering Phase
- Check VSCode compatibility
- Skip plugins with `vscode = false` in VSCode mode
- Log skipped plugins

### 3. Installation Phase
- Install plugins using `vim.pack.add()`
- Load common dependencies first
- Handle dependency resolution

### 4. Configuration Phase
- Load each plugin
- Execute setup functions
- Apply keymaps
- Handle errors gracefully

## VSCode Compatibility

### Automatic Detection

The system automatically detects VSCode mode:

```lua
local function is_vscode()
 return vim.g.vscode == 1
end
```

### Plugin Filtering

Plugins are filtered based on VSCode compatibility:

```lua
-- Skip plugin if it's disabled in VSCode
if is_vscode() and plugin.vscode == false then
 vim.notify("Skipping plugin " .. name .. " in VSCode", vim.log.levels.INFO)
else
-- Load the plugin
end
```

### Disabled Plugins

These plugins are disabled in VSCode mode:

- **NerdTree** - Conflicts with VSCode's file explorer
- **Lualine** - Conflicts with VSCode's status bar
- **Gruvbox** - Conflicts with VSCode's theme
- **Mundo** - Conflicts with VSCode's timeline
- **SwayConfig** - Not relevant in VSCode

## 📦 Common Dependencies

The system automatically loads common dependencies:

```lua
local common_deps = {
 "plenary.nvim", -- Common dependency for many plugins
 "nvim-web-devicons", -- Icons for UI plugins
}
```

## Plugin Lifecycle

### 1. Bootstrap
- Initialize plugin manager
- Set up packpath
- Load common dependencies

### 2. Discovery
- Auto-discover plugin files
- Parse configurations
- Build plugin registry

### 3. Installation
- Install plugins via `vim.pack.add()`
- Handle URL resolution
- Manage dependencies

### 4. Loading
- Load each plugin
- Execute setup functions
- Apply configurations

### 5. Error Handling
- Catch and log setup errors
- Continue loading other plugins
- Provide helpful error messages

## Adding New Plugins

### Method 1: Single Plugin File

Create a new file in `lua/plugins/`:

```lua
-- lua/plugins/my_plugin.lua
return {
 repo = "user/my-plugin",
 vscode = true,
 setup = function()
 require("my-plugin").setup({
-- Configuration
 })
 end,
 keys = {
 { "n", "<leader>m", ":MyCommand<CR>" }
 }
}
```

### Method 2: Add to Simple Plugins

Add to `lua/plugins/simple_plugins.lua`:

```lua
return {
 plugins = {
-- ... existing plugins ...
 my_plugin = {
 repo = "user/my-plugin",
 setup = function()
 require("my-plugin").setup({})
 end
 }
 }
}
```

### Method 3: Modify Existing Plugin

Edit an existing plugin file to add functionality.

## Debugging Plugins

### Check Plugin Status
```vim
:checkhealth
```

### View Installed Plugins
```lua
:lua print(vim.inspect(vim.pack.list()))
```

### Check VSCode Mode
```lua
:lua print(vim.g.vscode == 1)
```

### View Error Messages
```vim
:messages
```

## Plugin Categories

### Essential Plugins
- **Telescope** - File finding and searching
- **Copilot** - AI code completion
- **Treesitter** - Syntax highlighting
- **Fugitive** - Git integration

### UI Plugins
- **Lualine** - Status line (VSCode disabled)
- **Gruvbox** - Color scheme (VSCode disabled)
- **Flit.nvim** - Enhanced f/t motions

### Utility Plugins
- **NerdCommenter** - Commenting
- **BufKill** - Buffer management
- **Better Whitespace** - Whitespace handling
- **Indent Blankline** - Indentation guides

### Language Support
- **Treesitter** - Syntax highlighting
- **Language-specific plugins** - TypeScript, JSX, etc.

## Best Practices

### Plugin Configuration
1. **Keep it simple** - Only configure what you need
2. **Use descriptive names** - Make plugin files self-documenting
3. **Handle errors** - Wrap setup functions in error handling
4. **Document keymaps** - Use descriptive keymap options

### VSCode Compatibility
1. **Test in both modes** - Ensure plugins work in VSCode
2. **Use VSCode alternatives** - When possible, use VSCode's native features
3. **Mark incompatible plugins** - Set `vscode = false` for conflicting plugins

### Performance
1. **Lazy load when possible** - Use keymaps to trigger loading
2. **Minimize dependencies** - Only include necessary dependencies
3. **Use efficient configurations** - Avoid expensive operations in setup

## Related Documentation

- [Configuration System](configuration-system.md) - Overall architecture
- [Essential Plugins](plugins/essential.md) - Core plugin details
- [VSCode Integration](vscode-integration.md) - VSCode-specific considerations
- [Customization Guide](customization.md) - Modifying the configuration
