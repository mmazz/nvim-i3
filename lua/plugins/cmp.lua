return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      -- ========================================================================
      -- SNIPPET ENGINE
      -- ========================================================================
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      -- ========================================================================
      -- FUENTES DE COMPLETADO (en orden de prioridad)
      -- ========================================================================
      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },  -- LSP (texlab)
        { name = "luasnip", priority = 750 },    -- Snippets
        { name = "path", priority = 500 },       -- Rutas de archivos
        { name = "buffer", priority = 250 },     -- Buffer actual
      }),

      -- ========================================================================
      -- MAPEOS
      -- ========================================================================
      mapping = cmp.mapping.preset.insert({
        -- Navegación en el menú
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),

        -- Scroll en la documentación
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        -- Cancelar
        ["<C-e>"] = cmp.mapping.abort(),

        -- Confirmar selección
        ["<CR>"] = cmp.mapping.confirm({ select = false }),  -- Enter confirma
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),

      -- ========================================================================
      -- FORMATO DEL MENÚ
      -- ========================================================================
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, item)
          local kind_icons = {
            Text = "󰉿",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = "󰜢",
            Variable = "󰀫",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "󰑭",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "󰈇",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "󰙅",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "",
          }

          item.kind = string.format("%s %s", kind_icons[item.kind] or "", item.kind)

          -- Fuente del completado
          item.menu = ({
            nvim_lsp = "[LSP]",
            luasnip = "[Snip]",
            buffer = "[Buf]",
            path = "[Path]",
          })[entry.source.name]

          return item
        end,
      },

      -- ========================================================================
      -- VENTANA
      -- ========================================================================
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

      -- ========================================================================
      -- COMPORTAMIENTO EXPERIMENTAL
      -- ========================================================================
      experimental = {
        ghost_text = false,  -- Cambiar a true si querés preview en gris
      },
    })

    -- ========================================================================
    -- CONFIGURACIÓN ESPECÍFICA POR FILETYPE
    -- ========================================================================

    -- Para archivos LaTeX: priorizar LSP y snippets
    cmp.setup.filetype("tex", {
      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 900 },
        { name = "path", priority = 500 },
        { name = "buffer", priority = 250, keyword_length = 3 },
      }),
    })

    -- Para archivos BibTeX
    cmp.setup.filetype("bib", {
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
      }),
    })
  end,
}


