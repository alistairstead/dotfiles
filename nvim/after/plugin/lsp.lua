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

-- Use recommended preset
lsp.preset('recommended')

-- Always install following servers
lsp.ensure_installed({
  'elixirls',
  'tsserver',
  'astro',
})

lsp.set_preferences({
  sign_icons = {
    error = ' ',
    warn = ' ',
    hint = '',
    info = ' ',
  }
})

lsp.configure('tsserver', {
  root_dir = require("lspconfig").util.root_pattern(".git", "pnpm-workspace.yaml", "pnpm-lock.yaml", "yarn.lock", "package-lock.json", "bun.lockb"),
})

-- Set keybinds on LSP attach to the buffer
lsp.on_attach(function(client, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end
  -- Code actions
  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  -- Go *
  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('gT', vim.lsp.buf.type_definition, '[G]oto [T]ype Definition')
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  -- Show * symbols
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
  -- Lesser used LSP functionality
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')
  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
  -- Formatting
  nmap('<leader>f', function()
    if vim.lsp.buf.format then
      vim.lsp.buf.format()
    elseif vim.lsp.buf.formatting then
      vim.lsp.buf.formatting()
    end
  end, 'Run formatter')
  -- Navigate diagnostics
  nmap('gl', vim.diagnostic.open_float, '[G]oto Diagnostic [L]ist')
  nmap('<leader>vd', vim.diagnostic.open_float, '[V]iew [D]iognostics')
  -- typescript specific keymaps (e.g. rename file and update imports)
  if client.name == "tsserver" then
    nmap("<leader>rf", ":TypescriptRenameFile<CR>", '[R]ename [F]ile')
    nmap("<leader>oi", ":TypescriptOrganizeImports<CR>", '[O]rganise [I]mports')
    nmap("<leader>ru", ":TypescriptRemoveUnused<CR>", '[R]emove [U]nused')
  end
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
  formatting = {
    format = function(_, vim_item)
      vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
      return vim_item
    end,
  },
  window = {
    documentation = {
      winhighlight = 'Normal:Normal,FloatBorder:NonText,CursorLine:Visual,Search:None'
    },
    completion = {
      winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,Search:None',
    },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
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
        cmp.select_next_item({ behaviour = cmp.SelectBehavior.Replace })
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
    { name = "luasnip",                priority = 100 },
    { name = "nvim_lsp",               priority = 90, keyword_length = 1 },
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lua",               priority = 90 },
    { name = "copilot",                priority = 80, keyword_length = 3 },
    { name = "path",                   priority = 5 },
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
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = {
    { name = 'path' }
  },
  {
    {
      name = "cmdline",
      option = {
        ignore_cmds = { "Man", "!" },
      },
    },
  }
})

vim.diagnostic.config({
  virtual_text = true
})
