return {
  'glepnir/dashboard-nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  event = 'VimEnter',
  opts = {
    theme = 'hyper',
    config = {
      packages = { enable = true },
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
          desc = ' dotfiles',
          group = 'Number',
          action = 'Telescope find_files search_dirs=~/.dotfiles',
          key = 'd',
        },
      },
      project = { limit = 3 },
      mru = { limit = 5 },
    },
  },
}
