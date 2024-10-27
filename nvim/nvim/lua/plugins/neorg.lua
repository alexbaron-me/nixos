return {
  "nvim-neorg/neorg",
  lazy = true,
  cmd = {"Neorg"},
  version = "*",
  opts = {
    load = {
      ["core.defaults"] = {},
      ["core.concealer"] = {},
      ["core.dirman"] = {
        config = {
          workspaces = {
            notes = "~/Notes",
          },
        },
      },
    },
  }
}
