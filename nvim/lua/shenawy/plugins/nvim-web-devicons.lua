return {
  "nvim-tree/nvim-web-devicons",
  lazy = true,
  config = function()
    require("nvim-web-devicons").set_icon({
      proto = {
        icon = "",
        color = "#8bddde",
        cterm_color = "199",
        name = "Proto",
      },
      norg = {
        icon = "",
        color = "#3f5591",
        cterm_color = "199",
        name = "Neorg",
      },
    })
  end,
}
