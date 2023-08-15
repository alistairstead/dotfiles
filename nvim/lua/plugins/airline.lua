return {
  "windwp/windline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("wlsample.airline")
  end,
}
