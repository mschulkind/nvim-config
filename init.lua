-- =============================================================================
-- NEOVIM CONFIGURATION - MAIN ENTRY POINT
-- =============================================================================
-- Disable --More-- prompts for long messages. In particular the first startup
-- treesitter parser installation. 
vim.o.more = false 

-- Enable autoloading for better performance (Neovim 0.9+)
vim.loader.enable()

-- Faster file change detection (250ms)
vim.o.updatetime = 250

-- Load core configurations
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

-- Leader keys: primary and local leader used for user mappings. must be before
-- lazy loads.
vim.g.mapleader = ","
vim.g.maplocalleader = ","

local PLUGIN_MANAGER = determine_plugin_manager()
require("lib.plugin_manager").setup(PLUGIN_MANAGER)

-- =============================================================================
-- CORE NEOVIM SETTINGS
-- =============================================================================
-- Basic Neovim options and global settings

-- GUI settings: set GUI font when running in Neovide or a GUI frontend
if vim.g.neovide or vim.fn.has('gui_running') == 1 then
  vim.o.guifont = vim.g.guifont or "Inconsolata Nerd Font:h14:b"
end
-- Show absolute line numbers in the gutter
vim.o.number = true

-- Display and UI
-- Keep at least 3 lines visible above/below the cursor
vim.o.scrolloff = 3
-- Highlight the current line for easier tracking
vim.o.cursorline = true

-- Editing behavior
-- Limit text width for formatting/wrapping at 100 chars
vim.o.textwidth = 100
-- Format options: remove automatic text wrapping ('t'), add auto-insert comment leader on new line ('r','o')
vim.o.formatoptions = "ro" -- Remove 't', add 'r' and 'o'
-- Don't insert two spaces after a period when joining sentences
vim.o.joinspaces = false
-- Enable line wrapping visually
vim.o.wrap = true
-- Ensure backup behavior is compatible with some tools (guard/gulp)
vim.o.backupcopy = "yes" -- Fix guard/gulp issues

-- Search and command line
-- Control how command-line completion behaves (show longest match, then list)
vim.o.wildmode = "longest,list"
-- Ignore common noisy directories/files in completion and search
vim.o.wildignore = "*/_site/*,*/*.class,*/.git/*,*.swp,*/.AppleDouble/*,*/target/*,*/out/*,*/public/assets/*,*/node_modules/*,*/bower_components/*,*/dist/*,*/COMPILED/*,*/__pycache__*,*.pyc"
-- Use ripgrep for :grep for fast project-wide search with vimgrep format
vim.o.grepprg = "rg --vimgrep"

-- Reduce non-essential messages
vim.opt.shortmess:append("I")  -- Hide intro screen
vim.opt.shortmess:append("r")  -- Suppress "reading" messages

-- Folding
-- Show a small fold column to indicate folds
vim.o.foldcolumn = "2"
-- Start with folds mostly open (level 1)
vim.o.foldlevelstart = 1
-- Disable automatic folding by default
vim.o.foldenable = false

-- C indentation options: tune how C-style indentation behaves
vim.o.cinoptions = "+4N,(0,W4"

-- Python path setup: prefer asdf/direnv-managed python3, otherwise fallback to system
local function setup_python_path()
  -- Use asdf shims (which handles direnv automatically)
  if vim.fn.executable("python3") == 1 then
    vim.g.python3_host_prog = "python3"
  else
    -- Fallback to system Python
    vim.g.python3_host_prog = "/usr/bin/python3"
  end
end
setup_python_path()

-- Diagnostic settings: reduce visual noise from diagnostics
vim.diagnostic.config({
  underline = false, -- don't underline diagnostics inline
  -- You can also configure other diagnostic display options here if you want:
  -- virtual_text = false, -- To disable inline messages
  -- signs = false,        -- To disable signs in the gutter
})

-- Better format floating popup windows for things like looking up documentation
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    -- Match floating window background/border to theme for readability
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#282c34" })
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#61afef", bg = "#282c34" })
  end,
})

-- Window title settings: allow terminal/window title to reflect buffer info
vim.o.title = true

-- Neovide settings - Disable animations and fancy effects for minimal, snappy experience
if vim.g.neovide then
  -- Turn off positional and cursor animations for instant feedback
  vim.g.neovide_position_animation_length = 0
  vim.g.neovide_cursor_animation_length = 0.00
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_scroll_animation_far_lines = 0
  vim.g.neovide_scroll_animation_length = 0.00
end
