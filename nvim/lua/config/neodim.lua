local M = {}

function M.setup()
	require("neodim").setup({
		alpha = 0.75,
		blend_color = "#10171f",
		update_in_insert = {
			enable = true,
			delay = 200,
		},
		hide = {
			virtual_text = true,
			signs = true,
			underline = false,
		},
	})
end

return M
