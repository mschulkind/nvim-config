# Settings & Options

This document explains all the configuration settings used in this Neovim configuration.

## → Core Settings

### Performance Settings

#### Autoloading
```lua
vim.loader.enable()  -- Enable Neovim's autoloading system (Neovim 0.9+)
```
- **Purpose**: Improves startup time by loading modules on-demand
- **Impact**: Reduces initial startup time significantly

#### Update Time
```lua
vim.o.updatetime = 250  -- Update time in milliseconds
```
- **Purpose**: Controls how often Neovim updates its state
- **Impact**: Affects LSP responsiveness and cursor hold events

#### Complete Options
```lua
vim.o.completeopt = "menu,menuone,noselect"
```
- **Purpose**: Controls completion menu behavior
- **Options**:
  - `menu`: Show popup menu
  - `menuone`: Show menu even for single match
  - `noselect`: Don't auto-select first match

### UI Settings

#### Line Numbers
```lua
vim.o.number = true        -- Show line numbers
vim.o.relativenumber = true -- Show relative line numbers
```
- **Purpose**: Better navigation and orientation
- **Impact**: Shows current line number and relative distances

#### Cursor Line
```lua
vim.o.cursorline = true    -- Highlight current line
vim.o.cursorcolumn = false -- Don't highlight current column
```
- **Purpose**: Visual indication of current position
- **Impact**: Makes it easier to track cursor position

#### Sign Column
```lua
vim.o.signcolumn = "yes"   -- Always show sign column
```
- **Purpose**: Space for Git signs, LSP diagnostics, etc.
- **Impact**: Prevents layout shifts when signs appear

### Search Settings

#### Case Sensitivity
```lua
vim.o.ignorecase = true    -- Ignore case in searches
vim.o.smartcase = true     -- Override ignorecase if search contains uppercase
```
- **Purpose**: More intuitive search behavior
- **Impact**: Searches are case-insensitive unless you use uppercase

#### Search Highlighting
```lua
vim.o.hlsearch = true      -- Highlight search results
vim.o.incsearch = true     -- Highlight matches while typing
```
- **Purpose**: Visual feedback during search
- **Impact**: Makes it easier to see search results

### Indentation Settings

#### Tab Settings
```lua
vim.o.tabstop = 2          -- Number of spaces a tab represents
vim.o.shiftwidth = 2       -- Number of spaces for indentation
vim.o.expandtab = true     -- Use spaces instead of tabs
vim.o.smartindent = true   -- Smart indentation
```
- **Purpose**: Consistent indentation behavior
- **Impact**: Ensures consistent code formatting

#### Indentation Detection
```lua
vim.o.autoindent = true    -- Copy indentation from previous line
vim.o.smartindent = true   -- Smart indentation for C-like languages
```
- **Purpose**: Automatic indentation
- **Impact**: Reduces manual indentation work

### Terminal Settings

#### Colors
```lua
vim.o.termguicolors = true -- Enable true color support
```
- **Purpose**: Better color support in terminals
- **Impact**: More accurate color representation

#### Mouse Support
```lua
vim.o.mouse = "a"          -- Enable mouse in all modes
```
- **Purpose**: Mouse interaction
- **Impact**: Allows mouse clicks, scrolling, selection

## 🔧 Plugin-Specific Settings

### Telescope Settings

#### Layout
```lua
layout_strategy = "horizontal"
layout_config = {
  horizontal = {
    preview_width = 0.6,
  },
}
```
- **Purpose**: Horizontal layout with preview
- **Impact**: Better file preview experience

#### File Finding
```lua
find_command = { "rg", "--files", "--hidden", "--follow" }
```
- **Purpose**: Use ripgrep for file finding
- **Impact**: Faster and more accurate file searching

### Treesitter Settings

#### Parsers
```lua
ensure_installed = "all"  -- Install all available parsers
```
- **Purpose**: Automatic parser installation
- **Impact**: Syntax highlighting for many languages

