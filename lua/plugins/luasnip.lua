return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  dependencies = {
    "rafamadriz/friendly-snippets",  -- Snippets base
  },
  config = function()
    local ls = require("luasnip")

    -- Cargar snippets de friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Cargar tus snippets custom de tex.lua
    require("luasnip.loaders.from_lua").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets" })

    -- ============================================================================
    -- CONFIGURACIÓN
    -- ============================================================================
    ls.config.set_config({
      history = true,  -- Recordar último snippet para volver con Tab
      updateevents = "TextChanged,TextChangedI",
      enable_autosnippets = true,  -- Auto-snippets (se expanden sin Tab)
      ext_opts = {
        [require("luasnip.util.types").choiceNode] = {
          active = {
            virt_text = { { "●", "DiagnosticHint" } },
          },
        },
      },
    })

    -- ============================================================================
    -- KEYMAPS
    -- ============================================================================
    vim.keymap.set({ "i", "s" }, "<C-k>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, { silent = true, desc = "Expandir snippet o saltar" })

    vim.keymap.set({ "i", "s" }, "<C-j>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { silent = true, desc = "Saltar atrás en snippet" })

    vim.keymap.set({ "i", "s" }, "<C-l>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, { silent = true, desc = "Cambiar opción en snippet" })
  end,
}
