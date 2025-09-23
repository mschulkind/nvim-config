# Neovim Configuration - Beginner's Guide

## Installation

See the full install guide for Ubuntu/macOS (Neovim 0.12+, PPA, Homebrew, cloning, and Copilot auth):
[Installation Guide](docs/install.md)

### Quick Install
```bash
# Clone this repository to your Neovim config directory
# (See docs/install.md for OS-specific prerequisites)
git clone <your-repo-url> ~/.config/nvim

# Start Neovim - plugins will auto-install on first launch
nvim
```

### Prerequisites
- **Neovim 0.12+** (check with `nvim --version`)
- **Git** (for plugin management)
- **ripgrep** (for file searching - install with your package manager)

### What Gets Installed
- **Gruvbox** color scheme
- **GitHub Copilot** (AI code completion)
- **Telescope** (fuzzy file finder)
- **Tree-sitter** (smart syntax highlighting)
- **Fugitive** (Git integration)
- **Leap + Flit** (enhanced navigation)
- **Lualine** (status line)
- And many more productivity plugins!

> **First Launch**: Plugins will automatically install when you first open Neovim. This may take a few minutes. When installation finishes and the Lazy UI is visible, press `q` to close it.
> Note: On first setup run Neovim outside of VSCode so the plugin manager can complete installation and any native build steps. Open a terminal and run:
>
> ```bash
> nvim
> ```
>
> Wait for the Lazy.nvim installer UI to finish; when installation completes and the Lazy UI appears, press `q` to close it. Starting inside the VSCode Neovim extension before plugins are installed can cause some plugins or build steps to fail.

---

**Cross-Mode Compatible**: This configuration works seamlessly in both standalone Neovim and VSCode. All features below work in both modes unless marked otherwise.

> **Version Requirement**: This configuration requires **Neovim 0.12+** to use all features. Check your version with `nvim --version` and update if needed.

## VSCode Integration

