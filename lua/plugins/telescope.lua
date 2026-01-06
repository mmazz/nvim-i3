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
    telescope.setup({
      defaults = {
        sorting_strategy = "ascending",
      },
    })

    -- ⚠️ nunca romper por una extensión opcional
    pcall(telescope.load_extension, "fzf")

    -- keymaps ACÁ adentro
    vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
    vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
    vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
  end,
}
