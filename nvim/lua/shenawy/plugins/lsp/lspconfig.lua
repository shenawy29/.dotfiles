return {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local HOME = vim.fn.expand("$HOME")

        vim.diagnostic.config({
            signs = true,
            virtual_text = {
                source = "if_many",
                prefix = "● ",
            },
            update_in_insert = true,
            underline = true,
            severity_sort = true,
            float = {
                focusable = true,
                style = "minimal",
                border = "rounded",
                source = "if_many",
                header = "",
                prefix = "",
            },
        })

        -- require("neodev").setup({
        --     library = { plugins = { "neotest" }, types = true },
        -- })

        local lspconfig = require("lspconfig")

        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local keymap = vim.keymap

        local opts = { noremap = true, silent = true }

        local on_attach = function(_, bufnr)
            opts.buffer = bufnr

            -- keymap.set("n", "<leader>gi", function()
            -- 	require("telescope.builtin").lsp_references()
            -- end, { noremap = true, silent = true })

            keymap.set({ "n", "v" }, "<leader>vca", ":lua vim.lsp.buf.code_action()<CR>", opts)

            keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)

            keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

            keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float({ focusable = true }) end, opts)

            keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)

            keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)

            keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

            keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
        end

        local capabilities = cmp_nvim_lsp.default_capabilities()

        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }

        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        lspconfig["nil_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig["htmx"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "templ", "html" },
        })

        lspconfig["html"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig["dockerls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig["zls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig["omnisharp"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            -- cmd = { HOME .. "/.local/share/nvim/mason/bin/omnisharp" },
            root_dir = function(_)
                return vim.loop.cwd()
            end,
        })

        -- lspconfig["csharp_ls"].setup({
        -- 	capabilities = capabilities,
        -- 	on_attach = on_attach,
        -- 	root_dir = function(_)
        -- 		return vim.loop.cwd()
        -- 	end,
        -- })

        lspconfig["tsserver"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            root_dir = function(_)
                return vim.loop.cwd()
            end,
        })

        lspconfig["hls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            root_dir = function(_)
                return vim.loop.cwd()
            end,
        })

        lspconfig["zls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig["ocamllsp"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            root_dir = function(_)
                return vim.loop.cwd()
            end,
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

        -- lspconfig["rust_analyzer"].setup({
        --     capabilities = capabilities,
        --     on_attach = on_attach,
        -- })

        lspconfig["cmake"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig["phpactor"].setup({
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
            cmd = {
                'clangd',
                '--offset-encoding=utf-16',
            },
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
            filetypes = {
                "graphql",
                "gql",
                "svelte",
                "typescriptreact",
                "javascriptreact",
            },
        })

        lspconfig["basedpyright"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
    end,
}
