local treesitter = require "nvim-treesitter.configs"
local M = {}

local config = {
  ensure_installed = "",
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = false },
  autopairs = { enable = true },
  playground = { enable = true },
}

M.setup = function()
  treesitter.setup(config)
end

return M
