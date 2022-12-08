local status, nvim_lsp = pcall(require, 'lspconfig')
if not status then
  return
end

local Remap = require('alistairstead.keymap')
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap

local protocol = require('vim.lsp.protocol')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { buffer = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  nnoremap('gd', function()
    vim.lsp.buf.definition()
  end, opts)
  nnoremap('gi', function()
    vim.lsp.buf.implementation()
  end, opts)
  nnoremap('K', function()
    vim.lsp.buf.hover()
  end, opts)
  nnoremap('<leader>vws', function()
    vim.lsp.buf.workspace_symbol('')
  end, opts)
  nnoremap('<leader>vd', function()
    vim.diagnostic.open_float()
  end, opts)
  nnoremap('<C-j>', function()
    vim.diagnostic.goto_next()
  end, opts)
  nnoremap('<C-k>', function()
    vim.diagnostic.goto_prev()
  end, opts)
  nnoremap('<leader>va', function()
    vim.lsp.buf.code_action()
  end, opts)
  nnoremap('<leader>vco', function()
    vim.lsp.buf.code_action({
      filter = function(code_action)
        if not code_action or not code_action.data then
          return false
        end

        local data = code_action.data.id
        return string.sub(data, #data - 1, #data) == ':0'
      end,
      apply = true,
    })
  end, opts)
  nnoremap('<leader>vrr', function()
    vim.lsp.buf.references({})
  end, opts)
  nnoremap('<leader>rn', function()
    vim.lsp.buf.rename()
  end, opts)
  inoremap('<c-h>', function()
    vim.lsp.buf.signature_help()
  end, opts)
  local status_ok, illuminate = pcall(require, 'illuminate')
  if not status_ok then
    return
  end
  illuminate.on_attach(client)
end

protocol.CompletionItemKind = {
  '', -- Text
  '', -- Method
  '', -- Function
  '', -- Constructor
  '', -- Field
  '', -- Variable
  '', -- Class
  'ﰮ', -- Interface
  '', -- Module
  '', -- Property
  '', -- Unit
  '', -- Value
  '', -- Enum
  '', -- Keyword
  '﬌', -- Snippet
  '', -- Color
  '', -- File
  '', -- Reference
  '', -- Folder
  '', -- EnumMember
  '', -- Constant
  '', -- Struct
  '', -- Event
  'ﬦ', -- Operator
  '', -- TypeParameter
}

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

nvim_lsp.flow.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

nvim_lsp.tsserver.setup({
  on_attach = on_attach,
  -- filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript" },
  cmd = { 'typescript-language-server', '--stdio' },
  capabilities = capabilities,
})

nvim_lsp.sourcekit.setup({
  on_attach = on_attach,
})

nvim_lsp.sumneko_lua.setup({
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },

      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
    },
  },
})

nvim_lsp.tailwindcss.setup({})
nvim_lsp.astro.setup({
  init_options = {
    typescript = {
      serverPath = '/Users/adam/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib/tsserverlibrary.js',
    },
  },
})
nvim_lsp.graphql.setup({})
nvim_lsp.rust_analyzer.setup({
  on_attach = on_attach,
})

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 4, prefix = '●' },
  severity_sort = true,
})

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

vim.diagnostic.config({
  virtual_text = {
    prefix = '●',
  },
  update_in_insert = true,
  float = {
    source = 'always', -- Or "if_many"
  },
})
