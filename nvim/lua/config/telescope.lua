local M = {}

function M.setup()
	local status_ok, telescope = pcall(require, "telescope")
	if not status_ok then
		return
	end
	local telescopeConfig = require("telescope.config")

	-- Clone the default Telescope configuration
	local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

	-- I want to search in hidden/dot files.
	table.insert(vimgrep_arguments, "--hidden")
	-- I don't want to search in the `.git` directory.
	table.insert(vimgrep_arguments, "--glob")
	table.insert(vimgrep_arguments, "!.git/*")

	telescope.load_extension("fzf")
	telescope.load_extension("media_files")
	telescope.load_extension("file_browser")
	-- telescope.load_extension("project") -- telescope-project.nvim
	-- telescope.load_extension("projects") -- project.nvim
	-- telescope.load_extension("repo")
	-- telescope.load_extension("dap")
	-- telescope.load_extension "frecency"
	-- telescope.load_extension "neoclip"
	-- telescope.load_extension "smart_history"
	-- telescope.load_extension "arecibo"
	-- telescope.load_extension "bookmarks"
	-- telescope.load_extension "aerial"
	-- telescope.load_extension "gh"
	-- telescope.load_extension "zoxide"
	-- telescope.load_extension "cder"

	local actions = require("telescope.actions")

	telescope.setup({
		defaults = {
			-- `hidden = true` is not supported in text grep commands.
			vimgrep_arguments = vimgrep_arguments,
      file_ignore_patters = { "yarn.lock", "package-lock.json" },
			prompt_prefix = " ",
			selection_caret = "> ",
			path_display = { "smart" },

			mappings = {
				i = {
					["<C-n>"] = actions.cycle_history_next,
					["<C-p>"] = actions.cycle_history_prev,

					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,

					["<C-c>"] = actions.close,

					["<Down>"] = actions.move_selection_next,
					["<Up>"] = actions.move_selection_previous,

					["<CR>"] = actions.select_default,
					["<C-x>"] = actions.select_horizontal,
					["<C-v>"] = actions.select_vertical,
					["<C-t>"] = actions.select_tab,

					["<C-u>"] = actions.preview_scrolling_up,
					["<C-d>"] = actions.preview_scrolling_down,

					["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
					["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					["<C-l>"] = actions.complete_tag,
					["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
				},

				n = {
					["<esc>"] = actions.close,
					["<CR>"] = actions.select_default,
					["<C-x>"] = actions.select_horizontal,
					["<C-v>"] = actions.select_vertical,
					["<C-t>"] = actions.select_tab,

					["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
					["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

					["j"] = actions.move_selection_next,
					["k"] = actions.move_selection_previous,
					["H"] = actions.move_to_top,
					["M"] = actions.move_to_middle,
					["L"] = actions.move_to_bottom,

					["<Down>"] = actions.move_selection_next,
					["<Up>"] = actions.move_selection_previous,
					["gg"] = actions.move_to_top,
					["G"] = actions.move_to_bottom,

					["<C-u>"] = actions.preview_scrolling_up,
					["<C-d>"] = actions.preview_scrolling_down,

					["?"] = actions.which_key,
				},
			},
		},
		pickers = {
			find_files = {
				-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
				find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
			},
			-- Default configuration for builtin pickers goes here:
			-- picker_name = {
			--   picker_config_key = value,
			--   ...
			-- }
			-- Now the picker_config_key will be applied every time you call this
			-- builtin picker
		},
		extensions = {
			media_files = {
				-- filetypes whitelist
				-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
				filetypes = { "png", "webp", "jpg", "jpeg", "pdf", "mp4", "webm" },
				find_cmd = "rg", -- find command (defaults to `fd`)
			},
			project = {
				hidden_files = false,
				theme = "dropdown",
			},
			-- Your extension configuration goes here:
			-- extension_name = {
			--   extension_config_key = value,
			-- }
			-- please take a look at the readme of the extension you want to configure
		},
	})
end

return M
