return {
  require "plugins.completion.lsp",
  require "plugins.completion.blink",
  -- Rust tools
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    lazy = false, -- This plugin is already lazy
  },
}
