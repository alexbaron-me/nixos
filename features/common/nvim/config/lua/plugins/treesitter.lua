return {
  {
    "nvim-treesitter/nvim-treesitter",
    main = "nvim-treesitter.configs",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup {
        -- ensure_installed = "all",  -- Bloat? What's that mean?
        auto_install = true,
        highlight = {
          enable = true
        },
        indent = {
          enable = true
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
              ['ii'] = '@conditional.inner',
              ['ai'] = '@conditional.outer',
              ['il'] = '@loop.inner',
              ['al'] = '@loop.outer',
              ['ah'] = '@comment.outer',
              ['ih'] = '@comment.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']f'] = '@function.outer',
              [']]'] = '@class.outer',
              [']i'] = '@conditional.outer',
              [']l'] = '@loop.outer',
              [']h'] = '@comment.outer'
            },
            goto_next_end = {
              [']F'] = '@function.outer',
              [']['] = '@class.outer',
              [']I'] = '@conditional.outer',
              [']L'] = '@loop.outer',
              [']H'] = '@comment.outer'
            },
            goto_previous_start = {
              ['[f'] = '@function.outer',
              ['[['] = '@class.outer',
              ['[i'] = '@conditional.outer',
              ['[l'] = '@loop.outer',
              ['[h'] = '@comment.outer'
            },
            goto_previous_end = {
              ['[F'] = '@function.outer',
              ['[]'] = '@class.outer',
              ['[I'] = '@conditional.outer',
              ['[L'] = '@loop.outer',
              ['[H'] = '@comment.outer'
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },
        }
      }
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-textobjects"
    }
  },
  {
    "Wansmer/treesj",
    opts = {
      use_default_keymaps = false
    },
    init = function ()
      vim.keymap.set('n', '<leader>m', require('treesj').toggle)
      vim.keymap.set('n', '<leader>M', function ()
        require('treesj').toggle({ split = { recursive = true } })
      end)
    end
  }
}
