return {
  "glacambre/firenvim",
  build = ":call firenvim#install(0)",
  init = function()
    vim.g.firenvim_config = {
      localSettings = {
        ['.*'] = {
          selector = 'textarea'
        }
      }
    }
  end
}
