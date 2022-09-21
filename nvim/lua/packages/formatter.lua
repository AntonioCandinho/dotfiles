local formatter = require "formatter"
local M = {}

local configure_mappings = function()
  local map_opts = { noremap = true, silent = true }
  local kmap = function(mode, key, result)
    vim.api.nvim_set_keymap(mode, key, result, map_opts)
  end

  kmap("n", "<leader>f", ":Format<CR>")
end

local get_current_file_name = function()
  local file_name = vim.api.nvim_buf_get_name(0)
  return vim.fn.fnameescape(file_name)
end

M.prettierd = function()
  return {
    exe = "prettierd",
    args = { get_current_file_name() },
    stdin = true,
  }
end

M.prettier = function(options)
  return function()
    return {
      exe = "pretier",
      args = vim.tbl_flatten { "--stdin-filepath", get_current_file_name(), options or {} },
      stdin = true,
      try_node_modules = true,
    }
  end
end

M.clang = function()
  return {
    exe = "clang-format",
    args = { "-assume-filename=" .. vim.fn.expand "%:t" },
    stdin = true,
  }
end

M.stylua = function()
  return {
    exe = "stylua",
    args = {
      "--search-parent-directories",
      "--stdin-filepath",
      get_current_file_name(),
      "--",
      "-",
    },
    stdin = true,
  }
end

M.sh = function()
  return {
    exe = "shfmt",
    args = { "-i " .. vim.opt.shiftwidth:get() },
    stdin = true,
  }
end

M.black = function()
  return {
    exe = "black",
    args = { "--quiet", "-" },
    stdin = true,
  }
end

M.goimports = function()
  return {
    exe = "goimports",
    stdin = true,
  }
end

M.rustfmt = function()
  return {
    exe = "rustfmt",
    args = {
      string.format(
        "--config hard_tabs=%s,tab_spaces=%s",
        not vim.opt.expandtab:get(),
        vim.opt.shiftwidth:get()
      ),
    },
    stdin = true,
  }
end

M.latex = function()
  return {
    exe = "latexindent",
    args = { "-g /dev/stderr", "2>/dev/null" },
    stdin = true,
  }
end

M.swift = function()
  return {
    exe = "swift-format",
    args = { "format", get_current_file_name() },
    stdin = true,
  }
end

M.xmllint = function()
  return {
    exe = "xmllint",
    args = { "--format", get_current_file_name()},
    stdin = true,
  }
end

local config = {
  logging = true,
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
    css = { M.prettier "--parser css" },
    xml = { M.xmllint },
    json = { M.prettier() },
    html = { M.prettier "--parser html" },
    scss = { M.prettier() },
    markdown = { M.prettier() },
    javascript = { M.prettierd },
    typescript = { M.prettierd },
    javascriptreact = { M.prettierd },
    typescriptreact = { M.prettierd },
  },
}

M.setup = function()
  formatter.setup(config)
  configure_mappings()
end

return M
