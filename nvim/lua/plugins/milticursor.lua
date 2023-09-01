return {
  "smoka7/multicursors.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "smoka7/hydra.nvim",
  },
  opts = {
    hint_config = false,
  },
  cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
  keys = {
    {
      mode = { "v" },
      "<Leader>m",
      "<cmd>MCstart<cr>",
      desc = "Create a multicursor based on the selection",
    },
  },
}
