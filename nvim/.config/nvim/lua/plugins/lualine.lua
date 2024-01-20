return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    table.insert(opts.sections.lualine_x, {
      function()
        return require("util.dashboard").status()
      end,
    })

    table.insert(opts.sections.lualine_z, {})
  end,
}
