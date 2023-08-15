return {
  "folke/noice.nvim",
  opts = {
    presets = {
      bottom_search = false,
    },
    cmdline = {
      format = {
        cmdline = { icon = ">_" },
        search_down = { icon = "⌄" },
        search_up = { icon = "⌃" },
        filter = { icon = "$" },
        lua = { icon = "" },
        help = { icon = "?" },
      },
    },
    format = {
      level = {
        icons = {
          error = "",
          warn = "",
          info = "",
        },
      },
    },
    popupmenu = {
      kind_icons = false,
    },
    inc_rename = {
      cmdline = {
        format = {
          IncRename = { icon = "" },
        },
      },
    },
    views = {
      cmdline_popup = {
        position = {
          row = 5,
          col = "50%",
        },
        size = {
          width = 60,
          height = "auto",
        },
      },
      popupmenu = {
        relative = "editor",
        position = {
          row = 8,
          col = "50%",
        },
        size = {
          width = 60,
          height = 10,
        },
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
        },
      },
    },
  },
}
