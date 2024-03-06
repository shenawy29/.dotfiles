return {
  "utilyre/barbecue.nvim",
  version = "*",
  event = "VeryLazy",
  command = { "Barbecue" },
  dependencies = {
    "neovim/nvim-lspconfig",
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("barbecue").setup({
      exclude_filetypes = {
        "gitcommit",
        "toggleterm",
        "nvim-tree",
      },
      create_autocmd = false,
    })

    vim.api.nvim_create_autocmd({
      "WinScrolled",
      "BufWinEnter",
      "CursorHold",
      "InsertLeave",
      "BufWritePost",
      "TextChanged",
      "TextChangedI",
    }, {
      group = vim.api.nvim_create_augroup("barbecue#create_autocmd", { clear = true }),

      callback = function()
        local winid = vim.api.nvim_get_current_win()

        require("barbecue.ui").update(winid)
      end,
    })
  end,
}

-- return {}
