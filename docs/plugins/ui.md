# UI Plugins

This document covers the user interface plugins in this Neovim configuration.

## 🎨 Status Line

### Lualine ✗
**Repository**: `nvim-lualine/lualine.nvim`  
**VSCode Compatible**: ✗ Disabled in VSCode  
**Purpose**: Status line with theme and information

#### Features
- **Material theme** - Modern, clean appearance
- **Git integration** - Shows branch, diff, and diagnostics
- **File information** - Shows filename, encoding, filetype
- **Progress indicator** - Shows cursor position
- **Customizable sections** - Configurable information display

#### Configuration
```lua
require('lualine').setup({
  options = {
    theme = 'material',
  },
})
```

#### VSCode Alternative
- **Use VSCode's status bar** instead
- **Git information** is shown in VSCode's source control panel
- **File information** is shown in VSCode's status bar

## 🌈 Color Schemes

### Gruvbox ✗
**Repository**: `ellisonleao/gruvbox.nvim`  
**VSCode Compatible**: ✗ Disabled in VSCode  
**Purpose**: Dark color scheme with high contrast

#### Features
- **Dark theme** - Easy on the eyes
- **High contrast** - Good readability
- **Warm colors** - Brown and orange tones
- **Multiple variants** - Light and dark modes
- **Terminal support** - Works in terminal emulators

#### Configuration
```lua
require("gruvbox").setup({
  terminal_colors = true,
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true,
  contrast = "hard",
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
})
vim.cmd("colorscheme gruvbox")
```

#### VSCode Alternative
- **Use VSCode's theme system** instead
- **Install Gruvbox theme** from VSCode marketplace
- **Recommended themes**:
  - Gruvbox Material
  - One Dark Pro
  - Monokai Pro

## 📁 File Explorer

### nvim-tree ✗
**Repository**: `nvim-tree/nvim-tree.lua`  
**VSCode Compatible**: ✗ Disabled in VSCode  
**Purpose**: Modern file explorer and project navigation

#### Features
- **File tree** - Hierarchical file view with git integration
- **Current file highlighting** - Shows active file
- **Hidden files** - Shows dotfiles and hidden files
- **Git integration** - Shows git status and changes
- **Indent markers** - Visual hierarchy indicators
- **Modern UI** - Clean, fast interface

#### Keymaps
| Keymap | Action | Description |
|--------|--------|-------------|
| `<F6>` | Toggle nvim-tree | Open/close file explorer with current file selected |
| `g?` | nvim-tree help | Show nvim-tree keymap help |

#### Configuration
```lua
require("nvim-tree").setup({
  view = {
    width = 30,  -- Set tree width to 30 columns
  },
  renderer = {
    indent_markers = {
      enable = true,  -- Show indent markers for better visual hierarchy
    },
  },
  filters = {
    dotfiles = false,  -- Show hidden files (dotfiles)
  },
})
```

#### VSCode Alternative
- **Use VSCode's file explorer** instead
- **Keymap**: Ctrl+Shift+E to open file explorer
- **Features**: Integrated with VSCode's workspace

## 🔄 Undo History

### telescope-undo ✗
**Repository**: `debugloop/telescope-undo.nvim`  
**VSCode Compatible**: ✗ Disabled in VSCode  
**Purpose**: Searchable undo history with telescope integration

#### Features
- **Telescope integration** - Searchable undo history
- **Fuzzy search** - Find specific undo states quickly
- **Visual preview** - See changes before undoing
- **Efficient navigation** - Jump to any undo state
- **Git integration** - Works with git history

#### Keymaps
| Keymap | Action | Description |
|--------|--------|-------------|
| `<F5>` | Telescope undo | Open telescope undo history |

#### Configuration
```lua
require("telescope").load_extension("undo")
```

#### VSCode Alternative
- **Use VSCode's timeline** instead
- **Keymap**: Ctrl+Shift+P → "Timeline"
- **Features**: Integrated with VSCode's history system

## → Indentation Guides

### Indent Blankline ✓
**Repository**: `lukas-reineke/indent-blankline.nvim`  
**VSCode Compatible**: ✓ Works in both modes  
**Purpose**: Visual indentation indicators

#### Features
- **Indentation lines** - Shows indentation levels
- **Configurable appearance** - Customize line style and color
- **Performance optimized** - Efficient rendering
- **Language support** - Works with many file types

