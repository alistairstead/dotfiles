return {
  "nvim-lualine/lualine.nvim",
  opts = function()
    local function is_active()
      local ok, hydra = pcall(require, "hydra.statusline")
      return ok and hydra.is_active()
    end

    local function is_not_active()
      local ok, hydra = pcall(require, "hydra.statusline")
      return ok and not hydra.is_active()
    end

    local function get_name()
      local ok, hydra = pcall(require, "hydra.statusline")
      if ok then
        return hydra.get_name()
      end
      return ""
    end

    return {
      -- theme = "dracula-nvim",
      sections = {
        lualine_a = { { "mode", cond = is_not_active }, { get_name, cond = is_active } },
        lualine_z = {
          function()
            return " " .. os.date("%I:%M %p")
          end,
        },
      },
    }
  end,
}
