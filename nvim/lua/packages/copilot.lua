local cmp = require "cmp"
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

  -- hide copilot suggestions when cmp menu is open
  -- to prevent odd behavior/garbled up suggestions
  cmp.event:on("menu_opened", function()
    vim.b.copilot_suggestion_hidden = true
  end)

  cmp.event:on("menu_closed", function()
    vim.b.copilot_suggestion_hidden = false
  end)
end

return M
