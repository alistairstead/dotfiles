require('cmp').setup.buffer({
  sources = require('cmp').config.sources({ { name = 'conventionalcommits' } }, { { name = 'buffer' } }),
})

vim.opt_local.spell = true
vim.opt_local.wrap = true
