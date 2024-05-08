return {
  "zbirenbaum/neodim",
  -- event = { 'VeryLazy' },
  enabled = false,
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    alpha = 0.7,
    hide = {
      signs = false,
      virtual_text = false,
      underline = true,
    },
  },
}
