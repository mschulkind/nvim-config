# Plugin System

This Neovim configuration supports both Lazy.nvim and vim.pack plugin managers with a unified configuration format that automatically discovers, loads, and configures plugins.

## 🏗️ Architecture

### Dual Plugin Manager Support

This configuration supports both Lazy.nvim and vim.pack plugin managers with automatic selection:

- **Lazy.nvim** - Modern, fast plugin manager with lazy loading
- **vim.pack** - Built-in Neovim plugin manager, no external dependencies

**Automatic Selection Priority:**
1. **Explicit choice** via `NVIM_PLUGIN_MANAGER` environment variable
2. **vim.pack** if available (very recent nightly build)
3. **Lazy.nvim** as fallback

> ⚠️ **Important**: vim.pack requires a **very recent nightly build** of Neovim. The system will automatically fall back to Lazy.nvim if vim.pack is not available.

**Manual Override:**
```bash
# Force Lazy.nvim
NVIM_PLUGIN_MANAGER=lazy nvim

# Force vim.pack (if available)
NVIM_PLUGIN_MANAGER=vim_pack nvim
```

### Plugin Manager (`lua/lib/plugin_manager/`)

The plugin system consists of three main components:

- **`plugin_manager.lua`** - Core plugin management logic and vim.pack support
- **`lazy_integration.lua`** - Lazy.nvim integration and setup
- **`auto_loader.lua`** - Automatic plugin discovery and loading (legacy)

### Plugin Discovery

Plugins are automatically discovered by scanning the `lua/plugins/` directory:

```
lua/plugins/
├── telescope.lua      # Telescope configuration
├── completion.lua     # Copilot and completion
├── treesitter.lua     # Treesitter configuration
├── fugitive.lua       # Git integration
├── lualine.lua        # Status line
├── gruvbox.lua        # Color scheme
├── filetree.lua       # File explorer
├── formatting.lua     # Code formatting
├── flit.lua          # Enhanced f/t motions
├── leap.lua          # Lightning navigation
└── simple_plugins.lua # Multiple simple plugins
```

## 📝 Plugin Configuration Format

### Single Plugin File

Each plugin file returns a Lazy.nvim-compatible configuration table:

```lua
return {
  {
    "user/repo",                -- Plugin repository (required)
    cond = function()            -- Conditional loading (optional)
      return vim.g.vscode ~= 1  -- Only load when not in VSCode
    end,
    config = function()          -- Configuration function (optional)
      -- Plugin configuration code
    end,
    keys = {                     -- Keymaps (optional)
      { "n", "<leader>f", ":Telescope find_files<CR>" }
    },
    dependencies = {             -- Dependencies (optional)
      "plenary.nvim"
    }
  }
}
```

### Multiple Plugins File

For simple plugins, you can define multiple plugins in one file:

```lua
return {
  plugins = {
    plugin1 = {
      repo = "user/plugin1",
      setup = function() end
    },
    plugin2 = {
      repo = "user/plugin2",
      vscode = false
    }
  }
}
```

## 🔧 Configuration Options

### Required Options

#### `repo` (string)
The plugin repository URL or short name:
```lua
repo = "nvim-telescope/telescope.nvim"  -- Full GitHub repo
repo = "telescope.nvim"                 -- Short name (assumes GitHub)
repo = "https://gitlab.com/user/repo"   -- Full URL
```

### Optional Options

#### `vscode` (boolean)
Whether the plugin should load in VSCode mode:
```lua
vscode = true   -- Load in both modes (default)
vscode = false  -- Disable in VSCode mode
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

## ★ Plugin Loading Process

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

## → VSCode Compatibility

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
  "plenary.nvim",        -- Common dependency for many plugins
  "nvim-web-devicons",   -- Icons for UI plugins
}
```

## 🔄 Plugin Lifecycle

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

## 🛠️ Adding New Plugins

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

## 🔍 Debugging Plugins

### Check Plugin Status
```vim
:checkhealth
```

### View Plugin Registry
```lua
:lua print(vim.inspect(require("lib.plugin_manager.plugin_manager").plugins))
```

### Check VSCode Mode
```lua
:lua print(require("lib.plugin_manager.plugin_manager").is_vscode())
```

### View Error Messages
```vim
:messages
```

## 📚 Plugin Categories

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

## → Best Practices

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

## 📚 Related Documentation

- [Configuration System](configuration-system.md) - Overall architecture
- [Essential Plugins](plugins/essential.md) - Core plugin details
- [VSCode Integration](vscode-integration.md) - VSCode-specific considerations
- [Customization Guide](customization.md) - Modifying the configuration
