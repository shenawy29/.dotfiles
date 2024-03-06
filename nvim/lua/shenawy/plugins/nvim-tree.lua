return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")

    require("nvim-tree").setup({
      filters = {
        dotfiles = true,
        -- git_clean = true,
      },
    })
  end,
}
