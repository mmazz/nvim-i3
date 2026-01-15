return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
  },
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")

    telescope.setup({
      defaults = {
        sorting_strategy = "ascending",
        layout_config = {
          prompt_position = "top",
        },
      },
    })

    -- Extensión opcional
    pcall(telescope.load_extension, "fzf")

    -- Keymaps (solo definen acciones, no ejecutan lógica)
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
    vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Find git files" })
    --vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })

    -- ⚠️ Recomendación: NO Telescope para implementación

    -- Telescope para referencias (sí tiene sentido)
    vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "LSP references" })
    vim.keymap.set("n", "gs", builtin.lsp_document_symbols, { desc = "Document symbols" })
  end,
}
