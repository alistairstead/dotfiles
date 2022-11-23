local ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not ok then
  return
end

treesitter.setup({
  ensure_installed = {},
  ignore_install = { 'haskell', 'phpdoc' },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = false },
  autotag = {
    enable = true,
    filetypes = { 'html', 'javascript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue' },
  },
  autopairs = { enable = true },
  incrental_selection = {
    enable = true,
  },
  rainbow = {
    enable = true,
    disable = { 'html' },
    extended_mode = false,
    max_file_lines = nil,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
    config = {
      javascriptreact = { style_element = '{/*%s*/}' },
    },
  },
})
