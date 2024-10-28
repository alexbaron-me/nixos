return {
  "mistricky/codesnap.nvim",
  build = "make",
  lazy = false,
  keys = {
    { "<leader>cc", "<cmd>CodeSnap<cr>",              mode = "x", desc = "[C]odeSnap to [C]lipboard" },
    { "<leader>cC", "<cmd>CodeSnapHighlight<cr>",     mode = "x", desc = "[C]odeSnap to [C]lipboard - select lines" },
    { "<leader>cd", "<cmd>CodeSnapSave<cr>",          mode = "x", desc = "[C]odeSnap to [D]isk" },
    { "<leader>cD", "<cmd>CodeSnapSaveHighlight<cr>", mode = "x", desc = "[C]odeSnap to [D]isk - select lines" },
  },
  opts = {
    watermark = "",
    save_path = "~/Downloads",
  }
}
