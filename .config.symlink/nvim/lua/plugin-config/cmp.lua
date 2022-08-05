local lspkind = require('lspkind')
local snippy = require('snippy')
local cmp = require('cmp')
local opt = vim.opt

opt.completeopt = {'menu', 'menuone', 'noselect'}

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end


cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-y>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    ['<C-space>'] = cmp.mapping.complete(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      local copilot_keys = vim.fn['copilot#Accept']()

      if cmp.visible() then
        cmp.select_next_item()
      elseif snippy.can_expand_or_advance() then
        snippy.expand_or_advance()
      elseif copilot_keys ~= '' and type(copilot_keys) == 'string' then
        vim.api.nvim_feedkeys(copilot_keys, 'i', true)
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif snippy.can_jump(-1) then
        luasnip.previous()
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<Up>'] = cmp.config.disable,
    ['<Down>'] = cmp.config.disable,
  }),

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
    { name = 'cmdline' }
  })
})
