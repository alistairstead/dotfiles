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
