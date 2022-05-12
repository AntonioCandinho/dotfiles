local theme = require("lualine.themes.gruvbox")
local lualine = require("lualine")
local M = {}

local config = {
	options = {
		icons_enabled = false,
		theme = theme,
	},
	tabline = {
		lualine_a = { "buffers" },
	},
}

M.setup = function()
	lualine.setup(config)
end

return M
