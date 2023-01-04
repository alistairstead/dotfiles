local ok, telescope = pcall(require, 'telescope')
if not ok then
  return
end
local actions = require('telescope.actions')
local telescopeConfig = require('telescope.config')

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, '--hidden')
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, '--glob')
table.insert(vimgrep_arguments, '!.git/*')

require('telescope').load_extension('fzf')
require('telescope').load_extension('ui-select')
require('telescope').load_extension('git_worktree')

telescope.setup({
  defaults = {
    prompt_prefix = ' ',
    selection_caret = '  ',
    path_display = { 'truncate' },
    layout_strategy = 'horizontal',
    layout_config = {
      width = 0.95,
      height = 0.85,
      -- preview_cutoff = 120,
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
    vimgrep_arguments = vimgrep_arguments,
    file_ignore_patters = { '.git/', 'yarn.lock', 'package-lock.json', 'node_Modules', '.build', '.sst' },
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
    },
  },
})

local Remap = require('alistairstead.keymap')
local nnoremap = Remap.nnoremap
local builtin = require('telescope.builtin')

nnoremap('<C-t>', builtin.builtin, { desc = 'Telescope' })
nnoremap('<C-p>', builtin.git_files, { desc = 'Git files' })

-- See `:help telescope.builtin`
nnoremap('<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
nnoremap('<leader>b', builtin.buffers, { desc = '[b] Find existing buffers' })
nnoremap('<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

nnoremap('<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
nnoremap('<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
nnoremap('<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
nnoremap('<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
nnoremap('<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
nnoremap('<leader>sp', telescope.extensions.project.project, { desc = '[S]earch [P]rojects' })
nnoremap('<leader>gw', telescope.extensions.git_worktree.git_worktrees, { desc = '[G]it [W]orktrees' })

nnoremap('<leader>gm', function()
  telescope.extensions.git_worktree.create_git_worktree()
end)
