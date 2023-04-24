return {
  'iamcco/markdown-preview.nvim',
  build = 'cd app && npm install',
  config = function()
    vim.g.mkdp_filetypes = { 'markdown' }
  end,
  cmd = 'MarkdownPreview',
  ft = 'markdown',
  keys = {
    {
      '<leader>mp',
      function()
        vim.cmd('MarkdownPreview')
      end,
      desc = 'MarkdownPreview - Toggle',
    },
  },
}
