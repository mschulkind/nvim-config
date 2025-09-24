-- =============================================================================
-- KEYMAPPINGS
-- =============================================================================
-- All custom key mappings and shortcuts organized by category

-- =============================================================================
-- TEXT EDITING
-- =============================================================================

-- Quick insertion of a newline
vim.keymap.set("n", "<CR>", "O<Esc>j", { silent = true, desc = "Insert newline above" })

-- Quick clearing of a line
vim.keymap.set("n", "<DEL>", "cc<Esc>", { silent = true, desc = "Clear current line" })

-- Select the previously pasted text
vim.keymap.set("n", "gp", "'[v']", { silent = true, desc = "Select pasted text" })

-- Escape alternatives
vim.keymap.set("i", "jj", "<esc>", { silent = true, desc = "Escape insert mode" })
vim.keymap.set("c", "jj", "<c-c>", { silent = true, desc = "Cancel command" })

-- Disable Ctrl-C to avoid accidental interruption
vim.keymap.set("c", "<c-c>", "<Nop>", { silent = true, desc = "Disable Ctrl-C" })
vim.keymap.set("i", "<c-c>", "<Nop>", { silent = true, desc = "Disable Ctrl-C" })

-- Folding - Make open/close recursive by default
vim.keymap.set("n", "zo", "zO", { silent = true, desc = "Open fold recursively" })
vim.keymap.set("n", "zO", "zo", { silent = true, desc = "Open fold" })

-- =============================================================================
-- FILE OPERATIONS
-- =============================================================================

-- Save shortcuts
vim.keymap.set("n", "<C-S>", ":w<CR>", { silent = true, desc = "Save file" })
vim.keymap.set("i", "<C-S>", "<C-O>:w<CR>", { silent = true, desc = "Save file" })

-- For when we forget to use sudo to open/edit a file
vim.keymap.set("c", "w!!", "w !sudo tee % >/dev/null", { silent = true, desc = "Save with sudo" })

-- Configuration file access
vim.keymap.set("n", "<leader>v", function()
  vim.cmd("sp " .. vim.fn.stdpath("config") .. "/init.lua")
  vim.cmd("<C-W>_")
end, { silent = true, desc = "Open config file" })

vim.keymap.set("n", "<leader>V", function()
  vim.cmd("source " .. vim.fn.stdpath("config") .. "/init.lua")
  vim.cmd("filetype detect")
  vim.cmd("echo 'init.lua reloaded'")
end, { silent = true, desc = "Reload config" })

-- Buffer switching with Telescope (MRU sorted)
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>", { silent = true, desc = "Switch buffers (MRU sorted)" })

-- =============================================================================
-- NAVIGATION
-- =============================================================================

-- Navigate splits with Ctrl-hjkl
vim.keymap.set("n", "<c-h>", "<c-w>h", { silent = true, desc = "Move to left window" })
vim.keymap.set("n", "<c-j>", "<c-w>j", { silent = true, desc = "Move to bottom window" })
vim.keymap.set("n", "<c-k>", "<c-w>k", { silent = true, desc = "Move to top window" })
vim.keymap.set("n", "<c-l>", "<c-w>l", { silent = true, desc = "Move to right window" })

-- Make Ctrl-hjkl work in insert mode as well
vim.keymap.set("i", "<c-h>", "<c-o><c-h>", { silent = true, desc = "Move to left window" })
vim.keymap.set("i", "<c-j>", "<c-o><c-j>", { silent = true, desc = "Move to bottom window" })
vim.keymap.set("i", "<c-k>", "<c-o><c-k>", { silent = true, desc = "Move to top window" })
vim.keymap.set("i", "<c-l>", "<c-o><c-l>", { silent = true, desc = "Move to right window" })

-- Move windows left or right
vim.keymap.set("n", "<a-Left>", "<c-w>h<c-w>x", { silent = true, desc = "Move window left" })
vim.keymap.set("n", "<a-Right>", "<c-w>x<c-l>", { silent = true, desc = "Move window right" })
vim.keymap.set("i", "<a-Left>", "<c-h><c-o><c-w>x", { silent = true, desc = "Move window left" })
vim.keymap.set("i", "<a-Right>", "<c-o><a-Right>", { silent = true, desc = "Move window right" })

