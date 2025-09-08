return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("kanagawa").setup({
      compile = false,             -- enable compiling the colorscheme
      undercurl = true,            -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false,         -- do not set background color
      dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
      terminalColors = true,       -- define vim.g.terminal_color_{0,17}
      colors = {                   -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      overrides = function(colors) -- add/modify highlights
        return {
          -- Enhanced LSP and completion highlights
          NormalFloat = { bg = colors.theme.ui.bg_p1, fg = colors.theme.ui.fg },
          FloatBorder = { bg = colors.theme.ui.bg_p1, fg = colors.theme.ui.fg_dim },
          FloatTitle = { bg = colors.theme.ui.bg_p1, fg = colors.theme.ui.special, bold = true },
          
          -- Better completion menu
          Pmenu = { fg = colors.theme.ui.shade0, bg = colors.theme.ui.bg_p1 },
          PmenuSel = { fg = "NONE", bg = colors.theme.ui.bg_p2 },
          PmenuSbar = { bg = colors.theme.ui.bg_m1 },
          PmenuThumb = { bg = colors.theme.ui.bg_p2 },
          
          -- Enhanced diagnostics
          DiagnosticVirtualTextError = { bg = "NONE", fg = colors.theme.diag.error, italic = true },
          DiagnosticVirtualTextWarn = { bg = "NONE", fg = colors.theme.diag.warning, italic = true },
          DiagnosticVirtualTextInfo = { bg = "NONE", fg = colors.theme.diag.info, italic = true },
          DiagnosticVirtualTextHint = { bg = "NONE", fg = colors.theme.diag.hint, italic = true },
        }
      end,
      theme = "wave",              -- Load "wave" theme when 'background' option is not set
      background = {               -- map the value of 'background' option to a theme
        dark = "wave",             -- try "dragon" !
        light = "lotus"
      },
    })

    vim.cmd.colorscheme("kanagawa")
  end,
}
