# Utility Plugins

This document covers the utility plugins that provide essential functionality for enhanced editing experience.

## Text Objects

### Targets.vim 
**Repository**: `wellle/targets.vim` 
**VSCode Compatible**: 
**Purpose**: Enhanced text objects for more precise text selection

#### Features
- **Extended text objects** - More granular text selection
- **Consistent behavior** - Works across all text objects
- **Smart quotes** - Handles different quote styles intelligently
- **Bracket pairs** - Works with various bracket types

#### Usage
- `da"` - Delete around double quotes
- `ci'` - Change inside single quotes
- `ya(` - Yank around parentheses
- `va[` - Visual select around square brackets

## 📏 Dynamic Scrolling

### vim-scrolloff-fraction 
**Repository**: `drzel/vim-scrolloff-fraction` 
**VSCode Compatible**: 
**Purpose**: Dynamic scrolloff based on window height

#### Features
- **Adaptive scrolling** - Adjusts based on window size
- **Fractional control** - Uses percentage of window height
- **Smooth experience** - Better navigation in different window sizes

#### Configuration
```lua
vim.g.scrolloff_fraction = 0.20 -- 20% of window height
```

## Window Management

### SwayConfig 
**Repository**: `jamespeapen/swayconfig.vim` 
**VSCode Compatible**: Disabled in VSCode 
**Purpose**: Sway window manager integration

#### Features
- **Window management** - Sway-specific window operations
- **Workspace switching** - Integration with Sway workspaces
- **Floating windows** - Control floating window behavior

#### VSCode Alternative
- **Use VSCode's built-in window management** instead
- **Workspace switching** is handled by VSCode's workspace system

## Commenting

### NERD Commenter 
**Repository**: `scrooloose/nerdcommenter` 
**VSCode Compatible**: 
**Purpose**: Powerful commenting system

#### Features
- **Smart commenting** - Automatically detects file type
- **Nested commenting** - Handles nested comment styles
- **Visual mode support** - Comment selected text
- **Toggle functionality** - Toggle comments on/off

#### Keymaps
| Keymap | Action | Description |
|--------|--------|-------------|
| `gcc` | Comment line | Toggle comment on current line |
| `gc` | Comment selection | Comment selected text in visual mode |

## Buffer Management

### mini.bufremove 
**Repository**: `nvim-mini/mini.bufremove` 
**VSCode Compatible**: 
**Purpose**: Safe buffer removal without closing windows

#### Features
- **Safe deletion** - Prevents accidental window closure
- **Window preservation** - Keeps window layout intact
- **Smart fallback** - Handles edge cases gracefully

#### Keymaps
| Keymap | Action | Description |
|--------|--------|-------------|
| `<leader>k` | Delete buffer | Remove current buffer safely |

## LSP Progress

### Fidget 
**Repository**: `j-hui/fidget.nvim` 
**VSCode Compatible**: 
**Purpose**: LSP progress indicator

#### Features
- **Progress tracking** - Shows LSP operation progress
- **Notification display** - Displays LSP notifications
- **Minimal UI** - Clean, unobtrusive interface
- **Customizable** - Configurable appearance and behavior

#### Configuration
```lua
require("fidget").setup({
-- notification = { window = { winblend = 0 } }, -- Custom notification window
-- progress = { suppress_on_insert = false }, -- Suppress progress on insert mode
})
```

## 🧹 Whitespace Handling

### vim-better-whitespace 
**Repository**: `ntpeters/vim-better-whitespace` 
**VSCode Compatible**: 
**Purpose**: Highlight and manage whitespace issues

#### Features
- **Whitespace highlighting** - Shows trailing whitespace
- **Auto-strip** - Automatically remove trailing whitespace
- **Configurable** - Customizable highlighting and behavior
- **File type aware** - Different behavior for different file types

#### Configuration
```lua
vim.g.better_whitespace_enabled = 1
vim.g.better_whitespace_skip_empty_lines = 0
```

## Git Integration

### Gitsigns 
**Repository**: `lewis6991/gitsigns.nvim` 
**VSCode Compatible**: 
**Purpose**: Git signs in the gutter

#### Features
- **Git status** - Shows added, modified, deleted lines
- **Blame information** - Inline blame annotations
- **Hunk operations** - Stage/unstage hunks
- **Performance** - Fast and efficient

#### Configuration
```lua
require("gitsigns").setup({
-- signs = { add = { text = "+" }, change = { text = "~" }, delete = { text = "_" } },
-- numhl = false, -- Enable line number highlighting
})
```

## Undo History

### telescope-undo 
**Repository**: `debugloop/telescope-undo.nvim` 
**VSCode Compatible**: Disabled in VSCode 
**Purpose**: Searchable undo history

#### Features
- **Telescope integration** - Searchable undo history
- **Visual preview** - See changes before undoing
- **Efficient navigation** - Jump to any undo state
- **Git integration** - Works with git history

#### Keymaps
| Keymap | Action | Description |
|--------|--------|-------------|
| `<F5>` | Telescope undo | Open undo history browser |

#### VSCode Alternative
- **Use VSCode's timeline view** instead
- **Git history** is available in the Source Control panel

## 📏 Indentation Guides

### indent-blankline 
**Repository**: `lukas-reineke/indent-blankline.nvim` 
**VSCode Compatible**: 
**Purpose**: Visual indentation indicators

#### Features
- **Indent markers** - Shows indentation levels
- **Scope indicators** - Highlights code blocks
- **Treesitter integration** - Uses syntax information
- **Customizable** - Configurable appearance

#### Configuration
```lua
require("ibl").setup({
-- indent = { char = "│" }, -- Custom indent character
-- scope = { enabled = false }, -- Enable scope indicators
})
```

## Gemini CLI

### gemini-cli.nvim
**Repository**: `marcinjahn/gemini-cli.nvim`
**VSCode Compatible**: ❌ (Disabled in VSCode)
**Purpose**: Integrates Gemini AI into Neovim for prompt-driven queries and assistance

#### Features
- **Prompt-driven queries** — open an input prompt and send queries to Gemini
- **History & sessions** — browse and reuse prior queries
- **Buffer write helpers** — ask Gemini to produce or modify text
- **Lightweight UI integration** — optional popups/UIs

#### Keymaps
| Keymap | Action | Description |
|--------|--------|-------------|
| `<leader>at` | Toggle | Open/close Gemini UI |
| `<leader>aa` | Ask | Send a query or open prompt (normal/visual mode) |
| `<leader>af` | Add file | Add file to context |

#### Configuration
```lua
-- Plugin declared in plugins list; minimal setup recommended
require("gemini").setup({})
```

#### VSCode Alternative
- Use VSCode's AI extensions (GitHub Copilot Chat, Codeium, etc.)

## Utility Plugin Categories

### VSCode-Compatible Utilities
- **Targets.vim** - Text objects
- **vim-scrolloff-fraction** - Dynamic scrolling
- **NERD Commenter** - Commenting
- **mini.bufremove** - Buffer management
- **Fidget** - LSP progress
- **vim-better-whitespace** - Whitespace handling
- **Gitsigns** - Git integration
- **indent-blankline** - Indentation guides

### VSCode-Disabled Utilities
- **SwayConfig** - Window manager integration
- **telescope-undo** - Undo history

## Related Documentation

- [Essential Plugins](essential.md) - Core functionality plugins
- [Navigation Plugins](navigation.md) - Motion and navigation plugins
- [UI Plugins](ui.md) - Interface and appearance plugins
