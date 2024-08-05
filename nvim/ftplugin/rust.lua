local opts = { silent = true }

vim.keymap.set({ "n", "v" }, "<leader>vca", ":lua vim.lsp.buf.code_action()<CR>", opts)

vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float({ focusable = true }) end, opts)

vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)

vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)

vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)

vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
