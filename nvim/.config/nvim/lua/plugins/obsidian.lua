return {
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "Notes",
          path = "/Users/alistairstead/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes",
        },
      },
    },
  },
}
