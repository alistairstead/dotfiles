local lsp = require('lsp-zero')
local cmp = require('cmp')
local types = require('cmp.types')
local mapping = cmp.mapping
local luasnip = require('luasnip')

local cmp_kinds = {
  Text = '  ',
  Method = '  ',
  Function = '  ',
  Constructor = '  ',
  Field = '  ',
  Variable = '  ',
  Class = '  ',
  Interface = '  ',
  Module = '  ',
  Property = '  ',
  Unit = '  ',
  Value = '  ',
  Enum = '  ',
  Keyword = '  ',
  Snippet = '  ',
  Color = '  ',
  File = '  ',
  Reference = '  ',
  Folder = '  ',
  EnumMember = '  ',
  Constant = '  ',
  Struct = '  ',
  Event = '  ',
  Operator = '  ',
  TypeParameter = '  ',
  Copilot = '  ',
}

-- Use recommended preset
lsp.preset('recommended')

-- Always install following servers
lsp.ensure_installed({
  'elixirls',
  'tsserver',
  'eslint',
  'sumneko_lua',
})

-- Configure Lua LSP to support vim configs
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lsp.configure('sumneko_lua', {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = { globals = { 'vim' } },
      workspace = { library = vim.api.nvim_get_runtime_file('', true) },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = { enable = false },
    }
  }
})

-- Override default preferences
lsp.set_preferences({
  suggest_lsp_servers = false
})

-- Auto format
require("lsp-format").setup({})

-- Set keybinds on LSP attach to the buffer
lsp.on_attach(function(client, bufnr)
  require("lsp-format").on_attach(client)
  local opts = { buffer = bufnr, remap = false }

  -- Go *
  vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, opts)
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, opts)
  vim.keymap.set('n', 'gI', require('telescope.builtin').lsp_implementations, opts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)

  -- Navigate diagnostics
  vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

  -- Show * symbols
  vim.keymap.set('n', '<leader>sds', require('telescope.builtin').lsp_document_symbols, opts)
  vim.keymap.set('n', '<leader>sws', require('telescope.builtin').lsp_dynamic_workspace_symbols, opts)

  -- Inline help
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)

  -- Code actions
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

  -- Formatting
  vim.keymap.set('n', '<leader>f', function()
    if vim.lsp.buf.format then
      vim.lsp.buf.format()
    elseif vim.lsp.buf.formatting then
      vim.lsp.buf.formatting()
    end
  end, opts)
end)

lsp.setup()

-- Turn on lsp status information
require('fidget').setup()

-- Setup completion keybinds
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end
local cmp_config = lsp.defaults.cmp_config({
  -- experimental = {
  --   ghost_text = true,
  -- },
  formatting = {
    format = function(_, vim_item)
      vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
      return vim_item
    end,
  },
  -- snippet = {
  --   expand = function(args)
  --     luasnip.lsp_expand(args.body)
  --   end,
  -- },
  window = {
    documentation = {
      winhighlight = 'Normal:Normal,FloatBorder:NonText,CursorLine:Visual,Search:None'
    },
    completion = {
      -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,Search:None',
      -- winhighlight = "NormalFloat:NormalFloat,FloatBorder:TelescopeBorder",
    },
  },
  -- confirm_opts = {
  --   behavior = cmp.ConfirmBehavior.Replace,
  --   select = false,
  -- },
  mapping = lsp.defaults.cmp_mappings({
    ['<C-d>'] = mapping(mapping.scroll_docs(8), { 'i' }),
    ['<C-u>'] = mapping(mapping.scroll_docs(-8), { 'i' }),
    ['<C-Space>'] = mapping.complete(),
    ['<C-e>'] = mapping.abort(),
    ['<C-c>'] = mapping.abort(),
    ['<CR>'] = mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
    ['<C-j>'] = mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Select }),
    ['<C-k>'] = mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Select }),
    ['<Tab>'] = mapping(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behaviour = cmp.SelectBehavior.Select })
      elseif luasnip.expandable() then
        luasnip.expand({})
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert })
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = "luasnip", priority = 100 },
    { name = "nvim_lsp", priority = 90 },
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lua", priority = 90 },
    { name = "copilot", priority = 80 },
    { name = "path", priority = 5 },
  },
})

cmp.setup(cmp_config)

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },
  }, {
    { name = 'buffer' },
  },
    { { name = 'conventionalcommits' }, })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    {
      name = "cmdline",
      option = {
        ignore_cmds = { "Man", "!" },
      },
    },
  })
})

vim.diagnostic.config({
  virtual_text = true
})
