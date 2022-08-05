return function(capabilities, on_attach)
  require('lspconfig').gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
