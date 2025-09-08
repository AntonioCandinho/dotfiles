-- Global keymaps configuration
local M = {}

function M.setup()
  -- Set leader key (this is done in settings.lua but keeping reference)
  vim.g.mapleader = " "

  -- Fix Alt key handling in terminal (especially Kitty on macOS)
  -- Map escape sequences to Alt combinations
  local function setup_alt_keys()
    local chars = 'abcdefghijklmnopqrstuvwxyz'
    for i = 1, #chars do
      local c = chars:sub(i, i)
      local key = string.format('<A-%s>', c)
      local esc_seq = string.format('\\<Esc>%s', c)
      vim.keymap.set('i', esc_seq, key, { expr = true })
      vim.keymap.set('n', esc_seq, key, { expr = true })
    end
    
    -- Special characters that might be used with Alt
    local special_chars = { '\\', 'j', 'k', 'l' }
    for _, c in ipairs(special_chars) do
      local key = string.format('<A-%s>', c)
      local esc_seq = string.format('\\<Esc>%s', c)
      vim.keymap.set('i', esc_seq, key, { expr = true })
      vim.keymap.set('n', esc_seq, key, { expr = true })
    end
  end

  setup_alt_keys()

  -- Set timeouts for Alt key recognition
  vim.opt.timeout = true
  vim.opt.ttimeoutlen = 50

  -- General keymaps
  local map = vim.keymap.set

  -- Better window navigation
  map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
  map("n", "<C-j>", "<C-w>j", { desc = "Go to down window" })
  map("n", "<C-k>", "<C-w>k", { desc = "Go to up window" })
  map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

  -- Window resizing
  map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
  map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
  map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
  map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

  -- Buffer navigation
  map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

  -- Better indenting
  map("v", "<", "<gv", { desc = "Indent left" })
  map("v", ">", ">gv", { desc = "Indent right" })

  -- Move text up and down
  map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
  map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })

  -- Clear highlights
  map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear highlights" })

  -- Better paste
  map("v", "p", '"_dP', { desc = "Paste without overwriting register" })

  -- Quick save
  map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })

  -- Quit
  map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })

end

return M
