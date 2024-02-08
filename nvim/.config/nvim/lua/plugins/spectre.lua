return {
  "nvim-pack/nvim-spectre",
  keys = function()
    local wk = require("which-key")
    wk.register({
      r = {
        name = "+replace",
      },
    }, {
      prefix = "<leader>s",
      mode = { "n" },
    })
    return {
      {
        "<leader>sr",
        desc = "+replace",
      },
      {
        "<leader>srr",
        function()
          require("spectre").open()
        end,
        desc = "Replace in files",
      },
      {
        "<leader>srw",
        function()
          require("spectre").open_visual({ select_word = true })
        end,
        desc = "Replace current word",
        mode = { "n", "v" },
      },
      {
        "<leader>srW",
        function()
          require("spectre").open_file_search({ select_word = true })
        end,
        desc = "Replace current word in files",
      },
    }
  end,
}
