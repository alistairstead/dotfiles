vim.cmd([[
  augroup jsx_types
    autocmd!
    autocmd BufRead,BufNewFile *.tsx,*.jsx setlocal filetype=typescript.tsx
  augroup end
]])
