return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').setup({
      ensure_installed = { "lua", "c", "cpp", "markdown", "python", "javascript" },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    })
  end,
}

