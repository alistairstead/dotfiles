local status_ok, mason = pcall(require, 'mason')
if not status_ok then
  return
end

mason.setup({
  log_level = vim.log.levels.DEBUG
})
