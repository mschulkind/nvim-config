-- =============================================================================
-- CLIPBOARD INTEGRATION
-- =============================================================================
-- System clipboard integration for Wayland and X11

if vim.env.WAYLAND_DISPLAY and vim.fn.executable("wl-copy") == 1 and vim.fn.executable("wl-paste") == 1 then
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
