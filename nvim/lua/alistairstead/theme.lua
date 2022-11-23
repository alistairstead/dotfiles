local colorscheme = 'dracula_pro'
local cmd = vim.cmd

local status_ok, _ = pcall(cmd.colorscheme, colorscheme)
if not status_ok then
  vim.notify('colorscheme ' .. colorscheme .. ' not found!')
  return
end

-- Example comment in italic type
cmd('highlight Comment guifg=#7970A9 gui=italic')
cmd('highlight VertSplit guifg=#454158 guibg=#22212C')
