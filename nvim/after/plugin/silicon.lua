local ok, silicon = pcall(require, 'silicon')
if not ok then
  return
end

silicon.setup({
  font = 'DankMono Nerd Font=16',
  theme = 'Dracula',
})
