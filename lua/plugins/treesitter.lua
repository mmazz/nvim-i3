return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  branch = 'main',
 -- event = { "BufReadPost", "BufNewFile" },
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
    -- enable treesitter highlighting
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
