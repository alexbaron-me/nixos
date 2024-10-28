return {
  "stevearc/oil.nvim",
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  opts = {
    skip_confirm_for_simple_edits = true,
    keymaps = {
      ["<Esc>"] = "actions.close",
      ["q"] = "actions.close",
    },
    watch_for_changes = true,
    view_options = {
      show_hidden = true,
      is_always_hidden = function(name, bufnr)
	return name == "." or name == ".." or name == ".DS_Store"
      end
    },
  },
  init = function()
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end
}
