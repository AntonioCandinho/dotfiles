local M = {}

function M.apply()
	vim.g.mapleader = " "

	-- Backup and swap
	vim.opt.swapfile = false
	vim.opt.undofile = true
	vim.opt.backup = false
	vim.opt.writebackup = false

	-- UI options
	vim.opt.number = true
	vim.opt.relativenumber = true
	vim.opt.numberwidth = 1
	vim.opt.fileencoding = "utf-8"
	vim.opt.showmode = false

	-- Spacing
	vim.opt.wrap = false
	vim.opt.tabstop = 2
	vim.opt.shiftwidth = 2
	vim.opt.expandtab = true
	vim.opt.autoindent = true
	vim.opt.smartindent = true
	vim.opt.smarttab = true

	-- Window and options
	vim.opt.hidden = true -- Change buffer no saving
	vim.opt.splitbelow = true
	vim.opt.splitright = true

	-- Timing
	vim.opt.timeoutlen = 1000
	vim.opt.updatetime = 300
	vim.opt.ttimeoutlen = 10

	-- Diff
	vim.opt.diffopt:append({
		"vertical",
		"iwhite",
		"hiddenoff",
		"foldcolumn:0",
		"context:4",
		"algorithm:histogram",
		"indent-heuristic",
	})

	-- Use Ripgrep as grep
	if vim.fn.executable("rg") == 1 then
		vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
	end

	-- Searching and completion
	vim.opt.incsearch = true
	vim.opt.ignorecase = true
	vim.opt.smartcase = true
	vim.opt.inccommand = "nosplit"
	vim.opt.pumheight = 10 -- Items to show when completing
	vim.opt.completeopt = "menuone,noinsert,noselect"

	-- Disable not needed stuff
	vim.g.loaded_gzip = 1
	vim.g.loaded_tar = 1
	vim.g.loaded_tarPlugin = 1
	vim.g.loaded_zip = 1
	vim.g.loaded_zipPlugin = 1
	vim.g.loaded_getscript = 1
	vim.g.loaded_getscriptPlugin = 1
	vim.g.loaded_vimball = 1
	vim.g.loaded_vimballPlugin = 1
	vim.g.loaded_2html_plugin = 1
	vim.g.loaded_logiPat = 1
	vim.g.loaded_rrhelper = 1
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1
	vim.g.loaded_netrwSettings = 1
	vim.g.loaded_netrwFileHandlers = 1
	vim.g.loaded_man = 1
	vim.g.loaded_remote_plugins = 1
end

return M
