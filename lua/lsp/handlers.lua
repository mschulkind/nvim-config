-- =============================================================================
-- LSP HANDLERS
-- =============================================================================
-- Shared LSP setup: on_attach callback and capabilities.
-- This module is used by mason.lua to configure all installed servers.

local M = {}

-- Configure diagnostics to display source (linter/server name)
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    source = "always",  -- Always show which linter/server reported the error
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Helper: create a handler that opens definition results in a split
function M.get_definition_handler(split_cmd)
  local util = vim.lsp.util
  local log = require("vim.lsp.log")
  local api = vim.api

  local handler = function(err, result, ctx, _)
    if err then
      local _ = log.error() and log.error(ctx.method, err)
      return
    end
    if result == nil or vim.tbl_isempty(result) then
      local _ = log.info() and log.info(ctx.method, "No location found")
      return nil
    end

    -- Get the first location (whether result is single location or list)
    local location = vim.islist(result) and result[1] or result
    
    -- Always create split (even for same file)
    if split_cmd then
      vim.cmd(split_cmd)
    end

    -- Jump to the location
    util.jump_to_location(location, "utf-8")
    
    -- If multiple results, open quickfix list
    if vim.islist(result) and #result > 1 then
      vim.fn.setqflist(util.locations_to_items(result, "utf-8"))
      api.nvim_command("copen")
      api.nvim_command("wincmd p")
    end
  end

  return handler
end

-- Install global handler: open definitions in a horizontal split by default
vim.lsp.handlers["textDocument/definition"] = M.get_definition_handler("split")

-- on_attach is called when an LSP server attaches to a buffer
M.on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Buffer-local mappings
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- Goto definition in horizontal split
  vim.keymap.set("n", "gd", function()
    -- Request definition from LSP and invoke handler
    local params = vim.lsp.util.make_position_params(0, "utf-8")
    vim.lsp.buf_request(bufnr, "textDocument/definition", params, function(err, result, ctx, config)
      local handler = vim.lsp.handlers["textDocument/definition"]
      if handler then
        handler(err, result, ctx, config)
      end
    end)
  end, vim.tbl_extend("force", opts, { desc = "Goto definition (split)" }))
  
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Goto declaration" }))
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Goto implementation" }))
  vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Goto references" }))

  -- Hover
  vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover" }))

  -- Code actions
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))

  -- Rename
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename" }))
end

-- capabilities enhanced with cmp_nvim_lsp if available
M.capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if ok_cmp and cmp_nvim_lsp and cmp_nvim_lsp.default_capabilities then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  end
  return capabilities
end

return M