This config works seamlessly in VSCode using the [VSCode Neovim extension](https://marketplace.visualstudio.com/items?itemName=asvetliakov.vscode-neovim). The configuration automatically detects VSCode mode and adapts accordingly:

### What Works in VSCode
- ** Full Plugin Support**: LSP, Treesitter, Telescope, Copilot, and navigation plugins work perfectly
- ** Smart Config Split**: VSCode-specific features are disabled to avoid conflicts
- ** Native Integration**: Leverages VSCode's built-in features while keeping Neovim's power

### VSCode-Disabled Features
These features are disabled in VSCode to prevent conflicts (use VSCode's native features instead):

| Feature | VSCode Alternative | Reason |
|---------|-------------------|---------|
| **🗂 nvim-tree** (`<F6>`, `g?` help) | File explorer | Use VSCode's file explorer |
| ** Lualine** | Status line | Use VSCode's status bar |
| ** Gruvbox** | Color scheme | Use VSCode's theme system |
| ** telescope-undo** (`<F5>`) | Undo history | Use VSCode's timeline |


### VSCode Setup Required
- **`jj` escape keybinding**: Requires VSCode configuration (see detailed guide below)

> **Detailed VSCode Guide**: See [VSCode Integration Guide](docs/vscode-integration.md) for setup, keybindings, and advanced configuration.

> **Want more details?** Check out our [Complete Documentation](docs/README.md) for in-depth guides and advanced features!

## Essential Features (Learn These First!)

### Core Navigation 
| Keymap | Action | Description |
|--------|--------|-------------|
| `,f` | Find files | **Most used** - Fuzzy finder for files |
| `,o` | Find old files | Recently opened files |
| `,b` | Find buffers | Switch between open files |
| `<C-h/j/k/l>` | Navigate splits | Move between windows |
| `<C-w>s` | Split horizontal | Split window horizontally |
| `<C-w>v` | Split vertical | Split window vertically |
| `jj` | Escape | Alternative to Escape key |

> **Pro tip**: See [Complete Keymap Reference](docs/keymaps.md) for all available shortcuts!

### Essential Editing 
| Keymap | Action | Description |
|--------|--------|-------------|
| `<C-S>` | Save | Quick save (Ctrl+S) |
| `gcc` | Comment line | Toggle comment on current line (works great with `V` for visual line mode) |
| `gcu` | Uncomment line | Uncomment current line (works great with `V` for visual line mode) |
| `,k` | Delete buffer | Close file without closing window |

### Git Integration 
| Keymap | Action | Description |
|--------|--------|-------------|
| `,gs` | Git status | Open Git status window |

> **Learn more**: [Git integration guide](docs/plugins/essential.md#fugitive---git-integration)

### Configuration 
| Keymap | Action | Description |
|--------|--------|-------------|
| `,v` | Open config | Open Neovim config file |
| `,V` | Reload config | Reload configuration |
| `,L` | Lazy interface | Open [Lazy plugin manager](#lazy-nvim) (Lazy.nvim only) |

#### Plugin Customization
Each plugin file in `lua/plugins/` contains commented configuration options showing the most common settings you might want to customize. Browse the plugin files to discover available options:

- **`flit.lua`** - Enhanced f/t motions (case sensitivity, performance, highlighting)
- **`leap.lua`** - Lightning-fast navigation (search options, highlighting, key bindings)
- **`telescope.lua`** - Fuzzy finder (sorting, UI customization, file patterns)
- **`treesitter.lua`** - Syntax highlighting (auto-install, parsers, text objects)
- **`completion.lua`** - AI completion (keys, panels, filetype restrictions)
- **`filetree.lua`** - File explorer (width, grouping, git integration)
- **`gruvbox.lua`** - Color scheme (terminal colors, text styling)
- **`lualine.lua`** - Status line (themes, sections, separators)
- **`formatting.lua`** - Code formatting (timeouts, formatters, LSP preferences)
- **`simple_plugins.lua`** - Utility plugins (git signs, indentation, notifications)

Simply uncomment and modify the options you want to change!

## Top Plugins (Auto-installed)

### Telescope ([GitHub](https://github.com/nvim-telescope/telescope.nvim))
| Keymap | Action | Description |
|--------|--------|-------------|
| `,f` | Find files | Fuzzy finder for files |
| `,o` | Find old files | Recently opened files |
| `,b` | Find buffers | Switch between open files |

**Why it's great**: Fast, fuzzy search with preview

> **Deep dive**: [Telescope documentation](docs/plugins/essential.md#telescope---file-finding--searching)

### Copilot ([GitHub](https://github.com/zbirenbaum/copilot.lua))
| Keymap | Action | Description |
|--------|--------|-------------|
| `<Tab>` | Accept suggestion | Accept AI code completion |

**Why it's great**: Context-aware code suggestions

### Treesitter ([GitHub](https://github.com/nvim-treesitter/nvim-treesitter))
- **Purpose**: Smart syntax highlighting
- **Why it's great**: Better code understanding and navigation

### Fugitive ([GitHub](https://github.com/tpope/vim-fugitive))
| Keymap | Action | Description |
|--------|--------|-------------|
| `,gs` | Git status | Open Git status window |

**Why it's great**: Full Git workflow in Neovim

### 🗂 nvim-tree ([GitHub](https://github.com/nvim-tree/nvim-tree.lua))
| Keymap | Action | Description |
|--------|--------|-------------|
| `<F6>` | 🗂 Toggle filetree | Open/close file explorer with current file selected |
| `g?` | Help | Show nvim-tree keymap help |

**Why it's great**: Modern file explorer with git integration and visual hierarchy.

> ℹ Note: This feature is disabled in VSCode to avoid overlap with the built-in file explorer.

### Telescope Undo ([GitHub](https://github.com/debugloop/telescope-undo.nvim))
| Keymap | Action | Description |
|--------|--------|-------------|
| `<F5>` | Undo history | Open telescope undo history |

**Why it's great**: Searchable undo history with telescope's powerful fuzzy finding.

> ℹ Note: This feature is disabled in VSCode to avoid overlap with the built-in Timeline.

### Enhanced Navigation (Flit + Leap) ([Flit GitHub](https://github.com/ggandor/flit.nvim) | [Leap GitHub](https://github.com/ggandor/leap.nvim))
| Keymap | Action | Description |
|--------|--------|-------------|
| `f<char>` | Jump forward | Jump to next occurrence of character |
| `F<char>` | Jump backward | Jump to previous occurrence of character |
| `t<char>` | Jump before | Jump just before next occurrence |
| `T<char>` | Jump before | Jump just before previous occurrence |
| `s<char><char>` | Leap 2-char | Jump anywhere with 2 characters |
| `S<char><char>` | Leap line | Jump in current line with 2 characters |
| `gs<char><char>` | Leap window | Jump anywhere in window with 2 characters |
| `;` | Repeat | Repeat last motion |
| `,` | Reverse | Repeat motion in opposite direction |

**Why it's great**: Labeled targets and 2-character jumping

> **Master Both**: [Complete Flit + Leap Guide](docs/plugins/navigation.md) | [All Keybinds Reference](docs/keymaps.md#enhanced-navigation)

### Lazy.nvim ([GitHub](https://github.com/folke/lazy.nvim))
| Keymap | Action | Description |
|--------|--------|-------------|
| `,L` | Lazy interface | Open plugin manager interface |

**Why it's great**: Modern plugin manager with lazy loading, dependency management, and beautiful UI

> **Plugin Management**: Lazy.nvim automatically manages plugin installation, updates, and dependencies. Use `,L` to access the interface for managing your plugins.

## Troubleshooting

- Use `,V` to reload configuration after changes
- Check `:messages` for error information
- Use `:checkhealth` to verify plugin status

> **Need help?** Check our [Troubleshooting Guide](docs/troubleshooting.md) for common issues and solutions!

## Learning Resources

- [ Neovim Documentation](https://neovim.io/doc/)
- [ Vim Adventures](https://vim-adventures.com/) - Learn Vim keybindings through a game
- [ Complete Documentation](docs/README.md) - In-depth guides for this configuration
- [ Customization Guide](docs/customization.md) - Make it your own!

---

**Happy editing!** ✨