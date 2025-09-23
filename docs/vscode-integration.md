# VSCode Integration

This Neovim configuration is designed to work seamlessly in both standalone Neovim and VSCode with the Neovim extension. This document covers VSCode-specific considerations and optimizations.

> **Note**: This also applies to Cursor IDE, which uses the same VSCode Neovim extension.

## 🎯 Overview

The configuration automatically detects when running in VSCode and adapts accordingly:

- **Enables** features that work well in VSCode
- **Disables** features that conflict with VSCode's UI
- **Optimizes** performance for the VSCode environment
- **Maintains** full functionality where possible

## 🔍 VSCode Detection

The system detects VSCode mode using:

```lua
local function is_vscode()
  return vim.g.vscode == 1
end
```

This is automatically set by the VSCode Neovim extension.

## ⚙️ Required Configuration

### Composite Key Sequences

The `jj` escape keybinding requires VSCode/Cursor-specific configuration to work properly with the Neovim extension.

**For VSCode**: `~/.config/Code - OSS/User/settings.json` (or equivalent)
**For Cursor**: `~/.config/Cursor/User/settings.json`

```json
{
  "vscode-neovim.compositeKeys": {
    "jj": {
      "command": "vscode-neovim.escape"
    }
  }
}
```

This configuration is already included in the dotfiles at:
- `config/Code - OSS/User/settings.json` (VSCode)
- `config/Cursor/User/settings.json` (Cursor)

### Why This Is Needed

VSCode's Neovim extension handles composite key sequences differently than standalone Neovim. Without this configuration:
- `jj` won't work as an escape sequence
- You might experience issues typing uppercase 'J' and 'K'
- Some other composite keys may not function as expected


## ✅ Features That Work in VSCode

### Core Functionality
- **Telescope** - File finding and searching
- **Copilot** - AI code completion
- **Treesitter** - Syntax highlighting and text objects
- **Fugitive** - Git integration
- **Flit.nvim** - Enhanced f/t motions
- **Blink.cmp** - Completion engine

### Keymaps
- **Navigation**: `,f`, `,o`, `,b` for file operations
- **Window navigation**: `<C-h/j/k/l>` for moving between splits
- **Text editing**: `jj` for escape, `<C-S>` for save
- **Git**: `,gs` for Git status
- **Configuration**: `,v` and `,V` for config management

### LSP Features
- **Hover information**: `K` key
- **Code completion**: Tab completion
- **Diagnostics**: Error highlighting and navigation
- **Code actions**: Available through VSCode's command palette

## ❌ Features Disabled in VSCode

### UI Plugins (Use VSCode's Native Features Instead)

#### NerdTree ❌
- **Disabled because**: Conflicts with VSCode's file explorer
- **VSCode alternative**: Use VSCode's file explorer (Ctrl+Shift+E)
- **Keymap**: `<F6>` is disabled

#### Lualine ❌
- **Disabled because**: Conflicts with VSCode's status bar
- **VSCode alternative**: Use VSCode's status bar
- **Features**: File info, Git status, etc. are shown in VSCode's status bar

#### Gruvbox ❌
- **Disabled because**: Conflicts with VSCode's theme system
- **VSCode alternative**: Use VSCode's theme system
- **Note**: You can still use VSCode themes that mimic Gruvbox

### Utility Plugins

#### Mundo ❌
- **Disabled because**: Conflicts with VSCode's timeline feature
- **VSCode alternative**: Use VSCode's timeline (Ctrl+Shift+P → "Timeline")
- **Keymap**: `<F5>` is disabled

#### SwayConfig ❌
- **Disabled because**: Not relevant in VSCode environment
- **Note**: This is a window manager integration plugin

## 🔧 VSCode-Specific Optimizations

### Performance Optimizations
- **Reduced plugin loading** - Only loads compatible plugins
- **Optimized keymaps** - Focuses on essential shortcuts
- **Efficient completion** - Works with VSCode's completion system

### UI Integration
- **Status bar integration** - Uses VSCode's status bar
- **File explorer integration** - Uses VSCode's file explorer
- **Theme integration** - Uses VSCode's theme system
- **Command palette integration** - Works with VSCode's command palette

## 🚀 Getting Started in VSCode

### 1. Install the Neovim Extension
1. Open VSCode
2. Go to Extensions (Ctrl+Shift+X)
3. Search for "Neovim"
4. Install the official Neovim extension

### 2. Configure the Extension
Add to your VSCode settings:

```json
{
  "vscode-neovim.neovimExecutablePaths.linux": "/usr/bin/nvim",
  "vscode-neovim.neovimInitVimPaths.linux": "/home/username/.config/nvim/init.lua"
}
```

