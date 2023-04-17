local ok, silicon = pcall(require, 'silicon')
if not ok then
  return
end

 silicon.setup({
  font = 'DankMono Nerd Font=18',
  theme = 'Dracula',
  background = '#87f',
  line_number = true,
  line_pad = 0,
  pad_vert = 80,
  pad_horiz = 50,
  output = {
    path = "/Users/alistairstead/Downloads",
    format = "silicon_[year][month][day]_[hour][minute][second].png",
  },
  watermark = {
    text = ' @alistairstead',
  },
  window_title = function()
    return vim.fn.fnamemodify(vim.fn.bufname(vim.fn.bufnr()), ':~:.')
  end,
})
