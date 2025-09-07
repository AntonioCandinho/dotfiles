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
  get_or_create_lazy().setup {
    spec = {
      { import = "plugins" }
    },
    defaults = {
      lazy = true,
    },
    lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
  }
end

return M
