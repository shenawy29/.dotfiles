-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<C-s>+", "<C-w>+", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<C-s>-", "<C-w>-", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<C-s><", "<C-w>>", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<C-s><", "<C-w><", { desc = "Make splits equal size" }) -- make split windows equal width & height

keymap.set("n", "<C-s>h", "<C-w>H") -- close current split window
keymap.set("n", "<C-s>j", "<C-w>J") -- close current split window
keymap.set("n", "<C-s>k", "<C-w>K") -- close current split window
keymap.set("n", "<C-s>l", "<C-w>L") -- close current split window

-- keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
-- keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
-- keymap.set("n", "<leader>tl", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
-- keymap.set("n", "<leader>th", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
-- keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

keymap.set("v", "<S-j>", ":m '>+1<CR>gv=gv")
keymap.set("v", "<S-k>", ":m '<-2<CR>gv=gv")

-- Yank into system clipboard
keymap.set({ "n", "v" }, "<leader>y", [["+y]]) -- yank motion

-- Delete into system clipboard
keymap.set({ "n", "v" }, "<leader>d", [["+d]]) -- delete motion

-- Paste from system clipboard
keymap.set("n", "<leader>p", [["+P]]) -- paste before cursor

keymap.set("c", "<C-u>", "<Home>")
keymap.set("c", "<C-d>", "<End>")
keymap.set("c", "<C-h>", "<Left>")
keymap.set("c", "<C-k>", "<Up>")
keymap.set("c", "<C-j>", "<Down>")
keymap.set("c", "<C-l>", "<Right>")
keymap.set("c", "<C-b>", "<S-Left>")
keymap.set("c", "<C-e>", "<S-Right>")

keymap.set("n", "J", "mzj`z")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "<C-d>", "<C-d>zz")

keymap.set("n", "<leader>k", "<cmd>cprev<CR>zz")
keymap.set("n", "<leader>j", "<cmd>cnext<CR>zz")
keymap.set("n", "<leader>E", "<cmd>open<CR>zz")

keymap.set({ "n", "v", "o" }, "H", "^")

keymap.set({ "n", "v", "o" }, "L", "$")

keymap.set("n", "<leader>q", "<C-^>")

keymap.set("n", "<leader>c", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left><C-f><Left>]])

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- vim.keymap.set("n", "<leader><leader>", function()
--   vim.cmd("so")
-- end)
