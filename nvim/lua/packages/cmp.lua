local cmp = require "cmp"
local lspconfig = require "lspconfig"
local cmp_nvim_lsp = require "cmp_nvim_lsp"
local lsp_signature = require "lsp_signature"

local M = {}

local configure_cmp = function()
  cmp.setup {
    completion = {
      completeopt = "menu,menuone,noinsert",
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    mapping = {
      ["<Tab>"] = cmp.mapping.select_next_item(),
      ["<S-Tab>"] = cmp.mapping.select_prev_item(),
      ["<CR>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
    },
    formatting = {
      format = function(entry, item)
        item.menu = ({
          nvim_lsp = "[L]",
          path = "[P]",
          calc = "[C]",
          luasnip = "[S]",
          buffer = "[B]",
          spell = "[Spell]",
        })[entry.source.name]
        return item
      end,
    },
    window = {
      documentation = cmp.config.window.bordered(),
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
      { name = "nvim_lua" },
      { name = "spell" },
    },
  }

  local map = vim.api.nvim_set_keymap
  map("i", "<C-j>", "<Plug>luasnip-expand-or-jump", { silent = true })
  map("i", "<C-k>", "<cmd>lua require('luasnip').jump(-1)<Cr>", { silent = true })
end

local on_lsp_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true }
  local bmap = function(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local bopt = function(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  lsp_signature.on_attach { max_width = 90, fix_pos = true, hint_prefix = " " }

  bopt("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings
  bmap("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
  bmap("n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
  bmap("n", "gy", ":lua vim.lsp.buf.type_definition()<CR>", opts)
  bmap("n", "gh", ":lua vim.lsp.buf.hover()<CR>", opts)
  bmap("n", "K", ":lua vim.lsp.buf.signature_help()<CR>", opts)
  bmap("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", opts)
  bmap("n", "<leader>lgD", ":lua vim.lsp.buf.declaration()<CR>", opts)
  bmap("n", "<leader>lgd", ":lua vim.lsp.buf.definition()<CR>", opts)
  bmap("n", "<leader>lgy", ":lua vim.lsp.buf.type_definition()<CR>", opts)
  bmap("n", "<leader>lgi", ":lua vim.lsp.buf.implementation()<CR>", opts)
  bmap("n", "<leader>lh", ":lua vim.lsp.buf.hover()<CR>", opts)
  bmap("n", "<leader>lk", ":lua vim.lsp.buf.signature_help()<CR>", opts)
  bmap("n", "<leader>lc", ":lua vim.diagnostic.hide()<CR>", opts)
  bmap("n", "<leader>lr", ":lua vim.lsp.buf.rename()<CR>", opts)
  bmap("n", "<leader>lf", ":lua vim.lsp.buf.formatting()<CR>", opts)
  bmap("n", "<leader>l,s", [[:LspStop <C-R>=<CR>]], { noremap = true, silent = false })
end

local configure_lsp = function()
  local config = {
    capabilities = cmp_nvim_lsp.default_capabilities(),
    on_attach = on_lsp_attach,
    flags = { debounce_text_changes = 150 },
  }
  local default_config = lspconfig.util.default_config

  lspconfig.util.default_config = vim.tbl_extend("force", default_config, config)

  lspconfig.bashls.setup {}
  lspconfig.tsserver.setup {}
  lspconfig.sourcekit.setup {}
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
end

M.setup = function()
  configure_lsp()
  configure_cmp()
end

return M
