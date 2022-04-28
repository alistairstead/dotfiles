local opt = vim.opt

local statusline = {
  '%#PmenuSel#',
  '%m',
  '  %{mode()}',
  '  %#LineNr#',
  ' %.50f',
  '%=',
  '%y',
  ' %#CursorColumn#',
  ' %p%%',
  '/%L',
  ' %l:%c '
}

opt.statusline = table.concat(statusline, '')
