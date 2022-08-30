local M = {}

function M.setup()
	local notify = require("notify")
	notify.setup({
		icons = {
			ERROR = "",
			WARN = "",
			INFO = "",
			DEBUG = "",
			TRACE = "",
		},
	})
	vim.notify = notify
end

return M
