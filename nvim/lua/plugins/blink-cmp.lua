return {
  "saghen/blink.cmp",
  dependencies = { 
    "mikavilpas/blink-ripgrep.nvim", 
    "ribru17/blink-cmp-spell" 
  },
  version = "1.*",
  opts = {
    completion = {
      documentation = { 
        auto_show = true,
        auto_show_delay_ms = 200,
        treesitter_highlighting = true,
        window = {
          min_width = 15,
          max_width = 60,
          max_height = 20,
          border = "rounded",
          winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
          scrollbar = true,
        },
      },
      keyword = { range = "full" },
      list = { 
        selection = { auto_insert = false },
        max_items = 200,
      },
      menu = {
        enabled = true,
        min_width = 15,
        max_height = 10,
        border = "rounded",
        winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
        scrollbar = true,
        direction_priority = { "s", "n" },
      },
      accept = {
        create_undo_point = true,
        auto_brackets = {
          enabled = true,
          default_brackets = { "(", ")" },
          override_brackets_for_filetypes = {},
          force_allow_filetypes = {},
          blocked_filetypes = {},
        },
      },
    },
    keymap = {
      preset = "default",
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<C-y>"] = { "select_and_accept" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
      kind_icons = {
        Text = "󰉿",
        Method = "󰊕",
        Function = "󰊕",
        Constructor = "󰒓",
        Field = "󰜢",
        Variable = "󰀫",
        Class = "󰠱",
        Interface = "󰜰",
        Module = "󰆧",
        Property = "󰜢",
        Unit = "󰑭",
        Value = "󰎠",
        Enum = "󰒻",
        Keyword = "󰌋",
        Snippet = "󰩫",
        Color = "󰏘",
        File = "󰈚",
        Reference = "󰈇",
        Folder = "󰉋",
        EnumMember = "󰒻",
        Constant = "󰏿",
        Struct = "󰙅",
        Event = "󰉁",
        Operator = "󰆕",
        TypeParameter = "󰊄",
      },
    },
    signature = { 
      enabled = true,
      trigger = {
        blocked_trigger_characters = {},
        blocked_retrigger_characters = {},
        show_on_insert_on_trigger_character = true,
      },
      window = {
        min_width = 1,
        max_width = 100,
        max_height = 10,
        border = "rounded",
        winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
        scrollbar = false,
      },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "ripgrep", "spell" },
      providers = {
        path = {
          opts = {
            get_cwd = function()
              return vim.fn.getcwd()
            end,
            show_hidden_files_by_default = true,
          },
        },
        ripgrep = {
          module = "blink-ripgrep",
          name = "Ripgrep",
          max_items = 3,
          score_offset = -3,
        },
        spell = {
          name = "Spell",
          module = "blink-cmp-spell",
          opts = {
            enable_in_context = function()
              local curpos = vim.api.nvim_win_get_cursor(0)
              local captures =
                vim.treesitter.get_captures_at_pos(0, curpos[1] - 1, curpos[2] - 1)
              local in_spell_capture = false
              for _, cap in ipairs(captures) do
                if cap.capture == "spell" then
                  in_spell_capture = true
                elseif cap.capture == "nospell" then
                  return false
                end
              end
              return in_spell_capture
            end,
          },
        },
      },
    },
  },
}
