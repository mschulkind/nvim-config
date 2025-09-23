# Customization Guide

This guide shows you how to customize and extend this Neovim configuration to fit your needs.

## → Overview

The configuration is designed to be easily customizable while maintaining compatibility with both standalone Neovim and VSCode.

## 🔧 Basic Customization

### Adding Custom Keymaps

#### Global Keymaps
Edit `lua/core/keymaps.lua`:

```lua
-- Add a new keymap
vim.keymap.set("n", "<leader>m", ":MyCommand<CR>", { desc = "My custom command" })

-- Add a keymap with options
vim.keymap.set("n", "<leader>s", ":MySearch<CR>", {
  desc = "My custom search",
  silent = true,
  noremap = true
})
```

#### Plugin-Specific Keymaps
Add to the plugin's configuration file in `lua/plugins/`:

```lua
return {
  repo = "user/plugin",
  keys = {
    { "n", "<leader>p", ":PluginCommand<CR>", { desc = "Plugin command" } }
  }
}
```

### Modifying Core Settings

#### Basic Settings
Edit `lua/core/settings.lua`:

```lua
-- Change line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Change indentation
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- Change search behavior
vim.o.ignorecase = true
vim.o.smartcase = true
```

#### Advanced Settings
```lua
-- Change update time
vim.o.updatetime = 300

-- Change complete options
vim.o.completeopt = "menu,menuone,noselect"

-- Change scrolloff
vim.o.scrolloff = 8
```

### Customizing Plugins

#### Telescope Configuration
Create `lua/plugins/telescope.lua`:

```lua
return {
  repo = "nvim-telescope/telescope.nvim",
  setup = function()
    require("telescope").setup({
      defaults = {
        -- Custom configuration
        layout_strategy = "vertical",
        layout_config = {
          vertical = {
            preview_height = 0.8,
          },
        },
      },
    })
  end,
  keys = {
    { "n", "<leader>f", ":Telescope find_files<CR>" },
    { "n", "<leader>g", ":Telescope live_grep<CR>" },
  }
}
```

#### Treesitter Configuration
Create `lua/plugins/treesitter.lua`:

```lua
return {
  repo = "nvim-treesitter/nvim-treesitter",
  setup = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "lua", "vim", "python", "javascript" },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
    })
  end
}
```

## 🎨 Appearance Customization

### Color Scheme

#### Using a Different Color Scheme
Create `lua/plugins/colorscheme.lua`:

```lua
return {
  repo = "user/colorscheme",
  vscode = false,  -- Disable in VSCode
  setup = function()
    vim.cmd("colorscheme my-colorscheme")
  end
}
```

#### Customizing Gruvbox
Edit `lua/plugins/gruvbox.lua`:

```lua
return {
  repo = "ellisonleao/gruvbox.nvim",
  vscode = false,
  setup = function()
    require("gruvbox").setup({
      -- Custom Gruvbox configuration
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
      contrast = "hard", -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = false,
    })
    vim.cmd("colorscheme gruvbox")
  end
}
```

### Status Line

#### Customizing Lualine
Create `lua/plugins/lualine.lua`:

```lua
return {
  repo = "nvim-lualine/lualine.nvim",
  vscode = false,
  setup = function()
    require("lualine").setup({
      options = {
        theme = "gruvbox",
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end
}
```

## 🔌 Adding New Plugins

### Method 1: Single Plugin File

Create a new file in `lua/plugins/`:

```lua
-- lua/plugins/my_plugin.lua
return {
  repo = "user/my-plugin",
  vscode = true,  -- or false if it conflicts with VSCode
  setup = function()
    require("my-plugin").setup({
      -- Plugin configuration
    })
  end,
  keys = {
    { "n", "<leader>m", ":MyCommand<CR>", { desc = "My command" } }
  },
  dependencies = {
    "plenary.nvim"  -- if needed
  }
}
```

### Method 2: Add to Simple Plugins

Add to `lua/plugins/simple_plugins.lua`:

```lua
return {
  plugins = {
    -- ... existing plugins ...
    my_plugin = {
      repo = "user/my-plugin",
      setup = function()
        require("my-plugin").setup({})
      end
    }
  }
}
```

### Method 3: Modify Existing Plugin

