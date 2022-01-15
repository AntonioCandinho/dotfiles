local lspconfig = require("lspconfig")
local nvim_cmp = require("cmp")
-- COQ Config
-- local coq = require("coq")
-- local treesitter_config = require("nvim-treesitter.configs")
-- local treesitter_parsers = require("nvim-treesitter.parsers")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- nvim-cmp setup
nvim_cmp.setup {
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ['<Tab>'] = nvim_cmp.mapping(nvim_cmp.mapping.select_next_item(), { 'i', 's' }),
      ['<C-b>'] = nvim_cmp.mapping(nvim_cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = nvim_cmp.mapping(nvim_cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = nvim_cmp.mapping(nvim_cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = nvim_cmp.config.disable, -- Specify `nvim_cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = nvim_cmp.mapping({
        i = nvim_cmp.mapping.abort(),
        c = nvim_cmp.mapping.close(),
      }),
      ['<CR>'] = nvim_cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = nvim_cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
nvim_cmp.setup.cmdline('/', { sources = {
    { name = 'buffer' }
  }
})

local servers = {'eslint', 'tsserver', 'sourcekit'}
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities
  }
end


-- treesitter_config.setup {
--   highlight = {
--     enable = true,
--     disable = {},
--   }, 
--   indent = {
--     enable = true,
--     disable = {},
--   },
--   ensure_installed = {
--     "html",
--     "elixir",
--     "erlang",
--     "fish",
--     "swift",
--     "haskell",
--     "graphql",
--     "javascript",
--     "json",
--     "json5",
--     "julia",
--     "kotlin",
--     "latex",
--     "make",
--     "nix",
--     "ninja",
--     "ocaml",
--     "python",
--     "rust",
--     "scala",
--     "typescript",
--     "tsx",
--     "toml",
--     "vim",
--     "yaml",
--     "toml",
--     "zig"
--   },
-- }

-- local parser_config = treesitter_parsers.get_parser_configs()
-- parser_config.tsx.used_by = { "javascript", "typescript.tsx" }
