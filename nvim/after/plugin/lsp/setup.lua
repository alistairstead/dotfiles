local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
    return
end

local util = require "lspconfig.util"
local cmp_lsp_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")

local function create_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    vim.list_extend(capabilities.textDocument.completion.completionItem.resolveSupport.properties, {
        "documentation",
        "detail",
        "additionalTextEdits",
    })
    return cmp_lsp.update_capabilities(capabilities)
end

util.on_setup = util.add_hook_after(util.on_setup, function(config)
    if config.on_attach then
        config.on_attach = util.add_hook_after(config.on_attach, require "configs.lsp.on-attach")
    else
        config.on_attach = require "configs.lsp.on-attach"
    end
    config.capabilities = vim.tbl_deep_extend("force", create_capabilities(), config.capabilities or {})
end)

require("mason-lspconfig").setup {}

require("mason-lspconfig").setup_handlers {
    function(server_name)
        lspconfig[server_name].setup {}
    end,
    ["tsserver"] = function()
        require("typescript").setup {
            server = {
                settings = {
                    typescript = {
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
        }
    end,
    ["jsonls"] = function()
        lspconfig.jsonls.setup {
            settings = {
                json = {
                    schemas = require("schemastore").json.schemas(),
                },
            },
        }
    end,
    ["sumneko_lua"] = function()
        lspconfig.sumneko_lua.setup(require("lua-dev").setup {
            cmd = { "lua-language-server" },
            settings = {
                Lua = {
                    format = {
                        enable = false,
                    },
                    hint = {
                        enable = true,
                        arrayIndex = "Disable", -- "Enable", "Auto", "Disable"
                        await = true,
                        paramName = "Disable", -- "All", "Literal", "Disable"
                        paramType = false,
                        semicolon = "Disable", -- "All", "SameLine", "Disable"
                        setType = true,
                    },
                    diagnostics = {
                        globals = { "P", "vim" },
                    },
                },
            },
        })
    end,
    ["yamlls"] = function()
        lspconfig.yamlls.setup {
            settings = {
                yaml = {
                    hover = true,
                    completion = true,
                    validate = true,
                    schemas = require("schemastore").json.schemas(),
                },
            },
        }
    end,
}

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
