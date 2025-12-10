-- =============================================================================
-- LZ.N - LAZY LOADING LIBRARY
-- =============================================================================
-- Dead simple lazy-loading for Neovim plugins.
-- This plugin needs to be loaded eagerly (not lazy) since it manages all other plugins.

return {
  {
    url = "https://github.com/lumen-oss/lz.n.git",
    -- This must NOT be lazy-loaded since it's the lazy-loader itself
    lazy = false,
  },
}
