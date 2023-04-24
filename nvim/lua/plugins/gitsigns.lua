return {
  'lewis6991/gitsigns.nvim',
  opts = {
    current_line_blame = false,
    current_line_blame_opts = {
      delay = vim.o.updatetime,
    },
    signcolumn = true,
    signs = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '▎' },
      topdelete = { text = '契' },
      changedelete = { text = '▎' },
    },
  },
  event = { 'BufReadPost', 'BufNewFile' },
  config = function(_, opts)
    local gitsigns = require('gitsigns')
    gitsigns.setup(opts)

    vim.keymap.set('n', ']c', gitsigns.next_hunk)
    vim.keymap.set('n', '[c', gitsigns.prev_hunk)

    vim.keymap.set('n', '<leader>ga', gitsigns.stage_hunk)
    vim.keymap.set('n', '<leader>gr', gitsigns.reset_hunk)
    vim.keymap.set('n', '<leader>gp', gitsigns.preview_hunk)
    vim.keymap.set('n', '<leader>gu', gitsigns.undo_stage_hunk)

    vim.keymap.set('o', 'ah', gitsigns.select_hunk)
    vim.keymap.set('v', 'ah', gitsigns.select_hunk)

    -- Fine-tune highlights
    require('alistairstead.colors').inherit_hl('DiffAdd', 'GitSignsAdd', { background = 'none' })
    require('alistairstead.colors').inherit_hl('DiffChange', 'GitSignsChange', { background = 'none' })
    require('alistairstead.colors').inherit_hl('DiffDelete', 'GitSignsDelete', { background = 'none' })
  end,
}
