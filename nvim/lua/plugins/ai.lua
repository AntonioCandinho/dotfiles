return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
      panel = {
        enabled = true,
        auto_refresh = true,
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
      },
    },
  },
  {
    {
      "CopilotC-Nvim/CopilotChat.nvim",
      cmd = {
        "CopilotChatOpen",
        "CopilotChatToggle",
        "CopilotChatPrompts",
        "CopilotChatCommit",
        "CopilotChatLoad",
        "CopilotChatExplain",
        "CopilotChatReview",
      },
      dependencies = {
        { "zbirenbaum/copilot.lua" },
        { "nvim-lua/plenary.nvim", branch = "master" },
      },
      build = "make tiktoken",
      opts = {
        model = "claude-3.7-sonnet",
        mappings = {
          close = {
            insert = "",
          },
        },
      },
    },
  },
}
