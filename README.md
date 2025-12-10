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
- **Blink.cmp** (fast completion engine)
- **Telescope & FZF-lua** (fuzzy file finders)
- **Tree-sitter** (smart syntax highlighting)
- **Fugitive** (Git integration)
- **Gitsigns** (git blame & change indicators)
- **Leap + Flit** (enhanced navigation)
- **Lualine** (status line)
- **Mason** (LSP server manager)
- **ToggleTerm** (terminal management)
- **Conform & nvim-lint** (formatting & linting)
- **nvim-tree** (file explorer)
- **NerdCommenter** (code commenting)
- **indent-blankline** (indentation guides)
- **Gemini CLI** (AI assistant integration)
- And more productivity plugins!

> **First Launch**: Plugins will automatically install when you first open Neovim. This may take a few minutes.
> Note: On first setup run Neovim outside of VSCode so the plugin manager can complete installation and any native build steps. Open a terminal and run:
>
> ```bash
> nvim
> ```
>
> Wait for the plugin installer to finish. Starting inside the VSCode Neovim extension before plugins are installed can cause some plugins or build steps to fail.

---

**Cross-Mode Compatible**: This configuration works seamlessly in both standalone Neovim and VSCode. All features below work in both modes unless marked otherwise.

> **Version Requirement**: This configuration requires **Neovim 0.12+** to use all features. Check your version with `nvim --version` and update if needed.

## VSCode Integration

