return {
    "folke/trouble.nvim",
    keys = {
        {
            "<leader>xx",
            "<cmd>Trouble diagnostics toggle focus=true <cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>xX",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Buffer Diagnostics (Trouble)",
        },
        {
            "<leader>o",
            "<cmd>Trouble symbols toggle focus=true win.position=bottom<cr>",
            desc = "Symbols (Trouble)",
        },
        {
            "gt",
            "<cmd>Trouble lsp_type_definitions toggle focus=truq win.position=bottom<cr>",
            desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
            "<leader>gt",
            "<cmd>Trouble lsp_type_definitions toggle focus=truq win.position=bottom<cr>",
            desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
            "<leader>fi",
            "<cmd>Trouble lsp_references toggle focus=truq win.position=bottom<cr>",
            desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
            "gi",
            "<cmd>Trouble lsp_definitions toggle focus=truq win.position=bottom<cr>",
            desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
            "<leader>gi",
            "<cmd>Trouble lsp_definitions toggle focus=truq win.position=bottom<cr>",
            desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
            "<leader>xL",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Location List (Trouble)",
        },
        {
            "<leader>xQ",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
        },
    },
    opts = {},
}
