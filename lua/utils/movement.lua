-- =============================================================================
-- MOVEMENT UTILITIES
-- =============================================================================
-- Physical line mode functions and movement helpers

local M = {}

-- Screen movement function for wrapped lines
function M.screen_movement(movement)
  if vim.o.wrap then
    return "g" .. movement
  else
    return movement
  end
end

-- Insert mode screen movement
function M.insert_mode_screen_movement(movement, up)
  if vim.bo.filetype == "fuf" then
    return movement
  else
    return "<C-O>" .. M.screen_movement(movement)
  end
end

-- Map screen movement key
function M.map_screen_movement_key(key)
  vim.keymap.set("o", key, function() return M.screen_movement(key) end, { expr = true, silent = true })
  vim.keymap.set("n", key, function() return M.screen_movement(key) end, { expr = true, silent = true })
end

-- Setup all screen movement mappings
function M.setup()
  -- Apply screen movement mappings
  M.map_screen_movement_key("j")
  M.map_screen_movement_key("k")
  M.map_screen_movement_key("0")
  M.map_screen_movement_key("^")
  M.map_screen_movement_key("$")
  M.map_screen_movement_key("<Up>")
  M.map_screen_movement_key("<Down>")
  vim.keymap.set("i", "<Up>", function() return M.insert_mode_screen_movement("<Up>", "<Up>") end, { expr = true, silent = true })
  vim.keymap.set("i", "<Down>", function() return M.insert_mode_screen_movement("<Down>", "<Up>") end, { expr = true, silent = true })
end

return M