-- Tag navigation
vim.keymap.set("n", "<C-Y>", "<C-]>", { silent = true, desc = "Go to tag" })

-- =============================================================================
-- QUICKFIX AND LOCATION LISTS
-- =============================================================================

-- Quickfix window shortcuts
local function open_quickfix()
  vim.cmd("botright copen 20")
end
vim.keymap.set("n", "<leader>c", open_quickfix, { silent = true, desc = "Open quickfix" })
vim.keymap.set("n", "<leader>cc", ":cclose<CR>", { silent = true, desc = "Close quickfix" })
vim.keymap.set("n", "<leader>cn", ":cn<CR>", { silent = true, desc = "Next quickfix item" })
vim.keymap.set("n", "<leader>cp", ":cp<CR>", { silent = true, desc = "Previous quickfix item" })

-- Location list
vim.keymap.set("n", "<leader>l", ":lopen<CR>", { silent = true, desc = "Open location list" })
vim.keymap.set("n", "<leader>ll", ":lclose<CR>", { silent = true, desc = "Close location list" })
vim.keymap.set("n", "<C-F2>", ":lp<CR>", { silent = true, desc = "Previous location item" })
vim.keymap.set("n", "<C-F3>", ":lne<CR>", { silent = true, desc = "Next location item" })

-- =============================================================================
-- BUILD AND COMPILATION
-- =============================================================================

-- Emacs-style shortcuts
vim.keymap.set("n", "<F10>", function()
  vim.cmd("make")
  open_quickfix()
end, { silent = true, desc = "Make and show quickfix" })
vim.keymap.set("i", "<F10>", "<ESC><F10>", { silent = true, desc = "Make and show quickfix" })
vim.keymap.set("n", "<F2>", ":cp<CR>", { silent = true, desc = "Previous quickfix item" })
vim.keymap.set("n", "<F3>", ":cn<CR>", { silent = true, desc = "Next quickfix item" })

-- =============================================================================
-- REGISTERS AND CLIPBOARD
-- =============================================================================

-- Register management
vim.keymap.set("n", "<leader>r", ":registers<CR>", { silent = true, desc = "Show registers" })
for i = 0, 9 do
  vim.keymap.set("n", "<leader>" .. i, '"' .. i .. 'p', { silent = true, desc = "Paste register " .. i })
end

-- =============================================================================
-- SEARCH AND HIGHLIGHTING
-- =============================================================================

-- Turn off search highlighting
vim.keymap.set("n", "<C-N>", ":silent noh<CR>", { silent = true, desc = "Clear search highlight" })

-- =============================================================================
-- COMMAND LINE
-- =============================================================================

-- Command line editing (emacs-style)
vim.keymap.set("c", "<C-A>", "<Home>", { silent = true, desc = "Go to beginning of line" })
vim.keymap.set("c", "<C-E>", "<End>", { silent = true, desc = "Go to end of line" })

-- =============================================================================
-- TERMINAL
-- =============================================================================

-- Terminal key mappings
vim.keymap.set("n", "<ESC>[1;5D", "<C-Left>", { silent = true, desc = "Terminal Ctrl-Left" })
vim.keymap.set("n", "<ESC>[1;5C", "<C-Right>", { silent = true, desc = "Terminal Ctrl-Right" })

-- =============================================================================
-- LSP
-- =============================================================================

-- LSP Hover
vim.keymap.set("n", "K", function()
  vim.lsp.buf.hover({ border = "single" }) -- or 'rounded', 'double', 'solid'
end, { desc = "LSP Hover (with border)" })

-- =============================================================================
-- PLUGIN MANAGEMENT
-- =============================================================================

-- Lazy interface (only if using Lazy.nvim)
if vim.g.PLUGIN_MANAGER == "lazy" then
  vim.keymap.set("n", "<leader>L", ":Lazy<CR>", { silent = true, desc = "Open Lazy interface" })
end
