local ok, null_ls = pcall(require, "null-ls")
local ok1, mason_null_ls = pcall(require, "mason-null-ls")
if not ok or not ok1 then
    return
end

mason_null_ls.setup {}

null_ls.setup {
    sources = {
        -- null_ls.builtins.diagnostics.editorconfig_checker.with { command = "editorconfig-checker" },
        -- null_ls.builtins.diagnostics.actionlint,
        -- null_ls.builtins.diagnostics.codespell,
        -- null_ls.builtins.diagnostics.gitlint,
        -- null_ls.builtins.diagnostics.misspell,
        -- null_ls.builtins.diagnostics.selene,
        -- null_ls.builtins.diagnostics.shellcheck,
        -- null_ls.builtins.diagnostics.yamllint,
        -- null_ls.builtins.formatting.cbfmt,
        -- null_ls.builtins.formatting.jq,
        -- null_ls.builtins.formatting.ktlint,
        -- null_ls.builtins.formatting.markdownlint,
        null_ls.builtins.formatting.prettierd,
        -- null_ls.builtins.formatting.shellharden,
        -- null_ls.builtins.formatting.stylua,
    },
    on_attach = require "configs.lsp.on-attach",
}
