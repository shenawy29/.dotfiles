return {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader><leader>",
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            mode = "",
            desc = "Format buffer",
        },
    },
    opts = {
        formatters_by_ft = {
            javascript = { "prettierd" },
            typescript = { "prettierd" },
            javascriptreact = { "prettierd" },
            typescriptreact = { "prettierd" },
            svelte = { "prettierd" },
            python = { "autopep8" },
            html = { "prettierd" },
            css = { "prettierd" },
            json = { "prettierd" },
            yaml = { "prettierd" },
            nix = { "nixfmt" },
            markdown = { "prettierd" },
            graphql = { "prettierd" },
            lua = { "stylua" },
            sh = { "shfmt" },
            ocaml = { "ocamlformat" },
            cmake = { "cmakelang" },
            asm = { "asmfmt" },
            php = { "pretty-php" },
        },
        format_on_save = { timeout_ms = 500, lsp_fallback = true },
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
