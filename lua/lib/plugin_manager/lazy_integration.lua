-- =============================================================================
-- LAZY.NVIM INTEGRATION
-- =============================================================================
-- Integration module for Lazy.nvim plugin manager

local M = {}

-- Debug notification helper
local function info(msg)
  if vim.g.nvim_debug == 1 then
    vim.notify(msg, vim.log.levels.INFO)
  end
end


-- Check if Lazy.nvim is available
local function is_lazy_available()
  return pcall(require, "lazy")
end

-- Wrap config function with error handling for Lazy.nvim
local function wrap_config_with_error_handling(config_func, plugin_name)
  if not config_func or type(config_func) ~= "function" then
    return config_func
  end
  
  return function()
    local ok, err = pcall(config_func)
    if not ok then
      vim.notify("Failed to setup " .. plugin_name .. ": " .. tostring(err), vim.log.levels.WARN)
    end
  end
end

-- Install Lazy.nvim if not present
local function ensure_lazy_installed()
  local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  
  if not vim.loop.fs_stat(lazy_path) then
    info("Installing Lazy.nvim...")
    
    local lazy_repo = "https://github.com/folke/lazy.nvim.git"
    local install_cmd = string.format("git clone --filter=blob:none --single-branch %s %s", lazy_repo, lazy_path)
    
    local success = vim.fn.system(install_cmd)
    if vim.v.shell_error ~= 0 then
      vim.notify("Failed to install Lazy.nvim: " .. tostring(success), vim.log.levels.ERROR)
      return false
    end
    
    info("Lazy.nvim installed successfully!")
  end
  
  return true
end

-- Setup Lazy.nvim
function M.setup()
  -- Ensure Lazy.nvim is installed
  if not ensure_lazy_installed() then
    return false
  end
  
  -- Add Lazy.nvim to runtime path
  local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  vim.opt.rtp:prepend(lazy_path)
  
  -- Load Lazy.nvim
  local ok, lazy = pcall(require, "lazy")
  if not ok then
    vim.notify("Failed to load Lazy.nvim: " .. tostring(lazy), vim.log.levels.ERROR)
    return false
  end
  
  -- Setup Lazy.nvim with automatic plugin discovery
  -- Let Lazy.nvim handle plugin discovery natively using the import feature
  lazy.setup({
    { import = "plugins" },  -- Auto-discover all plugins in lua/plugins/
  }, {
    -- Error handling for plugin configs
    config = {
      error_handler = function(err, plugin, info)
        vim.notify("Plugin config error in " .. (plugin.name or "unknown") .. ": " .. tostring(err), vim.log.levels.WARN)
        vim.notify("Plugin info: " .. vim.inspect(info), vim.log.levels.DEBUG)
      end,
    },
    -- Performance settings
    performance = {
      cache = {
        enabled = true,
      },
      reset_packpath = true,
      rtp = {
        disabled_plugins = {
          "gzip",
          "matchit",
          "matchparen",
          "netrwPlugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
    -- UI settings
    ui = {
      border = "rounded",
      size = { width = 0.8, height = 0.8 },
      wrap = true,
    },
    -- Installer settings
    install = {
      missing = true,
      colorscheme = { "gruvbox" },
    },
    -- Checker settings
    checker = {
      enabled = false,
      notify = false,
    },
    -- Change detection
    change_detection = {
      enabled = true,
      notify = false,
    },
  })
  
  -- Add Lazy interface keymap
  vim.keymap.set("n", "<leader>L", ":Lazy<CR>", { silent = true, desc = "Open Lazy interface" })
  
  return true
end

-- Load plugins using Lazy.nvim
function M.load_plugins()
  -- Lazy.nvim handles plugin loading automatically
  -- This function is here for compatibility
  return true
end

-- Get plugin status
function M.get_status()
  if is_lazy_available() then
    local lazy = require("lazy")
    return {
      available = true,
      status = "loaded",
      manager = "lazy.nvim"
    }
  else
    return {
      available = false,
      status = "not_installed",
      manager = "lazy.nvim"
    }
  end
end

return M
