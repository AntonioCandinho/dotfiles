return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "saghen/blink.cmp" },
    { "ray-x/lsp_signature.nvim" },
  },
  config = function()
    vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<CR>", { desc = "LSP info" })

    local lspconfig = require "lspconfig"

    -- Setup ccls with lspconfig since it's not going to be supported by mason.nvim
    -- Source: https://github.com/williamboman/mason.nvim/issues/349
    if vim.fn.executable "ccls" then
      lspconfig["ccls"].setup {
        init_options = {
          cache = {
            directory = vim.fn.stdpath "cache" .. "/ccls-cache",
          },
        },
      }
    end
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
  end,
}
