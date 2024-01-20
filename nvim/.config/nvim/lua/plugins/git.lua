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
      auto_show_console = true,
      disable_insert_on_commit = false,
      integrations = {
        diffview = true,
      },
    },
    keys = {
      { "<leader>gc", "<cmd>lua require('neogit').open({'commit'})<CR>", desc = "Git commit" },
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
  {
    "ThePrimeagen/git-worktree.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
        config = function()
          require("telescope").load_extension("git_worktree")
        end,
      },
    },
    keys = {
      {
        "<leader>gw",
        function()
          require("telescope").extensions.git_worktree.git_worktrees()
        end,
        desc = "Worktree switch and delete <c-d>",
      },
      {
        "<leader>gW",
        function()
          require("telescope").extensions.git_worktree.create_git_worktree()
        end,
        desc = "Worktree create",
      },
    },
  },
  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {},
  },
}
