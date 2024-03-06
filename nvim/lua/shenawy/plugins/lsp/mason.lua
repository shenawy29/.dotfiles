return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    require("mason").setup({})
    local pylsp = require("mason-registry").get_package("python-lsp-server")

    pylsp:on("install:success", function()
      local function mason_package_path(package)
        local path = vim.fn.resolve(vim.fn.stdpath("data") .. "/mason/packages/" .. package)
        return path
      end

      local path = mason_package_path("python-lsp-server")
      local command = path .. "/venv/bin/pip"
      local args = {
        "install",
        "pylsp-mypy",
        "python-lsp-ruff",
      }

      require("plenary.job")
        :new({
          command = command,
          args = args,
          cwd = path,
        })
        :start()
    end)

    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason_lspconfig.setup({
      ensure_installed = {
        "tsserver",
        "cssls",
        "svelte",
        "lua_ls",
        "graphql",
        "prismals",
      },
      automatic_installation = true,
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier",
        "stylua",
        "eslint_d",
      },
    })
  end,
}
