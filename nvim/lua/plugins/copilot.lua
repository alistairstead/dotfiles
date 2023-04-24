return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    build = ':Copilot auth',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true, -- overrides default
      },
    },
  },
  {
    'zbirenbaum/copilot-cmp',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'zbirenbaum/copilot.lua',
    },
  },
}
