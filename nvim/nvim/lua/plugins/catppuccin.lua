return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    integrations = {
      cmp = true,
      harpoon = true,
      fidget = true,
      mason = true,
      notify = true,
      noice = true,
      octo = true,
      which_key = true,
      mini = true,
    },
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
      comments = { "italic" }, -- Change the style of comments
      conditionals = { "italic" },
    },
    custom_highlights = function(colors)
      return {
        CmpBorder = { fg = colors.maroon },
      }
    end
  },
  init = function()
    vim.cmd "colorscheme catppuccin-macchiato"

    -- Some personal tweaks
    local colors = require("catppuccin.palettes.macchiato")
    vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = colors.lavender })
    vim.api.nvim_set_hl(0, "HarpoonActive", { bg = colors.surface0, fg = colors.mauve })
    vim.api.nvim_set_hl(0, "HarpoonNumberActive", { bg = colors.surface0, fg = colors.mauve })
    vim.api.nvim_set_hl(0, "HarpoonInactive", { bg = colors.base, fg = colors.overlay0 })
    vim.api.nvim_set_hl(0, "HarpoonNumberInactive", { bg = colors.base, fg = colors.overlay0 })
  end
}
