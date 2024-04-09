return {
  "TobinPalmer/rayso.nvim",
  cmd = { "Rayso" },
  config = function()
    require("rayso").setup({
      options = {
        theme = "breeze",
      },
    })
  end,
  keys = {
    { "<leader>cs", "<cmd>Rayso<cr>", desc = "Screenshot code", mode = { "v" } },
  },
}
