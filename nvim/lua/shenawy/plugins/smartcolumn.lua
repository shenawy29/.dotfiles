return {
  "m4xshen/smartcolumn.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    disabled_filetypes = {
      "startup",
      "lazy",
      "mason",
      "markdown",
      "help",
      "netrw",
      "html",
      "man",
      "tsx",
      "jsx",
      "fugitive",
      "Trouble",
      "oil",
      "lspinfo",
      "conf",
    },
  },
}
