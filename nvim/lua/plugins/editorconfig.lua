return {
  {
    'editorconfig/editorconfig-vim',
    event = { 'BufReadPre', 'BufNewFile' },
    init = function()
      vim.g.EditorConfig_max_line_indicator = ''
      vim.g.EditorConfig_preserve_formatoptions = 1
    end,
  },
}
