local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end
local actions = require "telescope.actions"
local telescopeConfig = require('telescope.config')

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, '--hidden')
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, '--glob')
table.insert(vimgrep_arguments, '!.git/*')

require("telescope").load_extension("fzf")
require('telescope').load_extension('project')

telescope.setup {
  defaults = {
    prompt_prefix = ' ',
    selection_caret = '  ',
    path_display = { 'truncate' },
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.95,
      height = 0.85,
      -- preview_cutoff = 120,
      prompt_position = "top",
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
    borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    scroll_strategy = "cycle",
    vimgrep_arguments = vimgrep_arguments,
    file_ignore_patters = { '.git/', 'yarn.lock', 'package-lock.json' },
    mappings = {
      i = {
        ['<C-n>'] = actions.cycle_history_next,
        ['<C-p>'] = actions.cycle_history_prev,

        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,

        ['<C-c>'] = actions.close,

        ['<Down>'] = actions.move_selection_next,
        ['<Up>'] = actions.move_selection_previous,

        ['<CR>'] = actions.select_default,
        ['<C-x>'] = actions.select_horizontal,
        ['<C-v>'] = actions.select_vertical,
        ['<C-t>'] = actions.select_tab,

        ['<C-u>'] = actions.preview_scrolling_up,
        ['<C-d>'] = actions.preview_scrolling_down,

        ['<PageUp>'] = actions.results_scrolling_up,
        ['<PageDown>'] = actions.results_scrolling_down,

        ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
        ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
        ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
        ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
        ['<C-l>'] = actions.complete_tag,
      },

      n = {
        ['<esc>'] = actions.close,
        ['<CR>'] = actions.select_default,
        ['<C-x>'] = actions.select_horizontal,
        ['<C-v>'] = actions.select_vertical,
        ['<C-t>'] = actions.select_tab,

        ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
        ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
        ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
        ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,

        ['j'] = actions.move_selection_next,
        ['k'] = actions.move_selection_previous,
        ['H'] = actions.move_to_top,
        ['M'] = actions.move_to_middle,
        ['L'] = actions.move_to_bottom,

        ['<Down>'] = actions.move_selection_next,
        ['<Up>'] = actions.move_selection_previous,
        ['gg'] = actions.move_to_top,
        ['G'] = actions.move_to_bottom,

        ['<C-u>'] = actions.preview_scrolling_up,
        ['<C-d>'] = actions.preview_scrolling_down,

        ['<PageUp>'] = actions.results_scrolling_up,
        ['<PageDown>'] = actions.results_scrolling_down,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
      theme = "dropdown",
      borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
      previewer = false,
    },
    buffers = {
      previewer = false,
      theme = "dropdown",
      borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
    },
    lsp_references = {
      previewer = false,
    },
    -- default configuration for builtin pickers goes here:
    -- picker_name = {
      --   picker_config_key = value,
      --   ...
      -- }
      -- now the picker_config_key will be applied every time you call this
      -- builtin picker
    },
    extensions = {
      project = {
        base_dirs = {
          '~/code',
        },
        theme = 'dropdown',
        borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
      },
    },
  }

  -- borderless theme
  local TelescopePrompt = {
    TelescopePromptNormal = {
      bg = '#2d3149',
    },
    TelescopePromptBorder = {
      bg = '#2d3149',
    },
    TelescopePromptTitle = {
      fg = '#2d3149',
      bg = '#2d3149',
    },
    TelescopePreviewTitle = {
      fg = '#1F2335',
      bg = '#1F2335',
    },
    TelescopeResultsTitle = {
      fg = '#1F2335',
      bg = '#1F2335',
    },
  }
  for hl, col in pairs(TelescopePrompt) do
    vim.api.nvim_set_hl(0, hl, col)
  end
