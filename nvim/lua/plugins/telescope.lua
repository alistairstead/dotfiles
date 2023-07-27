return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/popup.nvim',
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      config = function()
        require('telescope').load_extension('fzf')
      end,
    },
    {
      'ahmedkhalf/project.nvim',
      opts = {
        manual_mode = true,
        patterns = { '.git' },
      },
      config = function(_, opts)
        require('project_nvim').setup(opts)
        require('telescope').load_extension('projects')
      end,
      keys = {
        { '<leader>fp', '<Cmd>Telescope projects<CR>', desc = 'Projects' },
      },
    },
    {
      'nvim-telescope/telescope-ui-select.nvim',
      config = function()
        require('telescope').load_extension('ui-select')
      end,
    },
    'ahmedkhalf/project.nvim',
  },
  opts = {
    defaults = {
      prompt_prefix = ' ',
      selection_caret = '  ',
      path_display = { 'truncate' },
      layout_strategy = 'horizontal',
      layout_config = {
        width = 0.95,
        height = 0.85,
        prompt_position = 'top',
        horizontal = {
          preview_width = function(_, cols, _)
            if cols > 200 then
              return math.floor(cols * 0.4)
            else
              return math.floor(cols * 0.6)
            end
          end,
        },
        vertical = {
          width = 0.9,
          height = 0.95,
          preview_height = 0.5,
        },
        flex = {
          horizontal = {
            preview_width = 0.9,
          },
        },
      },
      color_devicons = true,
      selection_strategy = 'reset',
      sorting_strategy = 'ascending',
      scroll_strategy = 'cycle',
      file_ignore_patters = { '.git/', 'yarn.lock', 'package-lock.json', 'node_Modules', '.build', '.sst' },
      mappings = {
        i = {
          ['<C-n>'] = require('telescope.actions').cycle_history_next,
          ['<C-p>'] = require('telescope.actions').cycle_history_prev,
          ['<C-j>'] = require('telescope.actions').move_selection_next,
          ['<C-k>'] = require('telescope.actions').move_selection_previous,
          ['<C-c>'] = require('telescope.actions').close,
          ['<CR>'] = require('telescope.actions').select_default,
          ['<Tab>'] = require('telescope.actions').toggle_selection + require('telescope.actions').move_selection_worse,
          ['<S-Tab>'] = require('telescope.actions').toggle_selection + require('telescope.actions').move_selection_better,
          ['<C-q>'] = require('telescope.actions').send_to_qflist + require('telescope.actions').open_qflist,
          ['<C-l>'] = require('telescope.actions').complete_tag,
        },
        n = {
          ['<esc>'] = require('telescope.actions').close,
          ['<CR>'] = require('telescope.actions').select_default,
        },
      },
    },
    pickers = {
      find_files = {
        hidden = true,
        theme = 'dropdown',
        previewer = false,
      },
      buffers = {
        previewer = false,
        theme = 'dropdown',
      },
      lsp_references = {
        previewer = false,
      },
    },
    extensions = {
      ['ui-select'] = {
        require('telescope.themes').get_dropdown({
          -- even more opts
        }),
      },
      project = {
        base_dirs = {
          '~/code',
        },
        theme = 'dropdown',
      },
    },
  },
  cmd = 'Telescope',
  keys = {
    { '<C-t>', '<cmd>Telescope<cr>', desc = 'Telescope' },
    { '<C-p>', '<cmd>Telescope git_files<CR>', desc = 'git files' },
    { '<leader>:', '<cmd>Telescope command_history<cr>', desc = 'Command History' },
    -- find
    { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = '[fb] Find existing buffers' },
    { '<leader>bb', '<cmd>Telescope buffers<cr>', desc = '[bb] Find existing buffers' },
    { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = '[ff] Find Files' },
    { '<leader>fr', '<cmd>Telescope oldfiles<cr>', desc = '[fr] Find recently opened files' },
    -- git
    { '<leader>gc', '<cmd>Telescope git_commits<CR>', desc = '[gc] Git commits' },
    { '<leader>gf', '<cmd>Telescope git_files<CR>', desc = '[gf] Git files' },
    -- search
    { '<leader>s.', '<cmd>Telescope find_files search_dirs=~/.dotfiles<cr>', desc = 'Auto Commands' },
    { '<leader>sa', '<cmd>Telescope autocommands<cr>', desc = 'Auto Commands' },
    { '<leader>sb', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = 'Buffer' },
    { '<leader>sc', '<cmd>Telescope command_history<cr>', desc = 'Command History' },
    { '<leader>sC', '<cmd>Telescope commands<cr>', desc = 'Commands' },
    { '<leader>sd', '<cmd>Telescope diagnostics bufnr=0<cr>', desc = 'Document diagnostics' },
    { '<leader>sD', '<cmd>Telescope diagnostics<cr>', desc = 'Workspace diagnostics' },
    { '<leader>sg', '<cmd>Telescope live_grep<cr>', desc = 'Grep (root dir)' },
    { '<leader>/', '<cmd>Telescope live_grep<cr>', desc = 'Grep (root dir)' },
    { '<leader>sh', '<cmd>Telescope help_tags<cr>', desc = 'Help Pages' },
    { '<leader>sH', '<cmd>Telescope highlights<cr>', desc = 'Search Highlight Groups' },
    { '<leader>sk', '<cmd>Telescope keymaps<cr>', desc = 'Key Maps' },
    { '<leader>sM', '<cmd>Telescope man_pages<cr>', desc = 'Man Pages' },
    { '<leader>sm', '<cmd>Telescope marks<cr>', desc = 'Jump to Mark' },
    { '<leader>sr', '<cmd>Telescope oldfiles<cr>', desc = '[fr] Find recently opened files' },
    { '<leader>so', '<cmd>Telescope vim_options<cr>', desc = 'Options' },
    { '<leader>sR', '<cmd>Telescope resume<cr>', desc = 'Resume' },
    { '<leader>sw', '<cmd>Telescope grep_string<cr>', desc = 'Word' },
    {
      '<leader>cc',
      function()
        require('telescope.builtin').colorscheme({ enable_preview = true })
      end,
      desc = 'Colorscheme with preview',
    },
  },
}
