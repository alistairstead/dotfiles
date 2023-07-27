local cmp_kinds = {
  Array = ' ',
  Boolean = ' ',
  Class = ' ',
  Color = ' ',
  Constant = ' ',
  Constructor = ' ',
  Copilot = '  ',
  Enum = ' ',
  EnumMember = ' ',
  Event = ' ',
  Field = ' ',
  File = ' ',
  Folder = ' ',
  Function = ' ',
  Interface = ' ',
  Key = ' ',
  Keyword = ' ',
  Method = ' ',
  Module = ' ',
  Namespace = ' ',
  Null = ' ',
  Number = ' ',
  Object = ' ',
  Operator = ' ',
  Package = ' ',
  Property = ' ',
  Reference = ' ',
  Snippet = ' ',
  String = ' ',
  Struct = ' ',
  Text = ' ',
  TypeParameter = ' ',
  Unit = ' ',
  Value = ' ',
  Variable = ' ',
}

return {
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdLineEnter' },
    cmd = 'CmpStatus',
    dependencies = {
      {
        'uga-rosa/cmp-dictionary',
        config = function()
          require('cmp_dictionary').update()
        end,
      },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'davidsierradz/cmp-conventionalcommits' },
      { 'petertriho/cmp-git' },
      { 'rafamadriz/friendly-snippets' },
    },
    opts = function()
      vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })
      local cmp = require('cmp')
      local defaults = require('cmp.config.default')()
      local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
          return false
        end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match('^%s*$') == nil
      end

      return {
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<C-c>'] = cmp.mapping.abort(),
          ['<Tab>'] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
              fallback()
            end
          end),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ['<S-CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'nvim_lsp', group_index = 2 },
          { name = 'nvim_lsp_signature_help', group_index = 2 },
          { name = 'dictionary', group_index = 2, keyword_length = 4 },
        }),
        formatting = {
          format = function(_, item)
            if cmp_kinds[item.kind] then
              item.kind = cmp_kinds[item.kind] .. item.kind
            end
            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = 'CmpGhostText',
          },
        },
        sorting = defaults.sorting,
      }
    end,
    -- config = function()
    --
    --
    --   cmp.setup({
    --     sources = cmp.config.sources({
    --     }),
    --     formatting = {
    --       format = function(_, vim_item)
    --         vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
    --         return vim_item
    --       end,
    --     },
    --   })
    --
    --   cmp.setup.filetype('gitcommit', {
    --     sources = cmp.config.sources({
    --       { name = 'git' },
    --     }, {
    --       { name = 'buffer' },
    --     }, { { name = 'conventionalcommits' } }),
    --   })
    --   -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore)
    --   cmp.setup.cmdline('/', {
    --     mapping = cmp.mapping.preset.cmdline(),
    --     sources = {
    --       { name = 'buffer' },
    --     },
    --   })
    --
    --   -- Use cmdline & path source for ":" (if you enabled `native_menu`, this won't work anymore)
    --   cmp.setup.cmdline(':', {
    --     mapping = cmp.mapping.preset.cmdline(),
    --     sources = cmp.config.sources({
    --       { name = 'path' },
    --     }, {
    --       { name = 'cmdline' },
    --     }),
    --   })
    --
    --   -- vim.opt_global.dictionary = { "~/.config/nvim/spell/en.utf-8.add", "/usr/share/dict/words" }
    --   require('cmp_dictionary').setup({
    --     dic = {
    --       ['*'] = { '~/.config/nvim/spell/en.utf-8.add', '/usr/share/dict/words' },
    --     },
    --     first_case_insensitive = true,
    --   })
    --   require('cmp_dictionary').update()
    -- end,
  },
}
