return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  event = 'VimEnter',
  keys = {
    { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle pin' },
    { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete non-pinned buffers' },
  },
  opts = {
    options = {
      buffer_close_icon = '',
      modified_icon = '●',
      close_icon = '',
      tab_size = 20,
      separator_style = 'slant',
      color_icons = false,
    },
  },
}
