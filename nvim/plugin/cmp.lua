local ok, cmp = pcall(require, "cmp")
if not ok then
    return
end
local types = require "cmp.types"
local luasnip = require "luasnip"
local mapping = cmp.mapping

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,longest,preview'

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end
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
}

cmp.setup {
  experimental = {
    ghost_text = true,
  },
  formatting = {
    format = function(_, vim_item)
      vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
      return vim_item
    end,
  },-- formatting = {
  --   fields = { "kind", "abbr", "menu" },
  --   format = require("lspkind").cmp_format({
  --     mode = 'symbol', -- show only symbol annotations
  --     preset = 'codicons',
  --     maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
  --   }),
  -- },
  snippet = {
      expand = function(args)
          luasnip.lsp_expand(args.body)
      end,
  },
  window = {
    completion = {
      -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
      -- winhighlight = "NormalFloat:NormalFloat,FloatBorder:TelescopeBorder",
    },
  },
  -- confirm_opts = {
  --   behavior = cmp.ConfirmBehavior.Replace,
  --   select = false,
  -- },
  mapping = {
      ["<C-d>"] = mapping(mapping.scroll_docs(8), { "i" }),
      ["<C-u>"] = mapping(mapping.scroll_docs(-8), { "i" }),
      -- ["<C-k>"] = mapping(function(fallback)
      --     if cmp.open_docs_preview() then
      --         cmp.close()
      --     else
      --         fallback()
      --     end
      -- end),
      ["<C-Space>"] = mapping.complete(),
      ["<C-e>"] = mapping.abort(),
      ["<C-c>"] = mapping.abort(),
      ["<CR>"] = mapping.confirm { select = false },
      ["<C-j>"] = mapping.select_next_item { behavior = types.cmp.SelectBehavior.Select },
      ["<C-k>"] = mapping.select_prev_item { behavior = types.cmp.SelectBehavior.Select },
      ["<C-l>"] = mapping(function(fallback)
          local copilot_keys = vim.fn['copilot#Accept']()
          if copilot_keys ~= '' and type(copilot_keys) == 'string' then
            vim.api.nvim_feedkeys(copilot_keys, 'i', true)
          end
      end, { "i", "s" }),
      ["<Tab>"] = mapping(function(fallback)
          local copilot_keys = vim.fn['copilot#Accept']()
          if cmp.visible() then
            cmp.select_next_item({ behaviour = cmp.SelectBehavior.Insert })
          elseif copilot_keys ~= '' and type(copilot_keys) == 'string' then
            vim.api.nvim_feedkeys(copilot_keys, 'i', true)
          elseif luasnip.expandable() then
            luasnip.expand()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
      end, { "i", "s" }),
      ["<S-Tab>"] = mapping(function(fallback)
          if cmp.visible() then
              cmp.select_prev_item { behavior = types.cmp.SelectBehavior.Insert }
          elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
          else
              fallback()
          end
      end, { "i", "s" }),
  },
  sources = {
      { name = "nvim_lsp" },
      { name = 'nvim_lsp_signature_help' },
      { name = 'nvim_lua' },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
  },
}

--  Use buffer source for `/`
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
    { name = "cmdline" },
  }),
})

