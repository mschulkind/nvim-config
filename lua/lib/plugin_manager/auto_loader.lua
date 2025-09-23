-- =============================================================================
-- AUTOMATIC PLUGIN LOADER - LAZY.NVIM FORMAT ONLY
-- =============================================================================
-- Advanced auto-discovery system for Lazy.nvim format plugin files

local M = {}

-- Debug notification helper
local function info(msg)
  if vim.g.nvim_debug == 1 then
    vim.notify(msg, vim.log.levels.INFO)
  end
end

-- Configuration for auto-loading
local config = {
  -- File patterns to ignore
  ignore_patterns = {
    "^example_",  -- Ignore example files
    "^_",         -- Ignore files starting with underscore
    "^init%.lua$", -- Ignore init.lua files
  },
  -- Whether to show loading messages
  verbose = false,
}

-- Check if a filename should be ignored
local function should_ignore_file(filename)
  for _, pattern in ipairs(config.ignore_patterns) do
    if filename:match(pattern) then
      return true
    end
  end
  return false
end

-- Load a plugin file with comprehensive error handling
local function load_plugin_file(file_path, module_name)
  -- Validate inputs
  if not file_path or not module_name then
    vim.notify("Invalid parameters for load_plugin_file: file_path=" .. tostring(file_path) .. ", module_name=" .. tostring(module_name), vim.log.levels.ERROR)
    return nil
  end
  
  -- Load the plugin file with error handling
  local ok, config = pcall(require, module_name)
  if not ok then
    local error_msg = tostring(config)
    
    -- Categorize errors for better handling
    if error_msg:match("module.*not found") then
      -- Dependency error - this is often expected during development
      if config.verbose then
        info("Plugin dependency not found: " .. module_name)
      end
    elseif error_msg:match("syntax error") then
      -- Syntax error - this needs attention
      vim.notify("Syntax error in plugin file: " .. file_path .. "\nError: " .. error_msg, vim.log.levels.ERROR)
    elseif error_msg:match("attempt to call") then
      -- Runtime error - likely configuration issue
      vim.notify("Runtime error in plugin file: " .. file_path .. "\nError: " .. error_msg, vim.log.levels.WARN)
    else
      -- Other errors
      vim.notify("Failed to load plugin file: " .. file_path .. "\nError: " .. error_msg, vim.log.levels.WARN)
    end
    return nil
  end
  
  -- Validate the loaded configuration
  if type(config) ~= "table" then
    vim.notify("Plugin file did not return a table: " .. file_path, vim.log.levels.WARN)
    return nil
  end
  
  return config
end

-- Recursively scan directory for plugin files with error handling
local function scan_directory_recursive(dir_path, plugin_configs)
  -- Validate directory path
  if not dir_path or type(dir_path) ~= "string" then
    vim.notify("Invalid directory path for scanning: " .. tostring(dir_path), vim.log.levels.ERROR)
    return
  end
  
  local handle = vim.loop.fs_scandir(dir_path)
  if not handle then
    vim.notify("Could not scan directory: " .. dir_path, vim.log.levels.WARN)
    return
  end
  
  local file, file_type = vim.loop.fs_scandir_next(handle)
  
  while file do
    local full_path = dir_path .. "/" .. file
    
    if file_type == "directory" then
      -- Recursively scan subdirectories with error handling
      local ok, err = pcall(scan_directory_recursive, full_path, plugin_configs)
      if not ok then
        vim.notify("Error scanning subdirectory " .. full_path .. ": " .. tostring(err), vim.log.levels.WARN)
      end
    elseif (file_type == "file" or file_type == "link") and file:match("%.lua$") and not should_ignore_file(file) then
      -- Load plugin file with error handling
      local relative_path = full_path:gsub("^.*/lua/", "lua/")
      local module_name = relative_path:gsub("^lua/", ""):gsub("%.lua$", ""):gsub("/", ".")
      local plugin_name = file:gsub("%.lua$", "")
      
      local ok, plugin_config = pcall(load_plugin_file, file, module_name)
      if ok and plugin_config and type(plugin_config) == "table" then
        plugin_configs[plugin_name] = plugin_config
      elseif not ok then
        vim.notify("Error loading plugin file " .. file .. ": " .. tostring(plugin_config), vim.log.levels.WARN)
      end
    end
    
    file, file_type = vim.loop.fs_scandir_next(handle)
  end
end

-- Auto-discover and load all plugin files with comprehensive error handling
function M.load_all_plugins()
  local all_plugin_configs = {}
  
  -- Validate config directory
  local config_dir = vim.fn.stdpath("config")
  if not config_dir or config_dir == "" then
    vim.notify("Could not determine Neovim config directory", vim.log.levels.ERROR)
    return all_plugin_configs
  end
  
  local plugins_dir = config_dir .. "/lua/plugins"
  
  -- Check if plugins directory exists
  if vim.fn.isdirectory(plugins_dir) == 0 then
    if config.verbose then
      info("Plugins directory not found: " .. plugins_dir)
    end
    return all_plugin_configs
  end
  
  -- Recursively scan the entire plugins directory with error handling
  local ok, err = pcall(scan_directory_recursive, plugins_dir, all_plugin_configs)
  if not ok then
    vim.notify("Error during plugin discovery: " .. tostring(err), vim.log.levels.ERROR)
    return all_plugin_configs
  end
  
  local total_loaded = 0
  for _ in pairs(all_plugin_configs) do
    total_loaded = total_loaded + 1
  end
  
  if config.verbose then
    info("Auto-discovery complete! Loaded " .. total_loaded .. " plugins.")
  end
  
  return all_plugin_configs
end

-- Configure the auto-loader
function M.configure(options)
  for key, value in pairs(options) do
    if config[key] ~= nil then
      config[key] = value
    end
  end
end

-- Get current configuration
function M.get_config()
  return vim.deepcopy(config)
end

return M