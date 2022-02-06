local formatter = require("formatter")
local M = {}

local configure_mappings = function()
	local map_opts = { noremap = true, silent = true }
	local kmap = function(mode, key, result)
		vim.api.nvim_set_keymap(mode, key, result, map_opts)
	end

	kmap("n", "<leader>f", ":Format<CR>")
end

local function fmt(args)
	return function()
		return args
	end
end

M.prettier = function(opts)
	return fmt({
		exe = "prettierd",
		args = {vim.api.nvim_buf_get_name(0)},
		stdin = true,
	})
end

M.clang = fmt({
	exe = "clang-format",
	args = {
		"-assume-filename=" .. vim.fn.expand("%:t"),
		[[
        -style='{IndentWidth: 4,
        AlignConsecutiveAssignments: true,
        AllowShortBlocksOnASingleLine: Empty,
        AllowShortLoopsOnASingleLine: true,
        AllowShortIfStatementsOnASingleLine: true,
        AlignConsecutiveMacros: true,
        BreakBeforeBraces: Linux,
        AlignConsecutiveDeclarations: true,
        AlwaysBreakAfterReturnType: None}'
        ]],
	},
	stdin = true,
})

M.stylua = fmt({
	exe = "stylua",
	args = { "--search-parent-directories", "--stdin-filepath", '"%:p"', "--", "-" },
	stdin = true,
})

M.sh = fmt({
	exe = "shfmt",
	args = { "-i " .. vim.opt.shiftwidth:get() },
	stdin = true,
})

M.black = fmt({
	exe = "black",
	args = { "--quiet", "-" },
	stdin = true,
})

M.goimports = fmt({
	exe = "goimports",
	stdin = true,
})

M.rustfmt = fmt({
	exe = "rustfmt",
	args = {
		string.format("--config hard_tabs=%s,tab_spaces=%s", not vim.opt.expandtab:get(), vim.opt.shiftwidth:get()),
	},
	stdin = true,
})

M.latex = fmt({
	exe = "latexindent",
	args = { "-g /dev/stderr", "2>/dev/null" },
	stdin = true,
})

M.swift = fmt({
  exe = "swiftformat",
  args = { "--output stdout" },
  stdin = true
})

local config = {
		logging = false,
		filetype = {
			sh = { M.sh },
			zsh = { M.sh },
			c = { M.clang },
			cs = { M.clang },
			cpp = { M.clang },
			lua = { M.stylua },
			tex = { M.latex },
      swift = { M.swift },
			python = { M.black },
			go = { M.goimports },
			rust = { M.rustfmt },
			css = { M.prettier("--parser css") },
			xml = { M.prettier() },
			json = { M.prettier() },
			html = { M.prettier("--parser html") },
			scss = { M.prettier() },
			markdown = { M.prettier() },
			javascript = { M.prettier({ "--single-quote" }) },
			typescript = { M.prettier({ "--single-quote" }) },
			javascriptreact = { M.prettier({ "--single-quote" }) },
			typescriptreact = { M.prettier({ "--single-quote" }) },
    }
}

M.setup = function()
	formatter.setup(config)
	configure_mappings()
end

return M
