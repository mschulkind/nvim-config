-- =============================================================================
-- SIMPLE PLUGINS
-- =============================================================================
-- Collection of essential utility plugins for enhanced editing experience.
-- Includes text objects, icons, git signs, scroll behavior, file explorer,
-- commenting, undo tree, buffer management, indentation guides, and whitespace handling.

return {
  {
    url = "https://github.com/wellle/targets.vim.git",
    lazy = false,  -- Load immediately, it's a small vim plugin
  },
  
  {
    url = "https://github.com/lewis6991/gitsigns.nvim.git",
    event = "BufReadPre",  -- Load when opening a file
    after = function()
      require("gitsigns").setup({
        -- signs = { add = { text = "+" }, change = { text = "~" }, delete = { text = "_" } },
        -- numhl = false,  -- Enable line number highlighting
        current_line_blame = true,  -- Enable git blame virtual text on current line
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol',  -- 'eol' | 'overlay' | 'right_align'
          delay = 0,  -- Show instantly (no delay)
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        -- Disable all default keymaps to avoid conflicts
        on_attach = function(bufnr)
          -- Don't set up any keymaps
        end,
      })
      
      -- Set high contrast color for git blame virtual text
      -- Using bright colors for better visibility
      vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', { 
        fg = '#a89984',  -- Gruvbox gray/beige - much more visible
        bg = 'NONE',
        italic = true,
      })
    end,
  },
  
  {
    url = "https://github.com/drzel/vim-scrolloff-fraction.git",
    lazy = false,  -- Small plugin, load immediately
    after = function()
      -- This plugin dynamically adjusts scrolloff based on window height
      vim.g.scrolloff_fraction = 0.20
    end,
  },
  
  {
    url = "https://github.com/jamespeapen/swayconfig.vim.git",
    lazy = false,
    enabled = function()
      return vim.g.vscode ~= 1  -- Only load when not in VSCode
    end,
  },
  
  {
    url = "https://github.com/preservim/nerdcommenter.git",
    beforeAll = function()
      -- Disable default mappings before plugin loads
      -- Must use beforeAll, not before, because NerdCommenter's plugin script
      -- checks these variables when sourced, which may happen before lz.n's
      -- before hook runs
      vim.g.NERDCreateDefaultMappings = 0
      vim.g.NERDCommentMapLeader = ''
    end,
    keys = {
      -- Normal mode: line-based commenting
      { "gcc", "<plug>NERDCommenterComment", desc = "Comment line", silent = true },
      { "gct", "<plug>NERDCommenterToggle", desc = "Toggle comment", silent = true },
      { "gcu", "<plug>NERDCommenterUncomment", desc = "Uncomment line", silent = true },
      
      -- Visual mode: selection-based commenting
      { "gcc", "<plug>NERDCommenterComment", mode = "v", desc = "Comment selection", silent = true },
      { "gct", "<plug>NERDCommenterToggle", mode = "v", desc = "Toggle comment selection", silent = true },
      { "gcu", "<plug>NERDCommenterUncomment", mode = "v", desc = "Uncomment selection", silent = true },
    },
  },
  
  {
    url = "https://github.com/debugloop/telescope-undo.nvim.git",
    enabled = function()
      return vim.g.vscode ~= 1  -- Undo tree conflicts with VSCode's timeline
    end,
    after = function()
      -- Load telescope first if not already loaded
      require("lz.n").trigger_load("telescope.nvim")
      require("telescope").load_extension("undo")
    end,
    keys = {
      { "<F5>", "<cmd>Telescope undo<CR>", desc = "Telescope undo history", silent = true },
    },
  },
  
  {
    url = "https://github.com/echasnovski/mini.bufremove.git",
    version = false,
    keys = {
      { "<leader>k", function() require("mini.bufremove").delete(0, false) end, desc = "Delete buffer", silent = true },
    },
  },
  
  {
    url = "https://github.com/lukas-reineke/indent-blankline.nvim.git",
    event = "BufReadPre",
    after = function()
      -- Load treesitter first if not already loaded
      require("lz.n").trigger_load("nvim-treesitter")
      require("ibl").setup({
        -- indent = { char = "│" },  -- Custom indent character
        -- scope = { enabled = false },  -- Enable scope indicators
      })
    end,
  },
  
  {
    url = "https://github.com/j-hui/fidget.nvim.git",
    event = "LspAttach",  -- Load when LSP attaches
    after = function()
      require("fidget").setup({
        -- notification = { window = { winblend = 0 } },  -- Custom notification window
        -- progress = { suppress_on_insert = false },  -- Suppress progress on insert mode
      })
    end,
  },
  
  {
    url = "https://github.com/ntpeters/vim-better-whitespace.git",
    event = "BufReadPre",
    before = function()
      vim.g.better_whitespace_enabled = 1
      vim.g.strip_whitespace_on_save = 1
      vim.g.strip_whitespace_confirm = 0
      vim.g.better_whitespace_filetypes_blacklist = {
        'diff', 'gitcommit', 'unite', 'qf', 'help', 'markdown', 'text', 'mail'
      }
      vim.g.better_whitespace_skip_empty_lines = 0
    end,
  },

  -- Gemini CLI integration (marcinjahn/gemini-cli.nvim)
  {
    url = "https://github.com/marcinjahn/gemini-cli.nvim.git",
    enabled = function()
      return vim.g.vscode ~= 1  -- don't load in VSCode
    end,
    keys = {
      { "<leader>at", "<cmd>Gemini toggle<cr>", desc = "Toggle Gemini CLI" },
      { "<leader>aa", "<cmd>Gemini ask<cr>", desc = "Ask Gemini", mode = { "n", "v" } },
      { "<leader>af", "<cmd>Gemini add_file<cr>", desc = "Add File" },
    },
    after = function()
      -- Load dependencies first
      require("lz.n").trigger_load({ "plenary.nvim", "snacks.nvim" })
      -- Best-effort setup if the plugin exposes setup()
      local ok, gem = pcall(require, "gemini")
      if ok and type(gem.setup) == "function" then
        pcall(gem.setup, {})
      end
    end,
  },
}