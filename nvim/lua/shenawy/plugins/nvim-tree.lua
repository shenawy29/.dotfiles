-- return {}
--
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    vim.opt.termguicolors = true
    -- -- change color for arrows in tree to lightblue
    -- vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#458588 ]])
    -- vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#458588 ]])

    -- configure nvim-tree
    nvimtree.setup({
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      view = {
        width = 35,
        relativenumber = true,
      },
      -- change folder arrow icons
      renderer = {
        -- indent_markers = {
        --   enable = true,
        -- },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "", -- arrow when folder is closed
              arrow_open = "", -- arrow when folder is open
            },
          },
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      -- actions = {
      --   open_file = {
      --     window_picker = {
      --       enable = false,
      --     },
      --   },
      -- },
    })

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
  end,
}
