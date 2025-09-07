return {
  {
    "saghen/blink.cmp",
    dependencies = { "mikavilpas/blink-ripgrep.nvim", "ribru17/blink-cmp-spell" },
    version = "1.*",
    opts = {
        completion = {
          documentation = { auto_show = true },
          keyword = { range = "full" },
          list = { selection = { auto_insert = false } },
        },
        keymap = { preset = "super-tab" },
        appearance = {
          nerd_font_variant = "mono",
        },
        signature = { enabled = true },
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
              -- the score offset may need more tweeking
              score_offset = -3,
            },
            spell = {
              name = "Spell",
              module = "blink-cmp-spell",
              opts = {
                -- Only enable source in `@spell` captures, and disable it in `@nospell` captures.
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
  },
}
