return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    {
      "s1n7ax/nvim-window-picker",
      opts = {
        show_prompt = true,
        filter_rules = {
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { "NvimTree", "neo-tree", "notify" },
            -- if the buffer type is one of following, the window will be ignored
            buftype = {},
          },
        },
        fg_color = "#EF87BD",
        -- if you have include_current_win == true, then current_win_hl_color will
        -- be highlighted using this background color
        current_win_hl_color = "#454158",
        -- all the windows except the current window will be highlighted using this color
        other_win_hl_color = "#454158",
      },
    },
  },
  opts = {
    enable_git_status = true,
    enable_diagnostics = false,
    sync_root_with_cwd = false,
    filesystem = {
      use_libuv_file_watcher = true,
      follow_current_file = {
        enabled = false, -- This will find and focus the file in the active buffer every time
        --               -- the current file is changed while the tree is open.
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
      git_status = {
        symbols = {
          -- Change type
          added = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
          deleted = "✖", -- this can only be used in the git_status source
          renamed = "", -- this can only be used in the git_status source
          -- Status type
          untracked = "?",
          ignored = "",
          unstaged = "",
          staged = "",
          conflict = "",
        },
      },
    },
    window = {
      mappings = {
        ["l"] = "open",
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
