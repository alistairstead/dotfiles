local M = {}

function M.setup()
	require("Comment").setup({
		ignore = "^$",
	})
end

return M
