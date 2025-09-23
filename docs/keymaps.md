# Keymaps Reference

Complete reference for all keymaps in this Neovim configuration. All keymaps work in both standalone Neovim and VSCode unless marked otherwise.

## 🎯 Legend

- ✅ **VSCode Compatible**: Works in both modes
- ❌ **VSCode Disabled**: Disabled in VSCode mode
- **Mode**: `n` = Normal, `i` = Insert, `v` = Visual, `c` = Command

## 🚀 Essential Keymaps (Learn These First!)

### File Operations ✅
| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `<C-S>` | n,i | Save | Quick save (Ctrl+S) |
| `w!!` | c | Sudo save | Save with sudo when needed |
| `,v` | n | Open config | Open Neovim config file |
| `,V` | n | Reload config | Reload configuration |

### Navigation ✅
| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `,f` | n | Find files | Telescope file finder |
| `,o` | n | Find old files | Recently opened files |
| `,b` | n | Find buffers | Switch between hidden buffers (MRU sorted) |
| `<C-h/j/k/l>` | n,i | Navigate splits | Move between windows |
| `<A-Left/Right>` | n | Move windows | Move current window left/right |

### Text Editing ✅
| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `jj` | i | Escape | Alternative to Escape key |
| `<CR>` | n | New line above | Insert newline above current line |
| `<DEL>` | n | Clear line | Clear current line content |
| `gp` | n | Select pasted | Select the text you just pasted |

## 📋 Complete Keymap Reference

### Navigation & Movement ✅

#### Window Navigation
| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `<C-h>` | n,i | Move left | Move to window on the left |
| `<C-j>` | n,i | Move down | Move to window below |
| `<C-k>` | n,i | Move up | Move to window above |
| `<C-l>` | n,i | Move right | Move to window on the right |
| `<A-Left>` | n | Move window left | Move current window left |
| `<A-Right>` | n | Move window right | Move current window right |

#### File Navigation
| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `,f` | n | Find files | Telescope file finder |
| `,o` | n | Find old files | Recently opened files |
| `,b` | n | Find buffers | Switch between hidden buffers (MRU sorted) |
| `<C-Y>` | n | Go to tag | Navigate to tag under cursor |

#### Enhanced Motions (Flit.nvim) ✅
| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `f` | n | Find forward | Enhanced f motion with labeled targets |
| `F` | n | Find backward | Enhanced F motion with labeled targets |
| `t` | n | Till forward | Enhanced t motion with labeled targets |
| `T` | n | Till backward | Enhanced T motion with labeled targets |

### Text Editing ✅

#### Basic Editing
| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `jj` | i | Escape | Alternative to Escape key |
| `<CR>` | n | New line above | Insert newline above current line |
| `<DEL>` | n | Clear line | Clear current line content |
| `gp` | n | Select pasted | Select the text you just pasted |

#### Commenting (NerdCommenter) ✅
| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `gcc` | n | Comment line | Comment/uncomment current line |
| `gct` | n | Toggle comment | Toggle comment on current line |
| `gcu` | n | Uncomment line | Uncomment current line |
| `V` + `gcu` | v | Uncomment selection | Uncomment selected lines (visual line mode) |

#### Visual Mode Workflow
- **`V`** - Enter visual line mode
- **Select lines** - Use `j`/`k` or arrow keys to select multiple lines
- **`gcu`** - Uncomment all selected lines at once
- **`gcc`** - Comment all selected lines at once
- **`gct`** - Toggle comment on all selected lines

### Command Line ✅

#### Command Line Navigation
| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `<C-A>` | c | Home | Move to beginning of command line |
| `<C-E>` | c | End | Move to end of command line |
| `jj` | c | Cancel | Cancel command (alternative to Ctrl+C) |

#### File Operations
| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `w!!` | c | Sudo save | Save file with sudo |

### Enhanced Navigation (Flit + Leap) ✅

#### Flit.nvim - Enhanced f/t Motions
| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `f` | n | Jump forward to character | Jump to next occurrence of character |
| `F` | n | Jump backward to character | Jump to previous occurrence of character |
| `t` | n | Jump forward to before character | Jump to just before next occurrence |
| `T` | n | Jump backward to before character | Jump to just before previous occurrence |
| `f` | v | Extend selection to character | Extend selection to next occurrence |
| `F` | v | Extend selection to character | Extend selection to previous occurrence |
| `;` | n | Repeat last motion | Repeat the last f/F/t/T motion |
| `,` | n | Repeat motion backward | Repeat the last motion in opposite direction |

#### Leap.nvim - 2-Character Jumping
| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `s` | n | Jump to 2 characters | Jump to any 2 characters in visible area |
| `S` | n | Jump to 2 characters in line | Jump to any 2 characters in current line |
| `gs` | n | Jump to 2 characters in window | Jump to any 2 characters in entire window |
| `s` | v | Extend selection to 2 characters | Extend selection to 2-character target |
| `S` | v | Extend selection to 2 characters | Extend selection to 2-character target in line |
| `;` | n | Repeat last leap | Repeat the last leap motion |
| `,` | n | Repeat leap backward | Repeat the last leap motion backward |

