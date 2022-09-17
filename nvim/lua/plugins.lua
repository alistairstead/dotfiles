local PACKER_BOOTSTRAP = false

-- packer.nvim configuration
local conf = {
	max_jobs = 10,
	profile = {
		enable = true,
		threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
	},

	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
}

-- Check if packer.nvim is installed
-- Run PackerCompile if there are changes in this file
local function packer_init()
	local fn = vim.fn
	-- Automatically install packer
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		PACKER_BOOTSTRAP = fn.system({
			"git",
			"clone",
			"--depth",
			"1",
			"https://github.com/wbthomason/packer.nvim",
			install_path,
		})
		print("Installing packer close and reopen Neovim...")
		vim.cmd([[packadd packer.nvim]])
	end

	-- Autocommand that reloads neovim whenever you save the plugins.lua file
	vim.cmd([[
    augroup packer_user_config
      autocmd!
      autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
  ]])
end

-- Plugins
local function plugins(use)
	-- Packer
	use({ "wbthomason/packer.nvim" })
	-- Performance
	use({ "lewis6991/impatient.nvim" })
	use({
		"max397574/better-escape.nvim",
		event = { "InsertEnter" },
		config = function()
			require("better_escape").setup({
				mapping = { "jk" },
				timeout = vim.o.timeoutlen,
				keys = "<ESC>",
			})
		end,
	})
	use({
		"antoinemadec/FixCursorHold.nvim",
		event = "BufReadPre",
		config = function()
			vim.g.cursorhold_updatetime = 100
		end,
	})
	use({ "dstein64/vim-startuptime", cmd = "StartupTime" })
	use({
		"nathom/filetype.nvim",
		config = function()
			vim.g.did_load_filetype = 1
		end,
	})
	-- /Performance
	-- Load only when require
	use({ "nvim-lua/plenary.nvim", module = "plenary" })

	-- IDE functionality
	--
	-- Startup screen
	use({
		"goolord/alpha-nvim",
		config = function()
			require("config.alpha").setup()
		end,
	})
	-- Notification
	use({
		"rcarriga/nvim-notify",
		event = "BufReadPre",
		config = function()
			require("config.notify").setup()
		end,
		disable = true,
	})

	-- Better icons
	use({
		"kyazdani42/nvim-web-devicons",
		module = "nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({ default = true })
		end,
	})


	-- nvim-tree
	use({
		"kyazdani42/nvim-tree.lua",
		opt = true,
		wants = "nvim-web-devicons",
		cmd = { "NvimTreeToggle", "NvimTreeClose" },
		-- module = "nvim-tree",
		config = function()
			require("config.nvimtree").setup()
		end,
	})

	-- Status line
	use({
		"nvim-lualine/lualine.nvim",
		event = "BufReadPre",
		after = "nvim-treesitter",
		config = function()
			require("config.lualine").setup()
		end,
		wants = "nvim-web-devicons",
	})

	-- trouble.nvim
	use({
		"folke/trouble.nvim",
		wants = "nvim-web-devicons",
		cmd = { "TroubleToggle", "Trouble" },
		config = function()
			require("trouble").setup({
				use_diagnostic_signs = true,
			})
		end,
	})

	-- Sidebar
	use({
		"liuchengxu/vista.vim",
		cmd = { "Vista" },
		config = function()
			vim.g.vista_default_executive = "nvim_lsp"
		end,
		disable = true,
	})
	use({
		"sidebar-nvim/sidebar.nvim",
		cmd = { "SidebarNvimToggle" },
		config = function()
			require("sidebar-nvim").setup({ open = false })
		end,
		disable = true,
	})
	use({
		"stevearc/aerial.nvim",
		config = function()
			require("aerial").setup()
		end,
		module = { "aerial" },
		cmd = { "AerialToggle" },
	})

	-- User interface
	use({
		"stevearc/dressing.nvim",
		event = "BufReadPre",
		config = function()
			require("dressing").setup({
				input = { relative = "editor" },
				select = {
					backend = { "telescope", "fzf", "builtin" },
				},
			})
		end,
		disable = true,
	})

	-- Smooth scrolling
	use({
		"karb94/neoscroll.nvim",
		event = "BufReadPre",
		config = function()
			require("config.neoscroll").setup()
		end,
	})

	-- Search
	use({ "google/vim-searchindex", event = "BufReadPre" })

	-- Terminal
	use({
		"akinsho/toggleterm.nvim",
		keys = { [[<C-\>]] },
		cmd = { "ToggleTerm", "TermExec" },
		module = { "toggleterm", "toggleterm.terminal" },
		config = function()
			require("config.toggleterm").setup()
		end,
	})

	-- Legendary
	use({
		"mrjones2014/legendary.nvim",
		opt = true,
		keys = { [[<C-p>]] },
		-- wants = { "dressing.nvim" },
		module = { "legendary" },
		cmd = { "Legendary" },
		config = function()
			require("config.legendary").setup()
		end,
		-- requires = { "stevearc/dressing.nvim" },
	})

	-- WhichKey
	use({
		"folke/which-key.nvim",
		event = "VimEnter",
		-- keys = { [[<leader>]] },
		config = function()
			require("config.whichkey").setup()
		end,
	})

	-- Refactoring
	use({
		"ThePrimeagen/refactoring.nvim",
		module = { "refactoring", "telescope" },
		keys = { [[<leader>r]] },
		wants = { "telescope.nvim" },
		config = function()
			require("config.refactoring").setup()
		end,
	})
	use({
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		disable = true,
		config = function()
			require("bqf").setup()
		end,
		disable = true,
	})
	use({ "nvim-pack/nvim-spectre", module = "spectre", keys = { "<leader>s" } })
	use({
		"https://gitlab.com/yorickpeterse/nvim-pqf",
		event = "BufReadPre",
		config = function()
			require("pqf").setup()
		end,
		disable = true,
	})
	use({
		"andrewferrier/debugprint.nvim",
		module = { "debugprint" },
		keys = { "g?p", "g?P", "g?v", "g?V", "g?o", "g?O" },
		cmd = { "DeleteDebugPrints" },
		config = function()
			require("debugprint").setup()
		end,
		disable = true,
	})
	-- /IDE functionality

	-- Colorscheme
	use({
		"folke/tokyonight.nvim",
	})

	use({
		"projekt0n/github-nvim-theme",
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		opt = true,
		event = "BufReadPre",
		run = ":TSUpdate",
	})
	use({
		"narutoxy/dim.lua",
		requires = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
		config = function()
			require("dim").setup({
				disable_lsp_decorations = true,
			})
		end,
	})

	-- editorconfig
	use({
		"gpanders/editorconfig.nvim",
		event = "BufReadPre",
	})

	-- AI completion
	use({
		"github/copilot.vim",
		-- opt = true,
		-- event = "InsertEnter",
		config = function()
			require("config.copilot").setup()
		end,
		-- disable = false,
	})

	-- Completion
	use({
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		opt = true,
		config = function()
			require("config.cmp").setup()
		end,
		wants = { "LuaSnip" },
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			"ray-x/cmp-treesitter",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"lukas-reineke/cmp-rg",
			"davidsierradz/cmp-conventionalcommits",
			-- "onsails/lspkind-nvim",
			-- "hrsh7th/cmp-calc",
			-- "f3fora/cmp-spell",
			-- "hrsh7th/cmp-emoji",
			{
				"L3MON4D3/LuaSnip",
				wants = { "friendly-snippets" },
				config = function()
					require("config.snip").setup()
				end,
			},
			"rafamadriz/friendly-snippets",
		},
	})

	-- Better surround
	use({ "tpope/vim-surround", event = "BufReadPre" })

	-- Better Comment
	use({
		"numToStr/Comment.nvim",
		keys = { "gc", "gcc", "gbc" },
		config = function()
			require("config.comment").setup()
		end,
		disable = false,
	})
	use({ "tpope/vim-commentary", keys = { "gc", "gcc", "gbc" }, disable = true })

	-- Jumps
	use({
		"ggandor/leap.nvim",
		keys = { "s", "S", "f", "F", "t", "T" },
		config = function()
			local leap = require("leap")
			leap.set_default_keymaps()
		end,
		disable = true,
	})
	use({
		"AndrewRadev/splitjoin.vim",
		keys = { "gS", "gJ" },
	})

	-- Harpoon
	use({
		"ThePrimeagen/harpoon",
		keys = { [[<leader>j]] },
		module = { "harpoon", "harpoon.cmd-ui", "harpoon.mark", "harpoon.ui", "harpoon.term" },
		wants = { "telescope.nvim" },
		config = function()
			require("config.harpoon").setup()
		end,
		disable = true,
	})

	-- Buffer
	use({
		"kazhala/close-buffers.nvim",
		cmd = { "BDelete", "BWipeout" },
	})
	use({
		"matbme/JABS.nvim",
		cmd = "JABSOpen",
		config = function()
			require("config.jabs").setup()
		end,
	})
	use({
		"chentoast/marks.nvim",
		event = "BufReadPre",
		config = function()
			require("marks").setup({})
		end,
	})

	-- Automatic closing of code structures
	-- Auto pairs
	use({
		"windwp/nvim-autopairs",
		opt = true,
		event = "InsertEnter",
		wants = "nvim-treesitter",
		module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
		config = function()
			require("config.autopairs").setup()
		end,
	})

	-- Auto tag
	use({
		"windwp/nvim-ts-autotag",
		opt = true,
		wants = "nvim-treesitter",
		event = "InsertEnter",
		config = function()
			require("nvim-ts-autotag").setup({ enable = true })
		end,
	})

	-- End wise
	use({
		"RRethy/nvim-treesitter-endwise",
		opt = true,
		wants = "nvim-treesitter",
		event = "InsertEnter",
	})

	-- /Automatic closing of code structures

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		-- opt = true,
		config = function()
			require("config.telescope").setup()
		end,
		cmd = { "Telescope" },
		module = { "telescope", "telescope.builtin" },
		keys = { "<leader>f", "<leader>p", "<leader>z" },
		wants = {
			"plenary.nvim",
			"popup.nvim",
			--
			"telescope-fzf-native.nvim",
			"telescope-media-files.nvim",
			"telescope-file-browser.nvim",
			-- "telescope-project.nvim",
			-- "project.nvim",
			-- "telescope-repo.nvim",
			-- "trouble.nvim",
			-- "telescope-dap.nvim",
			--
			-- "telescope-frecency.nvim",
			-- "nvim-neoclip.lua",
			-- "telescope-smart-history.nvim",
			-- "telescope-arecibo.nvim",
			-- "telescope-github.nvim",
			-- "telescope-zoxide",
			-- "cder.nvim",
			-- "telescope-bookmarks.nvim",
			-- "aerial.nvim",
			-- "telescope-ui-select.nvim",
		},
		requires = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			--
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
			{ "nvim-telescope/telescope-media-files.nvim" },
			{ "nvim-telescope/telescope-file-browser.nvim" },
			-- { "nvim-telescope/telescope-project.nvim" },
			-- {
			-- 	"ahmedkhalf/project.nvim",
			-- 	config = function()
			-- 		require("config.project").setup()
			-- 	end,
			-- },
			-- { "cljoly/telescope-repo.nvim" },
			-- { "nvim-telescope/telescope-dap.nvim" },
			-- { "nvim-telescope/telescope-frecency.nvim", requires = "tami5/sqlite.lua" },
			--
			-- {
			--   "airblade/vim-rooter",
			--   config = function()
			--     require("config.rooter").setup()
			--   end,
			-- },
			-- {
			--   "AckslD/nvim-neoclip.lua",
			--   requires = {
			--     { "tami5/sqlite.lua", module = "sqlite" },
			--     -- config = function()
			--     --   require("neoclip").setup()
			--     -- end,
			--   },
			-- },
			-- "nvim-telescope/telescope-smart-history.nvim",
			-- {
			--   "nvim-telescope/telescope-arecibo.nvim",
			--   rocks = { "openssl", "lua-http-parser" },
			-- },
			-- "dhruvmanila/telescope-bookmarks.nvim",
			-- "nvim-telescope/telescope-github.nvim",
			-- "jvgrootveld/telescope-zoxide",
			-- "Zane-/cder.nvim",
			-- "nvim-telescope/telescope-symbols.nvim",
			-- "nvim-telescope/telescope-ui-select.nvim",
		},
	})

	-- Quickfix
	use({ "romainl/vim-qf", event = "BufReadPre", disable = true })

	-- LSP
	use({
		"neovim/nvim-lspconfig",
		opt = true,
		event = { "BufReadPre" },
		wants = {
			"mason.nvim",
			"mason-lspconfig.nvim",
			"mason-tool-installer.nvim",
			"cmp-nvim-lsp",
			"lua-dev.nvim",
			"null-ls.nvim",
			"typescript.nvim",
			"schemastore.nvim",
		},
		config = function()
			require("config.lsp").setup()
		end,
		requires = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"folke/lua-dev.nvim",
			"jose-elias-alvarez/null-ls.nvim",
			"jose-elias-alvarez/typescript.nvim",
			"b0o/schemastore.nvim",
			{
				"zbirenbaum/neodim",
				event = "LspAttach",
				config = function()
					require("config.neodim").setup()
				end,
			},
		},
	})

	-- lspsaga.nvim
	use({
		"glepnir/lspsaga.nvim",
		cmd = { "Lspsaga" },
		config = function()
			require("lspsaga").init_lsp_saga()
		end,
	})

	-- renamer.nvim
	use({
		"filipdutescu/renamer.nvim",
		module = { "renamer" },
		config = function()
			require("renamer").setup({})
		end,
	})

	-- /LSP

	-- Debugging
	use({
		"mfussenegger/nvim-dap",
		opt = true,
		-- event = "BufReadPre",
		keys = { [[<leader>d]] },
		module = { "dap" },
		wants = { "nvim-dap-virtual-text", "nvim-dap-ui", "which-key.nvim" },
		requires = {
			"theHamsta/nvim-dap-virtual-text",
			"rcarriga/nvim-dap-ui",
			"nvim-telescope/telescope-dap.nvim",
			{ "jbyuki/one-small-step-for-vimkind", module = "osv" },
		},
		config = function()
			require("config.dap").setup()
		end,
	})

	-- Git
	use({
		"TimUntersberger/neogit",
		cmd = "Neogit",
		config = function()
			require("config.neogit").setup()
		end,
	})
	use({
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		wants = "plenary.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("config.gitsigns").setup()
		end,
	})
	use({
		"ruifm/gitlinker.nvim",
		requires = "nvim-lua/plenary.nvim",
		module = "gitlinker",
		config = function()
			require("gitlinker").setup({ mappings = nil })
		end,
	})
	use({
		"akinsho/git-conflict.nvim",
		cmd = {
			"GitConflictChooseTheirs",
			"GitConflictChooseOurs",
			"GitConflictChooseBoth",
			"GitConflictChooseNone",
			"GitConflictNextConflict",
			"GitConflictPrevConflict",
			"GitConflictListQf",
		},
		config = function()
			require("git-conflict").setup()
		end,
	})
	use({
		"knsh14/vim-github-link",
		cmd = { "GetCommitLink", "GetCurrentBranchLink", "GetCurrentCommitLink" },
	})

	-- Diffview
	use({
		"sindrets/diffview.nvim",
		requires = "nvim-lua/plenary.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles" },
	})

	-- Code screen shots
	use({
		"segeljakt/vim-silicon",
		cmd = { "Silicon" },
	})

	-- Bootstrap Neovim
	if PACKER_BOOTSTRAP then
		print("Neovim restart is required after installation!")
		require("packer").sync()
	end
end

-- Init and start packer
packer_init()
-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Performance
local impatient_ok, impatient = pcall(require, "impatient")
if impatient_ok then
	impatient.enable_profile()
end
-- pcall(require, "packer_compiled")

packer.init(conf)
packer.startup(plugins)
