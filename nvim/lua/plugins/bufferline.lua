return {
  'akinsho/bufferline.nvim',
  opts = {
    options = {
      indicator = {
        icon = ' ',
      },
      show_close_icon = false,
      offsets = {
        {
          filetype = 'NvimTree',
          text = '  Files',
          padding = 1,
          highlight = 'StatusLine',
          text_align = 'left',
        },
        { filetype = 'neo-tree', text = '', padding = 1 },
        { filetype = 'Outline', text = '', padding = 1 },
      },
      buffer_close_icon = '',
      modified_icon = '●',
      close_icon = '',
      max_name_length = 14,
      max_prefix_length = 13,
      tab_size = 20,
      separator_style = 'slant',
      -- custom_areas = {
      --   left = function()
      --     return {
      --       { text = '    ', fg = '#8fff6d' },
      --     }
      --   end,
      -- },
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
