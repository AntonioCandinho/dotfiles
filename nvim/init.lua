-- Load core settings
require("config.settings").apply()

-- Load configuration modules  
require("config.keymaps").setup()
require("config.autocmds").setup()
require("config.highlights").setup()

-- Initialize plugin manager
require("lazy-setup").setup()

-- Setup LSP after plugins are loaded
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("config.lsp").setup()
  end,
})
