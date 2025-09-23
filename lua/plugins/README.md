# Pure Data-Driven Plugin System

This is a streamlined plugin system - plugin files return configuration tables that are automatically discovered and loaded. No manual registration needed!

## How It Works

### Single Plugin File

```lua
-- plugins/my-plugin.lua
return {
 repo = "username/plugin-name",
 setup = function()
 require("plugin-name").setup({
 option1 = true,
 option2 = "value",
 })
 end,
}
```

### Multiple Plugins in One File

```lua
-- plugins/multiple-plugins.lua
return {
 plugins = {
 plugin1 = {
 repo = "username/plugin1",
 setup = function()
 require("plugin1").setup()
 end,
 },
 
 plugin2 = {
 repo = "username/plugin2",
 setup = function()
 require("plugin2").setup()
 end,
 },
 },
}
```

## Configuration Options

### Basic Options

- `repo` - Repository URL or short name (required)
- `setup` - Setup function to call after plugin loads
- `vscode` - Whether plugin should run in VSCode (optional, defaults to true)

### VSCode Compatibility

Some plugins may not work well in VSCode with the Neovim extension. You can disable them:

```lua
return {
 repo = "username/plugin-name",
 vscode = false, -- Disable this plugin when running in VSCode
 setup = function()
-- Plugin configuration
 end,
}
```

When `vscode = false`, the plugin will be skipped entirely when running in VSCode, preventing conflicts and improving performance.

### Keymap Options

```lua
return {
 repo = "username/plugin",
 keys = {
 { "<leader>k", "<cmd>PluginCommand<cr>", desc = "Plugin command" },
 { "<leader>K", "<cmd>AnotherCommand<cr>", desc = "Another command" },
 { "<leader>kk", "<cmd>YetAnotherCommand<cr>", mode = "v", desc = "Visual mode command" },
 },
}
```



## Examples

### Simple Plugin

```lua
return {
 repo = "username/simple-plugin",
}
```

### Plugin with Setup

```lua
return {
 repo = "username/complex-plugin",
 setup = function()
 require("complex-plugin").setup({
 option1 = true,
 option2 = "value",
 })
 
-- Custom keymaps
 vim.keymap.set("n", "<leader>c", "<cmd>ComplexCommand<cr>", { desc = "Complex command" })
 
-- Autocommands
 vim.api.nvim_create_autocmd("FileType", {
 pattern = "python",
 callback = function()
-- Plugin-specific filetype configuration
 end,
 })
 end,
}
```

### Multiple Related Plugins

```lua
return {
 plugins = {
 copilot = {
 repo = "zbirenbaum/copilot.lua",
 setup = function()
 require("copilot").setup({
 suggestion = { auto_trigger = true }
 })
 end,
 },
 
 blink_cmp = {
 repo = "saghen/blink.cmp",
 setup = function()
 require("blink.cmp").setup({
 sources = { "lsp", "path", "buffer" },
 })
 end,
 },
 },
}
```

## Benefits

1. **Pure Data**: Just return tables, no function calls needed
2. **Auto-Discovery**: Files are automatically found and loaded
3. **Self-Contained**: Each plugin file contains both repo and config
4. **Multiple Formats**: Single plugin or multiple plugins per file
5. **Advanced Features**: Multiple plugin formats
6. **Automatic Keymaps**: Keys are automatically applied
7. **Self-Documenting**: Configuration is clear and readable
