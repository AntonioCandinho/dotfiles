return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
  build = ":MasonUpdate",
  opts = {
    -- Keep Mason around for tooling visibility, but don't auto-install a big list.
    -- This avoids surprise background downloads and keeps this config minimal.
    ensure_installed = {
      "lua-language-server",
      "vtsls",
      "html-lsp",
      "css-lsp",
      "vue-language-server",
      "clangd",
      "rust-analyzer",
      "zls",
      "bash-language-server",

      "prettier",
      "stylua",
      "clang-format",

      "eslint_d",
      "shellcheck",
    },
  },
  config = function(_, opts)
    require("mason").setup(opts)
    
    -- Don't auto-install on startup; use :Mason when you want updates.
    -- Auto-installs can cause stalls/network waits that feel like "freezes".
    -- local mr = require("mason-registry")
    -- mr.refresh(function()
    --   for _, tool in ipairs(opts.ensure_installed) do
    --     local p = mr.get_package(tool)
    --     if not p:is_installed() then
    --       p:install()
    --     end
    --   end
    -- end)
  end,
}
