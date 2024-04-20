return {
  "folke/trouble.nvim",
  lazy = true,
  keys = {
    { "<leader>xx", '<cmd>lua require("trouble").toggle()<cr>' },
    { "<leader>xw", '<cmd>lua require("trouble").toggle("workspace_diagnostics")<cr>' },
    { "<leader>xd", '<cmd>lua require("trouble").toggle("document_diagnostics")<cr>' },
    { "<leader>xq", '<cmd>lua require("trouble").toggle("quickfix")<cr>' },
    { "<leader>xl", '<cmd>lua require("trouble").toggle("loclist")<cr>' },
    { "gR", '<cmd>lua require("trouble").toggle("lsp_references")<cr>' },
  },
}
