return {
  'zbirenbaum/neodim',
  config = function()
    require('neodim').setup({
      alpha = 0.5,
      hide = {
        signs = false,
        virtual_text = true,
        underline = true,
      },
    })
  end,
}
