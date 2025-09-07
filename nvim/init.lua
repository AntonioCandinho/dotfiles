-- Load core settings
require("config.settings").apply()

-- Load configuration modules  
require("config.keymaps").setup()
require("config.autocmds").setup()

-- Initialize plugin manager
require("lazy-setup").setup()
