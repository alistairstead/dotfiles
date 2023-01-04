local ok, neodim = pcall(require, 'neodim')
if not ok then
  return
end

neodim.setup({
  alpha = 0.5,
  hide = {
    signs = false,
    virtual_text = true,
    underline = true,
  },
})
