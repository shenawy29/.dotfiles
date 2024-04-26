return {
  "NvChad/nvim-colorizer.lua",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("colorizer").setup({
      filetypes = { "*" },
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = false,
        RRGGBBAA = true,
        AARRGGBB = false,
        rgb_fn = true,
        hsl_fn = true,
        css = false,
        css_fn = false,

        mode = "background",

        tailwind = true,

        sass = { enable = false, parsers = { "css" } },
        virtualtext = "■",

        always_update = false,
      },

      buftypes = {},
    })
  end,
}
