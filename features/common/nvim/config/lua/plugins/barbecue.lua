return {
  "utilyre/barbecue.nvim",
  cond = not vim.g.started_by_firenvim,
  name = "barbecue",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons"
  },
  opts = true,
}
