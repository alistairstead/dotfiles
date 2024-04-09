return {
  "ecthelionvi/NeoComposer.nvim",
  dependencies = {
    "kkharji/sqlite.lua",
    {
      "nvim-telescope/telescope.nvim",
      keys = function()
        require("telescope").load_extension("macros")
        return {
          { "<leader>fm", "<cmd>Telescope macros<cr>", desc = "Find macros" },
        }
      end,
    },
  },
  opts = {},
  keys = function()
    local wk = require("which-key")

    wk.register({
      m = {
        name = "+MacroComposer",
      },
    }, {
      prefix = "<leader>",
      mode = { "v", "n" },
    })
    return {
      {
        "<leader>mr",
        "<cmd>lua require('NeoComposer.ui').toggle_record()<cr>",
        desc = "Record macro",
      },
      {
        "<leader>mm",
        "<cmd>lua require('NeoComposer.ui').toggle_macro_menu()<cr>",
        desc = "Macro menu",
      },
    }
  end,
}