#### Highlighting
```lua
highlight = {
  enable = true,
  additional_vim_regex_highlighting = false,
}
```
- **Purpose**: Enable syntax highlighting
- **Impact**: Better code visualization

### Copilot Settings

#### Auto-trigger
```lua
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
```
- **Purpose**: Automatic suggestion triggering
- **Impact**: Suggestions appear automatically as you type

## 🎨 Appearance Settings

### Color Scheme
```lua
vim.cmd("colorscheme gruvbox")
```
- **Purpose**: Set color scheme
- **Impact**: Visual appearance of the editor

### Status Line
```lua
-- Lualine configuration
theme = "material"
```
- **Purpose**: Status line appearance
- **Impact**: Information display at bottom of screen

### Indentation Guides
```lua
-- Indent Blankline configuration
require("ibl").setup({})
```
- **Purpose**: Visual indentation indicators
- **Impact**: Makes indentation levels visible

## 🔄 VSCode-Specific Settings

### VSCode Detection
```lua
local function is_vscode()
  return vim.g.vscode == 1
end
```
- **Purpose**: Detect VSCode mode
- **Impact**: Enables VSCode-specific behavior

### Plugin Filtering
```lua
if is_vscode() and plugin.vscode == false then
  -- Skip plugin in VSCode
end
```
- **Purpose**: Disable conflicting plugins
- **Impact**: Prevents UI conflicts in VSCode

## 📊 Performance Settings

### Scrolloff
```lua
vim.g.scrolloff_fraction = 0.20
```
- **Purpose**: Dynamic scrolloff based on window height
- **Impact**: Maintains cursor position relative to screen

### Lazy Loading
```lua
-- Plugins are loaded on-demand
vim.keymap.set("n", "<leader>f", function()
  require("telescope").find_files()
end)
```
- **Purpose**: Load plugins only when needed
- **Impact**: Faster startup time

### Memory Management
```lua
vim.o.swapfile = false    -- Disable swap files
vim.o.backup = false      -- Disable backup files
vim.o.undofile = true     -- Enable persistent undo
```
- **Purpose**: Optimize file handling
- **Impact**: Reduces disk I/O and improves performance

## 🛠️ Customization

### Adding New Settings

#### Basic Settings
```lua
-- Add to lua/core/settings.lua
vim.o.my_setting = "value"
```

#### Plugin Settings
```lua
-- Add to plugin configuration
vim.g.plugin_setting = "value"
```

#### Conditional Settings
```lua
-- VSCode-specific settings
if vim.g.vscode then
  vim.o.setting = "vscode_value"
else
  vim.o.setting = "neovim_value"
end
```

### Modifying Existing Settings

#### Change Line Numbers
```lua
vim.o.number = false  -- Disable line numbers
```

#### Change Indentation
```lua
vim.o.tabstop = 4     -- Use 4 spaces for tabs
vim.o.shiftwidth = 4  -- Use 4 spaces for indentation
```

#### Change Search Behavior
```lua
vim.o.ignorecase = false  -- Make searches case-sensitive
```

## 🔍 Debugging Settings

### Check Current Settings
```vim
" Check all options
:set all

" Check specific option
:set number?

" Check in Lua
:lua print(vim.o.number)
```

### Check Plugin Settings
```vim
" Check plugin variables
:lua print(vim.g.copilot)

" Check plugin configuration
:lua print(vim.inspect(require("telescope")))
```

### Profile Settings
```vim
" Check startup time
:lua print(vim.g.startuptime)

" Check memory usage
:lua print(collectgarbage("count"))
```

## 📚 Related Documentation

- [Configuration System](configuration-system.md) - Overall architecture
- [Plugin System](plugin-system.md) - Plugin-specific settings
- [Customization Guide](customization.md) - How to modify settings
- [Troubleshooting](troubleshooting.md) - Common issues with settings
