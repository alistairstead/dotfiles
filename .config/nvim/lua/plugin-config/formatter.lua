local formatter = require('formatter')
local map = vim.api.nvim_set_keymap

map('n', '<leader>f', ':Format<cr>', {noremap = true, silent = true})

local formatter_prettier = function()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))},
    stdin = true
  }
end

local mix = function()
  return {
    exe = "mix",
    args = {"format", "-"},
    stdin = true
  }
end

formatter.setup {
  filetype = {
    javascript = formatter_prettier,
    javascriptreact = formatter_prettier,
    typescript = formatter_prettier,
    typescriptreact = formatter_prettier,
    json = formatter_prettier,
    javascript = { prettier },
    typescript = { prettier },
    typescriptreact = { prettier },
    elixir = { mix },
  }
}

vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html FormatWrite
augroup END
]], true)
