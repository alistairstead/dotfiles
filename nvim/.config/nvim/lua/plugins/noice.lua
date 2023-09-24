return {
  "folke/noice.nvim",
  opts = {
    presets = {
      bottom_search = false,
      lsp_doc_border = true,
    },
    lsp = {
      progress = {
        enabled = true,
      },
      override = {
        ["cmp.entry.get_documentation"] = true,
      },
    },
    messages = {
      enabled = false,
    },
    routes = {
      {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "written",
        },
        opts = { skip = true },
      },
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
