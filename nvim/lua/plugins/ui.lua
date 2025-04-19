return {
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    config = function()
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_foreground = "material"
      vim.g.gruvbox_material_background = "medium"
      vim.cmd "colorscheme gruvbox-material"
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("lualine").setup {
        options = {
          icons_enabled = false,
          theme = "gruvbox-material",
        },
        tabline = {
          lualine_a = { "buffers" },
        },
      }
    end,
  },

}
