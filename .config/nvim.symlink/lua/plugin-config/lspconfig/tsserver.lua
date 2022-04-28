return function(capabilities, on_attach)
  require('lspconfig').tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
