local M = {}

local get_current_file_name = function()
  local file_name = vim.api.nvim_buf_get_name(0)
  return vim.fn.fnameescape(file_name)
end

M.prettier = function(options)
  return function()
    return {
      exe = "bunx prettier",
      args = vim.tbl_flatten { "--stdin-filepath", get_current_file_name(), options or {} },
      stdin = true,
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

M.zig = function()
  return {
    exe = "zig",
    args = { "fmt --stdin" },
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
    exe = "swiftformat",
    args = { "stdin", "--stdinpath", get_current_file_name() },
    stdin = true,
  }
end

M.xmllint = function()
  return {
    exe = "xmllint",
    args = { "--format", get_current_file_name() },
    stdin = true,
  }
end

return {
  {
    "mhartington/formatter.nvim",
    cmd = { "Format", "FormatWrite" },
    keys = {
      { "<leader>f", "<cmd>Format<CR>", desc = "Format sources" },
    },
    config = function()
      require("formatter").setup {
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
          zig = { M.zig },
          json = { M.prettier() },
          html = { M.prettier "--parser html" },
          scss = { M.prettier() },
          markdown = { M.prettier() },
          javascript = { M.prettier() },
          typescript = { M.prettier() },
          javascriptreact = { M.prettier() },
          typescriptreact = { M.prettier() },
        },
      }
    end,
  },
}
