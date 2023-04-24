return {
  'zbirenbaum/neodim',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    alpha = 0.5,
    hide = {
      signs = false,
      virtual_text = true,
      underline = true,
    },
  },
}
