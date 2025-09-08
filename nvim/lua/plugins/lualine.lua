return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()
    -- VSCode-like status bar components
    local function buffer_count()
      local buffers = vim.tbl_filter(function(buf)
        return vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted
      end, vim.api.nvim_list_bufs())
      return "Buffers:" .. #buffers
    end
    
    -- Encoding info
    local function encoding()
      local enc = vim.bo.fileencoding or vim.bo.encoding
      return enc:upper()
    end
    
    -- Line endings
    local function line_endings()
      local format = vim.bo.fileformat
      if format == 'unix' then
        return 'LF'
      elseif format == 'dos' then
        return 'CRLF'
      elseif format == 'mac' then
        return 'CR'
      end
      return format:upper()
    end
    
    -- Selection info (when in visual mode) - simplified and safer
    local function selection_count()
      local mode = vim.fn.mode()
      if mode == 'v' or mode == 'V' or mode == '\x16' then
        if mode == 'V' then
          local lines = math.abs(vim.fn.line('.') - vim.fn.line('v')) + 1
          return lines .. ' lines'
        elseif mode == 'v' then
          return 'Visual'
        else
          return 'Block'
        end
      end
      return ''
    end

    -- Create custom kanagawa theme with proper semantic colors and transparency
    local kanagawa_colors = require('kanagawa.colors').setup()
    local theme_colors = kanagawa_colors.theme
    local palette = kanagawa_colors.palette
    
    local custom_kanagawa = {
      normal = {
        a = { bg = theme_colors.ui.bg, fg = palette.fujiWhite, gui = 'bold' },           -- Mode: bright white, bold
        b = { bg = theme_colors.ui.bg, fg = theme_colors.ui.fg_dim },                    -- Secondary info: dimmed
        c = { bg = theme_colors.ui.bg, fg = theme_colors.ui.fg },          -- Main background
        x = { bg = theme_colors.ui.bg, fg = theme_colors.ui.fg_dim },                    -- Secondary info
        y = { bg = theme_colors.ui.bg, fg = palette.crystalBlue },                      -- File info: crystal blue
        z = { bg = theme_colors.ui.bg, fg = palette.springViolet2, gui = 'bold' },      -- Location: spring violet, bold
      },
      insert = {
        a = { bg = theme_colors.ui.bg, fg = palette.springGreen, gui = 'bold' },        -- Insert mode: green
        b = { bg = theme_colors.ui.bg, fg = theme_colors.ui.fg_dim },
        c = { bg = theme_colors.ui.bg, fg = theme_colors.ui.fg },
        x = { bg = theme_colors.ui.bg, fg = theme_colors.ui.fg_dim },
        y = { bg = theme_colors.ui.bg, fg = palette.crystalBlue },
        z = { bg = theme_colors.ui.bg, fg = palette.springViolet2, gui = 'bold' },
      },
      visual = {
        a = { bg = theme_colors.ui.bg, fg = palette.surimiOrange, gui = 'bold' },       -- Visual mode: orange
        b = { bg = theme_colors.ui.bg, fg = theme_colors.ui.fg_dim },
        c = { bg = theme_colors.ui.bg, fg = theme_colors.ui.fg },
        x = { bg = theme_colors.ui.bg, fg = theme_colors.ui.fg_dim },
        y = { bg = theme_colors.ui.bg, fg = palette.crystalBlue },
        z = { bg = theme_colors.ui.bg, fg = palette.springViolet2, gui = 'bold' },
      },
      replace = {
        a = { bg = theme_colors.ui.bg, fg = palette.samuraiRed, gui = 'bold' },         -- Replace mode: red
        b = { bg = theme_colors.ui.bg, fg = theme_colors.ui.fg_dim },
        c = { bg = theme_colors.ui.bg, fg = theme_colors.ui.fg },
        x = { bg = theme_colors.ui.bg, fg = theme_colors.ui.fg_dim },
        y = { bg = theme_colors.ui.bg, fg = palette.crystalBlue },
        z = { bg = theme_colors.ui.bg, fg = palette.springViolet2, gui = 'bold' },
      },
      command = {
        a = { bg = theme_colors.ui.bg, fg = palette.crystalBlue, gui = 'bold' },        -- Command mode: blue
        b = { bg = theme_colors.ui.bg, fg = theme_colors.ui.fg_dim },
        c = { bg = theme_colors.ui.bg, fg = theme_colors.ui.fg },
        x = { bg = theme_colors.ui.bg, fg = theme_colors.ui.fg_dim },
        y = { bg = theme_colors.ui.bg, fg = palette.crystalBlue },
        z = { bg = theme_colors.ui.bg, fg = palette.springViolet2, gui = 'bold' },
      },
      inactive = {
        a = { bg = theme_colors.ui.bg, fg = palette.fujiGray },                         -- Inactive: gray
        b = { bg = theme_colors.ui.bg, fg = palette.fujiGray },
        c = { bg = theme_colors.ui.bg, fg = palette.fujiGray },
      },
    }

    require("lualine").setup({
      options = {
        icons_enabled = false,
        theme = custom_kanagawa,
        component_separators = { left = '│', right = '│' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,  -- Slower refresh to prevent cursor blinking
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        -- VSCode-inspired status bar layout
        lualine_a = {
          {
            "mode",
            padding = { left = 1, right = 1 },
          },
        }, -- Show editing mode
        lualine_b = {
          {
            "branch", -- Use built-in git branch instead of custom function
            padding = { left = 1, right = 1 },
          },
        },
        lualine_c = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            sections = { "error", "warn", "info", "hint" },
            symbols = { error = "E:", warn = "W:", info = "I:", hint = "H:" }, -- Simpler symbols
            padding = { left = 0, right = 1 },
          },
        },
        lualine_x = {
          {
            selection_count,
            cond = function() 
              local mode = vim.fn.mode()
              return mode == 'v' or mode == 'V' or mode == '\x16'
            end,
            padding = { left = 1, right = 1 },
          },
        },
        lualine_y = {
          {
            "filetype",
            padding = { left = 1, right = 1 },
          },
          {
            encoding,
            padding = { left = 1, right = 1 },
          },
          {
            line_endings,
            padding = { left = 1, right = 1 },
          },
        },
        lualine_z = {
          {
            "location", -- Use built-in location instead of custom function
            padding = { left = 1, right = 1 },
          },
          {
            "progress", -- Add progress percentage
            padding = { left = 1, right = 1 },
          }
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {
        -- Simplified tabline - VSCode doesn't show much here
        lualine_a = { 
          {
            buffer_count,
            padding = { left = 1, right = 1, bottom = 1 },
          }
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 
          {
            function()
              local filename = vim.fn.expand('%:t')
              if filename == '' then
                return '[No Name]'
              end
              -- Show modified indicator like VSCode
              if vim.bo.modified then
                return filename .. " ●"
              end
              return filename
            end,
            padding = { left = 1, right = 1 },
          }
        },
      },
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    })
  end,
}
