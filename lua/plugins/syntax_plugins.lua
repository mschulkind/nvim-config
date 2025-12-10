-- =============================================================================
-- SYNTAX PLUGINS
-- =============================================================================
-- Language-specific syntax highlighting and file type support.
-- Provides enhanced syntax highlighting for TypeScript, JSX, JSONC, PostCSS,
-- and JQ files with proper indentation and language-specific features.

return {
  {
    url = "https://github.com/leafgarland/typescript-vim.git",
    ft = { "typescript", "typescriptreact" },
  },
  
  {
    url = "https://github.com/peitalin/vim-jsx-typescript.git",
    ft = { "typescript", "typescriptreact" },
  },
  
  {
    url = "https://github.com/kevinoid/vim-jsonc.git",
    ft = "jsonc",
  },
  
  {
    url = "https://github.com/stephenway/postcss.vim.git",
    ft = { "css", "postcss" },
  },
  
  {
    url = "https://github.com/vito-c/jq.vim.git",
    ft = "jq",
  },
}
