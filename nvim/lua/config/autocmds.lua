-- Autocmds configuration  
local M = {}

function M.setup()
  local autocmd = vim.api.nvim_create_autocmd
  local augroup = vim.api.nvim_create_augroup

  -- General settings
  local general = augroup("General", { clear = true })

  -- Highlight on yank
  autocmd("TextYankPost", {
    group = general,
    callback = function()
      vim.highlight.on_yank()
    end,
  })

  -- Resize splits if window got resized
  autocmd({ "VimResized" }, {
    group = general,
    callback = function()
      local current_tab = vim.fn.tabpagenr()
      vim.cmd("tabdo wincmd =")
      vim.cmd("tabnext " .. current_tab)
    end,
  })

  -- Close some filetypes with <q>
  autocmd("FileType", {
    group = general,
    pattern = {
      "PlenaryTestPopup",
      "help",
      "lspinfo",
      "man",
      "notify",
      "qf",
      "spectre_panel",
      "startuptime",
      "tsplayground",
      "neotest-output",
      "checkhealth",
      "neotest-summary",
      "neotest-output-panel",
    },
    callback = function(event)
      vim.bo[event.buf].buflisted = false
      vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
  })

  -- Wrap and check for spell in text filetypes
  autocmd("FileType", {
    group = general,
    pattern = { "gitcommit", "markdown" },
    callback = function()
      vim.opt_local.wrap = true
      vim.opt_local.spell = true
    end,
  })

  -- Auto create dir when saving a file, in case some intermediate directory does not exist
  autocmd({ "BufWritePre" }, {
    group = general,
    callback = function(event)
      if event.match:match("^%w%w+://") then
        return
      end
      local file = vim.loop.fs_realpath(event.match) or event.match
      vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
  })

  -- LSP-related autocmds
  local lsp_group = augroup("LspFormatting", { clear = true })

  -- Format on save (if client supports it)
  autocmd("BufWritePre", {
    group = lsp_group,
    callback = function()
      -- Only format if there's an LSP client attached that supports formatting
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      for _, client in ipairs(clients) do
        if client.supports_method("textDocument/formatting") then
          vim.lsp.buf.format({ async = false })
          break
        end
      end
    end,
  })

  -- LSP setup
  local lsp_group = augroup("LspSetup", { clear = true })

  -- Initialize native LSP after plugins are loaded
  autocmd("User", {
    group = lsp_group,
    pattern = "VeryLazy",
    callback = function()
      require("config.lsp").setup()
    end,
  })
end

return M
