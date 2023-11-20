return {
  "stevearc/oil.nvim",
  opts = {},
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

    require("oil").setup({
      keymaps = {
        ["<TAB>"] = "actions.select",
      },
    })
  end,
}
