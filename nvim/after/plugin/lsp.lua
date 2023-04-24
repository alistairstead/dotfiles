local lsp = require('lsp-zero')
local lspconfig = require('lspconfig')
local cmp = require('cmp')
local types = require('cmp.types')
local mapping = cmp.mapping

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
lsp.preset({})

lsp.set_sign_icons({
  error = ' ',
  warn = ' ',
  hint = '',
  info = ' ',
})

-- Always install following servers
lsp.ensure_installed({
  'elixirls',
  'tailwindcss',
  'emmet_ls',
  'tsserver',
  'astro',
})

lspconfig.yamlls.setup({
  settings = {
    yaml = {
      keyOrdering = true,
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        ["https://json.schemastore.org/github-actions.json"] = "/.github/actions/*"
      }
    }
  }
})

lspconfig.intelephense.setup({
  init_options = {
    licenceKey = '/Users/alistairstead/Documents/intelephense.txt'
  }
})

lspconfig.tailwindcss.setup({
  settings = {
    tailwindCSS = {
      emmetCompletions = true,
    }
  }
})


lspconfig.emmet_ls.setup({
  init_options = {
    jsx = {
      options = {
        markup = {
          attributes = {
            class = 'class',
            className = 'class'
          }
        },
        ['markup.attributes'] = {
          className = 'class',
          class = 'class'
        }
      }
    }
  }
})

lspconfig.tsserver.setup({
  root_dir = require("lspconfig").util.root_pattern(".git", "pnpm-workspace.yaml", "pnpm-lock.yaml", "yarn.lock",
    "package-lock.json", "bun.lockb"),
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
    vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
  end, { desc = 'Format current buffer with LSP' })
  -- Formatting
  nmap('<leader>f', function()
    vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
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

lsp.format_on_save({
  format_opts = {
    timeout_ms = 10000,
  },
  servers = {
    ['null-ls'] = {'javascript', 'typescript', 'lua', 'php', 'yaml', 'json'},
  }
})

lsp.setup()

-- Turn on lsp status information
require('fidget').setup()

local cmp_action = require('lsp-zero').cmp_action()
cmp.setup({
  preselect = 'item',
  formatting = {
    format = function(_, vim_item)
      vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
      return vim_item
    end,
  },
  mapping = {
    ['<C-d>'] = mapping(mapping.scroll_docs(8), { 'i' }),
    ['<C-u>'] = mapping(mapping.scroll_docs(-8), { 'i' }),
    ['<C-Space>'] = mapping.complete(),
    ['<C-e>'] = mapping.abort(),
    ['<C-c>'] = mapping.abort(),
    ['<CR>'] = mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
    ['<C-j>'] = mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Select }),
    ['<C-k>'] = mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Select }),
    ['<Tab>'] = cmp_action.tab_complete(),
    ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
  },
  sources = {
    { name = "nvim_lsp",               priority = 100, keyword_length = 1 },
    { name = "copilot",                priority = 100,  keyword_length = 1 },
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lua",               priority = 80 },
    { name = "luasnip",                priority = 50 },
    { name = "path",                   priority = 5 },
  },
})

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

local null_ls = require('null-ls')

null_ls.setup({
  sources = {
    -- Here you can add tools not supported by mason.nvim
  }
})

-- See mason-null-ls.nvim's documentation for more details:
-- https://github.com/jay-babu/mason-null-ls.nvim#setup
require('mason-null-ls').setup({
  ensure_installed = nil,
  automatic_installation = false, -- You can still set this to `true`
  handlers = {
      -- Here you can add functions to register sources.
      -- See https://github.com/jay-babu/mason-null-ls.nvim#handlers-usage
      --
      -- If left empty, mason-null-ls will  use a "default handler"
      -- to register all sources
  }
})
