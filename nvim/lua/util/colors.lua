Colors = {}

function Colors.setup()
  vim.opt.termguicolors = true
end

---@diagnostic disable-next-line: duplicate-set-field
function Colors.get_hl(name)
  return vim.api.nvim_get_hl_by_name(name, true)
end

---@diagnostic disable-next-line: duplicate-set-field
function Colors.update_hl(name, overrides)
  local hl = vim.api.nvim_get_hl_by_name(name, true)
  for k, v in pairs(overrides) do
    hl[k] = v
  end
  vim.api.nvim_set_hl(0, name, hl)
end

---@diagnostic disable-next-line: duplicate-set-field
function Colors.inherit_hl(from_name, to_name, overrides)
  local hl = vim.api.nvim_get_hl_by_name(from_name, true)
  for k, v in pairs(overrides) do
    hl[k] = v
  end
  vim.api.nvim_set_hl(0, to_name, hl)
end

return Colors
