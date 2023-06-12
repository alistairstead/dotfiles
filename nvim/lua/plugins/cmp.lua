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
  Snippet = ' ',
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
      {
        'zbirenbaum/copilot-cmp',
        main = 'copilot_cmp',
        opts = {},
        dependencies = {
          'zbirenbaum/copilot.lua',
          build = ':Copilot auth',
          cmd = 'Copilot',
          opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
            filetypes = {
              gitcommit = true,
              markdown = true, -- overrides default
            },
          },
        },
      },
      { 'hrsh7th/cmp-path' },
      { 'L3MON4D3/LuaSnip' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'davidsierradz/cmp-conventionalcommits' },
      { 'petertriho/cmp-git' },
      { 'rafamadriz/friendly-snippets' },
    },
    config = function()
      local cmp = require('cmp')

      local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
          return false
        end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match('^%s*$') == nil
      end
      require('copilot_cmp').setup()
      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
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
          ['<C-Space>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
          ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
          ['<Tab>'] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
              fallback()
            end
          end),
        }),
        sources = cmp.config.sources({
          { name = 'copilot', group_index = 1 },
          { name = 'path', group_index = 3 },
          { name = 'nvim_lsp', group_index = 2 },
          { name = 'nvim_lsp_signature_help', group_index = 2 },
          { name = 'buffer', group_index = 3, keyword_length = 4 },
          { name = 'luasnip', group_index = 4 },
          { name = 'dictionary', group_index = 2, keyword_length = 4 },
        }),
        formatting = {
          format = function(_, vim_item)
            vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
            return vim_item
          end,
        },
      })

      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git' },
        }, {
          { name = 'buffer' },
        }, { { name = 'conventionalcommits' } }),
      })
      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore)
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })

      -- Use cmdline & path source for ":" (if you enabled `native_menu`, this won't work anymore)
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
      })

      -- vim.opt_global.dictionary = { "~/.config/nvim/spell/en.utf-8.add", "/usr/share/dict/words" }
      require('cmp_dictionary').setup({
        dic = {
          ['*'] = { '~/.config/nvim/spell/en.utf-8.add', '/usr/share/dict/words' },
        },
        first_case_insensitive = true,
      })
      require('cmp_dictionary').update()
    end,
  },
}
