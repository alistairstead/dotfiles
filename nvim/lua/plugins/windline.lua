return {
  "windwp/windline.nvim",
  enabled = false,
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    global_skip_filetypes = {
      "NvimTree",
      "lir",
    },
  },
  config = function(_, opts)
    require("wlsample.airline")
  end,
}
