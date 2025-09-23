-- =============================================================================
-- CORE NEOVIM SETTINGS
-- =============================================================================
-- Basic Neovim options and global settings

-- Leader keys
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- GUI settings
if vim.g.neovide or vim.fn.has('gui_running') == 1 then
  vim.o.guifont = vim.g.guifont or "Inconsolata Nerd Font:h14:b"
end
vim.o.number = true

-- Display and UI
vim.o.scrolloff = 3
vim.o.cursorline = true

-- Editing behavior
vim.o.textwidth = 100
vim.o.formatoptions = "ro" -- Remove 't', add 'r' and 'o'
vim.o.joinspaces = false
vim.o.wrap = true
vim.o.backupcopy = "yes" -- Fix guard/gulp issues

-- Search and command line
vim.o.wildmode = "longest,list"
vim.o.wildignore = "*/_site/*,*/*.class,*/.git/*,*.swp,*/.AppleDouble/*,*/target/*,*/out/*,*/public/assets/*,*/node_modules/*,*/bower_components/*,*/dist/*,*/COMPILED/*,*/__pycache__*,*.pyc"
vim.o.grepprg = "rg --vimgrep"
-- Prevent hit-enter prompts during startup, re-enable after VimEnter
vim.o.more = false

-- Reduce non-essential messages
vim.opt.shortmess:append("I")  -- Hide intro screen
vim.opt.shortmess:append("r")  -- Suppress "reading" messages

-- Folding
vim.o.foldcolumn = "2"
vim.o.foldlevelstart = 1
vim.o.foldenable = false

-- C indentation options
vim.o.cinoptions = "+4N,(0,W4"

-- Python path setup
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

-- Diagnostic settings
vim.diagnostic.config({
  underline = false,
  -- You can also configure other diagnostic display options here if you want:
  -- virtual_text = false, -- To disable inline messages
  -- signs = false,        -- To disable signs in the gutter
})

-- Better format floating popup windows for things like lookup up documentation
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#282c34" })
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#61afef", bg = "#282c34" })
  end,
})

-- Window title settings
vim.o.title = true

-- Re-enable hit-enter prompts after startup (optional - keeps more behavior for normal use)
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.o.more = true
  end,
})

-- Neovide settings - Disable animations and fancy effects for minimal, snappy experience
if vim.g.neovide then
  vim.g.neovide_position_animation_length = 0
  vim.g.neovide_cursor_animation_length = 0.00
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_scroll_animation_far_lines = 0
  vim.g.neovide_scroll_animation_length = 0.00
end
