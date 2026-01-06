return {
  "neovim/nvim-lspconfig",
  config = function()
    -- Python
    vim.lsp.config.pyright = {
      cmd = { "pyright-langserver", "--stdio" },
    }

    -- C / C++
    vim.lsp.config.clangd = {
      cmd = { "clangd" },
    }

    -- Lua (Neovim)
    vim.lsp.config.lua_ls = {
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
        },
      },
    }

    -- Activar servidores
    vim.lsp.enable("pyright")
    vim.lsp.enable("clangd")
    vim.lsp.enable("lua_ls")
  end,
}

