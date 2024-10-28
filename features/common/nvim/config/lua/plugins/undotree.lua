return {
  "jiaoshijie/undotree",
  dependencies = "nvim-lua/plenary.nvim",
  opts = {
    window = {
      winblend = 0
    },
    keymaps = {
      ['<Esc>'] = "quit"
    }
  },
  keys = { -- load the plugin only when using it's keybinding:
    { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
  },
}
