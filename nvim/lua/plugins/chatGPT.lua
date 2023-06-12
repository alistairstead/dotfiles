return {
  {
    'jackMort/ChatGPT.nvim',
    main = 'chatgpt',
    cmd = { 'ChatGPT' },
    opts = {
      api_key_cmd = 'op read op://Personal/OpenAI/credential --no-newline',
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
  },
}
