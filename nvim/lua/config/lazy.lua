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

require('lazy').setup('plugins', {
  -- defaults = { lazy = true },
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

vim.keymap.set('n', '<leader>z', '<cmd>:Lazy<cr>', { desc = 'Plugin Manager' })
