# Plugin System (lz.n + vim.pack)

Auto-discovering plugin system using lz.n for lazy-loading and vim.pack for installation.

## How It Works

1. All `.lua` files in `lua/plugins/` are automatically discovered
2. Plugin URLs are extracted and installed via `vim.pack`
3. Plugins are lazy-loaded by lz.n based on triggers (keys, events, commands, filetypes)

## Plugin Spec Format

```lua
-- plugins/my-plugin.lua
return {
  {
    url = "https://github.com/username/plugin-name.git",
    event = "BufReadPre",  -- Load on event
    after = function()
      -- Configure after plugin loads
      require("plugin-name").setup({
        option1 = true,
      })
    end,
  },
}
```

## Multiple Plugins in One File

```lua
-- plugins/multiple-plugins.lua
return {
  {
    url = "https://github.com/user/plugin1.git",
    keys = { { "<leader>p", "<cmd>Plugin1<cr>" } },
    after = function()
      require("plugin1").setup()
    end,
  },
  {
    url = "https://github.com/user/plugin2.git",
    cmd = "Plugin2Command",
    after = function()
      require("plugin2").setup()
    end,
  },
}
```

## Lazy-Loading Triggers

- `lazy = false` - Load immediately at startup
- `event = "BufReadPre"` - Load on event
- `cmd = "CommandName"` - Load when command is run
- `keys = { "<leader>k" }` - Load when key is pressed
- `ft = "python"` - Load for specific filetype
- `colorscheme = "gruvbox"` - Load when colorscheme is set

## Configuration Hooks

- `before = function() end` - Runs before plugin loads
- `after = function() end` - Runs after plugin loads (use for setup())

## Adding a New Plugin

Just create a new file:

```bash
cat > ~/.dotfiles/config/nvim/lua/plugins/my-plugin.lua << 'EOF'
return {
  {
    url = "https://github.com/user/awesome-plugin.git",
    keys = { { "<leader>a", "<cmd>Awesome<cr>" } },
    after = function()
      require("awesome-plugin").setup()
    end,
  },
}
