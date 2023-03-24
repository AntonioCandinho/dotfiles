local M = {}

local on_packer_start = function(use)
  -- It will try to delete itself otherwise + Nice updates
  use { "wbthomason/packer.nvim" }

  -- LSP configuration
  use { "ray-x/lsp_signature.nvim" }
  use { "neovim/nvim-lspconfig" }

  -- Completion
  use { "hrsh7th/nvim-cmp", event = "InsertEnter" }
  use { "hrsh7th/cmp-path", after = "nvim-cmp" }
  use { "hrsh7th/cmp-buffer", after = "nvim-cmp" }
  use { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" }
  use {
    "hrsh7th/cmp-nvim-lsp",
    after = "nvim-cmp",
    config = function()
      require("packages.cmp").setup()
    end,
  }
  use { "f3fora/cmp-spell", after = "nvim-cmp" }
  use { "saadparwaiz1/cmp_luasnip", after = "LuaSnip" }

  use {
    "L3MON4D3/LuaSnip",
    after = "nvim-cmp",
    config = function()
      require("luasnip").config.set_config {
        history = true,
      }
      require("luasnip.loaders.from_vscode").load {}
    end,
  }

  -- Moving between files
  use {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
  }
  use {
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("packages.telescope").setup()
    end,
  }

  -- UI
  use {
    "sainnhe/gruvbox-material",
    config = function()
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_foreground = "material"
      vim.g.gruvbox_material_background = "medium"
      vim.cmd "colorscheme gruvbox-material"
    end,
  }

  use {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("packages.statusline").setup()
    end,
  }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    event = "BufRead",
    config = function()
      require("packages.treesitter").setup()
    end,
  }

  use {
    "nvim-treesitter/playground",
    after = "nvim-treesitter",
  }

  -- Formatter
  use {
    "mhartington/formatter.nvim",
    cmd = { "Format", "FormatWrite" },
    config = function()
      require("packages.formatter").setup()
    end,
  }

  -- Utils
  use {
    "moll/vim-bbye",
    config = function()
      local map_opts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap("n", "<leader>bd", ":Bdelete<CR>", map_opts)
    end,
  }

  -- Git support
  use {
    "TimUntersberger/neogit",
    requires = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    config = function()
      require("packages.neogit").setup()
    end,
  }
end

local install_pack_if_needed = function()
  local vim_data_path = vim.fn.stdpath "data"
  local install_path = vim_data_path .. "/site/pack/packer/start/packer.nvim"

  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  end
end

M.setup = function()
  install_pack_if_needed()

  local packer = require "packer"
  packer.init { git = { clone_timeout = 600 } }
  packer.startup(on_packer_start)
end

return M
