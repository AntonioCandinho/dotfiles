-- Native LSP configuration for Neovim v0.11+
-- Uses individual server configs from lsp/ directory

local M = {}

-- Global LSP capabilities and handlers
local function setup_capabilities()
  local blink_ok, blink = pcall(require, "blink.cmp")
  local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    blink_ok and blink.get_lsp_capabilities() or {},
    {
      workspace = {
        fileOperations = {
          didRename = true,
          willRename = true,
        },
      },
    }
  )
  return capabilities
end

-- Global LSP keymaps and handlers
local function setup_lsp_keymaps(bufnr)
  local map = function(mode, keymap, action, desc)
    vim.keymap.set(mode, keymap, action, { buffer = bufnr, desc = desc })
  end

  map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
  map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
  map("n", "gI", vim.lsp.buf.implementation, "Goto Implementation")
  map("n", "gy", vim.lsp.buf.type_definition, "Goto T[y]pe Definition")
  map("n", "gr", vim.lsp.buf.references, "References")
  map("n", "K", vim.lsp.buf.hover, "Hover")
  map("n", "gK", vim.lsp.buf.signature_help, "Signature Help")
  map("i", "<c-k>", vim.lsp.buf.signature_help, "Signature Help")
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
  map({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, "Run Codelens")
  map("n", "<leader>cC", vim.lsp.codelens.refresh, "Refresh & Display Codelens")
  map("n", "<leader>cr", vim.lsp.buf.rename, "Rename")
end

-- Global on_attach handler
local function on_attach(client, bufnr)
  setup_lsp_keymaps(bufnr)
  
  -- Setup signature help plugin if available
  local lsp_signature_ok, lsp_signature = pcall(require, "lsp_signature")
  if lsp_signature_ok then
    lsp_signature.on_attach({
      bind = true,
      handler_opts = {
        border = "rounded"
      }
    }, bufnr)
  end
end

-- Configure diagnostic display
local function setup_diagnostics()
  vim.diagnostic.config {
    underline = true,
    update_in_insert = false,
    virtual_text = {
      spacing = 4,
      source = "if_many",
      prefix = "●",
    },
    severity_sort = true,
  }
  
  -- Configure inlay hints
  if vim.fn.has('nvim-0.10') == 1 then
    vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
  end
end

function M.setup()
  local capabilities = setup_capabilities()
  setup_diagnostics()

  -- Set default LSP configuration that will be applied to all servers
  vim.lsp.config("*", {
    on_attach = on_attach,
    capabilities = capabilities,
  })

  -- Special handling for Vue to disable inlay hints
  vim.lsp.config("volar", {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      -- Disable inlay hints for Vue as they can be noisy
      if vim.fn.has('nvim-0.10') == 1 then
        vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
      end
    end,
  })

  -- Enable each server by name (configurations are auto-loaded from lsp/ directory)
  vim.lsp.enable("lua_ls")
  vim.lsp.enable("vtsls")
  vim.lsp.enable("sourcekit")
  vim.lsp.enable("clangd")
  vim.lsp.enable("zls")
  vim.lsp.enable("rust_analyzer")
  vim.lsp.enable("html")
  vim.lsp.enable("volar")
  vim.lsp.enable("bashls")
end

return M
