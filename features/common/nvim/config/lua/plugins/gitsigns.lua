return {
  "lewis6991/gitsigns.nvim",
  opts = {
    on_attach = function (bufnr)
      vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<CR>", { buffer = bufnr, desc = "Toggle [G]it [B]lame" })
    end,
    attach_to_untracked = true,
    current_line_blame_opts = {
      delay = 0,
      ignore_whitespace = true,
    },
  }
}
