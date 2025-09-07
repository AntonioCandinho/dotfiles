return {
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
}
