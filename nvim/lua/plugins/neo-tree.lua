return {
  'nvim-neo-tree/neo-tree.nvim',
  version = 'v2.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    {
      's1n7ax/nvim-window-picker',
      opts = {
        show_prompt = true,
        filter_rules = {
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { 'NvimTree', 'neo-tree', 'notify' },
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
      },
    },
  },
  keys = {
    { '<leader>e', '<cmd>Neotree toggle<cr>', desc = 'NeoTree' },
  },
  opts = {
    close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
    popup_border_style = 'rounded',
    use_popups_for_input = true,
    enable_git_status = true,
    enable_diagnostics = true,
    use_default_mappings = false,
    respect_gitignore = true,
    default_component_configs = {
      indent = {
        indent_size = 2,
        padding = 1, -- extra padding on left hand side
        -- indent guides
        with_markers = false,
        indent_marker = '│',
        last_indent_marker = '└',
        highlight = 'NeoTreeIndentMarker',
        -- expander config, needed for nesting files
        with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = '',
        expander_expanded = '',
        expander_highlight = 'NeoTreeExpander',
      },
      icon = {
        folder_closed = '',
        folder_open = '',
        folder_empty = 'ﰊ',
        default = '',
      },
      modified = {
        symbol = '[+]',
        highlight = 'NeoTreeModified',
      },
      name = {
        trailing_slash = true,
        use_git_status_colors = false,
      },
      git_status = {
        symbols = {
          -- Change type
          added = '', -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified = '', -- or "", but this is redundant info if you use git_status_colors on the name
          deleted = '✖', -- this can only be used in the git_status source
          renamed = '', -- this can only be used in the git_status source
          -- Status type
          untracked = '?',
          ignored = '',
          unstaged = 'M',
          staged = '',
          conflict = '',
        },
      },
    },
    use_libuv_file_watcher = true,
    window = {
      position = 'left',
      width = 40,
      mappings = {
        ['l'] = 'open',
        ['<CR>'] = 'open',
        ['o'] = 'open_with_window_picker',
        ['s'] = 'open_split',
        ['v'] = 'vsplit_with_window_picker',
        ['w'] = 'open_with_window_picker',
        ['<C-x>'] = 'split_with_window_picker',
        ['t'] = 'open_tabnew',
        ['T'] = 'open_tabnew',
        ['h'] = 'close_node',
        ['K'] = 'navigate_up',
        ['C'] = 'set_root',
        ['H'] = 'toggle_hidden',
        ['R'] = 'refresh',
        ['f'] = 'filter_on_submit',
        ['<c-f>'] = 'clear_filter',
        ['a'] = 'add',
        ['d'] = 'delete',
        ['r'] = 'rename',
        ['m'] = 'move',
        ['c'] = 'copy_to_clipboard',
        ['x'] = 'cut_to_clipboard',
        ['p'] = 'paste_from_clipboard',
        ['q'] = 'close_window',
        [']c'] = 'next_git_modified',
        ['[c'] = 'prev_git_modified',
        ['?'] = 'show_help',
      },
      mapping_options = {
        nowait = true,
      },
    },
    nesting_rules = {},
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = true,
        hide_gitignored = true,
        hide_by_name = {},
        never_show = { -- remains hidden even if visible is toggled to true
          '.DS_Store',
          'thumbs.db',
        },
      },
      follow_current_file = true, -- This will find and focus the file in the active buffer every
      -- time the current file is changed while the tree is open.
      hijack_netrw_behavior = 'open_default', -- netrw disabled, opening a directory opens neo-tree
      -- in whatever position is specified in window.position
      -- "open_current",  -- netrw disabled, opening a directory opens within the
      -- window like netrw would, regardless of window.position
      -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
      use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
      -- instead of relying on nvim autocmd events.
    },
    buffers = {
      show_unloaded = false,
      window = {
        mappings = {
          ['bd'] = 'buffer_delete',
        },
      },
    },
    git_status = {
      window = {
        position = 'float',
        mappings = {
          ['A'] = 'git_add_all',
          ['gu'] = 'git_unstage_file',
          ['ga'] = 'git_add_file',
          ['gr'] = 'git_revert_file',
          ['gc'] = 'git_commit',
          ['gp'] = 'git_push',
          ['gg'] = 'git_commit_and_push',
        },
      },
    },
  },
}
