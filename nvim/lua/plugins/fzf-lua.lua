local config = {
  winopts = {
    height = 0.60, -- window height
    width = 0.55, -- window width
    row = 0.35, -- window row position (0=top, 1=bottom)
    col = 0.50, -- window col position (0=left, 1=right)
    preview = {
      layout = "vertical",
    },
  },
  fzf_opts = {
    ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history",
  },
  files = {
    fzf_opts = {
      ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-files-history",
    },
  },
  grep = {
    fzf_opts = {
      ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-grep-history",
    },
  },
}

local keymaps = {
  { "<leader><leader>", "<cmd>FzfLua files<cr>", desc = "Find files (quick)" },
  { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
  { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
  { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Find buffers" },
  { "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Help tags" },
}

return {
  "ibhagwan/fzf-lua",
  cmd = { "FzfLua" },
  keys = keymaps,
  config = function() 
    require("fzf-lua").setup(config) 
  end,
}
