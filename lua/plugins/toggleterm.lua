-- =============================================================================
-- TOGGLETERM
-- =============================================================================
-- Terminal management plugin for Neovim with easy toggling and custom keybindings

return {
  {
    url = "https://github.com/akinsho/toggleterm.nvim.git",
    keys = {
      { "<leader>t", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal", silent = true },
    },
    after = function()
      require("toggleterm").setup({
        -- Size of terminal window
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        
        -- Open terminal at the bottom
        direction = "horizontal",
        
        -- Close terminal window when process exits
        close_on_exit = true,
        
        -- Hide the number column in terminal buffers
        hide_numbers = true,
        
        -- Start terminal in insert mode
        start_in_insert = true,
        
        -- Disable persist_mode to allow automatic insert mode entry
        -- persist_mode = true conflicts with always entering insert mode
        persist_mode = false,
        
        -- Shade terminal background slightly
        shade_terminals = true,
        shading_factor = 2,
        
        -- Use shell from $SHELL environment variable
        shell = vim.o.shell,
        
        -- Keybindings for terminal mode
        -- kk to exit to normal mode (stay in terminal)
        -- jj to close/hide the terminal entirely (from both insert and normal mode)
        on_open = function(term)
          -- Set terminal-specific keymaps
          local opts = { buffer = term.bufnr }
          -- Terminal insert mode mappings
          vim.keymap.set("t", "kk", [[<C-\><C-n>]], opts)
          vim.keymap.set("t", "jj", [[<C-\><C-n><cmd>ToggleTerm<cr>]], opts)
          vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
          
          -- Terminal normal mode mapping - jj to close terminal
          vim.keymap.set("n", "jj", "<cmd>ToggleTerm<cr>", opts)
        end,
        
        -- Use TermEnter autocmd to reliably enter insert mode every time
        on_create = function(term)
          vim.api.nvim_create_autocmd("TermEnter", {
            buffer = term.bufnr,
            callback = function()
              vim.cmd("startinsert")
            end,
          })
        end,
      })
    end,
  },
}
