local ok, windline = pcall(require, 'windline')
if not ok then
  return
end

require('wlsample.airline')

-- windline.setup({
--   -- hide that filetype on global statusline
--     global_skip_filetypes = {
--         'dashboard',
--         'neo-tree',
--         'lir',
--     }
-- })


