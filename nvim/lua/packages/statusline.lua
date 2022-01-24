local lualine = require("lualine")
local M = {}

local config = {
	options = {
		icons_enabled = false,
		theme = "auto"
	},
	tabline = {
		lualine_a = { "buffers" },
	},
}

M.setup = function()
	lualine.setup(config)
end

return M
