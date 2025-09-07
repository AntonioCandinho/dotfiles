return {
  "moll/vim-bbye",
  keys = {
    { "<leader>bd", "<cmd>Bdelete<CR>", desc = "Close buffer keeping window" },
  },
  cmd = { "Bdelete", "Bwipeout" },
}
