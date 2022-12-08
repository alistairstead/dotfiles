local ok, copilot = pcall(require, 'copilot')
if not ok then
  return
end

copilot.setup({
  filetypes = {
    markdown = true, -- overrides default
  },
})
