return {
  -- {
  --   "mhanberg/output-panel.nvim",
  --   event = "VeryLazy",
  --   keys = {
  --     { "<leader>uo", "<cmd>OutputPanel<cr>", desc = "Toggle LSP output" },
  --   },
  --   config = true,
  -- },
  {
    "neovim/nvim-lspconfig",
    -- cmd = "LspInfo",
    opts = {
      diagnostics = {
        virtual_text = {
          -- prefix = "◦",
          prefix = "icons",
          source = "if_many",
          spacing = 2,
        },
        severity_sort = true,
      },
      capabilities = {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      },
      inlay_hints = {
        enabled = false,
      },
      -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the code lenses.
      codelens = {
        enabled = false,
      },
      servers = {
        -- eslint = {
        --   root_dir = require("lspconfig.util").root_pattern(
        --     ".git",
        --     "pnpm-workspace.yaml",
        --     "pnpm-lock.yaml",
        --     "yarn.lock",
        --     "package-lock.json",
        --     "bun.lockb"
        --   ),
        -- },
        intelephense = {
          init_options = {
            licenceKey = "/Users/alistairstead/Documents/intelephense.txt",
          },
        },
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                ["https://json.schemastore.org/github-actions.json"] = "/.github/actions/*",
              },
            },
          },
        },
        tailwindcss = {
          -- root_dir = require("lspconfig.util").root_pattern(".git"),
          settings = {
            tailwindCSS = {
              emmetCompletions = true,
            },
          },
        },
      },
      setup = {
        eslint = function()
          require("lazyvim.util").lsp.on_attach(function(client)
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = true
            elseif client.name == "tsserver" then
              client.server_capabilities.documentFormattingProvider = false
            end
          end)
        end,
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        lua = { "selene", "luacheck" },
        markdown = { "markdownlint" },
      },
      linters = {
        selene = {
          condition = function(ctx)
            return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
          end,
        },
        luacheck = {
          condition = function(ctx)
            return vim.fs.find({ ".luacheckrc" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
    },
  },
}
