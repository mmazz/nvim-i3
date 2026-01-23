return {
  'nvim-treesitter/nvim-treesitter',
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    vim.treesitter.language.register('markdown', 'octo')

    require('nvim-treesitter').setup({
      ensure_installed = {
        "lua",
        "c",
        "cpp",
        "markdown",
        "python",
        "javascript",
        "bibtex",
      },
      highlight = {
        enable = true,
        disable = { "latex" },
      },
      indent = {
        enable = true,
        disable = { "latex" },
      },
    })
  end,
}
