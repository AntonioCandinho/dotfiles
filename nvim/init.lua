-- Load configuration modules  
require("config.autocmds").setup()
require("config.settings").apply()

-- Initialize plugin manager
require("plugins").setup()

-- Initialize native LSP (after plugins are loaded)
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("config.lsp").setup()
  end,
})
