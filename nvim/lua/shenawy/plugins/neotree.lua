-- return {
--   "nvim-neo-tree/neo-tree.nvim",
--   branch = "v3.x",
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     "nvim-tree/nvim-web-devicons",
--     "MunifTanjim/nui.nvim",
--     "3rd/image.nvim",
--     "s1n7ax/nvim-window-picker",
--   },
--   config = function()
--     vim.g.loaded_netrwPlugin = 1
--     vim.g.loaded_netrw = 1
--     vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>")
--     require("neo-tree").setup({
--       filesystem = {
--         follow_current_file = {
--           enabled = false,
--           leave_dirs_open = true,
--         },
--       },
--       buffers = {
--         follow_current_file = {
--           enabled = false,
--           leave_dirs_open = true,
--         },
--       },
--     })
--   end,
-- }

return {}