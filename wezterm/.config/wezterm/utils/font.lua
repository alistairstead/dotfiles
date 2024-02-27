local wezterm = require("wezterm")
local M = {}

M.font_with_fallback = function(family, weight)
  return wezterm.font_with_fallback({
    {
      family = family,
      weight = weight,
      harfbuzz_features = { "calt", "liga", "dlig", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" },
    },
    { family = "Symbols Nerd Font Mono", scale = 0.75 },
  })
end

return M
