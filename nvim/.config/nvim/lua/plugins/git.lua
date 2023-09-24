return {
  {
    "TimUntersberger/neogit",
    -- event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    opts = {
      console_timeout = 20000,
      disable_commit_confirmation = true,
      auto_show_console = false,
      disable_insert_on_commit = false,
      integrations = {
        diffview = true,
      },
    },
    keys = {
      {
        "<leader>gg",
        function()
          require("neogit").open()
        end,
        desc = "Neogit",
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    -- event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
      "DiffviewFileHistory",
    },
    keys = { { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" } },
  },
}
