return {
  "williamboman/mason.nvim",
  event = { "BufReadPre", "BufNewFile" },
  lazy = true,
  dependencies = {
    { "williamboman/mason-lspconfig.nvim", cmd = { "LspInstall", "LspUninstall" } },
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    require("mason").setup({})

    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason_lspconfig.setup({
      ensure_installed = {
        "asm_lsp",
        "bashls",
        "clangd",
        "cssls",
        "docker_compose_language_service",
        "dockerls",
        "gopls",
        "graphql",
        "jdtls",
        "jsonls",
        "lua_ls",
        "ocamllsp",
        "omnisharp",
        "rust_analyzer",
        "svelte",
        "tailwindcss",
        "tsserver",
      },
      automatic_installation = true,
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "prettierd",
        "ocamlformat",
        "eslint_d",
        "cmakelang",
      },
    })
  end,
}
