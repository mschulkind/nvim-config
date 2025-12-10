-- =============================================================================
-- CLIPBOARD INTEGRATION
-- =============================================================================
-- System clipboard integration for Wayland and X11

-- Check for Wayland or running in WezTerm on Wayland
-- WezTerm may not pass WAYLAND_DISPLAY, so also check for WezTerm + wl-paste
local is_wayland = vim.env.WAYLAND_DISPLAY ~= nil
local has_wl_tools = vim.fn.executable("wl-copy") == 1 and vim.fn.executable("wl-paste") == 1
local is_wezterm = vim.env.WEZTERM_PANE ~= nil

-- Use Wayland clipboard tools if available (handles WezTerm on Wayland)
if has_wl_tools and (is_wayland or is_wezterm) then
  vim.g.clipboard = {
    name = "myClipboard",
    copy = {
      ["+"] = {"wl-copy", "--foreground"},
      ["*"] = {"wl-copy", "--foreground"},
    },
    paste = {
      ["+"] = {"wl-paste", "--no-newline"},
      ["*"] = {"wl-paste", "--no-newline"},
    },
    cache_enabled = 1,
  }
end
