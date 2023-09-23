return {
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    config = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    cmd = "MarkdownPreview",
    ft = "markdown",
    keys = {
      {
        "<leader>mp",
        function()
          vim.cmd("MarkdownPreview")
        end,
        desc = "MarkdownPreview - Toggle",
      },
    },
  },
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    ft = "markdown",
    keys = {
      {
        "<leader>op",
        function()
          local peek = require("peek")
          if peek.is_open() then
            peek.close()
          else
            peek.open()
          end
        end,
        desc = "Peek (Markdown Preview)",
      },
    },
    opts = { theme = "dark", app = "browser" },
  },
}
