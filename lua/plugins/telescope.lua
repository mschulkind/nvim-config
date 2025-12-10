-- =============================================================================
-- TELESCOPE - FUZZY FINDER
-- =============================================================================
-- Powerful fuzzy finder for files, buffers, and live grep searches.
-- Provides fast file navigation with preview, ripgrep integration,
-- and extensible picker system for enhanced productivity.

return {
  {
    url = "https://github.com/nvim-telescope/telescope.nvim.git",
    after = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      telescope.setup({
        defaults = {
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              preview_width = 0.40,
              width = 0.95,
            },
          },
          mappings = {
            i = {
              ["jj"] = require("telescope.actions").close,
            },
          },
          -- sorting_strategy = "descending",  -- Sort results in descending order
          -- prompt_prefix = "> ",  -- Custom prompt prefix
          -- selection_caret = "> ",  -- Custom selection indicator
          -- file_ignore_patterns = {},  -- Ignore specific patterns
          -- vimgrep_arguments = { "rg", "--vimgrep", "--no-heading" },  -- Custom grep command
        },
        pickers = {
          find_files = {
            hidden = true,
            -- Use ripgrep if available (faster), otherwise fall back to default
            find_command = vim.fn.executable("rg") == 1 and {
              "rg",
              "--files",
              "--hidden",
              "--no-ignore-global",
              "--follow",
              "--glob",
              "!.git/*",
            } or nil,  -- nil = use telescope's default (fd or find)
          },
          buffers = {
            path_display = function(_, path) return path end,
            -- Alt-tab behavior: most recent buffer is first and selected
            sort_mru = true,           -- Sort all buffers by Most Recently Used
            sort_lastused = true,      -- Put cursor on most recently used buffer
          ignore_current_buffer = true,  -- Exclude current buffer from list
          -- Initial mode should be normal (not insert) so fzf doesn't resort immediately
          initial_mode = "normal",
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
      })
 
      -- Try to enable fzf-native if available (provides much faster sorting)
      pcall(telescope.load_extension, "fzf")
    end,
    keys = {
      { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>o", "<cmd>Telescope oldfiles<cr>", desc = "Find old files" },
      {
        "<leader>m",
        function()
          local pickers = require("telescope.pickers")
          local finders = require("telescope.finders")
          local conf = require("telescope.config").values
          local make_entry = require("telescope.make_entry")
          local previewers = require("telescope.previewers")

          local root_result = vim.fn.systemlist({ "git", "rev-parse", "--show-toplevel" })
          if vim.v.shell_error ~= 0 or not root_result[1] or root_result[1] == "" then
            vim.notify("Not inside a git repository", vim.log.levels.ERROR)
            return
          end
          local git_root = root_result[1]

          -- Get files from diff against origin/master
          local diff_output = vim.fn.systemlist({ "git", "diff", "--name-only", "origin/master...HEAD" })
          local diff_status = vim.v.shell_error
          if diff_status ~= 0 then
            local err = diff_output[1] or ("exit code " .. diff_status)
            vim.notify("git diff failed: " .. err, vim.log.levels.ERROR)
            return
          end

          -- Get files from working directory (uncommitted changes and untracked files)
          local status_output = vim.fn.systemlist({ "git", "status", "--porcelain" })
          
          -- Combine all files into a set to avoid duplicates
          local files_set = {}
          for _, path in ipairs(diff_output) do
            if path ~= "" then
              files_set[path] = true
            end
          end
          
          -- Parse git status output and add files
          for _, line in ipairs(status_output) do
            if line ~= "" then
              -- git status --porcelain format: XY filename
              -- Extract filename (skip first 3 characters: status + space)
              local filename = line:sub(4)
              files_set[filename] = true
            end
          end

          -- Convert set to array
          local results = {}
          for path, _ in pairs(files_set) do
            table.insert(results, path)
          end

          if vim.tbl_isempty(results) then
            vim.notify("No changes compared to origin/master or in working directory", vim.log.levels.INFO)
            return
          end

          -- Custom previewer to show git diff
          local diff_previewer = previewers.new_termopen_previewer({
            get_command = function(entry)
              -- First try to show working directory diff (uncommitted changes)
              local status = vim.fn.system({ "git", "diff", "--quiet", "--", entry.value })
              if vim.v.shell_error ~= 0 then
                -- File has uncommitted changes in working directory
                return { "git", "--no-pager", "diff", "HEAD", "--", entry.value }
              end
              
              -- Check if file is untracked
              local ls_files = vim.fn.system({ "git", "ls-files", "--error-unmatch", "--", entry.value })
              if vim.v.shell_error ~= 0 then
                -- File is untracked, show its content
                return { "cat", entry.value }
              end
              
              -- Otherwise show diff against origin/master
              return { "git", "--no-pager", "diff", "origin/master...HEAD", "--", entry.value }
            end,
          })

          pickers.new({ cwd = git_root }, {
            prompt_title = "Diff vs origin/master + Working Directory",
            finder = finders.new_table({
              results = results,
              entry_maker = make_entry.gen_from_file({ cwd = git_root }),
            }),
            sorter = conf.file_sorter({}),
            previewer = diff_previewer,
          }):find()
        end,
        desc = "Diff files vs origin/master + working directory",
      },
    },
  },
}