local cmp = require "cmp"
local M = {}

M.setup = function()
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

return M
