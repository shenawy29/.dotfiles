return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    vim.diagnostic.config({
      virtual_text = {
        source = "if_many",
        prefix = "● ",
      },
      update_in_insert = true,
      underline = true,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "if_many",
        header = "",
        prefix = "",
      },
    })

    local lspconfig = require("lspconfig")

    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap

    local opts = { noremap = true, silent = true }

    local on_attach = function(_, bufnr)
      opts.buffer = bufnr

      opts.desc = "Show LSP references"
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

      opts.desc = "Go to declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

      opts.desc = "Show LSP definitions"
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

      opts.desc = "Show LSP type definitions"
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

      vim.keymap.set("n", "<leader>gi", function()
        require("telescope.builtin").lsp_references()
      end, { noremap = true, silent = true })

      opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "<leader>vca", ":Lspsaga code_action<CR>", opts)

      opts.desc = "Smart rename"

      keymap.set("n", "<leader>rn", ":Lspsaga rename<CR>", opts)

      opts.desc = "Show buffer diagnostics"

      keymap.set("n", "<leader>fi", ":Lspsaga finder imp<CR>", opts)

      keymap.set("n", "<leader>vd", ":Lspsaga show_line_diagnostics<CR>", opts)

      opts.desc = "Go to previous diagnostic"
      keymap.set("n", "[d", ":Lspsaga diagnostic_jump_prev<CR>", opts)

      opts.desc = "Go to next diagnostic"
      keymap.set("n", "]d", ":Lspsaga diagnostic_jump_next<CR>", opts)

      opts.desc = "Show documentation for what is under cursor"

      keymap.set("n", "K", ":Lspsaga hover_doc<CR>", opts)

      -- keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
    end

    local capabilities = cmp_nvim_lsp.default_capabilities()

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    lspconfig["html"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["kotlin_language_server"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["omnisharp"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      root_dir = function(_)
        return vim.loop.cwd()
      end,
    })

    lspconfig["tsserver"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      root_dir = function(_)
        return vim.loop.cwd()
      end,
    })

    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["ocamllsp"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["bashls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["jsonls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["cssls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["tailwindcss"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["templ"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["rust_analyzer"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["cmake"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["gopls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["asm_lsp"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "s", "asm" },
      root_dir = function(_)
        return vim.loop.cwd()
      end,
    })

    lspconfig["clangd"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "c", "cc", "cpp", "hpp", "h", "hh" },
    })

    lspconfig["sqlls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      root_dir = function(_)
        return vim.loop.cwd()
      end,
    })

    lspconfig["bufls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      root_dir = function(_)
        return vim.loop.cwd()
      end,
    })

    lspconfig["svelte"].setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)

        vim.api.nvim_create_autocmd("BufWritePost", {
          pattern = { "*.js", "*.ts" },
          callback = function(ctx)
            if client.name == "svelte" then
              client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
            end
          end,
        })
      end,
    })

    lspconfig["prismals"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["graphql"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
    })

    lspconfig["pylsp"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        pylsp = {
          pylsp_mypy = { enabled = true },
          -- black = { enabled = true },
          -- autopep8 = { enabled = false },
          -- yapf = { enabled = false },
          -- pylint = { enabled = true, executable = "pylint" },
          -- pyflakes = { enabled = false },
          -- pycodestyle = { enabled = false },
          -- jedi_completion = { fuzzy = true },
          -- pyls_isort = { enabled = true },
        },
      },
    })
  end,
}
