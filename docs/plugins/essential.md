# Essential Plugins

These are the core plugins that provide the fundamental functionality of this Neovim configuration. All essential plugins work in both standalone Neovim and VSCode.

## 🔍 Telescope - File Finding & Searching

**Repository**: `nvim-telescope/telescope.nvim`  
**VSCode Compatible**: ✅  
**Purpose**: Fuzzy finder for files, buffers, and more

### Key Features
- **Fast file searching** using ripgrep
- **Horizontal layout** with live preview
- **Multiple pickers** for different content types
- **Fuzzy matching** with smart scoring
- **Customizable** appearance and behavior

### Keymaps
| Keymap | Action | Description |
|--------|--------|-------------|
| `,f` | Find files | Search for files in current directory |
| `,o` | Find old files | Recently opened files |
| `,b` | Find buffers | Switch between hidden buffers (MRU sorted) |

### Configuration
```lua
-- Horizontal layout with preview
require("telescope").setup({
  defaults = {
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        preview_width = 0.6,
      },
    },
  },
})
```

### Advanced Usage
- **Live grep**: `:Telescope live_grep` - Search within file contents
- **Git files**: `:Telescope git_files` - Search only tracked files
- **Help tags**: `:Telescope help_tags` - Search help documentation
- **Commands**: `:Telescope commands` - Search available commands

## 🤖 Copilot - AI Code Completion

**Repository**: `zbirenbaum/copilot.lua`  
**VSCode Compatible**: ✅  
**Purpose**: AI-powered code completion

### Key Features
- **Context-aware suggestions** based on your code
- **Multi-language support** for most programming languages
- **Auto-trigger** suggestions as you type
- **Tab completion** for easy acceptance
- **Privacy-focused** with local processing

### Keymaps
| Keymap | Action | Description |
|--------|--------|-------------|
| `<Tab>` | Accept suggestion | Accept the current Copilot suggestion |
| `<C-]>` | Dismiss suggestion | Dismiss current suggestion |
| `<C-[>` | Next suggestion | Cycle to next suggestion |

### Configuration
```lua
-- Auto-trigger suggestions
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
```

### Advanced Usage
- **Manual trigger**: `:Copilot` - Manually trigger suggestions
- **Status**: `:Copilot status` - Check Copilot status
- **Disable**: `:Copilot disable` - Temporarily disable Copilot

## 🌳 Treesitter - Smart Syntax Highlighting

**Repository**: `nvim-treesitter/nvim-treesitter`  
**VSCode Compatible**: ✅  
**Purpose**: Advanced syntax highlighting and text objects

### Key Features
- **Tree-based parsing** for accurate highlighting
- **Incremental parsing** for performance
- **Text objects** for code navigation
- **Smart indentation** based on syntax
- **Language-specific** features

### Keymaps
| Keymap | Action | Description |
|--------|--------|-------------|
| `<C-space>` | Incremental selection | Start/expand incremental selection |
| `]f` | Next function | Jump to next function |
| `[f` | Previous function | Jump to previous function |
| `]c` | Next class | Jump to next class |
| `[c` | Previous class | Jump to previous class |
| `]a` | Next parameter | Jump to next parameter |
| `[a` | Previous parameter | Jump to previous parameter |

### Supported Languages
- **Web**: HTML, CSS, JavaScript, TypeScript, JSX, TSX
- **Backend**: Python, Go, Rust, Java, C/C++
- **Data**: JSON, YAML, TOML, SQL
- **Markup**: Markdown, LaTeX, reStructuredText
- **Config**: Lua, Vim, Bash, Zsh

### Configuration
```lua
require("nvim-treesitter.configs").setup({
  ensure_installed = "all", -- Install all available parsers
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = "<C-s>",
      node_decremental = "<C-backspace>",
    },
  },
})
```

## 🔧 Fugitive - Git Integration

**Repository**: `tpope/vim-fugitive`  
**VSCode Compatible**: ✅  
**Purpose**: Git wrapper for Neovim

### Key Features
- **Full Git workflow** in Neovim
- **Visual Git status** with color coding
- **Interactive staging** and committing
- **Branch management** and switching
- **Merge conflict resolution**

### Keymaps
| Keymap | Action | Description |
|--------|--------|-------------|
| `,gs` | Git status | Open Git status window |

### Commands
| Command | Action | Description |
|---------|--------|-------------|
| `:Git` | Git status | Open Git status |
| `:Git add` | Stage files | Stage changes |
| `:Git commit` | Commit changes | Commit staged changes |
| `:Git push` | Push changes | Push to remote |
| `:Git pull` | Pull changes | Pull from remote |
| `:Git log` | View log | Show commit history |
| `:Git blame` | Blame | Show line-by-line blame |

