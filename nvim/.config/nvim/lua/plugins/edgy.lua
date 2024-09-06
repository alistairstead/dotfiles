return {
  { import = "lazyvim.plugins.extras.ui.edgy" },
  {
    "folke/edgy.nvim",
    opts = {
      wo = {
        spell = false,
      },
      animate = {
        enabled = false,
      },
      bottom = {
        {
          ft = "lazyterm",
          title = "LazyTerm",
          size = { height = 0.4 },
          filter = function(buf)
            return not vim.b[buf].lazyterm_cmd
          end,
        },
        "Trouble",
        { ft = "qf", title = "QuickFix" },
        {
          ft = "help",
          size = { height = 20 },
          -- only show help buffers
          filter = function(buf)
            return vim.bo[buf].buftype == "help"
          end,
        },
        {
          title = "DB Query Result",
          ft = "dbout",
        },
      },
      left = {
        {
          title = "Neo-Tree",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "filesystem"
          end,
          open = function()
            require("neo-tree.command").execute({ dir = LazyVim.root() })
          end,
          size = { width = 0.2 },
        },
        { title = "UndoTree", ft = "undotree" },
        {
          title = "Database",
          ft = "dbui",
          open = function()
            vim.cmd("DBUI")
          end,
        },
      },
      right = {
        { title = "Spectre", ft = "spectre_panel" },
        { title = "CopilotChat.nvim", ft = "copilot-chat", size = { width = 0.4 } },
        { title = "Neotest", ft = "neotest" },
        { title = "Neotest Summary", ft = "neotest-summary" },
        { title = "Neotest Output", ft = "neotest-output-panel" },
        {
          ft = "Outline",
          open = "SymbolsOutlineOpen",
        },
      },
    },
  },
}
