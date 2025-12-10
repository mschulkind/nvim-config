-- =============================================================================
-- BUFFER MRU TRACKING
-- =============================================================================
-- Track buffer access order for true MRU (Most Recently Used) behavior
-- This maintains a global list of buffers in the order they were last accessed

local M = {}

-- Store buffer order (most recent first)
M.buffer_history = {}

-- Track buffer access
local function track_buffer()
  local bufnr = vim.api.nvim_get_current_buf()
  
  -- Only track normal buffers (not special buffers)
  if vim.bo[bufnr].buftype ~= "" then
    return
  end
  
  -- Remove buffer from history if it exists
  for i, b in ipairs(M.buffer_history) do
    if b == bufnr then
      table.remove(M.buffer_history, i)
      break
    end
  end
  
  -- Add to front of history
  table.insert(M.buffer_history, 1, bufnr)
  
  -- Keep history size reasonable (last 100 buffers)
  if #M.buffer_history > 100 then
    table.remove(M.buffer_history)
  end
end

-- Remove deleted buffers from history
local function remove_buffer(bufnr)
  for i, b in ipairs(M.buffer_history) do
    if b == bufnr then
      table.remove(M.buffer_history, i)
      break
    end
  end
end

-- Setup autocmds to track buffer usage
function M.setup()
  local augroup = vim.api.nvim_create_augroup("BufferMRU", { clear = true })
  
  -- Track when entering a buffer
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    group = augroup,
    callback = track_buffer,
  })
  
  -- Remove from history when buffer is deleted
  vim.api.nvim_create_autocmd("BufDelete", {
    group = augroup,
    callback = function(args)
      remove_buffer(args.buf)
    end,
  })
end

-- Get MRU sorted buffers for telescope
function M.get_mru_buffers()
  local valid_buffers = {}
  local current_buf = vim.api.nvim_get_current_buf()
  
  -- Add buffers from history in MRU order, skipping current buffer
  for _, bufnr in ipairs(M.buffer_history) do
    if vim.api.nvim_buf_is_valid(bufnr) and bufnr ~= current_buf then
      table.insert(valid_buffers, bufnr)
    end
  end
  
  return valid_buffers
end

return M
