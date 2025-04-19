local M = {}

local get_or_create_lazy = function()
  local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out =
      vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out, "WarningMsg" },
        { "\nPress any key to exit..." },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
  end
  vim.opt.rtp:prepend(lazypath)
  return require "lazy"
end

M.setup = function()
  local current_path = debug.getinfo(1).source:match "@?(.*/)"
  get_or_create_lazy().setup {
    spec = {
      require "packages.ui",
      require "packages.treesitter",
      require "packages.completion",
      require "packages.formatter",
      require "packages.navigation",
      require "packages.ai",
    },
    defaults = {
      lazy = true,
    },
    lockfile = current_path .. "/lazy-lock.json",
  }
end

return M
