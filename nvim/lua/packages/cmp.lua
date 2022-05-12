local cmp = require("cmp")
local M = {}

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

M.setup = function()
	cmp.setup({
		completion = {
			completeopt = "menu,menuone,noinsert",
		},
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		mapping = {
			["<Tab>"] = cmp.mapping(function(fallback)
				local luasnip = require("luasnip")
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
			["<S-Tab>"] = cmp.mapping(function()
				local luasnip = require("luasnip")
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.close(),
			["<CR>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
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
	})

	local map = vim.api.nvim_set_keymap
	map("i", "<C-j>", "<Plug>luasnip-expand-or-jump", { silent = true })
	map("i", "<C-k>", "<cmd>lua require('luasnip').jump(-1)<Cr>", { silent = true })
end

return M
