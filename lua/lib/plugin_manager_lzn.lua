-- =============================================================================
-- PLUGIN MANAGER - LZ.N WITH VIM.PACK
-- =============================================================================
-- Simple plugin manager using lz.n for lazy loading and vim.pack for installation.
-- This replaces the previous custom implementation with a much simpler approach.

local M = {}

-- Extract plugin name from URL
-- https://github.com/ibhagwan/fzf-lua.git -> fzf-lua
local function extract_plugin_name(url)
  return url:match("([^/]+)%.git$") or url:match("([^/]+)$")
end

-- Process a plugin spec and extract URL/name
-- Handles both array format { url = "...", ... } and first element format { "url", ... }
local function process_plugin_spec(spec)
  local url = spec.url or spec[1]
  if not url then
    return nil, nil
  end
  
  local plugin_name = extract_plugin_name(url)
  return url, plugin_name
end

-- Auto-discover all plugin files in plugins/ directory
local function discover_plugin_files()
  local plugins_path = vim.fn.stdpath("config") .. "/lua/plugins"
  local plugin_files = vim.fn.globpath(plugins_path, "*.lua", false, true)
  local modules = {}
  
  for _, file in ipairs(plugin_files) do
    local filename = vim.fn.fnamemodify(file, ":t:r")
    -- Skip README or any non-plugin files
    if filename ~= "README" and not filename:match("^_") then
      table.insert(modules, filename)
    end
  end
  
  return modules
end

-- Collect all URLs from plugin specs
local function collect_plugin_urls()
  local urls = {}
  local seen = {}
  
  -- Auto-discover all plugin files
  local plugin_files = discover_plugin_files()
  
  for _, plugin_file in ipairs(plugin_files) do
    local ok, specs = pcall(require, "plugins." .. plugin_file)
    if ok and type(specs) == "table" then
      -- Handle array of specs
      for _, spec in ipairs(specs) do
        local url, name = process_plugin_spec(spec)
        if url and name and not seen[name] then
          table.insert(urls, url)
          seen[name] = true
        end
      end
    end
  end
  
  return urls
end

-- Setup function
function M.setup()
  -- Check if vim.pack is available
  if not vim.pack or not vim.pack.add then
    vim.notify("vim.pack not available - requires Neovim nightly build", vim.log.levels.ERROR)
    return
  end
  
  -- Collect all plugin URLs
  local urls = collect_plugin_urls()
  
  -- Install all plugins using vim.pack (but don't load them yet)
  if #urls > 0 then
    vim.pack.add(urls, { load = false })
  end
  
  -- Load lz.n first (it needs to be loaded eagerly)
  local lzn_ok = pcall(vim.cmd.packadd, "lz.n")
  if not lzn_ok then
    vim.notify("Failed to load lz.n - plugins will not be lazy-loaded", vim.log.levels.ERROR)
    return
  end
  
  -- Check if lz.n loaded successfully
  local has_lzn, lzn = pcall(require, "lz.n")
  if not has_lzn then
    vim.notify("lz.n not available - plugins will not be lazy-loaded", vim.log.levels.ERROR)
    return
  end
  
  -- Load plugins using lz.n
  -- Process each spec to replace url with plugin name for lz.n
  -- Auto-discover all plugin files
  local plugin_files = discover_plugin_files()
  
  for _, plugin_file in ipairs(plugin_files) do
    local ok, specs = pcall(require, "plugins." .. plugin_file)
    if ok and type(specs) == "table" then
      -- Convert specs for lz.n (url -> name)
      local lzn_specs = {}
      for _, spec in ipairs(specs) do
        local url = spec.url or spec[1]
        if url then
          -- Create a copy of the spec with name instead of url
          local lzn_spec = vim.tbl_extend("force", {}, spec)
          lzn_spec[1] = extract_plugin_name(url)
          lzn_spec.url = nil  -- Remove url field, lz.n doesn't use it
          table.insert(lzn_specs, lzn_spec)
        else
          -- No url, pass through as-is (like lz.n itself)
          table.insert(lzn_specs, spec)
        end
      end
      lzn.load(lzn_specs)
    else
      vim.notify("Failed to load plugin specs from: plugins." .. plugin_file, vim.log.levels.WARN)
    end
  end
  
  -- Set the colorscheme (this will trigger lz.n to load the colorscheme plugin)
  vim.cmd.colorscheme("gruvbox")
end

return M
