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

keymap.set({ "n", "v" }, "<leader>vca", vim.lsp.buf.code_action, opts)

keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

keymap.set("n", "<leader>vd", function()
  vim.diagnostic.open_float()
end, opts)

keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

keymap.set("n", "K", vim.lsp.buf.hover, opts)

keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
