local ok, lualine = pcall(require, 'lualine')
if not ok then
  return
end

local function attached_clients()
  return '(' .. vim.tbl_count(vim.lsp.buf_get_clients()) .. ')'
end

lualine.setup({
  options = {
    icons_enabled = true,
    theme = 'auto',
    disabled_filetypes = {
      'dashboard',
      'neo-tree',
    },
  },
  sections = {
    lualine_b = { 'branch', { 'diagnostics', sources = { 'nvim_diagnostic' } } },
    lualine_c = {},
    lualine_x = {
      { 'filetype', separator = { right = '' }, right_padding = 0 },
      { attached_clients, separator = { left = '' }, left_padding = 0 },
    },
  },
  inactive_sections = {},
  extensions = { 'quickfix', 'toggleterm', 'fugitive' },
})
