return {
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = 'LspAttach',
    ft = { 'markdown', 'css' }, -- Other filetypes are handled by LspAttach
    dependencies = 'nvim-lua/plenary.nvim',
    opts = {
      sources = {
        -- Here you can add tools not supported by mason.nvim
      },
    },
  },
  {
    'jay-babu/mason-null-ls.nvim',
    cmd = { 'LspInfo', 'Mason' },
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      ensure_installed = {
        'prettier',
        'prettierd',
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
}
