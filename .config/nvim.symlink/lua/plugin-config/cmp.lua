local lspkind = require('lspkind')
local cmp = require('cmp')
local opt = vim.opt

opt.completeopt = {'menu', 'menuone', 'noselect'}

cmp.setup({
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-y>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<C-space>'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp.config.disable,
    ['<S-Tab>'] = cmp.config.disable,
    ['<Up>'] = cmp.config.disable,
    ['<Down>'] = cmp.config.disable,
  },

  snippet = {
    expand = function(args)
       require'snippy'.expand_snippet(args.body)
    end,
  },

  sources = cmp.config.sources({
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = "path" },
    { name = 'snippy' },
    { name = 'buffer', keyword_length = 5, max_item_count = 10 },
  }),

  formatting = {
    format = lspkind.cmp_format({
      with_text = false,
      menu = {
        buffer = "[buf]",
        nvim_lua = "[lua]",
        nvim_lsp = "[lsp]",
        path = "[path]",
        snippy = "[snip]",
      }
    })
  },

  experimental = {
    native_menu = false,
    ghost_text = false,
  },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
