function check_bufname(regex)
  return string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), regex)
end

return {
  "zbirenbaum/copilot.lua",
  lazy = true,
  cmd = "Copilot",
  event = "InsertEnter",
  opts = {
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = "<C-j>"
      }
    },
    panel = {
      auto_refresh = true,
      layout = {
        position = "right",
        ratio = 0.3
      },
    },
    filetypes = {
      yaml = function()
        return not check_bufname('.*docker-compose.y[a]ml$')
      end,
      -- disable for .env files
      sh = function()
        return not check_bufname('^%.env.*')
      end,
    },
  },
  init = function()
    vim.keymap.set("n", "<leader>cp", "<cmd>Copilot panel<CR>", { desc = "[C]opilot [P]anel" })
    vim.keymap.set("n", "<leader>cs", "<cmd>Copilot suggestion<CR>", { desc = "[C]opilot [S]uggestion" })
  end
}
