return {
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        color_icons = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        modified_icon = "◦",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        groups = {
          items = {
            require("bufferline.groups").builtin.pinned:with({ icon = "" }),
          },
        },
      },
    },
  },
}
