-- =============================================================================
-- SIMPLE PLUGINS
-- =============================================================================
-- Collection of essential utility plugins for enhanced editing experience.
-- Includes text objects, icons, git signs, scroll behavior, file explorer,
-- commenting, undo tree, buffer management, indentation guides, and whitespace handling.

return {
  {
    "wellle/targets.vim",
  },
  
  {
    "lewis6991/gitsigns.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("gitsigns").setup({
        -- signs = { add = { text = "+" }, change = { text = "~" }, delete = { text = "_" } },
        -- numhl = false,  -- Enable line number highlighting
      })
    end,
  },
  
  {
    "drzel/vim-scrolloff-fraction",
    config = function()
      -- This plugin dynamically adjusts scrolloff based on window height
      vim.g.scrolloff_fraction = 0.20
    end,
  },
  
  {
    "jamespeapen/swayconfig.vim",
    cond = function()
      return vim.g.vscode ~= 1  -- Only load when not in VSCode
    end,
  },
  
  {
    "scrooloose/nerdcommenter",
    config = function()
      vim.g.NERDCreateDefaultMappings = 0
    end,
    keys = {
      { "gcc", "<plug>NERDCommenterComment", desc = "Comment line", silent = true },
      { "gct", "<plug>NERDCommenterToggle", desc = "Toggle comment", silent = true },
      { "gcu", "<plug>NERDCommenterUncomment", desc = "Uncomment line", silent = true },
    },
  },
  
  {
    "debugloop/telescope-undo.nvim",
    cond = function()
      return vim.g.vscode ~= 1  -- Undo tree conflicts with VSCode's timeline
    end,
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("undo")
    end,
    keys = {
      { "<F5>", "<cmd>Telescope undo<CR>", desc = "Telescope undo history", silent = true },
    },
  },
  
  {
    "nvim-mini/mini.bufremove",
    version = false,
    keys = {
      { "<leader>k", function() require("mini.bufremove").delete(0, false) end, desc = "Delete buffer", silent = true },
    },
  },
  
  {
    "lukas-reineke/indent-blankline.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("ibl").setup({
        -- indent = { char = "│" },  -- Custom indent character
        -- scope = { enabled = false },  -- Enable scope indicators
      })
    end,
  },
  
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({
        -- notification = { window = { winblend = 0 } },  -- Custom notification window
        -- progress = { suppress_on_insert = false },  -- Suppress progress on insert mode
      })
    end,
  },
  
  {
    "ntpeters/vim-better-whitespace",
    config = function()
      vim.g.better_whitespace_enabled = 1
      vim.g.strip_whitespace_on_save = 1
      vim.g.strip_whitespace_confirm = 0
      vim.g.better_whitespace_filetypes_blacklist = { 
        'diff', 'gitcommit', 'unite', 'qf', 'help', 'markdown', 'text', 'mail'
      }
      vim.g.better_whitespace_skip_empty_lines = 0
    end,
  },
}