return {
  {
    "folke/noice.nvim",
    cond = not vim.g.started_by_firenvim,
    event = "VeryLazy",
    opts = {
      lsp = {
        progress = {
          enable = false -- Already using fidget.nvim for this
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,       -- add a border to hover docs and signature help
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "search_count",
          },
          opts = { skip = true },
        },
        -- Render large notifications as split window
        {
          filter = {
            event = "notify",
            min_height = 15
          },
          view = "split"
        },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        opts = {
          timeout = 1500,
          render = "compact"
        }
      },
    }
  },
  {
    "stevearc/dressing.nvim",
    opts = {}
  }
}
