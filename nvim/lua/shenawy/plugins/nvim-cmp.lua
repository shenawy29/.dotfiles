return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    "saadparwaiz1/cmp_luasnip", -- for autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets
    "onsails/lspkind.nvim", -- vs-code like pictograms
  },

  config = function()
    local cmp = require("cmp")

    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local luasnip = require("luasnip")

    vim.keymap.set({ "i", "s" }, "<C-l>", function()
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      end
    end)

    local s = luasnip.snippet
    local sn = luasnip.snippet_node
    local t = luasnip.text_node
    local i = luasnip.insert_node
    local f = luasnip.function_node
    local fmt = require("luasnip.extras.fmt").fmt
    local rep = require("luasnip.extras").rep
    local c = luasnip.choice_node
    local d = luasnip.dynamic_node
    local r = luasnip.restore_node

    local lspkind = require("lspkind")

    require("luasnip.loaders.from_vscode").lazy_load()

    luasnip.add_snippets("javascript", {
      s(
        "jsd",
        fmt(
          [[
        /**
         * {1}
         */
        ]],
          {
            c(1, { i(1, "This is a description."), t("") }),
          }
        )
      ),
      s("jsc", t("@constructor")),
      s(
        "jsp",
        fmt(
          "@param {{{1}}} {2} {3}",
          { i(1, "datatype"), i(2, "name"), c(3, { fmt(" - {1}", i(1, "description")), t("") }) }
        )
      ),
      s("jsr", fmt("@returns {{{1}}} {2}", { i(1, "datatype"), c(2, { fmt("{1}", i(1, "description")), t("") }) })),
      s(
        "jst",
        fmt(
          "@throws {1} {2}",
          { c(1, { fmt("{{{1}}}", i(1, "error type")), t("") }), c(2, { i(2, "error descripion"), t("") }) }
        )
      ),
    })

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(), -- close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = false }),

        ["<Tab>"] = cmp.mapping(function(fallback)
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
      }),
      -- configure lspkind for vs-code like pictograms in completion menu
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },
    })
  end,
}
