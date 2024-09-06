return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    {
      "s1n7ax/nvim-window-picker",
    },
  },
  opts = {
    open_files_do_not_replace_types = { "edgy" },
    enable_git_status = true,
    enable_diagnostics = true,
    sync_root_with_cwd = false,
    -- source_selector = {
    --   winbar = true,
    --   statusline = true,
    -- },
    filesystem = {
      use_libuv_file_watcher = true,
      follow_current_file = {
        enabled = true, -- This will find and focus the file in the active buffer every time
        leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      },
    },
    update_focused_file = {
      enable = true,
      update_root = false,
    },
    default_component_configs = {
      indent = {
        indent_marker = " ",
        last_indent_marker = " ",
      },
      name = {
        use_git_status_colors = false,
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
      },
      git_status = {
        symbols = {
          -- Change type
          added = "", -- ", -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified = "◦", -- "", -- or "", but this is redundant info if you use git_status_colors on the name
          deleted = "", -- "◦", -- this can only be used in the git_status source
          renamed = "", -- "", -- this can only be used in the git_status source
          -- Status type
          untracked = "◦",
          ignored = "",
          unstaged = "",
          staged = "",
          conflict = "",
        },
      },
      event_handlers = {
        {
          event = "file_opened",
          handler = function(file_path)
            -- auto close
            -- vimc.cmd("Neotree close")
            -- OR
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
        {
          event = "neo_tree_buffer_enter",
          handler = function()
            vim.cmd("highlight! Cursor blend=100")
          end,
        },
        {
          event = "neo_tree_buffer_leave",
          handler = function()
            vim.cmd("highlight! Cursor guibg=#5f87af blend=0")
          end,
        },
      },
    },
    window = {
      mappings = {
        ["e"] = function()
          vim.api.nvim_exec("Neotree focus filesystem left", true)
        end,
        ["b"] = function()
          vim.api.nvim_exec("Neotree focus buffers left", true)
        end,
        ["g"] = function()
          vim.api.nvim_exec("Neotree focus git_status left", true)
        end,
        ["l"] = "open",
        ["L"] = "open_with_window_picker",
        ["o"] = "open_with_window_picker",
        ["h"] = "close_node",
        ["S"] = "split_with_window_picker",
        ["s"] = "open_split",
        ["V"] = "vsplit_with_window_picker",
        ["v"] = "open_vsplit",
      },
    },
  },
}
