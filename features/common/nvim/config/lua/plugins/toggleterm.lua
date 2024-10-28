return {
  "akinsho/toggleterm.nvim",
  opts = {
    direction = "float",
  },
  init = function ()
    local Terminal = require("toggleterm.terminal").Terminal

    local lazygit = Terminal:new({ cmd = "lazygit", display_name = "lazygit" })
    vim.keymap.set("n", "<leader>wg", function ()
      lazygit:toggle()
    end, { desc = "Toggle [W]indow Lazy[G]it" })

    local atac = Terminal:new({ cmd = "mkdir -p .atac && atac -d .atac", display_name = "atac" })
    vim.keymap.set("n", "<leader>wa", function ()
      -- TODO: Update .gitignore to include .atac
      atac:toggle()
    end, { desc = "Toggle [W]indow [A]tac" })
  end
}
