return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = false,
        theme = "gruvbox-material",
      },
      tabline = {
        lualine_a = { "buffers" },
      },
    })
  end,
}
