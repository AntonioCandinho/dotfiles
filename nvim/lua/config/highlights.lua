-- Custom highlight configurations for improved visual experience with Kanagawa Wave
local M = {}

function M.setup()
  -- Define autocmd to set highlights after colorscheme loads
  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
      -- Enhanced completion menu highlights using Kanagawa Wave colors
      vim.api.nvim_set_hl(0, "BlinkCmpMenu", { 
        bg = "#2A2A37", -- Kanagawa sumiInk2 (lighter background)
        fg = "#DCD7BA", -- Kanagawa fujiWhite (default foreground)
      })
      
      vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { 
        fg = "#7E9CD8", -- Kanagawa crystalBlue
        bg = "#2A2A37", 
      })
      
      vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { 
        bg = "#363646", -- Kanagawa sumiInk3 (lighter background - cursorline)
        fg = "#DCD7BA", 
        bold = true,
      })
      
      vim.api.nvim_set_hl(0, "BlinkCmpDoc", { 
        bg = "#1F1F28", -- Kanagawa sumiInk1 (default background)
        fg = "#DCD7BA", 
      })
      
      vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { 
        fg = "#98BB6C", -- Kanagawa springGreen
        bg = "#1F1F28", 
      })
      
      vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelp", { 
        bg = "#16161D", -- Kanagawa sumiInk0 (dark background)
        fg = "#DCD7BA", 
      })
      
      vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { 
        fg = "#E6C384", -- Kanagawa carpYellow
        bg = "#16161D", 
      })

      -- Enhanced LSP diagnostic highlights using Kanagawa colors
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", {
        fg = "#E82424", -- Kanagawa samuraiRed
        bg = "NONE",
        italic = true,
      })
      
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", {
        fg = "#FF9E3B", -- Kanagawa roninYellow
        bg = "NONE", 
        italic = true,
      })
      
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", {
        fg = "#6A9589", -- Kanagawa waveAqua1
        bg = "NONE",
        italic = true,
      })
      
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", {
        fg = "#658594", -- Kanagawa dragonBlue
        bg = "NONE",
        italic = true,
      })

      -- Enhanced floating window highlights
      vim.api.nvim_set_hl(0, "NormalFloat", {
        bg = "#1F1F28", -- Kanagawa sumiInk1 (default background)
        fg = "#DCD7BA", -- Kanagawa fujiWhite
      })
      
      vim.api.nvim_set_hl(0, "FloatBorder", {
        fg = "#54546D", -- Kanagawa sumiInk4 (float borders)
        bg = "#1F1F28",
      })

      -- Enhanced inlay hints
      vim.api.nvim_set_hl(0, "LspInlayHint", {
        fg = "#727169", -- Kanagawa fujiGray (comments)
        bg = "NONE",
        italic = true,
      })

      -- Better cursor line
      vim.api.nvim_set_hl(0, "CursorLine", {
        bg = "#363646", -- Kanagawa sumiInk3 (lighter background - cursorline)
      })

      -- Enhanced search highlighting
      vim.api.nvim_set_hl(0, "Search", {
        bg = "#C0A36E", -- Kanagawa boatYellow2
        fg = "#1F1F28", -- Kanagawa sumiInk1
        bold = true,
      })
      
      vim.api.nvim_set_hl(0, "IncSearch", {
        bg = "#FFA066", -- Kanagawa surimiOrange
        fg = "#1F1F28", -- Kanagawa sumiInk1
        bold = true,
      })
    end,
  })
end

return M
