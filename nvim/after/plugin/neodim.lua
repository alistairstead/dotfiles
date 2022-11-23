local ok, neodim = pcall(require, 'neodim')
if not ok then
  return
end

neodim.setup({
  alpha = 0.4,
  hide = {
    signs = true,
    virtual_text = false,
    underline = true,
  },
})
