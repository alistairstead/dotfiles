local M = {}

-- local util = require "lspconfig.util"

local servers = {
	html = {},
	jsonls = {
		settings = {
			json = {
				-- schemas = require("schemastore").json.schemas(),
				schemas = {
					{
						fileMatch = { "tsconfig.json", "tsconfig.*.json" },
						url = "http://json.schemastore.org/tsconfig",
					},
					{
						fileMatch = { "lerna.json" },
						url = "http://json.schemastore.org/lerna",
					},
					{
						description = "Prettier config",
						fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
						url = "http://json.schemastore.org/prettierrc",
					},
					{
						fileMatch = { "package.json" },
						url = "http://json.schemastore.org/package",
					},
				},
			},
		},
	},
	sumneko_lua = {
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
					-- Setup your lua path
					path = vim.split(package.path, ";"),
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim", "describe", "it", "before_each", "after_each", "packer_plugins" },
					-- disable = { "lowercase-global", "undefined-global", "unused-local", "unused-vararg", "trailing-space" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					},
					-- library = vim.api.nvim_get_runtime_file("", true),
					maxPreload = 2000,
					preloadFileSize = 50000,
				},
				completion = { callSnippet = "Both" },
				telemetry = { enable = false },
				hint = {
					enable = true,
				},
			},
		},
	},
	tsserver = {
		disable_formatting = true,
	},
	vimls = {},
	tailwindcss = {},
	yamlls = {
		schemastore = {
			enable = true,
		},
		settings = {
			yaml = {
				hover = true,
				completion = true,
				validate = true,
				schemas = require("schemastore").json.schemas(),
			},
		},
	},
	jdtls = {},
	dockerls = {},
	graphql = {},
	bashls = {},
	-- omnisharp = {},
	-- kotlin_language_server = {},
	-- emmet_ls = {},
	marksman = {},
	-- angularls = {},
	-- sqls = {
	-- settings = {
	--   sqls = {
	--     connections = {
	--       {
	--         driver = "sqlite3",
	--         dataSourceName = os.getenv "HOME" .. "/workspace/db/chinook.db",
	--       },
	--     },
	--   },
	-- },
	-- },
}

function M.on_attach(client, bufnr)
	-- Enable completion triggered by <C-X><C-O>
	-- See `:help omnifunc` and `:help ins-completion` for more information.
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Use LSP as the handler for formatexpr.
	-- See `:help formatexpr` for more information.
	vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")

	-- Configure key mappings
	require("config.lsp.keymaps").setup(client, bufnr)

	-- Configure highlighting
	require("config.lsp.highlighter").setup(client, bufnr)

	-- Configure formatting
	require("config.lsp.null-ls.formatters").setup(client, bufnr)

	-- tagfunc
	if client.server_capabilities.definitionProvider then
		vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
	end
end

local opts = {
	on_attach = M.on_attach,
	flags = {
		debounce_text_changes = 150,
	},
}

-- Setup LSP handlers
require("config.lsp.handlers").setup()

function M.setup()
	-- null-ls
	require("config.lsp.null-ls").setup(opts)

	-- Installer
	require("config.lsp.installer").setup(servers, opts)
end

local diagnostics_active = true

function M.toggle_diagnostics()
	diagnostics_active = not diagnostics_active
	if diagnostics_active then
		vim.diagnostic.show()
	else
		vim.diagnostic.hide()
	end
end

function M.remove_unused_imports()
	vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.WARN })
	vim.cmd("packadd cfilter")
	vim.cmd("Cfilter /main/")
	vim.cmd("Cfilter /The import/")
	vim.cmd("cdo normal dd")
	vim.cmd("cclose")
	vim.cmd("wa")
end

return M
