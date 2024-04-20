return {
  "folke/neodev.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    library = { plugins = { "neotest" }, types = true },
  },
}
