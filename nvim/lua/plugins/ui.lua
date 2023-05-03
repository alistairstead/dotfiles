return {
  {
    'luukvbaal/stabilize.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
  },
  {
    'stevearc/dressing.nvim',
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.input(...)
      end
    end,
  },
  {
    'glepnir/dashboard-nvim',
    opts = {
      theme = 'hyper',
      config = {
        week_header = {
          enable = true,
        },
        shortcut = {
          { desc = ' Update', group = '@property', action = 'Lazy update', key = 'u' },
          {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Files',
            group = 'Label',
            action = 'Telescope find_files',
            key = 'f',
          },
          {
            desc = ' Apps',
            group = 'DiagnosticHint',
            action = 'Telescope app',
            key = 'a',
          },
          {
            desc = ' dotfiles',
            group = 'Number',
            action = 'Telescope dotfiles',
            key = 'd',
          },
        },
      },
    },
  },
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    keys = {
      { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle pin' },
      { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete non-pinned buffers' },
    },
    opts = {
      options = {
        -- stylua: ignore
        -- close_command = function(n) require("mini.bufremove").delete(n, false) end,
        -- stylua: ignore
        -- right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
        -- diagnostics_indicator = function(_, _, diag)
        --   local icons = require("lazyvim.config").icons.diagnostics
        --   local ret = (diag.error and icons.Error .. diag.error .. " " or "")
        --     .. (diag.warning and icons.Warn .. diag.warning or "")
        --   return vim.trim(ret)
        -- end,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Neo-tree',
            highlight = 'Directory',
            text_align = 'left',
          },
        },
      },
    },
  },
  {
    'windwp/windline.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('wlsample.airline')
    end,
  },
  -- colorizer
  {
    'NvChad/nvim-colorizer.lua',
    event = 'BufReadPre',
    opts = {
      filetypes = { '*', '!lazy' },
      buftype = { '*', '!prompt', '!nofile' },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = false, -- 0xAARRGGBB hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes: foreground, background
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = 'background', -- Set the display mode.
        virtualtext = '■',
      },
    },
  },
  -- scrollbar
  {
    'petertriho/nvim-scrollbar',
    event = 'BufReadPost',
    main = 'scrollbar',
    opts = {
      handlers = {
        cursor = false,
      },
      excluded_filetypes = { 'prompt', 'TelescopePrompt', 'noice', 'notify', 'neo-tree' },
    },
  },
  {
    'nvim-pack/nvim-spectre',
    keys = {
      {
        '<leader>sr',
        function()
          require('spectre').open()
        end,
        desc = '[s]pectre [r]eplace',
      },
    },
  },
}
