local M = {}

local status_ok, whichkey = pcall(require, "which-key")
if not status_ok then
	return
end
local legendary_ok, legendary = pcall(require, "legendary")

local next = next

local conf = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	operators = { gc = "Comments" },
	-- objects = {
	-- 	cs = "Surround",
	-- },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = ":", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "none", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		-- margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		-- padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		-- winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = false, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}
whichkey.setup(conf)

local opts = {
	mode = "n", -- Normal mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = false, -- use `nowait` when creating keymaps
}

local v_opts = {
	mode = "v", -- Visual mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = false, -- use `nowait` when creating keymaps
}

local function normal_keymap()
	local keymap_f = nil -- File search
	local keymap_p = nil -- Project search

	keymap_f = {
		name = "Find",
		f = { "<cmd>lua require('utils.finder').find_files()<cr>", "Files" },
		d = { "<cmd>lua require('utils.finder').find_dotfiles()<cr>", "Dotfiles" },
		b = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Buffers" },
		h = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Help" },
		m = { "<cmd>lua require('telescope.builtin').marks()<cr>", "Marks" },
		r = { "<cmd>lua require('telescope.builtin').oldfiles()<cr>", "Recent Files" },
		g = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Live Grep" },
		k = { "<cmd>lua require('telescope.builtin').keymaps()<cr>", "Keymaps" },
		c = { "<cmd>lua require('telescope.builtin').commands()<cr>", "Commands" },
		B = { "<cmd>lua require'telescope'.extensions.file_browser.file_browser()<cr>", "File Browser" },
		w = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", "Current Buffer" },
	}

	keymap_p = {
		name = "Project",
		p = { "<cmd>lua require'telescope'.extensions.project.project{display_type = 'full'}<cr>", "List" },
		s = { "<cmd>lua require'telescope'.extensions.repo.list{}<cr>", "Search" },
	}

	local keymap = {
		["/"] = { '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', "Comment" },
		["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
		["b"] = { "<Cmd>BufferLinePick<Cr>", "Pick a Buffer" },
		["c"] = { "<cmd>BDelete! this<CR>", "Close Buffer" },
		["w"] = { "<cmd>update!<CR>", "Save" },
		["q"] = { "<cmd>lua require('utils').quit()<CR>", "Quit" },
		["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
		-- ["t"] = { "<cmd>ToggleTerm<CR>", "Terminal" },

		["A"] = {
			name = "Attempt",
			n = { "<Cmd>lua require('attempt').new_select()<Cr>", "New Select" },
			i = { "<Cmd>lua require('attempt').new_input_ext()<Cr>", "New Input Extension" },
			r = { "<Cmd>lua require('attempt').run()<Cr>", "Run" },
			d = { "<Cmd>lua require('attempt').delete_buf()<Cr>", "Delete Buffer" },
			c = { "<Cmd>lua require('attempt').rename_buf()<Cr>", "Rename Buffer" },
			s = { "<Cmd>Telescope attempt<Cr>", "Search" },
		},

		["B"] = {
			name = "Buffer",
			c = { "<Cmd>BDelete this<Cr>", "Close Buffer" },
			f = { "<Cmd>BDelete! this<Cr>", "Force close buffer" },
			D = { "<Cmd>BWipeout other<Cr>", "Delete other buffers" },
			b = { "<Cmd>BufferLinePick<Cr>", "Pick buffer" },
			p = { "<Cmd>BufferLinePickClose<Cr>", "Pick & close buffer" },
			m = { "<Cmd>JABSOpen<Cr>", "Menu" },
		},

		["C"] = {
			name = "Code",
			g = { "<cmd>Neogen func<Cr>", "Func Doc" },
			G = { "<cmd>Neogen class<Cr>", "Class Doc" },
			d = { "<cmd>DogeGenerate<Cr>", "Generate Doc" },
			T = { "<cmd>TodoTelescope<Cr>", "TODO" },
			x = "Swap Next Param",
			X = "Swap Prev Param",
			-- f = "Select Outer Function",
			-- F = "Select Outer Class",
		},

		["D"] = {
			name = "Debug",
		},

		f = keymap_f,
		p = keymap_p,

		j = {
			name = "Jump",
			a = { "<Cmd>lua require('harpoon.mark').add_file()<Cr>", "Add File" },
			m = { "<Cmd>lua require('harpoon.ui').toggle_quick_menu()<Cr>", "UI Menu" },
			c = { "<Cmd>lua require('harpoon.cmd-ui').toggle_quick_menu()<Cr>", "Command Menu" },
		},

		-- t = {
		--   name = "Test",
		--   S = { "<cmd>UltestSummary<cr>", "Summary" },
		--   a = { "<cmd>Ultest<cr>", "All" },
		--   c = { "<cmd>UltestClear<cr>", "Clear" },
		--   d = { "<cmd>UltestDebug<cr>", "Debug" },
		--   f = { "<cmd>TestFile<cr>", "File" },
		--   l = { "<cmd>TestLast<cr>", "Last" },
		--   n = { "<cmd>TestNearest<cr>", "Nearest" },
		--   o = { "<cmd>UltestOutput<cr>", "Output" },
		--   s = { "<cmd>TestSuite<cr>", "Suite" },
		--   v = { "<cmd>TestVisit<cr>", "Visit" },
		--   p = { "<Plug>PlenaryTestFile", "PlenaryTestFile" },
		-- },

		-- keymap_c.s = { "<cmd>OverseerRun<cr>", "Overseer Run" }
		-- keymap_c.S = { "<cmd>OverseerToggle!<cr>", "Overseer Toggle" }
		-- keymap_c.a = { "<cmd>OverseerQuickAction<cr>", "Overseer Quick Action" }
		-- keymap_c.A = { "<cmd>OverseerTaskAction<cr>", "Overseer Task Action" }

		-- o = {
		-- 	name = "Overseer",
		-- 	C = { "<cmd>OverseerClose<cr>", "OverseerClose" },
		-- 	a = { "<cmd>OverseerTaskAction<cr>", "OverseerTaskAction" },
		-- 	b = { "<cmd>OverseerBuild<cr>", "OverseerBuild" },
		-- 	c = { "<cmd>OverseerRunCmd<cr>", "OverseerRunCmd" },
		-- 	d = { "<cmd>OverseerDeleteBundle<cr>", "OverseerDeleteBundle" },
		-- 	l = { "<cmd>OverseerLoadBundle<cr>", "OverseerLoadBundle" },
		-- 	o = { "<cmd>OverseerOpen!<cr>", "OverseerOpen" },
		-- 	q = { "<cmd>OverseerQuickAction<cr>", "OverseerQuickAction" },
		-- 	r = { "<cmd>OverseerRun<cr>", "OverseerRun" },
		-- 	s = { "<cmd>OverseerSaveBundle<cr>", "OverseerSaveBundle" },
		-- 	t = { "<cmd>OverseerToggle!<cr>", "OverseerToggle" },
		-- },
		t = {
			name = "Terminal",
			n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
			u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
			t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
			p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
			f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
			h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
			v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
		},
		-- t = {
		-- 	name = "Test",
		-- 	a = { "<cmd>lua require('neotest').run.attach()<cr>", "Attach" },
		-- 	f = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Run File" },
		-- 	F = { "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Debug File" },
		-- 	l = { "<cmd>lua require('neotest').run.run_last()<cr>", "Run Last" },
		-- 	L = { "<cmd>lua require('neotest').run.run_last({ strategy = 'dap' })<cr>", "Debug Last" },
		-- 	n = { "<cmd>lua require('neotest').run.run()<cr>", "Run Nearest" },
		-- 	N = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Debug Nearest" },
		-- 	o = { "<cmd>lua require('neotest').output.open({ enter = true })<cr>", "Output" },
		-- 	S = { "<cmd>lua require('neotest').run.stop()<cr>", "Stop" },
		-- 	s = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Summary" },
		-- 	p = { "<Plug>PlenaryTestFile", "PlenaryTestFile" },
		-- 	v = { "<cmd>TestVisit<cr>", "Visit" },
		-- 	x = { "<cmd>TestSuite<cr>", "Suite" },
		-- 	t = {
		-- 		name = "Test",
		-- 		l = { "<cmd>TestLast<cr>", "Run Last" },
		-- 		n = { "<cmd>TestNearest<cr>", "Run Nearest" },
		-- 	},
		-- },

		-- r = {
		-- 	name = "Refactor",
		-- 	i = { [[<cmd>lua require('refactoring').refactor('Inline Variable')<cr>]], "Inline Variable" },
		-- 	b = { [[<cmd>lua require('refactoring').refactor('Exract Block')<cr>]], "Extract Block" },
		-- 	B = { [[<cmd>lua require('refactoring').refactor('Exract Block To File')<cr>]], "Extract Block to File" },
		-- 	P = {
		-- 		[[<cmd>lua require('refactoring').debug.printf({below = false})<cr>]],
		-- 		"Debug Print",
		-- 	},
		-- 	p = {
		-- 		[[<cmd>lua require('refactoring').debug.print_var({normal = true})<cr>]],
		-- 		"Debug Print Variable",
		-- 	},
		-- 	c = { [[<cmd>lua require('refactoring').debug.cleanup({})<cr>]], "Debug Cleanup" },
		-- },

		s = {
			name = "Search",
			o = { [[ <Esc><Cmd>lua require('spectre').open()<CR>]], "Open" },
			c = { [[ <Esc><Cmd>lua require('utils.cht').cht()<CR>]], "Code" },
		},

		-- v = {
		-- 	name = "Vimspector",
		-- 	G = { "<cmd>lua require('config.vimspector').generate_debug_profile()<cr>", "Generate Debug Profile" },
		-- 	I = { "<cmd>VimspectorInstall<cr>", "Install" },
		-- 	U = { "<cmd>VimspectorUpdate<cr>", "Update" },
		-- 	R = { "<cmd>call vimspector#RunToCursor()<cr>", "Run to Cursor" },
		-- 	c = { "<cmd>call vimspector#Continue()<cr>", "Continue" },
		-- 	i = { "<cmd>call vimspector#StepInto()<cr>", "Step Into" },
		-- 	o = { "<cmd>call vimspector#StepOver()<cr>", "Step Over" },
		-- 	s = { "<cmd>call vimspector#Launch()<cr>", "Start" },
		-- 	t = { "<cmd>call vimspector#ToggleBreakpoint()<cr>", "Toggle Breakpoint" },
		-- 	u = { "<cmd>call vimspector#StepOut()<cr>", "Step Out" },
		-- 	S = { "<cmd>call vimspector#Stop()<cr>", "Stop" },
		-- 	r = { "<cmd>call vimspector#Restart()<cr>", "Restart" },
		-- 	x = { "<cmd>VimspectorReset<cr>", "Reset" },
		-- 	H = { "<cmd>lua require('config.vimspector').toggle_human_mode()<cr>", "Toggle HUMAN mode" },
		-- },

		-- x = {
		-- 	name = "External",
		-- 	p = { "<cmd>lua require('utils.term').project_info_toggle()<CR>", "Project Info" },
		-- 	s = { "<cmd>lua require('utils.term').system_info_toggle()<CR>", "System Info" },
		-- 	c = { "<cmd>lua require('utils.term').cht()<CR>", "Cheatsheet" },
		-- 	i = { "<cmd>lua require('utils.term').interactive_cheatsheet_toggle()<CR>", "Interactive Cheatsheet" },
		-- },

		z = {
			name = "System",
			-- c = { "<cmd>PackerCompile<cr>", "Compile" },
			c = { "<cmd>Telescope neoclip<cr>", "Clipboard" },
			d = { "<cmd>DiffviewOpen<cr>", "Diff View Open" },
			D = { "<cmd>DiffviewClose<cr>", "Diff View Close" },
			i = { "<cmd>PackerInstall<cr>", "Install" },
			m = { "<cmd>lua require('telescope').extensions.macroscope.default()<cr>", "Macros" },
			p = { "<cmd>PackerProfile<cr>", "Profile" },
			s = { "<cmd>PackerSync<cr>", "Sync" },
			S = { "<cmd>PackerStatus<cr>", "Status" },
			u = { "<cmd>PackerUpdate<cr>", "Update" },
			-- x = { "<cmd>cd %:p:h<cr>", "Change Directory" },
			-- x = { "<cmd>set autochdir<cr>", "Auto ChDir" },
			x = { "<cmd>Telescope cder<cr>", "Change Directory" },
			e = { "!!$SHELL<CR>", "Execute line" },
			W = { "<cmd>lua require('utils.session').toggle_session()<cr>", "Toggle Workspace Saving" },
			w = { "<cmd>lua require('utils.session').list_session()<cr>", "Restore Workspace" },
			z = { "<cmd>lua require'telescope'.extensions.zoxide.list{}<cr>", "Zoxide" },
		},

		g = {
			name = "Git",
			c = { "<cmd>lua require('utils.term').git_commit_toggle()<CR>", "Conventional Commits" },
			p = { "<cmd>!git push<CR>", "Push" },
			s = { "<cmd>Neogit<CR>", "Status - Neogit" },
			y = {
				"<cmd>lua require'gitlinker'.get_buf_range_url('n', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>",
				"Link",
			},
			g = { "<cmd>lua require('telescope').extensions.gh.gist()<CR>", "Gist" },
			h = {
				name = "+Github",
				c = {
					name = "+Commits",
					c = { "<cmd>GHCloseCommit<cr>", "Close" },
					e = { "<cmd>GHExpandCommit<cr>", "Expand" },
					o = { "<cmd>GHOpenToCommit<cr>", "Open To" },
					p = { "<cmd>GHPopOutCommit<cr>", "Pop Out" },
					z = { "<cmd>GHCollapseCommit<cr>", "Collapse" },
				},
				i = {
					name = "+Issues",
					p = { "<cmd>GHPreviewIssue<cr>", "Preview" },
				},
				l = {
					name = "+Litee",
					t = { "<cmd>LTPanel<cr>", "Toggle Panel" },
				},
				r = {
					name = "+Review",
					b = { "<cmd>GHStartReview<cr>", "Begin" },
					c = { "<cmd>GHCloseReview<cr>", "Close" },
					d = { "<cmd>GHDeleteReview<cr>", "Delete" },
					e = { "<cmd>GHExpandReview<cr>", "Expand" },
					s = { "<cmd>GHSubmitReview<cr>", "Submit" },
					z = { "<cmd>GHCollapseReview<cr>", "Collapse" },
				},
				p = {
					name = "+Pull Request",
					c = { "<cmd>GHClosePR<cr>", "Close" },
					d = { "<cmd>GHPRDetails<cr>", "Details" },
					e = { "<cmd>GHExpandPR<cr>", "Expand" },
					o = { "<cmd>GHOpenPR<cr>", "Open" },
					p = { "<cmd>GHPopOutPR<cr>", "PopOut" },
					r = { "<cmd>GHRefreshPR<cr>", "Refresh" },
					t = { "<cmd>GHOpenToPR<cr>", "Open To" },
					z = { "<cmd>GHCollapsePR<cr>", "Collapse" },
				},
				t = {
					name = "+Threads",
					c = { "<cmd>GHCreateThread<cr>", "Create" },
					n = { "<cmd>GHNextThread<cr>", "Next" },
					t = { "<cmd>GHToggleThread<cr>", "Toggle" },
				},
			},
		},
	}
	whichkey.register(keymap, opts)
	if legendary_ok then
		legendary.bind_whichkey(keymap, opts, false)
	end
end

local function visual_keymap()
	local keymap = {
		g = {
			name = "Git",
			y = {
				"<cmd>lua require'gitlinker'.get_buf_range_url('v', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>",
				"Link",
			},
		},

		r = {
			name = "Refactor",
			f = { [[<cmd>lua require('refactoring').refactor('Extract Function')<cr>]], "Extract Function" },
			F = {
				[[ <cmd>lua require('refactoring').refactor('Extract Function to File')<cr>]],
				"Extract Function to File",
			},
			v = { [[<cmd>lua require('refactoring').refactor('Extract Variable')<cr>]], "Extract Variable" },
			i = { [[<cmd>lua require('refactoring').refactor('Inline Variable')<cr>]], "Inline Variable" },
			r = { [[<cmd>lua require('telescope').extensions.refactoring.refactors()<cr>]], "Refactor" },
			d = { [[<cmd>lua require('refactoring').debug.print_var({})<cr>]], "Debug Print Var" },
		},
	}

	whichkey.register(keymap, v_opts)
	if legendary_ok then
		legendary.bind_whichkey(keymap, opts, false)
	end
end

local function code_keymap()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "*",
		callback = function()
			vim.schedule(CodeRunner)
		end,
	})

	function CodeRunner()
		local bufnr = vim.api.nvim_get_current_buf()
		local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
		local fname = vim.fn.expand("%:p:t")
		local keymap_c = {} -- normal key map
		local keymap_c_v = {} -- visual key map

		if ft == "python" then
			keymap_c = {
				name = "Code",
				r = { "<cmd>update<CR><cmd>exec '!python3' shellescape(@%, 1)<cr>", "Run" },
				m = { "<cmd>TermExec cmd='nodemon -e py %'<cr>", "Monitor" },
			}
		elseif ft == "lua" then
			keymap_c = {
				name = "Code",
				r = { "<cmd>luafile %<cr>", "Run" },
			}
		elseif ft == "typescript" or ft == "typescriptreact" or ft == "javascript" or ft == "javascriptreact" then
			keymap_c = {
				name = "Code",
				o = { "<cmd>TypescriptOrganizeImports<cr>", "Organize Imports" },
				r = { "<cmd>TypescriptRenameFile<cr>", "Rename File" },
				i = { "<cmd>TypescriptAddMissingImports<cr>", "Import Missing" },
				F = { "<cmd>TypescriptFixAll<cr>", "Fix All" },
				u = { "<cmd>TypescriptRemoveUnused<cr>", "Remove Unused" },
				R = { "<cmd>lua require('config.neotest').javascript_runner()<cr>", "Choose Test Runner" },
				s = { "<cmd>2TermExec cmd='yarn start'<cr>", "Yarn Start" },
				t = { "<cmd>2TermExec cmd='yarn test'<cr>", "Yarn Test" },
			}
		end

		if fname == "package.json" then
			keymap_c.v = { "<cmd>lua require('package-info').show()<cr>", "Show Version" }
			keymap_c.c = { "<cmd>lua require('package-info').change_version()<cr>", "Change Version" }
			keymap_c.s = { "<cmd>2TermExec cmd='yarn start'<cr>", "Yarn Start" }
			keymap_c.t = { "<cmd>2TermExec cmd='yarn test'<cr>", "Yarn Test" }
		end

		if next(keymap_c) ~= nil then
			local k = { ["C"] = keymap_c }
			local o = { mode = "n", silent = true, noremap = true, buffer = bufnr, prefix = "<leader>", nowait = true }
			whichkey.register(k, o)
			if legendary_ok then
				legendary.bind_whichkey(k, o, false)
			end
		end

		if next(keymap_c_v) ~= nil then
			local k = { ["C"] = keymap_c_v }
			local o = { mode = "v", silent = true, noremap = true, buffer = bufnr, prefix = "<leader>", nowait = true }
			whichkey.register(k, o)
			if legendary_ok then
				legendary.bind_whichkey(k, o, false)
			end
		end
	end
end

function M.setup()
	normal_keymap()
	visual_keymap()
	code_keymap()
end

return M
