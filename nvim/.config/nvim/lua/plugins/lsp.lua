return {
  {
    "mhanberg/output-panel.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>uo", "<cmd>OutputPanel<cr>", desc = "Toggle LSP output" },
    },
    config = true,
  },
  {
    "neovim/nvim-lspconfig",
    -- cmd = "LspInfo",
    opts = {
      diagnostics = {
        virtual_text = {
          prefix = "◦",
          spacing = 4,
        },
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
        enabled = true,
      },
      servers = {
        astro = {},
        eslint = {
          root_dir = require("lspconfig.util").root_pattern(
            ".git",
            "pnpm-workspace.yaml",
            "pnpm-lock.yaml",
            "yarn.lock",
            "package-lock.json",
            "bun.lockb"
          ),
        },
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
          root_dir = require("lspconfig.util").root_pattern(".git"),
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
    "stevearc/conform.nvim",
    -- dev = true,
    optional = true,
    opts = {
      formatters_by_ft = {
        ["markdown"] = { { "prettierd", "prettier" } },
        ["markdown.mdx"] = { { "prettierd", "prettier" } },
        ["javascript"] = { { "prettierd", "prettier" } },
        ["javascriptreact"] = { { "prettierd", "prettier" } },
        ["typescript"] = { { "prettierd", "prettier" } },
        ["typescriptreact"] = { { "prettierd", "prettier" } },
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
