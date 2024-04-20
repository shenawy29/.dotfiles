local capabilities = require("cmp_nvim_lsp").default_capabilities()

local config = {
  cmd = { "/home/shenawy/.local/share/nvim/mason/packages/jdtls/jdtls" },
  root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
  capabilities = capabilities,
}

require("jdtls").start_or_attach(config)

local opts = { noremap = true, silent = true }

local keymap = vim.keymap

keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

keymap.set({ "n", "v" }, "<leader>vca", ":Lspsaga code_action<CR>", opts)

keymap.set("n", "<leader>o", ":Lspsaga outline<CR>", opts)

keymap.set("n", "<leader>rn", ":Lspsaga rename<CR>", opts)

keymap.set("n", "<leader>vd", ":Lspsaga show_line_diagnostics<CR>", opts)

keymap.set("n", "]d", ":Lspsaga diagnostic_jump_next<CR>", opts)

keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
