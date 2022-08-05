local diffview = require "diffview"
local neogit = require "neogit"
local M = {}

local neogit_config = {
  disable_context_highlighting = false,
  use_icons = false,
  integrations = { diffview = true },
}

local diffview_config = {
  use_icons = false,
}

M.setup = function()
  neogit.setup(neogit_config)
  diffview.setup(diffview_config)
end

return M
