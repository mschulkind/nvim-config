-- =============================================================================
-- PLUGIN MANAGER - DUAL SUPPORT
-- =============================================================================
-- Plugin manager supporting both Lazy.nvim and vim.pack
-- Plugin files use Lazy.nvim format - compatible with both managers

local M = {}

-- Simple plugin manager configuration
local PLUGIN_MANAGER = "lazy"  -- Will be overridden by init.lua

-- Plugin registry (for vim.pack)
M.plugins = {}
M.initialized = false


-- Helper function to get plugin URL and name
local function get_plugin_url(repo)
  local url, plugin_name
  
  if repo:match("^https?://") then
    -- Full URL provided
    url = repo
    plugin_name = repo:match("([^/]+)%.git$") or repo:match("([^/]+)$")
  else
    -- Short repo name provided, default to GitHub
    url = "https://github.com/" .. repo .. ".git"
    plugin_name = repo:match("([^/]+)$")
  end
  
  return url, plugin_name
end

-- Debug notification helper
local function info(msg)
  if vim.g.nvim_debug == 1 then
    vim.notify(msg, vim.log.levels.INFO)
  end
end

-- Expose functions for external use
M.get_plugin_url = get_plugin_url

-- Wrap config function with error handling
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

-- Process a Lazy.nvim format plugin specification
local function process_lazy_plugin_spec(plugin_spec)
  if not plugin_spec or type(plugin_spec) ~= "table" then return end
  
  -- Handle array of plugin specs
  if plugin_spec[1] and type(plugin_spec[1]) == "string" then
    -- Single plugin spec: { "author/repo", opts = {...}, config = function() end }
    local repo = plugin_spec[1]
    local url, plugin_name = get_plugin_url(repo)
    
    M.plugins[plugin_name] = {
      repo = repo,
      url = url,
      name = plugin_name,
      config = wrap_config_with_error_handling(plugin_spec.config, plugin_name),
      opts = plugin_spec.opts,
      keys = plugin_spec.keys,
      event = plugin_spec.event,
      cmd = plugin_spec.cmd,
      ft = plugin_spec.ft,
      dependencies = plugin_spec.dependencies,
      vscode = plugin_spec.vscode,
    }
  else
    -- Array of plugin specs: { { "author/repo", ... }, { "author/repo2", ... } }
    for _, spec in ipairs(plugin_spec) do
      process_lazy_plugin_spec(spec)
    end
  end
end

-- Load a plugin file and process its configuration
function M.load_plugin_file(file_path, module_name)
  local ok, config = pcall(require, module_name)
  if not ok then
    vim.notify("Failed to load plugin file: " .. file_path .. "\nError: " .. tostring(config), vim.log.levels.WARN)
    return false
  end
  
  -- Process the Lazy.nvim format configuration
  process_lazy_plugin_spec(config)
  
  return true
end

-- Auto-discover and load plugin files
function M.auto_discover_plugins()
  local auto_loader = require("lib.plugin_manager.auto_loader")
  local plugin_configs = auto_loader.load_all_plugins()
  
  -- Process the returned plugin configurations (Lazy.nvim format only)
  for plugin_name, config in pairs(plugin_configs) do
    if config and type(config) == "table" then
      process_lazy_plugin_spec(config)
    end
  end
end

-- Install and load all registered plugins
function M.setup(plugin_manager)
  -- Prevent multiple initializations
  if M.initialized then
    return
  end
  
  -- Use provided plugin manager or default
  local manager = plugin_manager or PLUGIN_MANAGER
  
  -- Set global variable for other modules to use
  vim.g.PLUGIN_MANAGER = manager
  
  -- Check which plugin manager to use
  if manager == "lazy" then
    -- Use Lazy.nvim - let it manage packpath entirely
    local lazy_integration = require("lib.plugin_manager.lazy_integration")
    local success = lazy_integration.setup()
    if success then
      M.initialized = true
      return
    else
      vim.notify("Failed to setup Lazy.nvim, falling back to vim.pack", vim.log.levels.WARN)
    end
  elseif manager == "vim_pack" then
    -- Use vim.pack - check if available
    if vim.pack and vim.pack.add then
      M.setup_vim_pack()
    else
      vim.notify("vim.pack not available, falling back to Lazy.nvim", vim.log.levels.WARN)
      -- Fallback to Lazy.nvim
      local lazy_integration = require("lib.plugin_manager.lazy_integration")
      local success = lazy_integration.setup()
      if success then
        M.initialized = true
        return
      else
        vim.notify("Both vim.pack and Lazy.nvim failed to initialize", vim.log.levels.ERROR)
      end
    end
  else
    vim.notify("Unknown plugin manager: " .. tostring(manager), vim.log.levels.ERROR)
  end