This config works seamlessly in VSCode using the [VSCode Neovim extension](https://marketplace.visualstudio.com/items?itemName=asvetliakov.vscode-neovim). The configuration automatically detects VSCode mode and adapts accordingly:

### What Works in VSCode
- **Full Plugin Support**: LSP, Treesitter, Telescope, Copilot, and navigation plugins work perfectly
- **Smart Config Split**: VSCode-specific features are disabled to avoid conflicts
- **Native Integration**: Leverages VSCode's built-in features while keeping Neovim's power

### VSCode-Disabled Features
These features are disabled in VSCode to prevent conflicts (use VSCode's native features instead):

| Feature | VSCode Alternative | Reason |
|---------|-------------------|---------|
| **nvim-tree** (`<F6>`, `g?` help) | File explorer | Use VSCode's file explorer |
| **Lualine** | Status line | Use VSCode's status bar |
| **Gruvbox** | Color scheme | Use VSCode's theme system |
| **telescope-undo** (`<F5>`) | Undo history | Use VSCode's timeline |
| **ToggleTerm** (`<leader>t`) | Terminal | Use VSCode's integrated terminal |
| **Gemini CLI** (`<leader>a*`) | AI assistant | Use VSCode's AI extensions |


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
| `,b` | Find buffers | Switch between open buffers (MRU sorted) |
| **`,m`** | **Modified files** | **⭐ Show files changed vs origin/master + working dir (with diff preview!)** |
| `<C-h/j/k/l>` | Navigate splits | Move between windows |
| `<C-w>s` | Split horizontal | Split window horizontally |
| `<C-w>v` | Split vertical | Split window vertically |
| `jj` | Escape | Alternative to Escape key |

> **💡 Pro Tip**: The `,m` keymap is incredibly useful for code review! It shows all files you've changed compared to `origin/master`, including uncommitted changes and untracked files. Each file shows a git diff preview so you can quickly see what changed.

> **Pro tip**: See [Complete Keymap Reference](docs/keymaps.md) for all available shortcuts!

### Essential Editing 
| Keymap | Action | Description |
|--------|--------|-------------|
| `<C-S>` | Save | Quick save (Ctrl+S) |
| `gcc` | Comment line | Toggle comment on current line (works great with `V` for visual line mode) |
| `gcu` | Uncomment line | Uncomment current line (works great with `V` for visual line mode) |
| `,k` | Delete buffer | Close file without closing window |
| `,l` | Lint file | Trigger linting for current file |

### LSP (Language Server Protocol)

Language servers provide intelligent code completion, diagnostics, and refactoring. They're automatically installed for TypeScript, Python, JSON, HTML, and CSS.

| Keymap | Action | Description |
|--------|--------|-------------|
| `K` | Hover | Show documentation for symbol under cursor |
| `gd` | Go to definition | Jump to symbol definition (opens in split) |
| `gr` | Find references | Show all references to symbol |
| `gi` | Go to implementation | Jump to implementation |
| `,rn` | Rename | Rename symbol throughout file |
| `,ca` | Code actions | Show available fixes and refactorings |
| `,l` | Lint | Trigger linting to find errors |

#### How It Works
1. **Auto-installation**: Mason automatically installs LSP servers on first launch
2. **Auto-attach**: Servers connect automatically when you open supported files
3. **Live diagnostics**: Errors and warnings appear as you type
4. **Smart completion**: `<Tab>` shows context-aware suggestions

#### Supported Languages (Auto-installed)
- **TypeScript/JavaScript** - ts_ls (rename, refactoring, quick fixes)
- **Python** - pyright (type checking, completions, linting with ruff)
- **JSON** - jsonls (schema validation, formatting)
- **HTML** - html (attribute completion, validation)
- **CSS** - cssls (color picking, property completion)

#### Tips
- Press `K` to see hover documentation (or use `:hover`)
- Use `gr` to find where a function is used
- Use `,rn` to safely rename variables/functions across your code
- Run `,l` to check for issues manually (or it runs automatically on save)

> **Learn more**: [LSP Configuration Guide](docs/configuration-system.md#language-server-protocol) | [Troubleshooting LSP](docs/troubleshooting.md#lsp-issues)

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
| `,t` | Toggle terminal | Open/close integrated terminal (standalone only) |

#### Plugin Customization
Each plugin file in `lua/plugins/` contains commented configuration options showing the most common settings you might want to customize. Browse the plugin files to discover available options:

- **`flit.lua`** - Enhanced f/t motions (case sensitivity, performance, highlighting)
- **`leap.lua`** - Lightning-fast navigation (search options, highlighting, key bindings)
- **`telescope.lua`** - Fuzzy finder (sorting, UI customization, file patterns)
- **`fzf.lua`** - FZF-lua integration (MRU buffer sorting, layout)
- **`treesitter.lua`** - Syntax highlighting (auto-install, parsers, text objects)
- **`completion.lua`** - AI completion with Copilot and Blink.cmp
- **`filetree.lua`** - File explorer (width, grouping, git integration)
- **`gruvbox.lua`** - Color scheme (terminal colors, text styling)
- **`lualine.lua`** - Status line (themes, sections, separators)
- **`formatting.lua`** - Code formatting with Conform (timeouts, formatters)
- **`mason.lua`** - LSP server management (auto-install servers)
- **`toggleterm.lua`** - Terminal management (size, position, keybindings)
- **`simple_plugins.lua`** - Utility plugins (git signs, indentation, AI chat)

Simply uncomment and modify the options you want to change!

## Top Plugins (Auto-installed)

### Telescope ([GitHub](https://github.com/nvim-telescope/telescope.nvim))
| Keymap | Action | Description |
|--------|--------|-------------|
| `,f` | Find files | Fuzzy finder for files |
| `,o` | Find old files | Recently opened files |
| `,m` | Modified files | Files changed vs origin/master + working directory |

**Why it's great**: Fast, fuzzy search with preview and git integration

> **Deep dive**: [Telescope documentation](docs/plugins/essential.md#telescope---file-finding--searching)

### FZF-lua ([GitHub](https://github.com/ibhagwan/fzf-lua))
| Keymap | Action | Description |
|--------|--------|-------------|
| `,b` | Find buffers | Switch between open buffers (MRU sorted) |

**Why it's great**: Native fzf performance with intelligent MRU buffer sorting

> **Note**: Complements Telescope for buffer management with superior MRU handling

### Copilot & Blink.cmp ([Copilot GitHub](https://github.com/zbirenbaum/copilot.lua) | [Blink GitHub](https://github.com/saghen/blink.cmp))
| Keymap | Action | Description |
|--------|--------|-------------|
| `<Tab>` | Accept suggestion | Accept AI code completion |

**Why it's great**: Context-aware AI suggestions with modern completion engine

> **Note**: Blink.cmp provides LSP, path, snippet, and buffer completions alongside Copilot

### Treesitter ([GitHub](https://github.com/nvim-treesitter/nvim-treesitter))
- **Purpose**: Smart syntax highlighting
- **Why it's great**: Better code understanding and navigation

### Fugitive ([GitHub](https://github.com/tpope/vim-fugitive))
| Keymap | Action | Description |
|--------|--------|-------------|
| `,gs` | Git status | Open Git status window |

**Why it's great**: Full Git workflow in Neovim

### nvim-tree ([GitHub](https://github.com/nvim-tree/nvim-tree.lua))
| Keymap | Action | Description |
|--------|--------|-------------|
| `<F6>` | Toggle filetree | Open/close file explorer with current file selected |
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
| `S<char><char>` | Leap backward | Jump backward with 2 characters |
| `gs<char><char>` | Leap window | Jump anywhere in window with 2 characters |
| `;` | Repeat | Repeat last motion |
| `,` | Reverse | Repeat motion in opposite direction |

**Why it's great**: Labeled targets and 2-character jumping

> **Master Both**: [Complete Flit + Leap Guide](docs/plugins/navigation.md) | [All Keybinds Reference](docs/keymaps.md#enhanced-navigation)

### ToggleTerm ([GitHub](https://github.com/akinsho/toggleterm.nvim))
| Keymap | Action | Description |
|--------|--------|-------------|
| `<leader>t` | Toggle terminal | Open/close integrated terminal |
| `jj` (in terminal) | Close terminal | Close terminal from insert or normal mode |
| `kk` (in terminal) | Normal mode | Exit to normal mode (stay in terminal) |

**Why it's great**: Seamless terminal integration with smart keybindings

> ℹ Note: This feature is disabled in VSCode to avoid overlap with the built-in terminal.

### Mason ([GitHub](https://github.com/williamboman/mason.nvim))
**Purpose**: Automatic LSP server installation and management

**Why it's great**: Automatically installs language servers (TypeScript, Python, JSON, HTML, CSS)

> **Auto-installed servers**: ts_ls, pyright, jsonls, html, cssls

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