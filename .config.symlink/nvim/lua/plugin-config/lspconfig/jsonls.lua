
return function(capabilities, on_attach)
  require('lspconfig').jsonls.setup{
    cmd = { "vscode-json-languageserver", '--stdio' },
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      json = {
        schemas = {
          {
            fileMatch = {'tsconfig.json', 'tsconfig.*.json'},
            url = 'http://json.schemastore.org/tsconfig'
          },
          {
            fileMatch = {'lerna.json'},
            url = 'http://json.schemastore.org/lerna'
          },
          {
            description = 'Prettier config',
            fileMatch = {'.prettierrc', '.prettierrc.json', 'prettier.config.json'},
            url = 'http://json.schemastore.org/prettierrc'
          },
          {
            fileMatch = {'package.json'},
            url = 'http://json.schemastore.org/package'
          },
        }
      },
    }
  }
end
