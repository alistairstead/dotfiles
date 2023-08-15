local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--Remap space as leader key
vim.g.mapleader = ' '

require('lazy').setup({
  spec = {
    { import = 'plugins' },
    -- { import = 'plugins.lsp.core' },
    -- { import = 'plugins.lang.astro' },
    -- { import = 'plugins.lang.cmake' },
    -- { import = 'plugins.lang.docker' },
    -- { import = 'plugins.lang.elixir' },
    -- { import = 'plugins.lang.go' },
    -- { import = 'plugins.lang.json' },
    -- { import = 'plugins.lang.php' },
    -- { import = 'plugins.lang.python' },
    -- { import = 'plugins.lang.rust' },
    -- { import = 'plugins.lang.tailwind' },
    -- { import = 'plugins.lang.terraform' },
    -- { import = 'plugins.lang.typescript' },
    -- { import = 'plugins.lang.yaml' },
    -- { import = 'plugins.formatting.prettier' },
    -- { import = 'plugins.linting.eslint' },
    -- { import = 'plugins.dap.core' },
    -- { import = 'plugins.test.core' },
  },
  defaults = { lazy = false, version = false },
  install = { colorscheme = { 'tokyonight' } },
  checker = { enabled = true },
  dev = {
    path = '~/code/',
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
  -- debug = true,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    require('config.keymap')
    require('config.autocmds')
  end,
})

vim.keymap.set('n', '<leader>l', '<cmd>:Lazy<cr>', { desc = 'Plugin Manager' })
