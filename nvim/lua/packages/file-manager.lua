local M = {}

local kmap = function(mode, key, result)
  local map_opts = { noremap = true, silent = true }
  vim.api.nvim_set_keymap(mode, key, result, map_opts)
end

M.setup = function()
  vim.g.rnvimr_enable_ex = 1
  vim.g.rnvimr_draw_border = 1

  kmap("n", "<leader>rt", ":RnvimrToggle<CR>")
end

return M
