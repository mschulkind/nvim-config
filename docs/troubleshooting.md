# Troubleshooting

This guide helps you diagnose and fix common issues with this Neovim configuration.

## 🚨 Common Issues

### vim.pack Issues

#### vim.pack Not Working
**Symptoms**: Plugins fail to load when using vim.pack, error messages about missing functions

**Cause**: vim.pack requires a **very recent nightly build** of Neovim

**Solutions**:
1. **Switch to Lazy.nvim** (recommended):
   ```lua
   -- In init.lua, change:
   local PLUGIN_MANAGER = "lazy"  -- Use Lazy.nvim instead
   ```

2. **Update Neovim** (if you must use vim.pack):
   ```bash
   # Install latest nightly build
   # See docs/install.md for OS-specific instructions
   ```

### Plugin Loading Issues

#### Plugins Not Loading
**Symptoms**: Plugins don't appear or keymaps don't work

**Solutions**:
1. **Check plugin status**:
   ```vim
   :checkhealth
   ```

2. **View error messages**:
   ```vim
   :messages
   ```

3. **Reload configuration**:
   ```vim
   :source %
   ```

4. **Check VSCode mode**:
   ```lua
   :lua print(require("lib.plugin_manager.plugin_manager").is_vscode())
   ```

#### VSCode Plugin Conflicts
**Symptoms**: Plugins disabled in VSCode with notifications

**Solutions**:
- **Use VSCode's native features** instead of disabled plugins
- **Check VSCode extension** is properly installed
- **Verify configuration path** in VSCode settings

### Performance Issues

#### Slow Startup
**Symptoms**: Neovim takes a long time to start

**Solutions**:
1. **Check plugin count**:
   ```lua
   :lua print(vim.inspect(require("lib.plugin_manager.plugin_manager").plugins))
   ```

2. **Disable unnecessary plugins** by setting `vscode = false`

3. **Use lazy loading** for heavy plugins

4. **Check system resources**:
   ```bash
   htop
   ```

#### Motion Issues
**Symptoms**: f/t motions not working or behaving unexpectedly

**Solutions**:
1. **Check Flit.nvim settings**:
   ```lua
   :lua print(vim.inspect(require("flit")))
   ```

2. **Check Leap dependency**:
   ```lua
   :lua print(vim.inspect(require("leap")))
   ```

3. **Disable Flit.nvim** temporarily:
   ```lua
   -- Comment out flit.nvim in plugin configuration
   ```

### Keymap Issues

#### Keymaps Not Working
**Symptoms**: Custom keymaps don't respond

**Solutions**:
1. **Check keymap conflicts**:
   ```vim
   :verbose map <leader>f
   ```

2. **Verify leader key**:
   ```vim
   :echo mapleader
   ```

3. **Check mode** - ensure you're in the correct mode (normal, insert, visual)

4. **Reload keymaps**:
   ```vim
   :source ~/.config/nvim/lua/core/keymaps.lua
   ```

#### VSCode Keymap Conflicts
**Symptoms**: Keymaps work in standalone Neovim but not in VSCode

**Solutions**:
1. **Check VSCode extension settings**:
   ```json
   {
     "vscode-neovim.useCtrlKeysForInsertMode": true,
     "vscode-neovim.useCtrlKeysForNormalMode": true
   }
   ```

2. **Use VSCode's command palette** for complex operations

3. **Check VSCode keybindings** for conflicts

### Git Integration Issues

#### Fugitive Not Working
**Symptoms**: Git commands fail or don't appear

**Solutions**:
1. **Check Git installation**:
   ```bash
   git --version
   ```

2. **Verify repository**:
   ```bash
   git status
   ```

3. **Check Fugitive status**:
   ```vim
   :Git status
   ```

4. **Reload Fugitive**:
   ```vim
   :packadd fugitive
   ```

### LSP Issues

#### Language Server Not Working
**Symptoms**: No completions, hover, or diagnostics

**Solutions**:
1. **Check LSP status**:
   ```vim
   :LspInfo
   ```

2. **Install language server**:
   ```bash
   # For example, for Python
   pip install python-lsp-server
   ```