Edit an existing plugin file to add functionality.

## → VSCode-Specific Customization

### VSCode-Compatible Plugins

When adding plugins for VSCode compatibility:

```lua
return {
  repo = "user/plugin",
  vscode = true,  -- Enable in VSCode
  setup = function()
    -- Plugin configuration
  end
}
```

### VSCode-Disabled Plugins

For plugins that conflict with VSCode:

```lua
return {
  repo = "user/plugin",
  vscode = false,  -- Disable in VSCode
  setup = function()
    -- Plugin configuration
  end
}
```

### VSCode Alternative Features

When a plugin is disabled in VSCode, use VSCode's native features:

- **File Explorer**: Use VSCode's file explorer instead of NerdTree
- **Status Bar**: Use VSCode's status bar instead of Lualine
- **Timeline**: Use VSCode's timeline instead of Mundo
- **Themes**: Use VSCode's theme system instead of Gruvbox

## 🔄 Advanced Customization

### Custom Auto Commands

Edit `lua/core/autocmds.lua`:

```lua
-- Add custom auto commands
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = true
  end
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function()
    vim.cmd(":silent! !black %")
  end
})
```

### Custom Functions

Create `lua/utils/my_functions.lua`:

```lua
local M = {}

function M.my_function()
  -- Custom function
  print("Hello from my function!")
end

function M.setup()
  -- Setup function
  vim.keymap.set("n", "<leader>h", M.my_function, { desc = "My function" })
end

return M
```

Then load it in `init.lua`:

```lua
require("utils.my_functions").setup()
```

### Custom Plugin Configurations

#### Complex Plugin Setup
```lua
return {
  repo = "user/complex-plugin",
  setup = function()
    local plugin = require("complex-plugin")
    
    plugin.setup({
      -- Configuration
      option1 = true,
      option2 = "value",
      option3 = {
        sub_option = "value"
      }
    })
    
    -- Additional setup
    plugin.register_commands()
    plugin.setup_keymaps()
  end
}
```

#### Conditional Configuration
```lua
return {
  repo = "user/plugin",
  setup = function()
    local config = {
      -- Base configuration
      option1 = true,
    }
    
    -- Add VSCode-specific options
    if vim.g.vscode then
      config.option2 = "vscode_value"
    else
      config.option2 = "neovim_value"
    end
    
    require("plugin").setup(config)
  end
}
```

## 🧪 Testing Customizations

### Testing in Standalone Neovim
```bash
nvim
```

### Testing in VSCode
1. Open VSCode
2. Open a file
3. Test your customizations

### Testing Plugin Loading
```vim
:checkhealth
```

### Testing Keymaps
```vim
:verbose map <leader>m
```

## 📚 Best Practices

### 1. Keep It Simple
- Start with basic customizations
- Add complexity gradually
- Test each change

### 2. Maintain Compatibility
- Test in both Neovim and VSCode
- Use VSCode alternatives when possible
- Document VSCode-specific changes

### 3. Organize Your Code
- Use descriptive file names
- Group related functionality
- Add comments for complex logic

### 4. Version Control
- Commit changes incrementally
- Use descriptive commit messages
- Keep a backup of working configurations

### 5. Performance
- Profile your changes
- Use lazy loading when possible
- Avoid expensive operations in setup

## 🐛 Troubleshooting Customizations

### Common Issues

#### Keymaps Not Working
```vim
:verbose map <leader>m
```

#### Plugins Not Loading
```vim
:checkhealth
```

#### Configuration Errors
```vim
:messages
```

### Debugging Steps

1. **Check syntax**: Ensure Lua syntax is correct
2. **Check dependencies**: Ensure required plugins are installed
3. **Check VSCode compatibility**: Ensure plugins work in VSCode
4. **Test incrementally**: Add one change at a time
5. **Check logs**: Look at error messages

## 📚 Related Documentation

- [Configuration System](configuration-system.md) - Understanding the architecture
- [Plugin System](plugin-system.md) - How to add plugins
- [Keymaps Reference](keymaps.md) - All available shortcuts
- [VSCode Integration](vscode-integration.md) - VSCode-specific considerations
- [Troubleshooting](troubleshooting.md) - Common issues and solutions
