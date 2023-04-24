return {
  's1n7ax/nvim-window-picker',
  config = function()
    local window_picker = require('window-picker')
    window_picker.setup({
      show_prompt = true,
      filter_rules = {
        -- filter using buffer options
        bo = {
          -- if the file type is one of following, the window will be ignored
          filetype = { 'NvimTree', "neo-tree", "notify" },

          -- if the buffer type is one of following, the window will be ignored
          buftype = {},
        },
      },

      fg_color = '#EF87BD',

      -- if you have include_current_win == true, then current_win_hl_color will
      -- be highlighted using this background color
      current_win_hl_color = '#454158',

      -- all the windows except the current window will be highlighted using this color
      other_win_hl_color = '#454158',
    })

    vim.keymap.set('n', '-', function()
      local window = window_picker.pick_window({
        autoselect_one = true,
        include_current_win = true,
      })
      if window then
        vim.api.nvim_set_current_win(window)
      end
    end)
  end,
}
