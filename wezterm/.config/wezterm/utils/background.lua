local M = {}
local h = require("utils/helpers")

M.get_background = function()
  return {
    source = {
      Gradient = {
        colors = { h.is_dark() and "#000000" or "#ffffff" },
      },
    },
    width = "100%",
    height = "100%",
    opacity = h.is_dark() and 0.85 or 1,
  }
end

return M
