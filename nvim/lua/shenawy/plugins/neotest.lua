return {
  "nvim-neotest/neotest",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-neotest/nvim-nio",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-go",
    "rouge8/neotest-rust",
    "nvim-neotest/neotest-python",
  },

  config = function()
    -- local neotest_ns = vim.api.nvim_create_namespace("neotest")
    -- vim.diagnostic.config({
    --   virtual_text = {
    --     format = function(diagnostic)
    --       local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
    --       return message
    --     end,
    --   },
    -- }, neotest_ns)

    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "<leader>mr", ':lua require("neotest").run.run()<CR>', opts)
    vim.keymap.set("n", "<leader>ms", ':lua require("neotest").run.stop()<CR>', opts)
    vim.keymap.set("n", "<leader>mo", ':lua require("neotest").output.open()<CR>', opts)
    vim.keymap.set("n", "<leader>mt", ':lua require("neotest").summary.toggle()<CR>', opts)
    vim.keymap.set("n", "<leader>ma", ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>', opts)
    vim.keymap.set("n", "[m", ':lua require("neotest").jump.prev({status = "failed"})<CR>', opts)
    vim.keymap.set("n", "]m", ':lua require("neotest").jump.next({status = "failed"})<CR>', opts)

    require("neotest").setup({
      adapters = {
        require("neotest-go"),
        require("neotest-rust"),
        require("neotest-python"),
      },
    })
  end,
}
