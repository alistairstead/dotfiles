local M = {}

function M.setup()
	local nvim_tree_status_ok, nvim_tree = pcall(require, "nvim-tree")
	if not nvim_tree_status_ok then
		return
	end

	local nvim_tree_config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
	if not nvim_tree_config_status_ok then
		return
	end

	local tree_cb = nvim_tree_config.nvim_tree_callback

	nvim_tree.setup({
		disable_netrw = true,
		hijack_netrw = true,
		reload_on_bufenter = true,
		filters = {
			custom = { ".git", "node_modules", ".build", ".vscode" },
		},
		git = {
			ignore = true,
		},
		view = {
			width = 28,
			side = "right",
			signcolumn = "yes",
			mappings = {
				custom_only = false,
				list = {
					{ key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
					{ key = "h", cb = tree_cb("close_node") },
					{ key = "v", cb = tree_cb("vsplit") },
				},
			},
		},
		renderer = {
			add_trailing = true,
			highlight_git = false,
			full_name = true,
			highlight_opened_files = "all",
			root_folder_modifier = ":~",
			indent_markers = {
				enable = false,
				inline_arrows = true,
			},
			icons = {
				webdev_colors = false,
				git_placement = "before",
				padding = " ",
				symlink_arrow = " ➛ ",
				show = {
					file = true,
					folder = true,
					folder_arrow = false,
					git = true,
				},
				glyphs = {
					git = {
						unstaged = "!",
						staged = "",
						unmerged = "",
						renamed = "",
						untracked = "?",
						deleted = "",
						ignored = "",
					},
				},
			},
			special_files = { "README.md" },
			symlink_destination = true,
		},
		update_focused_file = {
			enable = true,
		},
		diagnostics = {
			enable = false,
			show_on_dirs = true,
			icons = { error = "", warning = "", info = "", hint = "" },
		},
		actions = {
			change_dir = {
				restrict_above_cwd = true,
			},
		},
		trash = {
			cmd = "rm",
		},
	})

	vim.cmd("highlight NvimTreeRootFolder guifg=NONE")
	vim.cmd("highlight NvimTreeFolderIcon guifg=NONE")
end

return M
