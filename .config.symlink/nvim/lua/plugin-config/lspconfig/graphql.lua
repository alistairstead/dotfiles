return function(capabilities, on_attach)
  require('lspconfig').graphql.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
