local telescope = require("telescope")
local actions = require("telescope.actions")

local M = {}

local configure_mappings = function()
	local map_opts = { noremap = true, silent = true }
	local kmap = function(mode, key, result)
		vim.api.nvim_set_keymap(mode, key, result, map_opts)
	end

	kmap("n", "<leader>hh", ":Telescope help_tags<CR>")
	kmap("n", "<leader>hm", ":Telescope man_pages<CR>")
	kmap("n", "<leader>ht", ":Telescope colorscheme<CR>")
	kmap("n", "<leader>ho", ":Telescope vim_options<CR>")
	kmap("n", "<leader>bb", ":Telescope buffers<CR>")
	kmap("n", "<leader>gb", ":Telescope git_branches<CR>")
	kmap("n", "<leader>gf", ":Telescope git_files<CR>")
	kmap("n", "<leader>gm", ":Telescope git_status<CR>")
	kmap("n", "<leader>gc", ":Telescope git_commits<CR>")
	kmap("n", "<leader><space>", ":Telescope find_files<CR>")
	kmap("n", "<leader>/", ":Telescope live_grep<CR>")
	kmap("n", "<leader>ff", ":Telescope find_files<CR>")
	kmap("n", "<leader>fR", ":Telescope registers<CR>")
	kmap("n", "<leader>fr", ":Telescope oldfiles<CR>")
	kmap("n", "<leader>fg", ":Telescope live_grep<CR>")
	kmap("n", "<leader>fb", ":Telescope current_buffer_fuzzy_find<CR>")
	kmap("n", "<leader>fC", ":Telescope command_history<CR>")
	kmap("n", "<leader>fc", ":Telescope commands<CR>")
	kmap("n", "<leader>fs", ":Telescope search_history<CR>")
	kmap("n", "<leader>fq", ":Telescope quickfix<CR>")
	kmap("n", "<leader>fl", ":Telescope loclist<CR>")
	kmap("n", "<leader>fq", ":Telescope quickfix<CR>")
	kmap("n", "<leader>fn", ":Telescope fd cwd=$HOME/.config/nvim/<CR>")
	kmap("n", "<leader>rb", ":Telescope file_browser<CR>")

	kmap("n", "gr", ":Telescope lsp_references<CR>")
	kmap("n", "<leader>lgr", ":Telescope lsp_references<CR>")
	kmap("n", "<leader>la", ":Telescope lsp_code_actions<CR>")
	kmap("n", "<leader>lA", ":Telescope lsp_range_code_actions<CR>")
	kmap("n", "<leader>ld", ":Telescope diagnostics bufnr=0<CR>")
	kmap("n", "<leader>lD", ":Telescope diagnostics<CR>")
	kmap("n", "<leader>ls", ":Telescope lsp_document_symbols<CR>")
	kmap("n", "<leader>lS", ":Telescope lsp_workspace_symbols<CR>")
end

local load_extensions = function()
	pcall(require("telescope").load_extension, "fzf")
	pcall(require("telescope").load_extension, "projects")
end

local setup_config = {
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--hidden",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		sorting_strategy = "descending",
		layout_strategy = "horizontal",
		layout_config = { height = 0.75, width = 0.8 },
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<CR>"] = actions.select_default + actions.center,
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,
			},
			n = {
				["<C-c>"] = actions.close,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
	pickers = {
		-- Your special builtin config goes in here
		buffers = {
			sort_lastused = true,
			ignore_current_buffer = true,
			layout_strategy = "horizontal",
			layout_config = { height = 20, preview_width = 0.6 },
			show_all_buffers = true,
			mappings = {
				i = {
					["<c-d>"] = actions.delete_buffer,
				},
				n = {
					["<c-d>"] = actions.delete_buffer,
				},
			},
		},
		live_grep = {
			layout_strategy = "vertical",
			layout_config = { height = 35, preview_height = 8 },
		},
		current_buffer_fuzzy_find = {
			layout_strategy = "vertical",
			layout_config = { height = 35, preview_height = 8 },
		},
		lsp_code_actions = {
			layout_strategy = "horizontal",
			layout_config = { height = 10, width = 0.5 },
		},
		lsp_range_code_actions = {
			layout_strategy = "horizontal",
			layout_config = { height = 10, width = 0.5 },
		},
		diagnostics = {
			layout_config = { width = 0.7 },
			layout_strategy = "vertical",
		},
		find_files = {
			layout_config = { height = 35, preview_width = 0.55 },
			hidden = false,
			no_ignore = false,
		},
		help_tags = {
			layout_config = { height = 35, preview_width = 0.65 },
		},
		git_files = {
			layout_config = { height = 35, preview_width = 0.55 },
		},
		fd = {
			layout_config = { height = 35, preview_width = 0.55 },
		},
		file_browser = {
			hidden = true,
			layout_config = { height = 35, preview_width = 0.65 },
		},
		lsp_document_symbols = { previewer = false },
		lsp_workspace_symbols = { previewer = false },
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		},
	},
}

M.setup = function()
	telescope.setup(setup_config)
	load_extensions()
	configure_mappings()
end

return M
