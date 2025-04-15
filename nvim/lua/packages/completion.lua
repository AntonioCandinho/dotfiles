local M = {}

M.configure_lsp = function()
  vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<CR>", { desc = "LSP info" })

  local lspconfig = require "lspconfig"
  local default_config = lspconfig.util.default_config

  lspconfig.util.default_config = vim.tbl_extend("force", default_config, {
    capabilities = require("blink.cmp").get_lsp_capabilities(default_config.capabilities),
  })
  lspconfig.bashls.setup {}
  lspconfig.ts_ls.setup {}
  lspconfig.sourcekit.setup {
    cmd = { "sourcekit-lsp" },
    root_dir = function(fname)
      return lspconfig.util.root_pattern("Package.swift", "*.xcodeproj", "*.xcworkspace")(fname)
        or lspconfig.util.path.dirname(fname)
    end,
  }
  lspconfig.cssls.setup {}
  lspconfig.html.setup {}
  lspconfig.eslint.setup {}
  lspconfig.lua_ls.setup {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  }

  require("lspconfig.ui.windows").default_options.border = "rounded"
end

M.configure_blink_cmp = function()
  local path_provider_options = {
    opts = {
      get_cwd = function()
        return vim.fn.getcwd()
      end,
      show_hidden_files_by_default = true,
    },
  }

  local spell_provider_options = {
    name = "Spell",
    module = "blink-cmp-spell",
    opts = {
      -- Only enable source in `@spell` captures, and disable it in `@nospell` captures.
      enable_in_context = function()
        local curpos = vim.api.nvim_win_get_cursor(0)
        local captures = vim.treesitter.get_captures_at_pos(0, curpos[1] - 1, curpos[2] - 1)
        local in_spell_capture = false
        for _, cap in ipairs(captures) do
          if cap.capture == "spell" then
            in_spell_capture = true
          elseif cap.capture == "nospell" then
            return false
          end
        end
        return in_spell_capture
      end,
    },
  }

  local ripgrep_provider_options = {
    module = "blink-ripgrep",
    name = "Ripgrep",
    max_items = 3,
    -- the score offset may need more tweeking
    score_offset = -3,
  }

  return {
    completion = {
      documentation = { auto_show = true },
      keyword = { range = "full" },
      list = { selection = { auto_insert = false } },
    },
    keymap = { preset = "super-tab" },
    appearance = {
      nerd_font_variant = "mono",
    },
    signature = { enabled = true },
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "ripgrep", "spell" },
      providers = {
        path = path_provider_options,
        ripgrep = ripgrep_provider_options,
        spell = spell_provider_options,
      },
    },
  }
end

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "saghen/blink.cmp" },
      { "ray-x/lsp_signature.nvim" },
    },
    config = M.configure_lsp,
  },

  -- Completion
  {
    "saghen/blink.cmp",
    dependencies = { "mikavilpas/blink-ripgrep.nvim", "ribru17/blink-cmp-spell" },
    version = "1.*",
    config = M.configure_blink_cmp(),
  },

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

  -- Rust tools
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    lazy = false, -- This plugin is already lazy
  },
}
