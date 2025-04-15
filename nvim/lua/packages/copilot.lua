local copilot = require "copilot"

local M = {}

M.setup = function()
  copilot.setup {
    panel = {
      enabled = true,
      auto_refresh = true,
    },
    suggestion = {
      enabled = true,
      auto_trigger = true
    },
  }
end

return M
