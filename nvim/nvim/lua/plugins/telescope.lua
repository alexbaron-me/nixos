return {
  "nvim-telescope/telescope.nvim",
  branch = '0.1.x',
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "BurntSushi/ripgrep",
    "nvim-telescope/telescope-fzy-native.nvim",
    "nvim-tree/nvim-web-devicons"
  },
  opts = {
    defaults = {
      layout_strategy = "flex",
    },
  },
  init = function()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = "[S]earch [B]uffers" })
    vim.keymap.set('n', '<leader>sq', builtin.quickfix, { desc = "[S]earch [Q]uickfix" })
    vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Search [G]it [F]iles" })
    vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<leader>sr", builtin.registers, { desc = "[S]earch [R]egisters" })
    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
    vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
    vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
    vim.keymap.set("n", "<leader>ss", builtin.lsp_dynamic_workspace_symbols, { desc = "[S]earch [S]ymbols" })
    vim.keymap.set("n", "<leader>st", ":TodoTelescope<CR>", { desc = "[S]earch [T]odo-comments" })
    vim.keymap.set("n", "<leader>sn", ":Telescope notify<CR>", { desc = "[S]earch [N]notifications" })
    vim.keymap.set("n", "<leader><leader>", builtin.treesitter, { desc = "Search Treesitter" })

    vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "[G]o to [D]efinition" })
    vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "[G]o to [R]eferences" })
    vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "[G]o to [I]mplementations" })
    vim.keymap.set("n", "gI", builtin.lsp_incoming_calls, { desc = "[G]o to [I]ncoming calls" })
    vim.keymap.set("n", "gO", builtin.lsp_outgoing_calls, { desc = "[G]o to [O]utgoing calls" })

    vim.keymap.set("n", "<leader>/", function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
	previewer = false,
      })
    end, { desc = "[/] Fuzzily search in current buffer" })

    require('telescope').load_extension('fzy_native')
  end
}
