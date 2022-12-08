local ok, refactoring = pcall(require, 'refactoring')
if not ok then
  return
end
local Remap = require('alistairstead.keymap')
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap

nnoremap('<leader>ri', function()
  refactoring.refactor('Inline Variable')
end, { desc = 'Refactor to inline variable' })

vnoremap('<leader>re', function()
  refactoring.refactor('Extract Variable')
end, { desc = 'Refactor to extract variable' })
