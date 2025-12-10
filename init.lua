-- =============================================================================
-- NEOVIM CONFIGURATION - MAIN ENTRY POINT
-- =============================================================================
-- Disable --More-- prompts for long messages. In particular the first startup
-- treesitter parser installation. 
vim.o.more = false 

-- Enable autoloading for better performance (Neovim 0.9+)
vim.loader.enable()

-- Ensure config directory is in runtimepath so lua/ modules can be required
vim.opt.rtp:prepend(vim.fn.stdpath("config"))

-- Load LSP handlers early so global handlers (like definition jump handlers)
-- are registered before any LSP servers attach. Use pcall to avoid errors
-- during early startup if the module isn't present yet.
pcall(function() require("lsp.handlers") end)
-- Faster file change detection (250ms)
vim.o.updatetime = 250

-- Search settings
vim.o.ignorecase = true  -- Ignore case in searches
vim.o.smartcase = true   -- Override ignorecase if search contains uppercase

-- Load core configurations
-- Leader keys: primary and local leader used for user mappings. must be before
-- plugins load.
vim.g.mapleader = ","
vim.g.maplocalleader = ","

require("core.autocmds")
require("core.keymaps")
require("core.clipboard")

-- Load utility modules
require("utils.movement").setup()

-- Load plugin configurations
require("lib.plugin_manager_lzn").setup()

-- =============================================================================
-- CORE NEOVIM SETTINGS
-- =============================================================================
-- Basic Neovim options and global settings

-- GUI settings: set GUI font when running in Neovide or a GUI frontend
if vim.g.neovide or vim.fn.has('gui_running') == 1 then
  vim.o.guifont = vim.g.guifont or "Inconsolata Nerd Font:h14:b"
end

-- Enable true color support (24-bit RGB colors)
vim.o.termguicolors = true

-- Show absolute line numbers in the gutter
vim.o.number = true

-- Display and UI
-- Keep at least 3 lines visible above/below the cursor
vim.o.scrolloff = 3
-- Highlight the current line for easier tracking
vim.o.cursorline = true

-- Editing behavior
-- Disable automatic hard wrapping: do not insert line breaks automatically when typing
vim.o.textwidth = 0
-- Remove 't' and 'a' from formatoptions to prevent automatic wrapping and auto-paragraph formatting;
-- keep 'r' and 'o' so comment leaders continue on new lines.
vim.opt.formatoptions:remove("t")
vim.opt.formatoptions:remove("a")
vim.opt.formatoptions:append("ro")
-- Don't insert two spaces after a period when joining sentences
vim.o.joinspaces = false

-- Visual tab/indent settings: show and use 2-space tabs
vim.o.tabstop = 2            -- visual width of a TAB
vim.o.shiftwidth = 2         -- indentation amount for >>, << and autoindent
vim.o.softtabstop = 2        -- number of spaces a <Tab> counts for while editing
vim.o.expandtab = true       -- use spaces instead of literal TABs

-- Enable line wrapping visually
vim.o.wrap = true
-- Prefer wrapping at word boundaries (whitespace) and display wrapped lines cleanly
vim.o.linebreak = true
vim.o.breakat = " \t"                 -- only break on spaces/tabs (word boundaries)
vim.o.breakindent = true              -- keep visual indent for wrapped lines
vim.o.breakindentopt = "shift:2,min:20"
vim.o.showbreak = "↪ "                -- visual prefix for wrapped continuation lines
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

-- Diagnostic settings: show diagnostics in floating window on hover
vim.diagnostic.config({
  underline = false,    -- don't underline diagnostics inline
  virtual_text = false, -- disable inline messages (use floating window instead)
  signs = true,         -- keep signs in the gutter
})

-- Show diagnostics automatically in floating window when hovering
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  callback = function()
    vim.diagnostic.open_float(nil, {
      focus = false,
      border = "rounded",
      source = "always",  -- Always show the source (e.g., "eslint", "typescript")
    })
  end,
})

-- Better format floating popup windows for things like looking up documentation
-- and diagnostics with improved contrast
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    -- Diagnostic float with darker background for better contrast
    -- Using gruvbox dark colors for consistency
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1d2021" })  -- Darker than buffer bg (#282828)
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#fe8019", bg = "#1d2021" })  -- Orange border
    
    -- Optional: Make diagnostic messages more visible in the float
    vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { fg = "#fb4934", bg = "#1d2021" })  -- Bright red
    vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { fg = "#fabd2f", bg = "#1d2021" })   -- Bright yellow
    vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", { fg = "#83a598", bg = "#1d2021" })   -- Bright blue
    vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", { fg = "#8ec07c", bg = "#1d2021" })   -- Bright aqua
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
