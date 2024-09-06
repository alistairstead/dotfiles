return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      {
        "OlegGulevskyy/better-ts-errors.nvim",
        enabled = false,
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = {
          keymaps = {
            toggle = "<leader>dd", -- default '<leader>dd'
            go_to_definition = "<leader>dx", -- default '<leader>dx'
          },
        },
      },
    },
    opts = {
      servers = {
        tsserver = {
          -- root_dir = require("lspconfig").util.root_pattern(
          --   ".git",
          --   "pnpm-workspace.yaml",
          --   "pnpm-lock.yaml",
          --   "yarn.lock",
          --   "package-lock.json",
          --   "bun.lockb"
          -- ),
          -- single_file_support = false,
          -- settings = {
          --   typescript = {
          --     implementationsCodeLens = { enabled = true },
          --     referencesCodeLens = { enabled = true, showOnAllFunctions = true },
          --     inlayHints = {
          --       -- taken from https://github.com/typescript-language-server/typescript-language-server#workspacedidchangeconfiguration
          --       includeInlayParameterNameHints = "literal",
          --       includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          --       includeInlayFunctionParameterTypeHints = false,
          --       includeInlayVariableTypeHints = false,
          --       includeInlayPropertyDeclarationTypeHints = false,
          --       includeInlayFunctionLikeReturnTypeHints = false,
          --       includeInlayEnumMemberValueHints = true,
          --     },
          --   },
          --   javascript = {
          --     inlayHints = {
          --       includeInlayParameterNameHints = "all",
          --       includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          --       includeInlayFunctionParameterTypeHints = true,
          --       includeInlayVariableTypeHints = true,
          --       includeInlayPropertyDeclarationTypeHints = true,
          --       includeInlayFunctionLikeReturnTypeHints = false,
          --       includeInlayEnumMemberValueHints = true,
          --     },
          --   },
          -- },
        },
      },
    },
  },
  {
    "dmmulroy/tsc.nvim",
    config = true,
    cmd = "TSC",
    keys = {
      { "<leader>tc", "<cmd>TSC<cr>", desc = "Type-check" },
    },
  },
}
