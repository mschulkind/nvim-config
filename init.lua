-- =============================================================================
-- NEOVIM CONFIGURATION - MAIN ENTRY POINT
-- =============================================================================

-- Enable autoloading for better performance (Neovim 0.9+)
vim.loader.enable()

-- Load core configurations
require("core.settings")
require("core.autocmds")
require("core.keymaps")
require("core.clipboard")

-- Load utility modules
require("utils.movement").setup()

-- Load plugin configurations
-- Priority: 1) explicit choice, 2) vim.pack if available, 3) lazy
local function determine_plugin_manager()
  -- 1. Check for explicit choice via environment variable
  local explicit_choice = vim.env.NVIM_PLUGIN_MANAGER
  if explicit_choice then
    return explicit_choice
  end
  
  -- 2. Check if vim.pack is available (very recent nightly build)
  if vim.pack and vim.pack.add then
    return "vim_pack"
  end
  
  -- 3. Fallback to lazy
  return "lazy"
end

local PLUGIN_MANAGER = determine_plugin_manager()
require("lib.plugin_manager").setup(PLUGIN_MANAGER)