### Git Status Window
When you run `:Git` or press `,gs`, you get an interactive Git status window:

- **Stage files**: Press `s` on files to stage
- **Unstage files**: Press `u` on staged files
- **Commit**: Press `cc` to commit staged changes
- **Amend**: Press `ca` to amend last commit
- **View changes**: Press `dv` to view file differences

## 🎯 Flit.nvim - Enhanced F/T Motions

**Repository**: `ggandor/flit.nvim`  
**VSCode Compatible**: ✅  
**Purpose**: Enhanced f, F, t, T motions with labeled targets

### Key Features
- **Labeled targets** for better navigation
- **Clever repeat** functionality
- **Multiline support** for cross-line navigation
- **Visual feedback** with target highlighting
- **Leap integration** for advanced motion

### Keymaps
| Keymap | Action | Description |
|--------|--------|-------------|
| `f` | Find forward | Enhanced f motion with labeled targets |
| `F` | Find backward | Enhanced F motion with labeled targets |
| `t` | Till forward | Enhanced t motion with labeled targets |
| `T` | Till backward | Enhanced T motion with labeled targets |

### Configuration
```lua
require("flit").setup({
  keys = { f = 'f', F = 'F', t = 't', T = 'T' },
  labeled_modes = "nv",  -- Enable labeled targets in normal and visual modes
  clever_repeat = true,
  multiline = true,
  opts = {}
})
```

### Getting Started with Flit

#### Basic Usage
1. **Press `f`** followed by any character to jump to the next occurrence
   - **Visual guide appears** showing labeled targets (e.g., `a`, `s`, `d`, `f`)
   - **Press the label** to jump to that specific occurrence
2. **Press `F`** followed by any character to jump to the previous occurrence  
3. **Press `t`** to jump to just before the next occurrence
4. **Press `T`** to jump to just before the previous occurrence

#### Visual Mode Enhancement
- **Press `V`** to enter visual line mode
- **Press `f`** followed by a character to extend selection to that character
- **Press `F`** to extend selection backward to a character

#### Pro Tips
- **Use `;`** to repeat the last f/t motion in the same direction
- **Use `,`** to repeat the last f/t motion in the opposite direction
- **Works across lines** - multiline support for better navigation
- **Labeled targets** appear when you press f/F/t/T for better accuracy

## 🔄 Blink.cmp - Completion Engine

**Repository**: `saghen/blink.cmp`  
**VSCode Compatible**: ✅  
**Purpose**: Modern completion engine with fuzzy matching

### Key Features
- **LSP completions** from language servers
- **Path completions** for file paths
- **Snippet support** for code snippets
- **Buffer completions** from open files
- **Fuzzy matching** for better results

### Keymaps
| Keymap | Action | Description |
|--------|--------|-------------|
| `<Tab>` | Next completion | Cycle to next completion |
| `<S-Tab>` | Previous completion | Cycle to previous completion |
| `<CR>` | Accept completion | Accept selected completion |
| `<C-Space>` | Trigger completion | Manually trigger completion |

### Completion Sources
- **LSP**: Language server completions
- **Path**: File path completions
- **Buffer**: Text from open buffers
- **Snippets**: Code snippet completions
- **Copilot**: AI-powered suggestions

## 🎯 Why These Plugins?

### Telescope
- **Essential for navigation** - Finding files is the most common task
- **Fast and efficient** - Uses ripgrep for speed
- **Highly customizable** - Can be adapted to any workflow

### Copilot
- **Modern development** - AI assistance is becoming standard
- **Productivity boost** - Suggests code patterns and completions
- **Context-aware** - Understands your codebase

### Treesitter
- **Better syntax highlighting** - More accurate than regex-based highlighting
- **Code navigation** - Text objects for moving around code
- **Language support** - Works with many programming languages

### Fugitive
- **Git integration** - Essential for version control
- **Visual interface** - Makes Git operations more intuitive
- **Full workflow** - Complete Git functionality in Neovim

### Flit.nvim
- **Better navigation** - Enhanced f/t motions for faster movement
- **Visual feedback** - Labeled targets make navigation clearer
- **Efficiency** - Reduces the need for multiple keystrokes

### Blink.cmp
- **Completion system** - Essential for modern development
- **LSP integration** - Works with language servers
- **Extensible** - Supports many completion sources

## 📚 Related Documentation

- [Plugin System](plugin-system.md) - How plugins are managed
- [Keymaps Reference](keymaps.md) - All available shortcuts
- [VSCode Integration](vscode-integration.md) - VSCode-specific considerations
