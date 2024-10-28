return {
  "ThePrimeagen/harpoon",
  cond = not vim.g.started_by_firenvim,
  opts = {
    save_on_toggle = true,
    mark_branch = true,
    tabline = true
  },
  init = function()
    vim.keymap.set("n", "<leader>ha", function()
      require("harpoon.mark").add_file()
    end, { desc = "[H]arpoon [A]dd" })
    vim.keymap.set("n", "<leader>hf", function()
      require("harpoon.ui").toggle_quick_menu()
    end, { desc = "[H]arpoon [F]ind" })

    vim.keymap.set({"n", "i"}, "<C-J>", function ()
      require("harpoon.ui").nav_file(1)
    end)
    vim.keymap.set({"n", "i"}, "<C-K>", function ()
      require("harpoon.ui").nav_file(2)
    end)
    vim.keymap.set({"n", "i"}, "<C-L>", function ()
      require("harpoon.ui").nav_file(3)
    end)
    vim.keymap.set({"n", "i"}, "<C-;>", function ()
      require("harpoon.ui").nav_file(4)
    end)
  end
}