3. **Check LSP configuration**:
   ```vim
   :lua print(vim.inspect(vim.lsp.get_active_clients()))
   ```

4. **Restart LSP**:
   ```vim
   :LspRestart
   ```

### Telescope Issues

#### Telescope Not Finding Files
**Symptoms**: Telescope shows no results or errors

**Solutions**:
1. **Check ripgrep installation**:
   ```bash
   rg --version
   ```

2. **Install ripgrep**:
   ```bash
   # Ubuntu/Debian
   sudo apt install ripgrep
   
   # Arch Linux
   sudo pacman -S ripgrep
   
   # macOS
   brew install ripgrep
   ```

3. **Check Telescope configuration**:
   ```lua
   :lua print(vim.inspect(require("telescope")))
   ```

4. **Test with different pickers**:
   ```vim
   :Telescope find_files
   :Telescope buffers
   :Telescope help_tags
   ```

## 🔧 Debugging Commands

### Check System Status
```vim
" Check Neovim version
:version

" Check plugin health
:checkhealth

" Check LSP status
:LspInfo

" Check Git status
:Git status
```

### Check Configuration
```vim
" View error messages
:messages

" Check loaded plugins
:lua print(vim.inspect(require("lib.plugin_manager.plugin_manager").plugins))

" Check VSCode mode
:lua print(require("lib.plugin_manager.plugin_manager").is_vscode())

" Check keymaps
:verbose map <leader>f
```

### Check Performance
```vim
" Check startup time
:lua print(vim.g.startuptime)

" Check memory usage
:lua print(collectgarbage("count"))

" Profile startup
:lua require("profile").start()
```

## 🛠️ Advanced Troubleshooting

### Plugin System Debugging

#### Check Plugin Loading Order
```lua
:lua print(vim.inspect(require("lib.plugin_manager.plugin_manager").plugins))
```

#### Check VSCode Filtering
```lua
:lua print(require("lib.plugin_manager.plugin_manager").is_vscode())
```

#### Reload Plugin Manager
```lua
:lua require("lib.plugin_manager.plugin_manager").setup()
```

### Configuration Debugging

#### Check Core Settings
```vim
" Check settings
:lua print(vim.inspect(vim.o))

" Check keymaps
:lua print(vim.inspect(vim.keymap))

" Check autocmds
:lua print(vim.inspect(vim.api.nvim_get_autocmds()))
```

#### Check Plugin Configurations
```vim
" Check Telescope
:lua print(vim.inspect(require("telescope")))

" Check Treesitter
:lua print(vim.inspect(require("nvim-treesitter")))

" Check Copilot
:lua print(vim.inspect(vim.g.copilot))
```

### Performance Debugging

#### Profile Startup Time
```bash
nvim --startuptime startup.log
```

#### Check Memory Usage
```vim
:lua print(collectgarbage("count") .. " KB")
```

#### Profile Plugin Loading
```lua
:lua require("profile").start()
```

## 🆘 Getting Help

### Check Logs
```vim
" View Neovim messages
:messages

" Check health
:checkhealth

" View startup log
:lua print(vim.g.startuptime)
```

### Common Solutions

#### Reset Configuration
1. **Backup current config**:
   ```bash
   cp -r ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Reset to default**:
   ```bash
   rm -rf ~/.config/nvim
   git clone <your-config-repo> ~/.config/nvim
   ```

3. **Restart Neovim**

#### Update Plugins
```vim
" Update all plugins
:lua require("lib.plugin_manager.plugin_manager").update()

" Or manually update
:packadd <plugin-name>
```

### External Resources

- **Neovim Documentation**: https://neovim.io/doc/
- **Plugin Documentation**: Check individual plugin repos
- **VSCode Extension**: https://marketplace.visualstudio.com/items?itemName=asvetliakov.vscode-neovim
- **Community**: https://www.reddit.com/r/neovim/

## 📚 Related Documentation

- [Configuration System](configuration-system.md) - Understanding the architecture
- [Plugin System](plugin-system.md) - How plugins are managed
- [VSCode Integration](vscode-integration.md) - VSCode-specific issues
- [Customization Guide](customization.md) - Modifying the configuration
