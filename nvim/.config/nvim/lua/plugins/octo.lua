return {
  {
    "pwntester/octo.nvim",
    lazy = true,
    cmd = "Octo",
    config = function()
      -- the 'op.api' module provides the same interface as the CLI
      -- each subcommand accepts a list of arguments
      -- and returns a list of output lines.
      -- use it to retrieve the GitHub access token from 1Password
      local github_token = require("op.api").item.get({ "GitHub", "--fields", "token" })[1]
      if not github_token or not vim.startswith(github_token, "ghp_") then
        error("Failed to get GitHub token.")
      end
      require("octo").setup({
        enable_builtin = true,
        mappings = {
          review_diff = {
            select_next_entry = { lhs = "<Tab>", desc = "move to previous changed file" },
            select_prev_entry = { lhs = "<S-Tab>", desc = "move to next changed file" },
          },
        },
        gh_env = { GITHUB_TOKEN = github_token },
      })

      vim.treesitter.language.register("markdown", "octo")
    end,
    dependencies = {
      -- 1Password plugin for Neovim
      { "mrjones2014/op.nvim", build = "make install" },
      -- another plugin to make the UI a bit nicer
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>go", "<cmd>Octo<cr>", desc = "Octo" },
    },
  },
}
