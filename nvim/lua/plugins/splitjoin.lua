return {
  {
    "echasnovski/mini.splitjoin",
    enabled = false,
    opts = { mappings = { toggle = "J" } },
    keys = {
      { "J", desc = "Split/Join" },
    },
  },
  {
    "Wansmer/treesj",
    keys = {
      { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },
}