### 3. Essential Keymaps to Learn
Start with these keymaps that work in both modes:

| Keymap | Action | Description |
|--------|--------|-------------|
| `,f` | Find files | Telescope file finder |
| `,o` | Recent files | Recently opened files |
| `,b` | Switch buffers | Switch between open files |
| `jj` | Escape | Alternative to Escape key |
| `<C-S>` | Save | Quick save |
| `,gs` | Git status | Open Git status |

### 4. VSCode-Specific Workflow
- **File navigation**: Use VSCode's file explorer instead of NerdTree
- **Undo history**: Use VSCode's timeline instead of Mundo
- **Status information**: Use VSCode's status bar
- **Theming**: Use VSCode's theme system

## 🎨 VSCode Theme Recommendations

Since Gruvbox is disabled in VSCode, consider these alternatives:

### Gruvbox-like Themes
- **Gruvbox Material** - VSCode extension
- **One Dark Pro** - Similar dark theme
- **Monokai Pro** - High contrast theme

### Installation
1. Open VSCode
2. Go to Extensions (Ctrl+Shift+X)
3. Search for theme name
4. Install and activate

## 🔄 Switching Between Modes

### From VSCode to Standalone Neovim
- **File explorer**: Use NerdTree (`<F6>`)
- **Status bar**: Use Lualine
- **Theme**: Use Gruvbox
- **Undo history**: Use Mundo (`<F5>`)

### From Standalone Neovim to VSCode
- **File explorer**: Use VSCode's file explorer
- **Status bar**: Use VSCode's status bar
- **Theme**: Use VSCode's theme system
- **Undo history**: Use VSCode's timeline

## 🐛 Troubleshooting VSCode Issues

### Common Issues

#### Keymaps Not Working
- **Check extension**: Ensure Neovim extension is installed and enabled
- **Check configuration**: Verify the extension is pointing to the correct config
- **Reload window**: Try reloading VSCode window (Ctrl+Shift+P → "Developer: Reload Window")

#### Performance Issues
- **Check plugin loading**: Look for VSCode compatibility notifications
- **Disable conflicting extensions**: Some VSCode extensions may conflict
- **Check Neovim version**: Ensure you're using a recent version

#### UI Conflicts
- **Status bar**: Use VSCode's status bar instead of Lualine
- **File explorer**: Use VSCode's file explorer instead of NerdTree
- **Theme**: Use VSCode's theme system instead of Gruvbox

### Debug Commands
```vim
" Check if running in VSCode
:echo v:g.vscode

" Check loaded plugins
:checkhealth

" View error messages
:messages

" Reload configuration
:source %
```

## 📚 VSCode Extension Integration

### Recommended VSCode Extensions
- **Neovim** - Official Neovim extension
- **GitLens** - Enhanced Git capabilities
- **Bracket Pair Colorizer** - Better bracket matching
- **Indent Rainbow** - Visual indentation guides

### Extension Settings
```json
{
  "vscode-neovim.neovimExecutablePaths.linux": "/usr/bin/nvim",
  "vscode-neovim.neovimInitVimPaths.linux": "/home/username/.config/nvim/init.lua",
  "vscode-neovim.useCtrlKeysForInsertMode": true,
  "vscode-neovim.useCtrlKeysForNormalMode": true
}
```

## 🎯 Best Practices for VSCode Users

### 1. Use VSCode's Native Features
- **File explorer**: Use VSCode's file explorer instead of NerdTree
- **Status bar**: Use VSCode's status bar instead of Lualine
- **Timeline**: Use VSCode's timeline instead of Mundo
- **Themes**: Use VSCode's theme system

### 2. Learn the Essential Keymaps
Focus on keymaps that work in both modes:
- File operations: `,f`, `,o`, `,b`
- Navigation: `<C-h/j/k/l>`
- Editing: `jj`, `<C-S>`
- Git: `,gs`

### 3. Customize for VSCode
- **Disable conflicting extensions** that may interfere
- **Use VSCode's command palette** for advanced operations
- **Leverage VSCode's debugging** and IntelliSense features

### 4. Performance Optimization
- **Keep the config minimal** in VSCode mode
- **Use VSCode's built-in features** when possible
- **Monitor plugin loading** for performance issues

## 📚 Related Documentation

- [Configuration System](configuration-system.md) - How VSCode detection works
- [Plugin System](plugin-system.md) - Plugin filtering in VSCode
- [Essential Plugins](plugins/essential.md) - Plugins that work in VSCode
- [Keymaps Reference](keymaps.md) - All available shortcuts
