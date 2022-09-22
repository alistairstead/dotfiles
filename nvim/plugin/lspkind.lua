local ok, lspkind = pcall(require, "lspkind")
if not ok then
    return
end

lspkind.init({
  -- mode = "symbol",
  -- symbol_map = {
  --   Text = "",
  --   Method = "m",
  --   Function = "",
  --   Constructor = "",
  --   Field = "",
  --   Variable = "",
  --   Class = "ﴯ",
  --   Interface = "",
  --   Module = "",
  --   Property = "ﰠ",
  --   Unit = "",
  --   Value = "",
  --   Enum = "",
  --   Keyword = "",
  --   Snippet = "",
  --   Color = "",
  --   File = "",
  --   Reference = "",
  --   Folder = "",
  --   EnumMember = "",
  --   Constant = "",
  --   Struct = "",
  --   Event = "",
  --   Operator = "",
  --   TypeParameter = "",
  -- },
})
