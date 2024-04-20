return {
  "williamboman/mason.nvim",
  event = { "BufReadPre", "BufNewFile", "CmdLineEnter" },
  lazy = true,
  dependencies = {
    { "williamboman/mason-lspconfig.nvim", cmd = { "LspInstall", "LspUninstall" } },
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    require("mason").setup({})

    -- local pylsp = require("mason-registry").get_package("python-lsp-server")
    --
    -- pylsp:on("install:success", function()
    --   local function mason_package_path(package)
    --     local path = vim.fn.resolve(vim.fn.stdpath("data") .. "/mason/packages/" .. package)
    --     return path
    --   end
    --
    --   local path = mason_package_path("python-lsp-server")
    --   local command = path .. "/venv/bin/pip"
    --
    --   local args = {
    --     "install",
    --     "pylsp-mypy",
    --   }
    --
    --   require("plenary.job")
    --     :new({
    --       command = command,
    --       args = args,
    --       cwd = path,
    --     })
    --     :start()
    -- end)

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