> 🎯 **Learn more**: [Complete Flit + Leap guide](plugins/navigation.md)

### Configuration ✅

#### Config Management
| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `,v` | n | Open config | Open Neovim config file |
| `,V` | n | Reload config | Reload Neovim configuration |
| `,r` | n | Show registers | Display all registers |

### Registers ✅

#### Register Operations
| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `,0` | n | Paste register 0 | Paste from register 0 |
| `,1` | n | Paste register 1 | Paste from register 1 |
| `,2` | n | Paste register 2 | Paste from register 2 |
| `,3` | n | Paste register 3 | Paste from register 3 |
| `,4` | n | Paste register 4 | Paste from register 4 |
| `,5` | n | Paste register 5 | Paste from register 5 |
| `,6` | n | Paste register 6 | Paste from register 6 |
| `,7` | n | Paste register 7 | Paste from register 7 |
| `,8` | n | Paste register 8 | Paste from register 8 |
| `,9` | n | Paste register 9 | Paste from register 9 |

### Quickfix & Location Lists ✅

#### Quickfix Operations
| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `,c` | n | Open quickfix | Open quickfix window |
| `,cc` | n | Close quickfix | Close quickfix window |
| `,cn` | n | Next error | Go to next quickfix item |
| `,cp` | n | Previous error | Go to previous quickfix item |
| `<F2>` | n | Previous error | Go to previous quickfix item |
| `<F3>` | n | Next error | Go to next quickfix item |
| `<F9>` | n | Close quickfix | Close quickfix window |
| `<F10>` | n | Make | Run make and open quickfix |

#### Location List Operations
| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `,l` | n | Open location list | Open location list |
| `,ll` | n | Close location list | Close location list |
| `<C-F2>` | n | Previous location | Go to previous location list item |
| `<C-F3>` | n | Next location | Go to next location list item |

### Search & Folding ✅

#### Search Operations
| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `<C-N>` | n | Clear search | Turn off search highlighting |

#### Folding Operations
| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `zo` | n | Open fold | Open fold (recursive) |
| `zO` | n | Close fold | Close fold (recursive) |

### LSP ✅

#### Language Server Protocol
| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `K` | n | Hover | Show LSP hover information with border |

### Treesitter ✅

#### Text Objects
| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `<C-space>` | n | Incremental selection | Start incremental selection |
| `]f` | n | Next function | Go to next function |
| `[f` | n | Previous function | Go to previous function |
| `]c` | n | Next class | Go to next class |
| `[c` | n | Previous class | Go to previous class |
| `]a` | n | Next parameter | Go to next parameter |
| `[a` | n | Previous parameter | Go to previous parameter |

### Git Integration ✅

#### Fugitive
| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `,gs` | n | Git status | Open Git status window |

### Buffer Management ✅

#### Buffer Operations
| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `,k` | n | Delete buffer | Delete buffer without closing window |

## ❌ VSCode-Disabled Keymaps

These keymaps are disabled in VSCode mode (use VSCode's native features instead):

### File Explorer (nvim-tree) ❌
| Keymap | Mode | Action | VSCode Alternative |
|--------|------|--------|-------------------|
| `<F6>` | n | Toggle nvim-tree | Use VSCode's file explorer |
| `g?` | n | nvim-tree help | Use VSCode's file explorer |

### Undo History (telescope-undo) ❌
| Keymap | Mode | Action | VSCode Alternative |
|--------|------|--------|-------------------|
| `<F5>` | n | Telescope undo | Use VSCode's timeline feature |

## 🎯 Keymap Categories by Use Case

### For File Management
- `,f` - Find files
- `,o` - Recent files
- `,b` - Switch hidden buffers (MRU sorted)
- `,k` - Close buffer

### For Navigation
- `<C-h/j/k/l>` - Window navigation
- `<C-Y>` - Go to tag
- `j/k` - Smooth scrolling

### For Editing
- `jj` - Escape
- `gcc` - Comment line
- `<C-S>` - Save

### For Git
- `,gs` - Git status

### For Configuration
- `,v` - Open config
- `,V` - Reload config

## 💡 Tips for Learning Keymaps

1. **Start with essentials**: Learn `,f`, `jj`, `<C-S>`, and window navigation first
2. **Use muscle memory**: Practice the same keymaps repeatedly
3. **Check this reference**: Keep this page handy while learning
4. **Customize gradually**: Add your own keymaps as you get comfortable
5. **VSCode users**: Focus on the ✅ keymaps that work in both modes

## 🔧 Customizing Keymaps

To add your own keymaps, edit `lua/core/keymaps.lua`:

```lua
-- Add a new keymap
vim.keymap.set("n", "<leader>m", ":MyCommand<CR>", { desc = "My custom command" })
```

For plugin-specific keymaps, add them to the plugin's configuration file in `lua/plugins/`.

## 📚 Related Documentation

- [Configuration System](configuration-system.md) - How keymaps are loaded
- [Plugin System](plugin-system.md) - Plugin-specific keymaps
- [Customization Guide](customization.md) - Adding custom keymaps
