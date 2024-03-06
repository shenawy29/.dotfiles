vim.g.mapleader = " "

local keymap = vim.keymap

-- keymap.set("n", "x", '"_x')

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

keymap.set("v", "<S-j>", ":m '>+1<CR>gv=gv")
keymap.set("v", "<S-k>", ":m '<-2<CR>gv=gv")

-- keymap.set({ "n", "v" }, "<leader>y", [["+y]]) -- yank motion
--
-- keymap.set({ "n", "v" }, "<leader>d", [["+d]]) -- delete motion
--
-- keymap.set({ "n", "v" }, "<leader>p", [["+P]]) -- paste before cursor

-- keymap.set("c", "<C-u>", "<Home>")
-- keymap.set("c", "<C-d>", "<End>")
-- keymap.set("c", "<C-h>", "<Left>")
-- keymap.set("c", "<C-k>", "<Up>")
-- keymap.set("c", "<C-j>", "<Down>")
-- keymap.set("c", "<C-l>", "<Right>")
-- keymap.set("c", "<C-b>", "<S-Left>")
-- keymap.set("c", "<C-e>", "<S-Right>")

-- keymap.set({ "n", "v" }, ":", ":<C-f>i")
-- keymap.set("c", ":", ":<C-f>i")

keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("i", "<C-d>", "<C-d>zz")

keymap.set("n", "<leader>k", "<cmd>cprev<CR>zz")
keymap.set("n", "<leader>j", "<cmd>cnext<CR>zz")
keymap.set("n", "<leader>h", "<cmd>cfirst<CR>zz")
keymap.set("n", "<leader>l", "<cmd>clast<CR>zz")

keymap.set("n", "<leader>w", function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end
  if qf_exists == true then
    vim.cmd("cclose")
    return
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd("copen")
  end
end)

keymap.set("v", "<S-k>", ":m '<-2<CR>gv=gv")

keymap.set({ "n", "v", "o" }, "<leader>z", function()
  vim.cmd("normal %")
end)

keymap.set({ "n", "v", "o" }, "H", "^")

keymap.set({ "n", "v", "o" }, "L", "$")

keymap.set("n", "<leader>q", "<C-^>")

keymap.set("n", "<leader>c", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})
