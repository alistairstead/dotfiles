local home = os.getenv('HOME')
local db = require('dashboard')
--
db.custom_center = {
  { icon = '  ',
    desc = 'Recently latest session                  ',
    shortcut = 'SPC s l',
    action = 'SessionLoad' },
  { icon = '  ',
    desc = 'Recently opened files                   ',
    action = 'Telescope oldfiles',
    shortcut = 'SPC f h' },
  { icon = '  ',
    desc = 'Find File                              ',
    action = 'Telescop find_files find_command=rg,--hidden,--files',
    shortcut = 'SPC s f' },
  { icon = '  ',
    desc = 'Find word                              ',
    action = 'Telescope live_grep',
    shortcut = 'SPC s g' },
  { icon = '  ',
    desc = 'Open Personal dotfiles                  ',
    action = 'Telescope find_files search_dirs=' .. home .. '/.dotfiles',
    shortcut = 'SPC f d' },
}
