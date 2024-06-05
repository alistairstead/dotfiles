return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    local function add(lang)
      if type(opts.ensure_installed) == "table" then
        table.insert(opts.ensure_installed, lang)
      end
    end

    vim.filetype.add({
      extension = {
        astro = "astro",
      },
      pattern = {
        [".*/kitty/*.conf"] = "bash",
      },
    })

    add("git_config")
    add("astro")
    add("twig")
    add("typescript")
    add("lua")
    add("markdown")
    add("markdown_inline")
    add("yaml")
    add("toml")
    add("json")
    add("go")
  end,
}
