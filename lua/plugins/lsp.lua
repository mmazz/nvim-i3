return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local opts = { buffer = args.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition,
          vim.tbl_extend("force", opts, { desc = "Ir a definición" }))
        vim.keymap.set("n", "K", vim.lsp.buf.hover,
          vim.tbl_extend("force", opts, { desc = "Hover info" }))
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,
          vim.tbl_extend("force", opts, { desc = "Renombrar" }))
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,
          vim.tbl_extend("force", opts, { desc = "Code action" }))
        vim.keymap.set("n", "gr", vim.lsp.buf.references,
          vim.tbl_extend("force", opts, { desc = "Ver referencias" }))
      end,
    })

    -- texlab
    vim.lsp.config.texlab = {
      cmd = { "texlab" },
      filetypes = { "tex", "bib" },
      root_markers = { ".latexmkrc", ".git" },
      capabilities = capabilities,
      settings = {
        texlab = {
          build = {
            executable = "latexmk",
            args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
            onSave = false,
            forwardSearchAfter = false,
          },
          auxDirectory = ".",
          diagnostics = {
            ignoredPatterns = {
              "^Underfull",
              "^Overfull",
              "^LaTeX Warning",
              "^Package .* Warning",
            },
          },
          forwardSearch = {
            executable = "zathura",
            args = { "--synctex-forward", "%l:1:%f", "%p" },
          },
          chktex = {
            onEdit = false,
            onOpenAndSave = false,
          },
        },
      },
    }

    vim.lsp.config.pyright = {
      capabilities = capabilities,
    }
    -- clangd
    vim.lsp.config.clangd = {
      cmd = { "clangd", "--background-index", "--clang-tidy" },
      capabilities = vim.tbl_extend("force", capabilities, {
        offsetEncoding = { "utf-16" },
      }),
    }

    -- lua_ls (comentar si no está instalado)
    -- vim.lsp.config.lua_ls = {
    --   cmd = { "lua-language-server" },
    --   capabilities = capabilities,
    --   settings = {
    --     Lua = {
    --       diagnostics = { globals = { "vim" } },
    --       workspace = {
    --         library = vim.api.nvim_get_runtime_file("", true),
    --         checkThirdParty = false,
    --       },
    --       telemetry = { enable = false },
    --     },
    --   },
    -- }

    -- Activar LSPs
    vim.lsp.enable("texlab")
    vim.lsp.enable("pyright")
    vim.lsp.enable("clangd")
    -- vim.lsp.enable("lua_ls")
  end,
}
