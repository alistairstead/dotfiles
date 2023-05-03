return {
  'chrishrb/gx.nvim',
  event = { 'BufEnter' },
  keys = { 'gx' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  main = 'gx',
  opts = {
    handlers = {
      plugin = true, -- open plugin links in lua (e.g. packer, lazy, ..)
      github = true, -- open github issues
      package_json = true, -- open dependencies from package.json
    },
  },
}
