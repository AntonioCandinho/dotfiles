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

    -- LSP setup
    require "packages.lsp",

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

    -- Completion
    require "packages.completion",

    -- Copilot
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      build = ":Copilot auth",
      event = "InsertEnter",
      config = function()
        require("packages.copilot").setup()
      end,
    },

    -- Navigation
    {
      "nvim-telescope/telescope.nvim",
      cmd = { "Telescope" },
      keys = {
        { "<leader>hh", "<cmd>Telescope help_tags<CR>" },
        { "<leader>hm", "<cmd>Telescope man_pages<CR>" },
        { "<leader>ht", "<cmd>Telescope colorscheme<CR>" },
        { "<leader>ho", "<cmd>Telescope vim_options<CR>" },
        { "<leader>bb", "<cmd>Telescope buffers<CR>" },
        { "<leader>gb", "<cmd>Telescope git_branches<CR>" },
        { "<leader>gf", "<cmd>Telescope git_files<CR>" },
        { "<leader>gm", "<cmd>Telescope git_status<CR>" },
        { "<leader>gc", "<cmd>Telescope git_commits<CR>" },
        { "<leader><space>", "<cmd>Telescope find_files<CR>" },
        { "<leader>/", "<cmd>Telescope live_grep<CR>" },
        { "<leader>ff", "<cmd>Telescope find_files<CR>" },
        { "<leader>fR", "<cmd>Telescope registers<CR>" },
        { "<leader>fr", "<cmd>Telescope oldfiles<CR>" },
        { "<leader>fg", "<cmd>Telescope live_grep<CR>" },
        { "<leader>fb", "<cmd>Telescope current_buffer_fuzzy_find<CR>" },
        { "<leader>fC", "<cmd>Telescope command_history<CR>" },
        { "<leader>fc", "<cmd>Telescope commands<CR>" },
        { "<leader>fs", "<cmd>Telescope search_history<CR>" },
        { "<leader>fq", "<cmd>Telescope quickfix<CR>" },
        { "<leader>fl", "<cmd>Telescope loclist<CR>" },
        { "<leader>fq", "<cmd>Telescope quickfix<CR>" },
        { "<leader>fn", "<cmd>Telescope fd cwd=$HOME/.config/nvim/<CR>" },
        { "<leader>rb", "<cmd>Telescope file_browser<CR>" },
        { "gr", "<cmd>Telescope lsp_references<CR>" },
        { "<leader>lgr", "<cmd>Telescope lsp_references<CR>" },
        { "<leader>la", "<cmd>Telescope lsp_code_actions<CR>" },
        { "<leader>lA", "<cmd>Telescope lsp_range_code_actions<CR>" },
        { "<leader>ld", "<cmd>Telescope diagnostics bufnr=0<CR>" },
        { "<leader>lD", "<cmd>Telescope diagnostics<CR>" },
        { "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>" },
        { "<leader>lS", "<cmd>Telescope lsp_workspace_symbols<CR>" },
      },
      dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      },
      config = function()
        require("packages.telescope").setup()
      end,
    },

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

    -- Rust tools
    {
      "mrcjkb/rustaceanvim",
      version = "^4", -- Recommended
      lazy = false, -- This plugin is already lazy
    },

    -- Utils
    {
      "moll/vim-bbye",
      keys = {
        { "<leader>bd", "<cmd>Bdelete<CR>", desc = "Close buffer keeping window" },
      },
      cmd = { "Bdelete", "Bwipeout" },
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
