localr M = {}

function M.setup()

  local function plugins(use)

    -- Markdown
    use {
      "iamcco/markdown-preview.nvim",
      opt = true,
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
      ft = "markdown",
      cmd = { "MarkdownPreview" },
      requires = { "zhaozg/vim-diagram", "aklt/plantuml-syntax" },
    }
    use {
      "jakewvincent/mkdnflow.nvim",
      config = function()
        require("mkdnflow").setup {}
      end,
      ft = "markdown",
    }
    use {
      "nvim-neorg/neorg",
      config = function()
        require("neorg").setup {
          load = {
            ["core.defaults"] = {},
            ["core.presenter"] = {
              config = {
                zen_mode = "truezen",
              },
            },
          },
        }
      end,
      ft = "norg",
      after = "nvim-treesitter",
      requires = { "nvim-lua/plenary.nvim", "Pocco81/TrueZen.nvim" },
      disable = true,
    }





    -- Translation
    use {
      "voldikss/vim-translator",
      cmd = { "Translate", "TranslateV", "TranslateW", "TranslateWV", "TranslateR", "TranslateRV", "TranslateX" },
      config = function()
        vim.g.translator_target_lang = "zh"
        vim.g.translator_history_enable = true
      end,
      disable = true,
    }

    use {
      "michaelb/sniprun",
      run = "bash ./install.sh",
      cmd = { "SnipRun", "SnipInfo", "SnipReset", "SnipReplMemoryClean", "SnipClose", "SnipLive" },
      module = { "sniprun", "sniprun.api" },
      disable = true,
    }

    -- Testing
    use {
      "linty-org/readline.nvim",
      event = { "BufReadPre" },
      config = function()
        require("config.readline").setup()
      end,
      disable = true,
    }
    use { "protex/better-digraphs.nvim", module = { "better-digraphs" }, disable = true }
    use {
      "ziontee113/icon-picker.nvim",
      config = function()
        require("icon-picker").setup {
          disable_legacy_commands = true,
        }
      end,
      cmd = { "IconPickerNormal", "IconPickerYank", "IconPickerInsert" },
      disable = true,
    }

    use {
      "m-demare/attempt.nvim",
      opt = true,
      requires = "nvim-lua/plenary.nvim",
      module = { "attempt" },
      config = function()
        require("config.attempt").setup()
      end,
      disable = true,
    }
    use {
      "gbprod/substitute.nvim",
      event = "BufReadPre",
      config = function()
        require("config.substitute").setup()
      end,
      disable = true,
    }
    use {
      "AckslD/nvim-trevJ.lua",
      config = function()
        require("trevj").setup()
      end,
      module = "trevj",
      setup = function()
        vim.keymap.set("n", ",j", function()
          require("trevj").format_at_cursor()
        end)
      end,
      disable = true,
    }
    use {
      "narutoxy/dim.lua",
      requires = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
      config = function()
        require("dim").setup {
          disable_lsp_decorations = true,
        }
      end,
      disable = true,
    }
    use { "mg979/vim-visual-multi", event = "BufReadPre", disable = false }
    use {
      "anuvyklack/hydra.nvim",
      config = function()
        require("config.hydra").setup()
      end,
      requires = "anuvyklack/keymap-layer.nvim",
      module = { "hydra" },
      event = { "BufReadPre" },
      disable = true,
    }
    use {
      "Olical/conjure",
      cmd = { "ConjureSchool" },
      config = function()
        vim.g["conjure#extract#tree_sitter#enabled"] = true
      end,
      disable = true,
    }


  end

end

return M
