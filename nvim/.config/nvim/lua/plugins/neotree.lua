return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    {
      "s1n7ax/nvim-window-picker",
    },
  },
  opts = {
    enable_git_status = true,
    enable_diagnostics = false,
    sync_root_with_cwd = false,
    filesystem = {
      use_libuv_file_watcher = true,
      follow_current_file = {
        enabled = true, -- This will find and focus the file in the active buffer every time
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
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "󰜌",
      },
      git_status = {
        symbols = {
          -- Change type
          added = "", -- ", -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified = "◦", -- "", -- or "", but this is redundant info if you use git_status_colors on the name
          deleted = "", -- "◦", -- this can only be used in the git_status source
          renamed = "", -- "", -- this can only be used in the git_status source
          -- Status type
          untracked = "",
          ignored = "",
          unstaged = "",
          staged = "",
          conflict = "",
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
