-- =============================================================================
-- AUTOCMDS
-- =============================================================================
-- Auto commands and file type specific configurations organized by category

-- =============================================================================
-- FILE OPERATIONS
-- =============================================================================

-- Auto-create directories on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("FileOperations", { clear = true }),
  callback = function(event)
    local file = event.match
    local dir = vim.fn.fnamemodify(file, ":h")
    
    -- Skip if it's a URL or already exists
    if file:match("^%w+://") or vim.fn.isdirectory(dir) == 1 then
      return
    end
    
    -- Create directory
    vim.fn.mkdir(dir, "p")
  end,
})

-- =============================================================================
-- WINDOW TITLE MANAGEMENT
-- =============================================================================

-- Window title management (combined VimResized and VimEnter)
local function title_string()
  local cwd = vim.fn.getcwd()
  local home = vim.fn.expand("~")
  -- Show path relative to home (generic across users)
  return cwd:gsub("^" .. vim.pesc(home) .. "/", "")
end

local function update_title()
  vim.o.titlestring = title_string() .. " - %t"
end

vim.api.nvim_create_autocmd({ "VimResized", "VimEnter" }, {
  group = vim.api.nvim_create_augroup("WindowTitle", { clear = true }),
  callback = update_title,
})

-- =============================================================================
-- KEYMAP MANAGEMENT
-- =============================================================================

-- Command window keymap management (simplified)
vim.api.nvim_create_autocmd({ "CmdWinEnter", "CmdWinLeave" }, {
  group = vim.api.nvim_create_augroup("CommandWindow", { clear = true }),
  callback = function(event)
    if event.event == "CmdWinEnter" then
      vim.keymap.del("n", "<CR>", { buffer = 0 })
    else -- CmdWinLeave
      vim.keymap.set("n", "<CR>", "O<Esc>j", { silent = true })
    end
  end,
})

-- =============================================================================
-- FILE TYPE SPECIFIC
-- =============================================================================

-- Quickfix window keymaps
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("FileTypeQuickfix", { clear = true }),
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "<CR>", "<CR>", { buffer = true })
  end,
})

-- Text files configuration
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("FileTypeText", { clear = true }),
  pattern = "text",
  callback = function()
    vim.bo.wrapmargin = 0
    vim.wo.spell = false
  end,
})

-- Git (Fugitive) buffer settings
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = vim.api.nvim_create_augroup("FileTypeGit", { clear = true }),
  pattern = "fugitive://*",
  callback = function()
    vim.bo.bufhidden = "delete"
  end,
})
