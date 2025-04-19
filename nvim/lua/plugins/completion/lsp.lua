return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    { "saghen/blink.cmp" },
    { "ray-x/lsp_signature.nvim" },
  },
  config = function()
    local lspconfig = require "lspconfig"

    -- Create capabilities
    local blink = require "blink.cmp"
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      blink.get_lsp_capabilities() or {},
      {
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      }
    )

    local on_attach = function(_, bufnr)
      local map = function(mode, keymap, action, desc)
        vim.keymap.set(mode, keymap, action, { buffer = bufnr, desc = desc })
      end

      local hover = function()
        vim.lsp.buf.hover()
      end
      local signature_help = function()
        vim.lsp.buf.signature_help()
      end

      map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
      map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
      map("n", "gI", vim.lsp.buf.implementation, "Goto Implementation")
      map("n", "gy", vim.lsp.buf.type_definition, "Goto T[y]pe Definition")
      map("n", "gr", vim.lsp.buf.references, "References")
      map("n", "K", hover, "Hover")
      map("n", "gK", signature_help, "Signature Help")
      map("i", "<c-k>", signature_help, "Signature Help")
      map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
      map({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, "Run Codelens")
      map("n", "<leader>cC", vim.lsp.codelens.refresh, "Refresh & Display Codelens")
      map("n", "<leader>cr", vim.lsp.buf.rename, "Rename")
    end

    vim.diagnostic.config {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
      },
      severity_sort = true,
      inlay_hints = {
        enabled = true,
        exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
      },
    }

    local lsp_servers = {
      bashls = {},
      sourcekit = {},
      clangd = {},
      vtsls = {
        -- explicitly add default filetypes, so that we can extend
        -- them in related extras
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
        settings = {
          complete_function_calls = true,
          vtsls = {
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
            experimental = {
              maxInlayHintLength = 30,
              completion = {
                enableServerSideFuzzyMatch = true,
              },
            },
          },
          typescript = {
            updateImportsOnFileMove = { enabled = "always" },
            suggest = {
              completeFunctionCalls = true,
            },
            inlayHints = {
              enumMemberValues = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              variableTypes = { enabled = false },
            },
          },
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            codeLens = {
              enable = true,
            },
            completion = {
              callSnippet = "Replace",
            },
            doc = {
              privateName = { "^_" },
            },
            diagnostics = { globals = { "vim" } },
            hint = {
              enable = true,
              setType = false,
              paramType = true,
              paramName = "Disable",
              semicolon = "Disable",
              arrayIndex = "Disable",
            },
          },
        },
      },
    }

    for server_name, server_opts in pairs(lsp_servers) do
      lspconfig[server_name].setup(vim.tbl_deep_extend("force", {
        on_attach = on_attach,
        capabilities = capabilities,
      }, server_opts or {}))
    end
  end,
}
