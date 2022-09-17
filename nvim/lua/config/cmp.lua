local M = {}

vim.o.completeopt = "menu,menuone,noselect"

--   פּ ﯟ   some other good icons
local kind_icons = {
	Text = "",
	Method = "m",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "ﴯ",
	Interface = "",
	Module = "",
	Property = "ﰠ",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

function M.setup()
	local has_words_before = function()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end

	local cmp_status_ok, cmp = pcall(require, "cmp")
	if not cmp_status_ok then
		return
	end

	local snip_status_ok, luasnip = pcall(require, "luasnip")
	if not snip_status_ok then
		return
	end

	cmp.setup({
		-- completion = { completeopt = "menu,menuone,noinsert", keyword_length = 1 },
		-- view = {
		--   entries = "native",
		-- },
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
				-- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind-- Source
				vim_item.menu = ({
					nvim_lsp = "[LSP]",
					luasnip = "[Snip]",
					buffer = "[Buffer]",
					nvim_lua = "[Lua]",
					path = "[Path]",
				})[entry.source.name]
				return vim_item
			end,
		},
		mapping = {
			["<C-k>"] = cmp.mapping.select_prev_item(),
			["<C-j>"] = cmp.mapping.select_next_item(),
			["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
			["<C-e>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			-- Accept currently selected item. If none selected, `select` first item.
			-- Set `select` to `false` to only confirm explicitly selected items.
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<Tab>"] = cmp.mapping(function(fallback)
				local copilot_keys = vim.fn["copilot#Accept"]()

				if cmp.visible() then
					cmp.select_next_item()
				elseif copilot_keys ~= "" and type(copilot_keys) == "string" then
					vim.api.nvim_feedkeys(copilot_keys, "i", true)
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end, {
				"i",
				"s",
				"c",
			}),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, {
				"i",
				"s",
				"c",
			}),
		},
		sources = {
			{ name = "nvim_lsp" },
			{ name = "nvim_lsp_signature_help" },
			{ name = "luasnip" },
			{ name = "buffer" },
			{ name = "path" },
			-- { name = "spell" },
			-- { name = "emoji" },
			-- { name = "calc" },
		},
		confirm_opts = {
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		},
		window = {
			documentation = {
				border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
				winhighlight = "NormalFloat:NormalFloat,FloatBorder:TelescopeBorder",
			},
		},
		experimental = {
			ghost_text = false,
			native_menu = false,
		},
	})

	-- --  Use buffer source for `/`
	-- cmp.setup.cmdline("/", {
	-- 	sources = {
	-- 		{ name = "buffer" },
	-- 	},
	-- })

	-- Use cmdline & path source for ':'
	cmp.setup.cmdline(":", {
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})

	-- Auto pairs
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
end

return M
