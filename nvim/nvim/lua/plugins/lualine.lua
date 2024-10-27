return {
  "nvim-lualine/lualine.nvim",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {'filename', 'filesize'},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'selectioncount', 'progress'},
      lualine_z = {'location'}
    },
  }
}
