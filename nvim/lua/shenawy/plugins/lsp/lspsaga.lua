return {
  "nvimdev/lspsaga.nvim",
  lazy = true,
  event = "LspAttach",
  config = function()
    local lspsaga = require("lspsaga")

    lspsaga.setup({
      symbol_in_winbar = {
        enable = false,
      },
      lightbulb = {
        enable = false,
      },
      ui = {
        border = "rounded",
      },
      code_action = {
        extend_gitsigns = true,
      },
    })
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
}
