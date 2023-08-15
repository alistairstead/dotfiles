return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    lazy = true,
    config = function()
      -- This is where you modify the settings for lsp-zero
      -- Note: autocompletion settings will not take effect
      require('lsp-zero.settings').preset({})
    end,
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = 'LspInfo',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'jose-elias-alvarez/null-ls.nvim' },
      {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        event = 'LspAttach',
      },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'williamboman/mason.nvim' },
      {
        'folke/neodev.nvim',
        ft = 'lua',
      },
      {
        'jay-babu/mason-null-ls.nvim',
        cmd = { 'LspInfo', 'Mason' },
        opts = {
          ensure_installed = {
            'eslint',
            'stylua',
            'stylelint',
            'shellcheck',
            'yamllint',
            'jsonlint',
          },
          automatic_installation = true, -- You can still set this to `true`
          handlers = {
            -- Here you can add functions to register sources.
            -- See https://github.com/jay-babu/mason-null-ls.nvim#handlers-usage
            --
            -- If left empty, mason-null-ls will  use a "default handler"
            -- to register all sources
          },
        },
      },
    },
    config = function()
      local lsp = require('lsp-zero')

      lsp.set_sign_icons({
        Error = ' ',
        Warn = ' ',
        Hint = ' ',
        Info = ' ',
      })
      -- Always install following servers
      lsp.ensure_installed({
        'astro',
        'elixirls',
        'emmet_ls',
        'tailwindcss',
        'tsserver',
      })

      -- Set keybinds on LSP attach to the buffer
      lsp.on_attach(function(client, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end
          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc, silent = true })
        end
        -- Code actions
        nmap('<leader>rn', vim.lsp.buf.rename, '[r]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[c]ode [a]ction')
        -- Go *
        nmap('gd', require('telescope.builtin').lsp_definitions, '[g]oto [d]efinition')
        nmap('gr', require('telescope.builtin').lsp_references, '[g]oto [r]eferences')
        nmap('gi', require('telescope.builtin').lsp_implementations, '[g]oto [i]mplementation')
        nmap('gt', vim.lsp.buf.type_definition, '[g]oto [t]ype Definition')
        nmap('gD', vim.lsp.buf.declaration, '[g]oto [D]eclaration')
        -- Show * symbols
        nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
          vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
        end, { desc = 'Format current buffer with LSP' })
        -- Formatting
        nmap('<leader>f', function()
          vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
        end, '[f]ormat buffer')
        -- Navigate diagnostics
        nmap('gl', vim.diagnostic.open_float, '[g]oto diagnostic [l]ist')
        nmap('<leader>vd', vim.diagnostic.open_float, '[v]iew [d]iognostics')
        -- typescript specific keymaps (e.g. rename file and update imports)
      end)

      lsp.format_on_save({
        format_opts = {
          async = false,
          timeout_ms = 10000,
        },
        servers = {
          ['null-ls'] = {
            'astro',
            'javascript',
            'typescript',
            'lua',
            'php',
            'yaml',
            'json',
            'markdown',
            'css',
            'html',
          },
        },
      })

      local lspconfig = require('lspconfig')
      lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
      lspconfig.yamlls.setup({
        settings = {
          yaml = {
            keyOrdering = false,
            schemas = {
              ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
              ['https://json.schemastore.org/github-actions.json'] = '/.github/actions/*',
            },
          },
        },
      })

      lspconfig.intelephense.setup({
        init_options = {
          licenceKey = '/Users/alistairstead/Documents/intelephense.txt',
        },
      })

      lspconfig.eslint.setup({
        root_dir = require('lspconfig.util').root_pattern('.git', 'pnpm-workspace.yaml', 'pnpm-lock.yaml', 'yarn.lock', 'package-lock.json', 'bun.lockb'),
        settings = {
          -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
          workingDirectory = { mode = 'auto' },
        },
      })

      lspconfig.tailwindcss.setup({
        root_dir = function(...)
          return require('lspconfig.util').root_pattern('.git')(...)
        end,
        settings = {
          tailwindCSS = {
            emmetCompletions = true,
          },
        },
      })

      lspconfig.emmet_ls.setup({
        init_options = {
          jsx = {
            options = {
              markup = {
                attributes = {
                  class = 'class',
                  className = 'class',
                },
              },
              ['markup.attributes'] = {
                className = 'class',
                class = 'class',
              },
            },
          },
        },
      })

      lspconfig.tsserver.setup({

        root_dir = require('lspconfig').util.root_pattern('.git', 'pnpm-workspace.yaml', 'pnpm-lock.yaml', 'yarn.lock', 'package-lock.json', 'bun.lockb'),
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = 'literal',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = false,
              includeInlayVariableTypeHints = false,
              includeInlayPropertyDeclarationTypeHints = false,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      })

      lsp.setup()

      local null_ls = require('null-ls')

      null_ls.setup({
        sources = {
          -- Replace these with the tools you have installed
          -- make sure the source name is supported by null-ls
          -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
          null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.prettierd,
        },
      })

      -- Turn on lsp status information
      require('fidget').setup()

      vim.diagnostic.config({
        virtual_text = true,
      })
    end,
  },
  {
    'lvimuser/lsp-inlayhints.nvim',
    event = 'LspAttach',
    opts = {},
    config = function(_, opts)
      require('lsp-inlayhints').setup(opts)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('LspAttach_inlayhints', {}),
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require('lsp-inlayhints').on_attach(client, args.buf)
        end,
      })
    end,
  },
}