end

-- Setup vim.pack plugin manager
function M.setup_vim_pack()
  -- Auto-discover plugin files first
  M.auto_discover_plugins()
  
  -- Bootstrap vim.pack if not already done
  if not vim.g.pack_initialized then
    vim.o.packpath = vim.o.packpath .. "," .. vim.fn.stdpath("data") .. "/site"
    vim.g.pack_initialized = true
  end
  
  local urls = {}
  local names = {}
  local all_plugins = {}
  
  -- Collect all plugin URLs and names (including dependencies)
  for name, plugin in pairs(M.plugins) do
    -- Check cond function for conditional loading
    local should_load = true
    
    if plugin.cond and type(plugin.cond) == "function" then
      local ok, result = pcall(plugin.cond)
      if not ok then
        vim.notify("Error in cond function for plugin " .. name .. ": " .. tostring(result), vim.log.levels.WARN)
        should_load = false
      else
        should_load = result
        if not should_load then
          info("Skipping plugin " .. name .. " (cond function returned false)")
        end
      end
    end
    
    if should_load then
      -- Add main plugin
      local url = plugin.url or get_plugin_url(plugin.repo)
      local plugin_name = plugin.name or name
      table.insert(urls, url)
      table.insert(names, plugin_name)
      all_plugins[plugin_name] = plugin
      
      -- Add dependencies
      if plugin.dependencies then
        for _, dep in ipairs(plugin.dependencies) do
          local dep_url, dep_name = get_plugin_url(dep)
          if not all_plugins[dep_name] then
            table.insert(urls, dep_url)
            table.insert(names, dep_name)
            all_plugins[dep_name] = { repo = dep }
          end
        end
      end
    end
  end
  
  -- Install main plugins first
  -- Dependencies will be installed automatically with the main plugins
  
  -- Install all plugins
  vim.pack.add(urls)
  
  -- Add essential dependencies
  vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim.git",
    "https://github.com/ggandor/leap.nvim.git"
  })
  
  -- Load and configure plugins with minimal delay
  vim.defer_fn(function()
    for name, plugin in pairs(M.plugins) do
      -- Load plugin
      local plugin_name = plugin.name or name
      pcall(function() vim.cmd("packadd! " .. plugin_name) end)
      
      -- Apply config function with error handling (Lazy.nvim format)
      if plugin.config and type(plugin.config) == "function" then
        local ok, err = pcall(plugin.config)
        if not ok then
          vim.notify("Plugin config failed for " .. name .. ": " .. tostring(err), vim.log.levels.WARN)
        end
      end
      
      -- Apply opts if config is not provided (Lazy.nvim style)
      if plugin.opts and not plugin.config then
        local ok, err = pcall(function()
          local plugin_module = require(plugin_name)
          if plugin_module and plugin_module.setup then
            plugin_module.setup(plugin.opts)
          end
        end)
        if not ok then
          vim.notify("Plugin opts setup failed for " .. name .. ": " .. tostring(err), vim.log.levels.WARN)
        end
      end
      
      -- Apply keymaps (Lazy.nvim format only)
      if plugin.keys then
        for _, keymap in ipairs(plugin.keys) do
          if type(keymap) == "table" and keymap[1] and keymap[2] then
            -- Lazy.nvim format: { "key", function() end, desc = "description" }
            local mode = keymap.mode or "n"
            local key = keymap[1]
            local rhs = keymap[2]
            local opts = vim.tbl_extend("force", keymap.opts or {}, {
              desc = keymap.desc,
            })
            vim.keymap.set(mode, key, rhs, opts)
          end
        end
      end
    end
  end, 100)  -- Defer by 100ms to let installation complete
  
  -- Mark as initialized to prevent duplicate loading
  M.initialized = true
end

-- Get current plugin manager status
function M.get_status()
  return {
    available = true,
    status = M.initialized and "loaded" or "not_loaded",
    manager = PLUGIN_MANAGER
  }
end

return M