local ok, null_ls = pcall(require, 'null-ls')
local ok1, mason_null_ls = pcall(require, 'mason-null-ls')
if not ok or not ok1 then
  return
end

require('lsp-format').setup({})

null_ls.setup({
  -- you can reuse a shared lspconfig on_attach callback here
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format()
        end,
      })
    end
  end,
  debug = true,
  sources = {
    debounce = 150,
    null_ls.builtins.diagnostics.editorconfig_checker.with({ command = 'editorconfig-checker' }),
    -- null_ls.builtins.diagnostics.actionlint,
    -- null_ls.builtins.diagnostics.codespell,
    null_ls.builtins.diagnostics.gitlint,
    -- null_ls.builtins.diagnostics.misspell,
    -- null_ls.builtins.diagnostics.selene,
    -- null_ls.builtins.diagnostics.shellcheck,
    -- null_ls.builtins.diagnostics.yamllint,
    -- null_ls.builtins.formatting.cbfmt,
    -- null_ls.builtins.formatting.jq,
    -- null_ls.builtins.formatting.ktlint,
    null_ls.builtins.formatting.markdownlint,
    null_ls.builtins.formatting.prettierd.with({
      filetypes = {
        'html',
        'css',
        'json',
        'yaml',
        'markdown',
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'graphql',
      },
    }),
    -- null_ls.builtins.formatting.shellharden,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettier.with({
      filetypes = {
        'html',
        'css',
        'json',
        'yaml',
        'markdown',
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'graphql',
      },
    }),
  },
})
