return {
  "ggandor/leap.nvim",
  dependencies = {
    "tpope/vim-repeat"
  },
  config = function()
    local leap = require("leap")
    leap.opts.equivalence_classes = { ' \t\r\n', 'aä', 'oö', 'uü', 'sß' }
    leap.add_default_mappings()

    vim.keymap.set({'n', 'o'}, 'gS', function ()
      require('leap.remote').action()
    end)

    local actions = { 'i', 'a' }
    local textobjects = { 'w', 'W', 's', 'p', '[', '[', '(', ')', 'b', '>', '<', 't', '{', '}', 'B', '"', '\'', '`', 'f', 'c', 'i', 'h', 'l', 'a' }

    -- Create remote versions of all native text objects by inserting `r` (for remote)
    -- into the middle (`iw` becomes `irw`, etc.):
    for _, action in ipairs(actions) do
      for _, obj in ipairs(textobjects) do
	vim.keymap.set({'x', 'o'}, action..'r'..obj, function ()
	  require('leap.remote').action { input = action..obj }
	end)
      end
    end

    -- Special case: `gc` for comments
    vim.keymap.set({'x', 'o'}, "rgc", function ()
      require('leap.remote').action { input = "gc" }
    end)
  end
}
