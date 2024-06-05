return {
  {
    "s1n7ax/nvim-window-picker",
    main = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    -- commit = "6e98757",
    opts = {
      hint = "statusline-winbar",
      show_prompt = true,
      selection_chars = "dfghjkl;",
      filter_rules = {
        -- filter using buffer options
        bo = {
          -- if the file type is one of following, the window will be ignored
          filetype = { "NvimTree", "neo-tree", "notify", "edgy" },
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
}
