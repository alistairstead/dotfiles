return {
  'levouh/tint.nvim',
  config = function()
    require('tint').setup({
      tint = -50,
      saturation = 0.4,
      ignore = { 'WinBar.*', 'WinSeparator', 'IndentBlankline.*', 'SignColumn', 'EndOfBuffer' },
      ignorefunc = function(winid)
        local bufnr = vim.api.nvim_win_get_buf(winid)
        -- Only tint normal buffers.
        return vim.api.nvim_buf_get_option(bufnr, 'buftype') ~= ''
      end,
    })
  end,
}
