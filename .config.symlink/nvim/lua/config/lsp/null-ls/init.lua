local M = {}

local nls = require("null-ls")
local nls_utils = require("null-ls.utils")
local b = nls.builtins

local with_diagnostics_code = function(builtin)
	return builtin.with({
		diagnostics_format = "#{m} [#{c}]",
	})
end

-- local with_root_file = function(builtin, file)
--   return builtin.with {
--     condition = function(utils)
--       return utils.root_has_file(file)
--     end,
--   }
-- end

local sources = {
	-- formatting
	--[[ b.formatting.prettierd, ]]
	b.formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
	b.formatting.shfmt,
	b.formatting.shellharden,
	b.formatting.black.with({ extra_args = { "--fast" } }),
	b.formatting.isort,
	b.formatting.stylua,
	-- with_root_file(b.formatting.stylua, "stylua.toml"),

	-- diagnostics
	b.diagnostics.write_good,
	-- b.diagnostics.markdownlint,
	b.diagnostics.eslint_d,
	-- b.diagnostics.flake8.with { extra_args = { "--max-line-length=120" } },
	b.diagnostics.tsc,
	-- b.diagnostics.selene,
	-- b.diagnostics.codespell,
	-- with_root_file(b.diagnostics.selene, "selene.toml"),
	with_diagnostics_code(b.diagnostics.shellcheck),
	b.diagnostics.zsh,
	-- b.diagnostics.cspell.with {
	--   filetypes = { "python", "rust", "typescript" },
	-- },
	-- b.diagnostics.stylelint,

	-- code actions
	b.code_actions.gitsigns.with({
		disabled_filetypes = { "NeogitCommitMessage" },
	}),
	b.code_actions.eslint_d,
	b.code_actions.gitrebase,
	b.code_actions.refactoring,
	b.code_actions.proselint,
	b.code_actions.shellcheck,

	-- hover
	b.hover.dictionary,
}

function M.setup(opts)
	nls.setup({
		-- debug = true,
		debounce = 150,
		save_after_format = true,
		sources = sources,
		on_attach = opts.on_attach,
		root_dir = nls_utils.root_pattern(".git"),
	})
end

return M
