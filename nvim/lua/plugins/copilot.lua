return {
  {
    'zbirenbaum/copilot.lua',
    config = function()
      require('copilot').setup({
        filetypes = {
          markdown = true, -- overrides default
        },
      })
    end,
  },
  {
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup()
    end,
  }
}
