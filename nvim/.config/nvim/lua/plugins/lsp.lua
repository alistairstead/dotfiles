return {
  {
    "neovim/nvim-lspconfig",
    -- cmd = "LspInfo",
    opts = {
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
        tsserver = {
          root_dir = require("lspconfig").util.root_pattern(
            ".git",
            "pnpm-workspace.yaml",
            "pnpm-lock.yaml",
            "yarn.lock",
            "package-lock.json",
            "bun.lockb"
          ),
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "literal",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = false,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = false,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
      },
      setup = {
        eslint = function()
          require("lazyvim.util").on_attach(function(client)
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
}
