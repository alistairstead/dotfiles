return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  -- event = { 'BufReadPre', 'BufNewFile' },
  event = 'VimEnter',
  -- event = 'VeryLazy',
  keys = {
    { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle pin' },
    { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete non-pinned buffers' },
  },
  opts = {
    options = {
      themable = true,
      -- indicator = {
      --   -- icon = ' ',
      --   style = 'underline',
      -- },
      buffer_close_icon = '',
      modified_icon = '●',
      close_icon = '',
      tab_size = 20,
      separator_style = 'slant',
      -- diagnostics = 'nvim_lsp',
      color_icons = false,
    },
    highlights = {
      fill = {
        bg = { attribute = 'bg', highlight = 'StatusLine' },
      },
      background = {
        bg = { attribute = 'bg', highlight = 'StatusLine' },
      },
      tab = {
        bg = { attribute = 'bg', highlight = 'StatusLine' },
      },
      tab_close = {
        bg = { attribute = 'bg', highlight = 'StatusLine' },
      },
      close_button = {
        bg = { attribute = 'bg', highlight = 'StatusLine' },
        fg = { attribute = 'fg', highlight = 'StatusLineNonText' },
      },
      close_button_visible = {
        bg = { attribute = 'bg', highlight = 'StatusLine' },
        fg = { attribute = 'fg', highlight = 'StatusLineNonText' },
      },
      close_button_selected = {
        fg = { attribute = 'fg', highlight = 'StatusLineNonText' },
      },
      buffer_visible = {
        bg = { attribute = 'bg', highlight = 'StatusLine' },
      },
      modified = {
        bg = { attribute = 'bg', highlight = 'StatusLine' },
      },
      modified_visible = {
        bg = { attribute = 'bg', highlight = 'StatusLine' },
      },
      duplicate = {
        bg = { attribute = 'bg', highlight = 'StatusLine' },
      },
      duplicate_visible = {
        bg = { attribute = 'bg', highlight = 'StatusLine' },
      },
      separator = {
        fg = { attribute = 'bg', highlight = 'StatusLine' },
        bg = { attribute = 'bg', highlight = 'StatusLine' },
      },
      separator_selected = {
        fg = { attribute = 'bg', highlight = 'StatusLine' },
        bg = { attribute = 'bg', highlight = 'Normal' },
      },
      separator_visible = {
        fg = { attribute = 'bg', highlight = 'StatusLine' },
        bg = { attribute = 'bg', highlight = 'StatusLine' },
      },
    },
  },
}
