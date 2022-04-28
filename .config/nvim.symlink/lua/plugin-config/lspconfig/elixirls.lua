local elixirls_root_path = '/Users/everzet/Tools/elixir-language-server'

return function(capabilities, on_attach)
  require('lspconfig').elixirls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { elixirls_root_path .. '/language_server.sh' }
  }
end
