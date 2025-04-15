local M = {}

local create_lazy = function()
  local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    }
  end
  vim.opt.rtp:prepend(lazypath)
  return require "lazy"
end

local default_lazy_opts = function()
  local current_path = debug.getinfo(1).source:match "@?(.*/)"
  return {
    defaults = {
      lazy = true,
    },
    lockfile = current_path .. "/lazy-lock.json",
  }
end

local get_packages = function()
  return {
    -- UI
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
        require("packages.statusline").setup()
      end,
    },

    -- Treesitter
    {
      "nvim-treesitter/nvim-treesitter",
      lazy = false,
      build = ":TSUpdate",
      config = function()
        require("packages.treesitter").setup()
      end,
    },

    -- Treesitter playground
    {
      "nvim-treesitter/playground",
      cmd = { "TSPlaygroundToggle" },
      dependencies = {
        "nvim-treesitter",
      },
    },

    require "packages.completion",
    require "packages.navigation",
    require "packages.ai",

    -- Formatting
    {
      "mhartington/formatter.nvim",
      cmd = { "Format", "FormatWrite" },
      keys = {
        { "<leader>f", "<cmd>Format<CR>", desc = "Format sources" },
      },
      config = function()
        require("packages.formatter").setup()
      end,
    },
  }
end

M.setup = function()
  local lazy = create_lazy()
  local packages = get_packages()
  local opts = default_lazy_opts()
  lazy.setup(packages, opts)
end

return M
