local M = {
  "utilyre/barbecue.nvim",
  version = "*",
  event = { "VeryLazy" },
  command = { "Barbecue" },
  dependencies = {
    "neovim/nvim-lspconfig",
    "SmiteshP/nvim-navic",
    -- "nvim-tree/nvim-web-devicons", -- optional dependency
  },
}

M.config = function()
  require("barbecue").setup({
    exclude_filetypes = {
      "gitcommit",
      "toggleterm",
      "nvim-tree",
    },
    create_autocmd = false,
  })

  vim.opt.updatetime = 200

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
      local bufnr = vim.api.nvim_win_get_buf(winid)
      require("barbecue.ui").update(winid)
      if vim.bo[bufnr].filetype == "neo-tree" then
        require("neo-tree.ui.selector").set_source_selector({
          winid = winid,
        })
      end
    end,
  })
end

return M
