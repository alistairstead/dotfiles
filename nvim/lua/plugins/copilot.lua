return {
  'zbirenbaum/copilot-cmp',
  main = 'copilot_cmp',
  dependencies = {
    'zbirenbaum/copilot.lua',
    build = ':Copilot auth',
    cmd = 'Copilot',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        gitcommit = true,
        markdown = true, -- overrides default
      },
    },
  },
}
