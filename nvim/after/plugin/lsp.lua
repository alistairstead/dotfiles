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

lsp.set_preferences({
  sign_icons = {
    error = ' ',
    warn = ' ',
    hint = '',
    info = ' ',
  }
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

lsp.configure('tsserver', {
  root_dir = require('lspconfig').util.root_pattern('.git')
})

-- Auto format
-- require("lsp-format").setup({})

-- Set keybinds on LSP attach to the buffer
lsp.on_attach(function(client, bufnr)
  -- require("lsp-format").on_attach(client)
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
  -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

  -- typescript specific keymaps (e.g. rename file and update imports)
  if client.name == "tsserver" then
    nmap("<leader>rf", ":TypescriptRenameFile<CR>", '[R]ename [F]ile') -- rename file and update imports
    nmap("<leader>oi", ":TypescriptOrganizeImports<CR>", '[O]rganise [I]mports') -- organize imports (not in youtube nvim video)
    nmap("<leader>ru", ":TypescriptRemoveUnused<CR>", '[R]emove [U]nused') -- remove unused variables (not in youtube nvim video)
  end
end)

lsp.setup()

-- Turn on lsp status information
require('fidget').setup()

local null_ls = require('null-ls')
local null_opts = lsp.build_options('null-ls', {})

null_ls.setup({
  on_attach = function(client, bufnr)
    null_opts.on_attach(client, bufnr)

    local format_cmd = function(input)
      vim.lsp.buf.format({
        id = client.id,
        timeout_ms = 5000,
        async = input.bang,
      })
    end

    local bufcmd = vim.api.nvim_buf_create_user_command
    bufcmd(bufnr, 'NullFormat', format_cmd, {
      bang = true,
      range = true,
      desc = 'Format using null-ls'
    })
  end,
  sources = {
    -- You can add tools not supported by mason.nvim
  }
})

-- See mason-null-ls.nvim's documentation for more details:
-- https://github.com/jay-babu/mason-null-ls.nvim#setup
require('mason-null-ls').setup({
  ensure_installed = nil,
  automatic_installation = false, -- You can still set this to `true`
  automatic_setup = true,
})

-- Required when `automatic_setup` is true
require('mason-null-ls').setup_handlers({
  function(source_name, methods)
    -- all sources with no handler get passed here

    -- To keep the original functionality of `automatic_setup = true`,
    -- please add the below.
    require("mason-null-ls.automatic_setup")(source_name, methods)
  end,
  stylua = function(source_name, methods)
    null_ls.register(null_ls.builtins.formatting.stylua)
  end,
})

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
