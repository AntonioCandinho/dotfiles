local M = {}

local buff_reloaded = false

local current_buffer_is_a_file = function()
  return vim.api.nvim_buf_get_name(0) ~= ""
end

-- This enables TreeSitter syntax highlighting
local on_buf_enter = function()
  if not buff_reloaded and current_buffer_is_a_file() then
    buff_reloaded = true
    vim.cmd "edit"
  end
end

M.setup = function()
  vim.api.nvim_create_autocmd("BufEnter", {
    callback = on_buf_enter,
  })
end

return M
