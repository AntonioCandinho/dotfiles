local treesitter = require "nvim-treesitter.configs"
local M = {}

local config = {
  ensure_installed = "",
  ignore_install = {},
  indent = { enable = false },
  autopairs = { enable = true },
}

M.setup = function()
    treesitter.setup(config)
end

return M
