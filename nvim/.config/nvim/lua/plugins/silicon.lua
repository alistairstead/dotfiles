return {
  "krivahtoo/silicon.nvim",
  build = "./install.sh build",
  cmd = "Silicon",
  opts = {
    font = "DankMono Nerd Font=18",
    theme = "Dracula",
    background = "#333333",
    line_number = true,
    line_pad = 0,
    pad_vert = 80,
    pad_horiz = 50,
    output = {
      path = "/Users/alistairstead/Downloads",
      format = "silicon_[year][month][day]_[hour][minute][second].png",
    },
    window_title = function()
      return vim.fn.fnamemodify(vim.fn.bufname(vim.fn.bufnr()), ":~:.")
    end,
  },
}