#### Configuration
```lua
require("ibl").setup({
  indent = {
    char = "│",
    tab_char = "│",
  },
  scope = {
    enabled = true,
    char = "│",
    show_start = true,
    show_end = true,
  },
})
```

## → Enhanced Motions

### Flit.nvim ✓
**Repository**: `ggandor/flit.nvim`  
**VSCode Compatible**: ✓ Works in both modes  
**Purpose**: Enhanced f, F, t, T motions with labeled targets

#### Features
- **Labeled targets** - Visual indicators for navigation
- **Clever repeat** - Smart repetition of motions
- **Multiline support** - Cross-line navigation
- **Leap integration** - Advanced motion capabilities

#### Keymaps
| Keymap | Action | Description |
|--------|--------|-------------|
| `f` | Find forward | Enhanced f motion with labeled targets |
| `F` | Find backward | Enhanced F motion with labeled targets |
| `t` | Till forward | Enhanced t motion with labeled targets |
| `T` | Till backward | Enhanced T motion with labeled targets |

#### Configuration
```lua
require("flit").setup({
  keys = { f = 'f', F = 'F', t = 't', T = 'T' },
  labeled_modes = "nv",  -- Enable labeled targets in normal and visual modes
  clever_repeat = true,
  multiline = true,
  opts = {}
})
```

#### Getting Started with Flit
1. **Basic motions**: Press `f` + character to jump forward, `F` + character to jump backward
   - **Visual guide appears** with labeled targets (e.g., `a`, `s`, `d`, `f`)
   - **Press the label** to jump to that specific occurrence
2. **Till motions**: Press `t` + character to jump just before forward, `T` + character for backward
3. **Visual mode**: Press `V` then `f`/`F` to extend selection to a character
4. **Repeat**: Use `;` to repeat last motion, `,` to repeat in opposite direction
5. **Multiline**: Works across line boundaries for better navigation

## 🔧 Window Management

### SwayConfig ✗
**Repository**: `jamespeapen/swayconfig.vim`  
**VSCode Compatible**: ✗ Disabled in VSCode  
**Purpose**: Sway window manager integration

#### Features
- **Sway integration** - Works with Sway window manager
- **Window management** - Sway-specific functionality
- **Not relevant in VSCode** - Desktop environment specific

#### VSCode Alternative
- **Not applicable** - VSCode handles window management
- **Use VSCode's window features** instead

## 📊 File Type Icons

### Web Devicons ✓
**Repository**: `nvim-tree/nvim-web-devicons`  
**VSCode Compatible**: ✓ Works in both modes  
**Purpose**: File type icons for better visual identification

#### Features
- **File type icons** - Icons for different file types
- **Color coding** - Different colors for different types
- **Wide support** - Icons for many file types
- **Integration** - Works with other plugins

#### Configuration
```lua
require("nvim-web-devicons").setup({
  override = {},
  default = true,
})
```

## → UI Plugin Categories

### VSCode-Compatible UI Plugins ✓
- **Indent Blankline** - Indentation guides
- **Flip.nvim** - Smooth scrolling
- **Web Devicons** - File type icons

### VSCode-Disabled UI Plugins ✗
- **Lualine** - Status line
- **Gruvbox** - Color scheme
- **nvim-tree** - File explorer
- **telescope-undo** - Undo history
- **SwayConfig** - Window manager integration

## 🎨 Customizing UI Plugins

### Adding Custom Themes
```lua
-- Create lua/plugins/my_theme.lua
return {
  repo = "user/my-theme",
  vscode = false,
  setup = function()
    vim.cmd("colorscheme my-theme")
  end
}
```

### Customizing Status Line
```lua
-- Modify lua/plugins/lualine.lua
require("lualine").setup({
  options = {
    theme = "my-theme",
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff" },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})
```

### Customizing Indentation
```lua
-- Modify lua/plugins/indent_blankline.lua
require("ibl").setup({
  indent = {
    char = "▏",
    tab_char = "▏",
  },
  scope = {
    enabled = true,
    char = "▏",
    show_start = true,
    show_end = true,
  },
})
```

## 📚 Related Documentation

- [Essential Plugins](essential.md) - Core functionality plugins
- [VSCode Integration](../vscode-integration.md) - VSCode-specific considerations
- [Customization Guide](../customization.md) - How to modify UI plugins
- [Troubleshooting](../troubleshooting.md) - Common UI issues
