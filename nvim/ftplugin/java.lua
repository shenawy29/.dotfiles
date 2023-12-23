local capabilities = require("cmp_nvim_lsp").default_capabilities()

local config = {
  cmd = { "/home/shenawy29/.local/share/nvim/mason/packages/jdtls/jdtls" },
  root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
  capabilities = capabilities,
}

require("jdtls").start_or_attach(config)

local opts = { noremap = true, silent = true }

local keymap = vim.keymap

keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

keymap.set({ "n", "v" }, "<leader>vca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

keymap.set("n", "<leader>vd", function()
  vim.diagnostic.open_float()
end, opts)

keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
