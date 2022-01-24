local lsp_installer = require "nvim-lsp-installer" 
local lsp_signature = require "lsp_signature"

local M = {}

local get_lsp_capabilities = function () 
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.preselectSupport = true
  capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
  capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
  capabilities.textDocument.completion.completionItem.deprecatedSupport = true
  capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
  capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
  capabilities.textDocument.completion.completionItem.resolveSupport = { 
    properties = { "documentation", "detail", "additionalTextEdits" }
  }
  return capabilities
end

local on_lsp_attach = function(client, bufnr)
    local opts = { noremap=true, silent=true }
    local bmap = function (...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local bopt = function (...) vim.api.nvim_buf_set_option(bufnr, ...) end

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

M.setup = function ()
  lsp_installer.on_server_ready(function (server)
    server:setup {
      capabilities = get_lsp_capabilities(),
      on_attach = on_lsp_attach,
      flags = { debounce_text_changes = 150 }
    }
    vim.cmd [[ do User LspAttachBuffers ]]
  end)
end

return M
