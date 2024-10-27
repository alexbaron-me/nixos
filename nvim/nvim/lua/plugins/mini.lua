return {
  "echasnovski/mini.nvim",
  version = false,
  init = function ()
    require("mini.trailspace").setup()
    require("mini.comment").setup()
    require("mini.cursorword").setup()
  end
}
