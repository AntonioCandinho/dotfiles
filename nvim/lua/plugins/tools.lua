-- Development tools and utilities
return {
  -- LSP server manager 
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        -- Language servers
        "lua-language-server",
        "typescript-language-server", 
        "vtsls", -- Alternative TypeScript server (preferred)
        "html-lsp",
        "vue-language-server",
        "clangd",
        "rust-analyzer",
        "zls",
        "bash-language-server",
        
        -- Formatters
        "stylua",
        "prettier", 
        "clang-format",
        
        -- Linters (optional)
        "eslint_d",
        "shellcheck",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      
      -- Automatically install configured servers
      local mr = require("mason-registry")
      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },
}
