return {
  "iamcco/markdown-preview.nvim",
  ft = { "markdown" },
  build = "cd app && npm install",
  config = function()
    -- Configuración básica
    vim.g.mkdp_auto_start = 0
    vim.g.mkdp_auto_close = 1
    vim.g.mkdp_browser = "" -- usa navegador por defecto
    vim.g.mkdp_echo_preview_url = 1

    -- Keymaps
    vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreview<CR>", { desc = "Markdown Preview" })
    vim.keymap.set("n", "<leader>ms", "<cmd>MarkdownPreviewStop<CR>", { desc = "Stop Preview" })
    vim.keymap.set("n", "<leader>mt", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Toggle Preview" })
  end,
}
