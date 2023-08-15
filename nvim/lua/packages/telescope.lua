local telescope = require "telescope"
local actions = require "telescope.actions"

local M = {}

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
end

return M
